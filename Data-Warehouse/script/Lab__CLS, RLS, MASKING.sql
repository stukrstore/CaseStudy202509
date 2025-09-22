-------------
--CLS
-------------
GRANT SELECT ON dbo.Stores([ContinentName],[RegionCountryName],[StoreName]) to [fabric03@tskrtech.net]

-------------
--RLS
--https://learn.microsoft.com/ko-kr/fabric/data-warehouse/row-level-security
-------------
-- Create a table to store sales data
CREATE TABLE dbo.Orders (
    SaleID INT,
    SalesRep VARCHAR(100),
    ProductName VARCHAR(50),
    SaleAmount DECIMAL(10, 2),
    SaleDate DATE
);

-- Insert sample data
INSERT INTO dbo.Orders (SaleID, SalesRep, ProductName, SaleAmount, SaleDate)
VALUES
    (1, 'sopark@tskrtech.net', 'Smartphone', 500.00, '2023-08-01'),
    (2, 'sopark@tskrtech.net', 'Laptop', 1000.00, '2023-08-02'),
    (3, 'fabric02@tskrtech.net', 'Headphones', 120.00, '2023-08-03'),
    (4, 'fabric02@tskrtech.net', 'Tablet', 800.00, '2023-08-04'),
    (5, 'sopark@tskrtech.net', 'Smartwatch', 300.00, '2023-08-05'),
    (6, 'sopark@tskrtech.net', 'Gaming Console', 400.00, '2023-08-06'),
    (7, 'fabric02@tskrtech.net', 'TV', 700.00, '2023-08-07'),
    (8, 'fabric02@tskrtech.net', 'Wireless Earbuds', 150.00, '2023-08-08'),
    (9, 'sopark@tskrtech.net', 'Fitness Tracker', 80.00, '2023-08-09'),
    (10, 'fabric03@tskrtech.net', 'Camera', 600.00, '2023-08-10');


-- Creating schema for Security
CREATE SCHEMA Security;
GO
 
-- Creating a function for the SalesRep evaluation
CREATE FUNCTION Security.tvf_securitypredicate(@SalesRep AS nvarchar(50))
    RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS tvf_securitypredicate_result
WHERE @SalesRep = USER_NAME() OR USER_NAME() = 'sopark@tskrtech.net';
GO
 
-- Using the function to create a Security Policy
CREATE SECURITY POLICY SalesFilter
ADD FILTER PREDICATE Security.tvf_securitypredicate(SalesRep)
ON dbo.Orders
WITH (STATE = ON);
GO

GRANT SELECT ON dbo.Orders to [fabric03@tskrtech.net]
GO

-------------
--MASKING
--https://learn.microsoft.com/en-us/fabric/data-warehouse/howto-dynamic-data-masking
-------------
CREATE TABLE dbo.EmployeeData (
    EmployeeID INT
    ,FirstName VARCHAR(50) MASKED WITH (FUNCTION = 'partial(1,"-",2)') NULL
    ,LastName VARCHAR(50) MASKED WITH (FUNCTION = 'default()') NULL
    ,SSN CHAR(11) MASKED WITH (FUNCTION = 'partial(0,"XXX-XX-",4)') NULL
    ,email VARCHAR(256) NULL
    );
GO
INSERT INTO dbo.EmployeeData
    VALUES (1, 'TestFirstName', 'TestLastName', '123-45-6789','email@youremail.com');
GO
INSERT INTO dbo.EmployeeData
    VALUES (2, 'First_Name', 'Last_Name', '000-00-0000','email2@youremail2.com');
GO

SELECT * FROM dbo.EmployeeData;
GO

GRANT SELECT ON dbo.EmployeeData to [fabric03@tskrtech.net]
GO

