CREATE DATABASE movie_streaming;
USE movie_streaming;
CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(50),
    price DECIMAL(8,2),
    duration_months INT
);
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE,
    subscription_id INT,
    FOREIGN KEY (subscription_id) REFERENCES Subscriptions(subscription_id)
);
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150),
    genre VARCHAR(50),
    language VARCHAR(50),
    release_year INT
);
CREATE TABLE Actors (
    actor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);
CREATE TABLE Movie_Actors (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY(movie_id, actor_id),
    FOREIGN KEY(movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY(actor_id) REFERENCES Actors(actor_id)
);
CREATE TABLE Watch_History (
    watch_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    watch_date DATE,
    rating INT,
    FOREIGN KEY(user_id) REFERENCES Users(user_id),
    FOREIGN KEY(movie_id) REFERENCES Movies(movie_id)
);
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    amount DECIMAL(8,2),
    method VARCHAR(50),
    payment_date DATE,
    FOREIGN KEY(user_id) REFERENCES Users(user_id)
);
INSERT INTO Subscriptions (plan_name, price, duration_months) VALUES
('Basic', 199.00, 1),
('Standard', 399.00, 1),
('Premium', 599.00, 1);
INSERT INTO Users (name, email, join_date, subscription_id) VALUES
('Amit Sharma', 'amit@gmail.com', '2023-08-10', 1),
('Priya Verma', 'priya@gmail.com', '2023-07-15', 2),
('Rahul Mehta', 'rahul@gmail.com', '2023-08-22', 3);
INSERT INTO Movies (title, genre, language, release_year) VALUES
('Avengers Endgame', 'Action', 'English', 2019),
('3 Idiots', 'Comedy', 'Hindi', 2009),
('KGF Chapter 2', 'Action', 'Kannada', 2022),
('Dangal', 'Drama', 'Hindi', 2016);
INSERT INTO Actors (name) VALUES
('Robert Downey Jr'),
('Aamir Khan'),
('Yash');
INSERT INTO Watch_History (user_id, movie_id, watch_date, rating) VALUES
(1, 1, '2023-09-01', 5),
(1, 3, '2023-09-05', 4),
(2, 2, '2023-09-03', 5);

#1️⃣ List all users with subscription plan
SELECT u.name, s.plan_name
FROM Users u
JOIN Subscriptions s
ON u.subscription_id = s.subscription_id;

#2 Movies released after 2015
SELECT title, release_year
FROM Movies
WHERE release_year > 2015;

#3 Find Action movies
SELECT title, genre
FROM Movies
WHERE genre = 'Action';

#4 Users joined in August 2023
SELECT name, join_date
FROM Users
WHERE join_date BETWEEN '2023-08-01' AND '2023-08-31';

#5 Movies watched by Amit Sharma
SELECT m.title
FROM Watch_History w
JOIN Users u ON w.user_id = u.user_id
JOIN Movies m ON w.movie_id = m.movie_id
WHERE u.name = 'Amit Sharma';

#6 Count movies watched per user
SELECT u.name, COUNT(w.movie_id) AS total_movies
FROM Users u
JOIN Watch_History w ON u.user_id = w.user_id
GROUP BY u.name;

#7 Top 5 Highest Rated Movies
SELECT m.title, AVG(w.rating) AS avg_rating
FROM Movies m
JOIN Watch_History w ON m.movie_id = w.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC
LIMIT 5;

#8 Most Popular Genre
SELECT m.genre, COUNT(*) AS total_watches
FROM Watch_History w
JOIN Movies m ON w.movie_id = m.movie_id
GROUP BY m.genre
ORDER BY total_watches DESC
LIMIT 1;


