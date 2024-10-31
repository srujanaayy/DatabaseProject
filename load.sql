INSERT INTO Customer (FirstName, LastName, EmailAddress, PhoneNumber, CardNumber)
VALUES
    ('John', 'Doe', 'johndoe@example.com', '123-456-7890', '1111222233334444'),
    ('Jane', 'Smith', 'janesmith@example.com', '098-765-4321', '5555666677778888');

-- CardInformation table
INSERT INTO CardInformation (CardNumber, BillingAddress)
VALUES
    ('1111222233334444', '123 Main St, Anytown, USA'),
    ('5555666677778888', '456 Elm St, Othertown, USA');

-- Product table
INSERT INTO Product (ProductName, ProdDescription, Brand, Price, Category, StockQuantity, WarehouseLocation)
VALUES
    ('Laptop', 'High-performance laptop', 'BrandA', 999.99, 'Electronics', 10, 'Warehouse 1'),
    ('Headphones', 'Noise-cancelling headphones', 'BrandB', 199.99, 'Audio', 25, 'Warehouse 2'),
    ('Smartphone', 'Latest model smartphone', 'BrandC', 799.99, 'Electronics', 15, 'Warehouse 1');

-- Order table
INSERT INTO `Order` (CustomerID, Date, Status, ShippingAddress)
VALUES
    (1, '2023-10-01 10:30:00', 'Pending', '123 Main St, Anytown, USA'),
    (2, '2023-10-02 15:45:00', 'Shipped', '456 Elm St, Othertown, USA');

-- OrderedItem table
INSERT INTO OrderedItem (OrderID, ProductID, Quantity)
VALUES
    (1, 1, 1),  -- 1 Laptop ordered by John Doe
    (1, 2, 2),  -- 2 Headphones ordered by John Doe
    (2, 3, 1);  -- 1 Smartphone ordered by Jane Smith

-- Payment table
INSERT INTO Payment (CustomerID, BasePrice, Discount, Tax, ShippingFee)
VALUES
    (1, 1399.97, 50.00, 84.00, 15.00),  -- Payment for John Doe
    (2, 799.99, 0.00, 48.00, 10.00);    -- Payment for Jane Smith

-- Price table
INSERT INTO Price (PaymentID, TotalPrice)
VALUES
    (1, 1448.97),  -- Total for John Doe
    (2, 857.99);   -- Total for Jane Smith
