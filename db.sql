CREATE DATABASE commerceDb;
USE commerceDb;

CREATE TABLE Customers(
    CustomerID INT Primary KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    EmailAddress VARCHAR(100),
    PhoneNumber VARCHAR(15),
    ShippingAddress TEXT,
    BillingAddress TEXT,
    CardNumber VARCHAR(19),
    Foreign Key(OrderCreatedAtTime) references Order 

);
CREATE TABLE Products(
    ProductID INT Primary KEY AUTO_INCREMENT,
    ProductName VARCH(255),
    ProdDescription TEXT,
    Brand VARCHAR(100),
    Price DECIMAL(10,2),
    Category VARCHAR(100),
    StockQuantity INT,
    CreatedAt TIMESTAMP,
    ReOrderLevel INT,
    LastUpdated TIMESTAMP,
    WarehouseLocation VARCHAR(255),

);

CREATE TABLE Order(
    OrderId INT Primary KEY AUTO_INCREMENT,
    OrderDate TIMESTAMP,
    OrderCreatedAtTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    OrderStatus ENUM('Pending','Shipped', 'Delivered'),
    Foreign key(CustomerID) references Customers,
    Foreign key(ShippingAddress) references Customers
);

CREATE TABLE OrderedItem(
    Quantity INT,
    Foreign key(ProductID) references Products,
    Foreign key(OrderID) references Order,
    Foreign key(PaymentId) references Payment
);

CREATE TABLE Payment(
    PaymentID Primary KEY AUTO_INCREMENT,
    TotalPrice DECIMAL(10,2),
    BasePrice DECIMAL(10,2),
    Discount DECIMAL,
    Tax DECIMAL, 
    ShippingFee DECIMAL(10,2),
    Foreign key(CustomerID) references Customers
);
