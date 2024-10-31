CREATE DATABASE commerceDb;
USE commerceDb;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    EmailAddress VARCHAR(100),
    PhoneNumber VARCHAR(15),
    CardNumber VARCHAR(19)
);

CREATE TABLE CardInformation (
    CardNumber VARCHAR(19) PRIMARY KEY,
    BillingAddress VARCHAR(255)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(255),
    ProdDescription TEXT,
    Brand VARCHAR(100),
    Price DECIMAL(10,2),
    Category VARCHAR(100),
    StockQuantity INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ReOrderLevel INT,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    WarehouseLocation VARCHAR(255)
);

CREATE TABLE `Order` (
    OrderId INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    Date TIMESTAMP,
    OrderTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Pending', 'Shipped', 'Delivered'),
    ShippingAddress VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderedItem (
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderId),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID), 
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    BasePrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    Tax DECIMAL(5,2), 
    ShippingFee DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Price(
    TotalPrice DECIMAL(10,2), 
    Foreign key(BasePrice) references Payment(BasePrice),  
    Foreign key(Discount) references Payment(Discount), 
    Foreign key(Tax) references Payment(Tax), 
    Foreign key(ShippingFee) references Payment(ShippingFee)
);

