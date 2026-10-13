CREATE DATABASE SalesSnowflakeDB;
USE SalesSnowflakeDB;

-- 1. Category dimension
CREATE TABLE Dim_Category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(50)
);

-- 2. Product dimension
CREATE TABLE Dim_Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category_ID INT,
    FOREIGN KEY (Category_ID)
        REFERENCES Dim_Category(Category_ID)
);

-- 3. State dimension
CREATE TABLE Dim_State (
    State_ID INT PRIMARY KEY,
    State_Name VARCHAR(50)
);

-- 4. City dimension
CREATE TABLE Dim_City (
    City_ID INT PRIMARY KEY,
    City_Name VARCHAR(50),
    State_ID INT,
    FOREIGN KEY (State_ID)
        REFERENCES Dim_State(State_ID)
);

-- 5. Customer dimension
CREATE TABLE Dim_Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    City_ID INT,
    FOREIGN KEY (City_ID)
        REFERENCES Dim_City(City_ID)
);

-- 6. Date dimension
CREATE TABLE Dim_Date (
    Date_ID INT PRIMARY KEY,
    Full_Date DATE,
    Month_Name VARCHAR(20),
    Year INT
);

-- 7. Central fact table
CREATE TABLE Fact_Sales (
    Sales_ID INT PRIMARY KEY,
    Product_ID INT,
    Customer_ID INT,
    Date_ID INT,
    Quantity INT,
    Amount DECIMAL(10,2),

    FOREIGN KEY (Product_ID)
        REFERENCES Dim_Product(Product_ID),

    FOREIGN KEY (Customer_ID)
        REFERENCES Dim_Customer(Customer_ID),

    FOREIGN KEY (Date_ID)
        REFERENCES Dim_Date(Date_ID)
);
INSERT INTO Dim_Category
VALUES
(1, 'Electronics');

INSERT INTO Dim_Product
VALUES
(1, 'Laptop', 1),
(2, 'Mobile', 1);

INSERT INTO Dim_State
VALUES
(1, 'Tamil Nadu');

INSERT INTO Dim_City
VALUES
(1, 'Chennai', 1),
(2, 'Madurai', 1);

INSERT INTO Dim_Customer
VALUES
(101, 'Arun', 1),
(102, 'Priya', 2);

INSERT INTO Dim_Date
VALUES
(20260101, '2026-01-01', 'January', 2026),
(20260201, '2026-02-01', 'February', 2026);

INSERT INTO Fact_Sales
VALUES
(1, 1, 101, 20260101, 2, 100000.00),
(2, 2, 102, 20260201, 1, 20000.00);

SELECT
    c.Customer_Name,
    ci.City_Name,
    s.State_Name,
    p.Product_Name,
    cat.Category_Name,
    d.Month_Name,
    f.Quantity,
    f.Amount
FROM Fact_Sales f
JOIN Dim_Customer c
    ON f.Customer_ID = c.Customer_ID
JOIN Dim_City ci
    ON c.City_ID = ci.City_ID
JOIN Dim_State s
    ON ci.State_ID = s.State_ID
JOIN Dim_Product p
    ON f.Product_ID = p.Product_ID
JOIN Dim_Category cat
    ON p.Category_ID = cat.Category_ID
JOIN Dim_Date d
    ON f.Date_ID = d.Date_ID;