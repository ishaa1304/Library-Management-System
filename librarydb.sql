-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 02, 2024 at 08:42 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `librarydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `Book_id` int(11) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Author` varchar(255) NOT NULL,
  `Published_Year` int(11) DEFAULT NULL,
  `Genre` varchar(50) DEFAULT NULL,
  `Available_Copies` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`Book_id`, `Title`, `Author`, `Published_Year`, `Genre`, `Available_Copies`) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction', 3),
(2, '1984', 'George Orwell', 1949, 'Dystopian', 1),
(3, 'Moby Dick', 'Herman Melville', 1851, 'Adventure', 4),
(4, 'Pride and Prejudice', 'Jane Austen', 1813, 'Romance', 6),
(5, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Fiction', 2),
(6, 'War and Peace', 'Leo Tolstoy', 1869, 'Historical', 5),
(7, 'The Catcher in the Rye', 'J.D. Salinger', 1951, 'Fiction', 4),
(8, 'The Hobbit', 'J.R.R. Tolkien', 1937, 'Fantasy', 3),
(9, 'Fahrenheit 451', 'Ray Bradbury', 1953, 'Dystopian', 5),
(10, 'Jane Eyre', 'Charlotte Brontë', 1847, 'Romance', 4),
(11, 'Brave New World', 'Aldous Huxley', 1932, 'Dystopian', 6),
(12, 'The Odyssey', 'Homer', -800, 'Epic', 5),
(13, 'The Brothers Karamazov', 'Fyodor Dostoevsky', 1880, 'Philosophical', 3),
(14, 'Crime and Punishment', 'Fyodor Dostoevsky', 1866, 'Psychological', 4),
(15, 'Anna Karenina', 'Leo Tolstoy', 1877, 'Romance', 5),
(16, 'The Divine Comedy', 'Dante Alighieri', 1320, 'Epic', 6),
(17, 'Wuthering Heights', 'Emily Brontë', 1847, 'Gothic', 4),
(18, 'The Iliad', 'Homer', -750, 'Epic', 5),
(19, 'Great Expectations', 'Charles Dickens', 1861, 'Fiction', 3),
(20, 'Les Misérables', 'Victor Hugo', 1862, 'Historical', 4),
(21, 'Don Quixote', 'Miguel de Cervantes', 1605, 'Adventure', 5),
(22, 'The Alchemist', 'Paulo Coelho', 1988, 'Adventure', 6),
(23, 'Frankenstein', 'Mary Shelley', 1818, 'Gothic', 4),
(24, 'The Grapes of Wrath', 'John Steinbeck', 1939, 'Fiction', 3),
(25, 'The Old Man and the Sea', 'Ernest Hemingway', 1952, 'Fiction', 4),
(26, 'Dracula', 'Bram Stoker', 1897, 'Gothic', 5),
(27, 'The Sun Also Rises', 'Ernest Hemingway', 1926, 'Fiction', 6),
(28, 'The Grapes of Wrath', 'John Steinbeck', 1939, 'Historical', 7),
(29, 'Fahrenheit 451', 'Ray Bradbury', 1953, 'Dystopian', 8),
(30, 'Beloved', 'Toni Morrison', 1987, 'Historical', 4),
(31, 'The Handmaid\'s Tale', 'Margaret Atwood', 1985, 'Dystopian', 9),
(32, 'Gone with the Wind', 'Margaret Mitchell', 1936, 'Historical', 5),
(33, 'Lolita', 'Vladimir Nabokov', 1955, 'Fiction', 6),
(34, 'Catch-22', 'Joseph Heller', 1961, 'Satire', 8),
(35, 'The Sound and the Fury', 'William Faulkner', 1929, 'Fiction', 7),
(36, 'Slaughterhouse-Five', 'Kurt Vonnegut', 1969, 'Science Fiction', 9),
(37, 'On the Road', 'Jack Kerouac', 1957, 'Fiction', 10),
(38, 'The Stranger', 'Albert Camus', 1942, 'Philosophical', 6),
(39, 'To the Lighthouse', 'Virginia Woolf', 1927, 'Fiction', 5),
(40, 'Heart of Darkness', 'Joseph Conrad', 1899, 'Adventure', 4),
(41, 'Ulysses', 'James Joyce', 1922, 'Modernist', 3),
(42, 'The Old Man and the Sea', 'Ernest Hemingway', 1952, 'Fiction', 6),
(43, 'Invisible Man', 'Ralph Ellison', 1952, 'Fiction', 7),
(44, 'Rebecca', 'Daphne du Maurier', 1938, 'Gothic', 5),
(45, 'The Secret Garden', 'Frances Hodgson Burnett', 1911, 'Children', 9),
(46, 'A Tale of Two Cities', 'Charles Dickens', 1859, 'Historical', 8),
(47, 'Dune', 'Frank Herbert', 1965, 'Science Fiction', 10),
(48, 'The Shining', 'Stephen King', 1977, 'Horror', 6),
(49, 'Emma', 'Jane Austen', 1815, 'Romance', 7),
(50, 'Great Expectations', 'Charles Dickens', 1861, 'Fiction', 8),
(51, 'The_Heart_Of_The_Matter', 'Graham_Greene', 1948, 'Novel', 4),
(52, 'Jane Eyre', 'Jane Austen', 1888, 'Romance', 4),
(53, 'The_Grapes_Of_Wrath', 'John_Steinbeck', 1939, 'Novel', 2),
(54, 'I_Claudius', 'Robert_Graves', 1934, 'Historical', 7),
(55, 'To_The_Lighthouse', 'Virginia_Woolf', 1927, 'Modernism', 6),
(56, 'Slaughterhouse_Five', 'Kurt_Vonnegut', 1969, 'War_Novel', 3),
(57, 'Invisible_Man', 'Ralph_Ellison', 1952, 'African_American_Literature', 9),
(58, 'Native_Son', 'Richard_Wright', 1940, 'Social_Protest', 10),
(59, 'USA_Trilogy', 'John_Dos_Passos', 1930, 'Political_Fiction', 1),
(60, 'A_Passage_To_India', 'E_M_Forster', 1924, 'Novel', 4),
(61, 'Tender_Is_The_Night', 'F_Scott_Fitzgerald', 1934, 'Tragedy', 6),
(62, 'Animal_Farm', 'George_Orwell', 1945, 'Political_Satire', 3),
(63, 'The_Golden_Bowl', 'Henry_James', 1904, 'Philosophy', 4),
(64, 'A_Handful_Of_Dust', 'Evelyn_Waugh', 1934, 'Fiction', 1),
(65, 'As_I_Lay_Dying', 'William_Faulkner', 1930, 'Black_Comedy', 8),
(70, 'Geronimo Stilton', 'Thea', 2004, 'Children', 6);

-- --------------------------------------------------------

--
-- Table structure for table `borrowed_books`
--

CREATE TABLE `borrowed_books` (
  `Book_Id` int(11) NOT NULL,
  `Member_Id` int(11) DEFAULT NULL,
  `Borrowed_Date` date DEFAULT NULL,
  `Return_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `Member_ID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Join_Date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`Member_ID`, `Name`, `Email`, `Join_Date`) VALUES
(1, 'Isha ', 'isha@gmail.com', '2024-06-02'),
(2, 'Sanjana Rathod ', 'sanjana@gmail.com', '2024-06-02'),
(3, 'John', 'john@gmail.com', '2024-06-02'),
(4, 'adithya', 'adithya@gmail.com', '2024-06-02'),
(5, 'Prajakta', 'prajakta@gmail.com', '2024-06-02'),
(6, 'Siddhi Deo ', 'siddhi@gmail.com', '2024-06-02'),
(7, 'Jane', 'jane@gmail.com', '2024-06-02'),
(9, 'Janhavi', 'janhavi@gmail.com', '2024-06-02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`Book_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`Member_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `Member_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
