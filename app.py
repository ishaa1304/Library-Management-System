from flask import Flask, render_template, request, redirect, url_for, flash
from datetime import datetime
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)
app.secret_key = 'charliechaplin'

# Database connection configuration
DB_CONFIG = {
    'host': "gowsj.h.filess.io",
    'database': "1304_situation",
    'port': 3307,
    'user': "1304_situation",
    'password': "b08e3b880f62610823dfee4174e9e60a58ceb9ed"
}

def get_db_connection():
    return mysql.connector.connect(**DB_CONFIG)

# Example function to fetch books
def fetch_books():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("SELECT * FROM books")
    books = cursor.fetchall()
    cursor.close()
    connection.close()
    return books

@app.route('/')
def login():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login_post():
    name = request.form.get('name')
    email = request.form.get('email')

    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("SELECT * FROM members WHERE Name = %s AND Email = %s", (name, email))
    member = cursor.fetchone()
    cursor.close()
    connection.close()

    if member:
        return redirect(url_for('display_books', name=name, email=email))
    else:
        return render_template('login.html', error='Invalid name or email')

@app.route('/display_books')
def display_books():
    name = request.args.get('name')
    email = request.args.get('email')

    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("SELECT Member_Id FROM members WHERE Name = %s AND Email = %s", (name, email))
    member = cursor.fetchone()
    cursor.close()
    connection.close()

    member_id = member['Member_Id'] if member else None
    books = fetch_books()

    return render_template('index.html', books=books, name=name, email=email, member_id=member_id)

@app.route('/borrow', methods=['POST'])
def borrow_book():
    book_id = request.form['book_id']
    member_id = request.form['member_id']

    connection = get_db_connection()
    cursor = connection.cursor()

    # Check availability
    cursor.execute("SELECT Available_Copies FROM books WHERE Book_Id = %s", (book_id,))
    available = cursor.fetchone()
    if available and available[0] > 0:
        # Update copies and insert into borrow history
        cursor.execute("UPDATE books SET Available_Copies = Available_Copies - 1 WHERE Book_Id = %s", (book_id,))
        cursor.execute("INSERT INTO borrows (Book_Id, Member_Id, Borrow_Date) VALUES (%s, %s, %s)",
                       (book_id, member_id, datetime.now()))
        connection.commit()
        flash('Book borrowed successfully!', 'success')
    else:
        flash('Book not available.', 'danger')

    cursor.close()
    connection.close()
    return redirect(url_for('display_books', name=request.args.get('name'), email=request.args.get('email')))

if __name__ == '__main__':
    app.run(debug=True)
