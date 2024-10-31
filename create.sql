CREATE DATABASE commerceDb;
USE commerceDb;

CREATE TABLE Customer(
    CustomerID INT Primary KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    EmailAddress VARCHAR(100),
    PhoneNumber VARCHAR(15),
    CardNumber VARCHAR(19),

);

CREATE TABLE CardInformation(
    CardNumber VARCHAR(50) Primary KEY,
    BillingAddress VARCHAR(50),
    
);

CREATE TABLE Product(
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
    Date TIMESTAMP,
    OrderTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    OrderStatus ENUM('Pending','Shipped', 'Delivered'), //this could be useful to have we don't have it in original but should we add it? 
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
    BasePrice DECIMAL(10,2),
    Discount DECIMAL,
    Tax DECIMAL, 
    ShippingFee DECIMAL(10,2),
    Foreign key(CustomerID) references Customers
);

CREATE TABLE Price(
    TotalPrice DECIMAL(10,2), 
    Foreign key(BasePrice) references Payment,  
    Foreign key(Discount) references Payment, 
    Foreign key(Tax) references Payment, 
    Foreign key(ShippingFee) references Payment
);
