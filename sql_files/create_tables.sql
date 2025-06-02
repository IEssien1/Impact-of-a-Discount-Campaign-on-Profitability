-- Customer Table
CREATE TABLE Customer (
    CustomerID varchar(15) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Gender VARCHAR(10),
    Email VARCHAR(255) NOT NULL,
    DateOfRegistration Date,
    ShippingAddress TEXT,
    PreferredPaymentMethod VARCHAR(25),
    PreferredCategories varchar(50),
    LoyaltyPoints INT,
    PhoneVerified VARCHAR(10),
    EmailVerified VARCHAR(10)
);


-- Product Table
CREATE TABLE Product (
    ProductID Varchar(25) PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    UnitPrice INT,
    Category VARCHAR(100),
    Stock INT DEFAULT 0,
    PopularityScore DECIMAL(5, 2), 
    ReturnRate DECIMAL(5, 2),
    CostPrice DECIMAL (10,2)
);

-- Transaction Table
CREATE TABLE Transaction (
    TransactionID varchar(25) PRIMARY KEY,
    CustomerID varchar(15) NOT NULL,
    CartStartTimestamp DATE,
    TransactionTimestamp DATE,
    TransactionDuration INT,
    ProductPurchased VARCHAR(15),
    Quantity INT,
    PaymentMethod VARCHAR(50),
    DeviceUsed VARCHAR(50),
    BrowserUsed VARCHAR(50),
    IPAddress VARCHAR(45),
    SuspiciousFlag VARCHAR(10),
    Abandoned VARCHAR(5),
    DeliveryStatus VARCHAR(10),
    ExpectedDeliveryDate DATE,
    Discount  DECIMAL(10,2),
    Region VARCHAR(25),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductPurchased) REFERENCES Product(ProductID)
);
