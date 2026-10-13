CREATE DATABASE SalesStarDB;
USE SalesStarDB;

-- 1. Product dimension
CREATE TABLE Dim_Product_1(
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50)
);

-- 2. Customer dimension
CREATE TABLE Dim_Customer_1 (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50)
);

-- 3. Date dimension
CREATE TABLE Dim_Date_1 (
    Date_ID INT PRIMARY KEY,
    Full_Date DATE,
    Month_Name VARCHAR(20),
    Year INT
);

-- 4. Central fact table
CREATE TABLE Fact_Sales_1 (
    Sales_ID INT PRIMARY KEY,
    Product_ID INT,
    Customer_ID INT,
    Date_ID INT,
    Quantity INT,
    Amount DECIMAL(10,2),

    FOREIGN KEY (Product_ID)
        REFERENCES Dim_Product_1(Product_ID),

    FOREIGN KEY (Customer_ID)
        REFERENCES Dim_Customer_1(Customer_ID),

    FOREIGN KEY (Date_ID)
        REFERENCES Dim_Date_1(Date_ID)
);

INSERT INTO Dim_Product_1
VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Mobile', 'Electronics');

INSERT INTO Dim_Customer_1
VALUES
(101, 'Arun', 'Chennai', 'Tamil Nadu'),
(102, 'Priya', 'Madurai', 'Tamil Nadu');

INSERT INTO Dim_Date_1
VALUES
(20260101, '2026-01-01', 'January', 2026),
(20260201, '2026-02-01', 'February', 2026);

INSERT INTO Fact_Sales_1
VALUES
(1, 1, 101, 20260101, 2, 100000.00),
(2, 2, 102, 20260201, 1, 20000.00);

SELECT
    c.Customer_Name,
    p.Product_Name,
    d.Month_Name,
    f.Quantity,
    f.Amount
FROM Fact_Sales f
JOIN Dim_Customer c
    ON f.Customer_ID = c.Customer_ID
JOIN Dim_Product p
    ON f.Product_ID = p.Product_ID
JOIN Dim_Date d
    ON f.Date_ID = d.Date_ID;
