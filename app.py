from flask import Flask, render_template, request, redirect, url_for, session, flash
import mysql.connector
from datetime import datetime
import os
from urllib.parse import urlparse
import mysql.connector

app = Flask(__name__)
app.secret_key = 'charliechaplin'
# metrics = PrometheusMetrics(app)
# Connect to MySQL (local)
# db = mysql.connector.connect(
#     host="localhost",
#     user="root",
#     password="root",  # Replace with your actual password
#     database="librarydb"
# )



url = urlparse(os.environ["DATABASE_URL"])  # or os.environ["MYSQL_URI"]

db = mysql.connector.connect(
    host=url.hostname,
    port=url.port,
    user=url.username,
    password=url.password,
    database=url.path[1:],  # strip leading '/'
)


# # Prometheus Metrics
# REQUEST_COUNT = Counter('http_requests_total', 'Total number of HTTP requests', ['method', 'endpoint'])
# REQUEST_LATENCY = Histogram('http_request_duration_seconds', 'Histogram of HTTP request durations', ['method', 'endpoint'])

# # Register Prometheus metrics
# REGISTRY.register(REQUEST_COUNT)
# REGISTRY.register(REQUEST_LATENCY)

# Middleware to track request count and latency
@app.before_request
def before_request():
    request.start_time = datetime.now()

# @app.after_request
# def after_request(response):
    # Track HTTP request count
    # REQUEST_COUNT.labels(method=request.method, endpoint=request.endpoint).inc()
    
    # # Track HTTP request latency
    # duration = (datetime.now() - request.start_time).total_seconds()
    # REQUEST_LATENCY.labels(method=request.method, endpoint=request.endpoint).observe(duration)
    
    # return response

def fetch_books():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM books")
    books = cursor.fetchall()
    cursor.close()
    return books

# @app.route('/metrics')
# def metrics():
#     # Expose metrics to Prometheus
#     return generate_latest(REGISTRY), 200, {'Content-Type': 'text/plain'}

@app.route('/')
def login():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login_post():
    error = None
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')

        cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM members WHERE Name = %s AND Email = %s", (name, email))
        member = cursor.fetchone()

        if member:
            return redirect(url_for('display_books', name=name, email=email))
        else:
            error = 'Invalid name or email'
    return render_template('login.html', error=error)

@app.route('/display_books')
def display_books():
    name = request.args.get('name')
    email = request.args.get('email')

    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT Member_Id FROM members WHERE Name = %s AND Email = %s", (name, email))
    member = cursor.fetchone()
    cursor.close()

    if member:
        member_id = member['Member_Id']
    else:
        member_id = None

    books = fetch_books()
    return render_template('index.html', books=books, name=name, email=email, member_id=member_id)

@app.route('/borrow', methods=['POST'])
def borrow_book():
    try:
        book_id = request.form['book_id']
        member_id = request.form['member_id']

        cursor = db.cursor()
        cursor.execute("SELECT Available_Copies FROM books WHERE Book_Id = %s", (book_id,))
        available_copies = cursor.fetchone()[0]

        if available_copies > 0:
            cursor.execute("SELECT COUNT(*) FROM borrowed_books WHERE Member_Id = %s", (member_id,))
            borrowed_count = cursor.fetchone()[0]

            if borrowed_count >= 2:
                return "You have already borrowed the maximum number of books (2).", 400

            cursor.execute("INSERT INTO borrowed_books (Book_Id, Member_Id, Borrowed_Date) VALUES (%s, %s, %s)", (book_id, member_id, datetime.now()))
            cursor.execute("UPDATE books SET Available_Copies = Available_Copies - 1 WHERE Book_Id = %s", (book_id,))
            db.commit()
            cursor.close()

            return "Book borrowed successfully.", 200
        else:
            return "Sorry, the book is not available for borrowing.", 400
    except Exception as e:
        print("Error:", e)
        return "Failed to borrow the book. Error: {}".format(e), 500

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

def fetch_borrowed_books(member_id):
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT books.Book_Id, books.Title, books.Author, borrowed_books.Borrowed_Date
        FROM borrowed_books
        JOIN books ON borrowed_books.Book_Id = books.Book_Id
        WHERE borrowed_books.Member_Id = %s
    """, (member_id,))
    borrowed_books = cursor.fetchall()
    cursor.close()
    return borrowed_books

@app.route('/my_borrowed_books/<member_id>')
def my_borrowed_books(member_id):
    try:
        borrowed_books = fetch_borrowed_books(member_id)
        return render_template('my_borrowed_books.html', borrowed_books=borrowed_books, member_id=member_id)
    except Exception as e:
        print("Error:", e)
        return "Failed to fetch borrowed books. Error: {}".format(e), 500

@app.route('/return_books', methods=['POST'])
def return_books():
    try:
        book_ids = request.form.getlist('book_ids[]')
        member_id = request.form['member_id']

        if not book_ids or not member_id:
            return "Missing book IDs or member ID", 400

        cursor = db.cursor()

        for book_id in book_ids:
            cursor.execute("DELETE FROM borrowed_books WHERE Book_Id = %s AND Member_Id = %s", (book_id, member_id))
            affected_rows = cursor.rowcount
            print(f"Deleted {affected_rows} row(s) from borrowed_books")

            if affected_rows > 0:
                cursor.execute("UPDATE books SET Available_Copies = Available_Copies + 1 WHERE Book_Id = %s", (book_id,))
                updated_rows = cursor.rowcount
                print(f"Updated {updated_rows} row(s) in books")

        db.commit()
        cursor.close()

        flash('Books returned successfully', 'success')
        return redirect(url_for('my_borrowed_books', member_id=member_id))
    except Exception as e:
        print("Error:", e)
        flash('Failed to return books. Please try again later.', 'error')
        return "Failed to return books. Error: {}".format(e), 500

@app.route('/register', methods=['GET', 'POST'])
def register():
    error = None
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        join_date = datetime.now()

        cursor = db.cursor()
        cursor.execute("INSERT INTO members (Name, Email, Join_Date) VALUES (%s, %s, %s)", (name, email, join_date))
        db.commit()
        cursor.close()

        return redirect(url_for('login'))
    return render_template('register.html', error=error)

@app.route('/add_book')
def add_book_form():
    return render_template('add_book.html')

@app.route('/add_book', methods=['POST'])
def add_book():
    try:
        book_id = request.form['book_id']
        title = request.form['title']
        author = request.form['author']
        published_year = request.form['published_year']
        genre = request.form['genre']
        available_copies = request.form['available_copies']
        
        cursor = db.cursor()
        cursor.execute("INSERT INTO books (Book_Id, Title, Author, Published_Year, Genre, Available_Copies) VALUES (%s, %s, %s, %s, %s, %s)", (book_id, title, author, published_year, genre, available_copies))
        db.commit()
        cursor.close()

        return redirect(url_for('add_book_form'))
    except Exception as e:
        print("Error:", e)
        return "Failed to add the book. Error: {}".format(e), 500

if __name__ == "__main__":
    app.run(debug=True)
