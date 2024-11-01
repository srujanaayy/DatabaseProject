LOAD DATA INFILE 'CardInformation.csv'
INTO TABLE CardInformation
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS -- ignore header in CSV file
(CardNumber, BillingAddress);

LOAD DATA INFILE 'Customer.csv'
INTO TABLE Customer
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(FirstName, LastName, EmailAddress, PhoneNumber, CardNumber); -- CustomerID not included because that is auto incremented


LOAD DATA INFILE 'Product.csv'
INTO TABLE Product
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ProductName, Description, Brand, Category, Price, StockQuantity, ReorderLevel, WarehouseLocation); -- ProductID not included because that is auto incremented, timestamp related not inlcuded for similar reason

LOAD DATA INFILE 'Orders.csv'
INTO TABLE Orders  
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CustomerID, Status, ShippingAddress); -- OrderID not included because that is auto incremented, timestamp related not inlcuded for similar reason

LOAD DATA INFILE 'Price.csv'
INTO TABLE Price  
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(BasePrice, Discount, Tax, ShippingFee, TotalPrice); 

LOAD DATA INFILE 'Payment.csv'
INTO TABLE Payment  
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CustomerID, BasePrice, Discount, Tax, ShippingFee);  -- PaymentID not included because that is auto incremented

LOAD DATA INFILE 'OrderedItem.csv'
INTO TABLE OrderedItem  
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ProductID, OrderID, PaymentID, Quantity); 

