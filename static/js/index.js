// script.js

function addNewBook() {
    window.location.href = "/add_book"; // Redirect to the add book page
}

function returnBooks(memberId) {
    if (memberId) {
        window.location.href = `/my_borrowed_books/${memberId}`; // Redirect to the page for returning borrowed books
    } else {
        Swal.fire('Error', 'Member ID is missing.', 'error');
    }
}

function viewBorrowedBooks(memberId) {
    if (memberId) {
        window.location.href = `/my_borrowed_books/${memberId}`; // Redirect to the borrowed books page
    } else {
        Swal.fire('Error', 'Member ID is missing.', 'error');
    }
}

function borrowBook(bookId, memberId) {
    console.log('Borrowing book with ID:', bookId);
    fetch('/borrow', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `book_id=${bookId}&member_id=${memberId}`
    })
    .then(response => {
        if (response.ok) {
            // Update the counter
            const counterElement = document.getElementById('borrowed-counter');
            let borrowedCount = parseInt(counterElement.innerText, 10);
            
            // Check if the parsed value is a number
            if (!isNaN(borrowedCount)) {
                borrowedCount++;
                counterElement.innerText = borrowedCount;
            } else {
                console.error('Counter value is not a number:', counterElement.innerText);
            }

            Swal.fire('Success', 'Book borrowed successfully!', 'success');
            const bookElement = document.getElementById(`book-${bookId}`);
            if (bookElement) {
                bookElement.remove();
            }
        } else {
            Swal.fire('Error', 'Failed to borrow the book.', 'error');
        }
    })
    .catch(error => {
        console.error('Error borrowing book:', error);
        Swal.fire('Error', 'Failed to borrow the book.', 'error');
    });
}
