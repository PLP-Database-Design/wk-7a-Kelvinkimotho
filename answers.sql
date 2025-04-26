-- My test db 
create database myDB;

-- then choose to use it
use myDB;
-- Question 1 ( achieving 1nf). The Products column contains multiple values.
-- The Goal id to split it so each product has its own row

-- First, I created a new table that satisfies 1NF
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- The inserted  the separated data into the new table
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Question 2
-- The problem is that CustomerName only depends on OrderID (not on the full composite key).
-- so the goal here is to eliminate partial dependency by spliting into two tables.
-- split the information into two tables:
    -- One table for who made the order (OrderID + CustomerName).
    -- Another table for what they ordered (OrderID + Product + Quantity).

-- I created CustomerOrder table to hold OrderID and CustomerName
CREATE TABLE CustomerOrder (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert unique orders
INSERT INTO CustomerOrder (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Created a new table for OrderDetails without CustomerName
CREATE TABLE OrderItem (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES CustomerOrder(OrderID)
);

-- Insert product and quantity details
INSERT INTO OrderItem (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);
