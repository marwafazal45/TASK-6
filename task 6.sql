USE order_management;

CREATE TABLE Review (
    Review_ID VARCHAR(10) PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Rating INT NOT NULL,
    Review_Text VARCHAR(500),
    Review_Date DATE NOT NULL,

    CHECK (Rating BETWEEN 1 AND 5),

    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID),

    FOREIGN KEY (Product_ID)
    REFERENCES Product(Product_ID)
);

INSERT INTO Review
(Review_ID, Customer_ID, Product_ID, Rating, Review_Text, Review_Date)
VALUES ('R101', 1, 1, 5, 'Excellent performance', '2026-10-10');
INSERT INTO Review
(Review_ID, Customer_ID, Product_ID, Rating, Review_Text, Review_Date)
VALUES ('R102', 2, 3, 4, 'Good battery life', '2026-10-11');
INSERT INTO Review
(Review_ID, Customer_ID, Product_ID, Rating, Review_Text, Review_Date)
VALUES ('R103', 3, 5, 5, 'Very comfortable to use', '2026-10-12');
INSERT INTO Review
(Review_ID, Customer_ID, Product_ID, Rating, Review_Text, Review_Date)
VALUES ('R104', 4, 4, 3, 'Average quality', '2026-10-13');
INSERT INTO Review
(Review_ID, Customer_ID, Product_ID, Rating, Review_Text, Review_Date)
VALUES ('R105', 5, 2, 2, 'Not working as expected', '2026-10-14');

SELECT * FROM Review;

UPDATE Review
SET Review_Text = 'Good performance and excellent quality'
WHERE Review_ID = 'R102';

DELETE FROM Review
WHERE Review_ID = 'R105';

SELECT * FROM Review;

SELECT Product_Name, Rating, Review_Text
FROM Product
JOIN Review
ON Product.Product_ID = Review.Product_ID;

SELECT Customer_Name, Review_Text, Rating
FROM Customer
JOIN Review
ON Customer.Customer_ID = Review.Customer_ID;

SELECT Product_Name, COUNT(Review_ID) AS Total_Reviews
FROM Product
JOIN Review
ON Product.Product_ID = Review.Product_ID
GROUP BY Product.Product_ID, Product_Name
ORDER BY Total_Reviews DESC
LIMIT 1;

SELECT Customer_Name, Review_Text, Review_Date
FROM Customer
JOIN Review
ON Customer.Customer_ID = Review.Customer_ID
ORDER BY Review_Date DESC;

SELECT Product_Name, Rating, Review_Text
FROM Product
JOIN Review
ON Product.Product_ID = Review.Product_ID
WHERE Rating > 4;

SELECT Product_ID, AVG(Rating) AS Average_Rating
FROM Review
GROUP BY Product_ID;

SELECT Product_ID, COUNT(Review_ID) AS Total_Reviews
FROM Review
GROUP BY Product_ID;

SELECT Product_ID, AVG(Rating) AS Average_Rating
FROM Review
GROUP BY Product_ID
ORDER BY Average_Rating DESC
LIMIT 1;

SELECT Product_ID, AVG(Rating) AS Average_Rating
FROM Review
GROUP BY Product_ID
HAVING AVG(Rating) > 4;


SELECT Product_Name, COUNT(Review_ID) AS Total_Reviews
FROM Product
JOIN Review
ON Product.Product_ID = Review.Product_ID
GROUP BY Product.Product_ID, Product_Name
ORDER BY Total_Reviews DESC;

SELECT Product_Name, AVG(Rating) AS Average_Rating
FROM Product
JOIN Review
ON Product.Product_ID = Review.Product_ID
GROUP BY Product.Product_ID, Product_Name
HAVING AVG(Rating) > 4;

SELECT Product_Name, AVG(Rating) AS Average_Rating
FROM Product
JOIN Review
ON Product.Product_ID = Review.Product_ID
GROUP BY Product.Product_ID, Product_Name
HAVING AVG(Rating) < 3;

SELECT Product_Name, AVG(Rating) AS Average_Rating
FROM Product
JOIN Review
ON Product.Product_ID = Review.Product_ID
GROUP BY Product.Product_ID, Product_Name
HAVING AVG(Rating) < 3;

SELECT COUNT(*) AS Five_Star_Ratings
FROM Review
WHERE Rating = 5;

SELECT COUNT(*) AS Four_Star_Ratings
FROM Review
WHERE Rating = 4;

SELECT COUNT(*) AS Low_Rated_Products
FROM (
    SELECT Product_ID
    FROM Review
    GROUP BY Product_ID
    HAVING AVG(Rating) < 3
) AS LowRatedProducts;