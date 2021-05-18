CREATE TABLE MsCustomer
(
CustomerId CHAR ( 5 ) NOT NULL PRIMARY KEY
CHECK(CustomerId LIKE 'CU[0-9][0-9][0-9]'),
CustomerName VARCHAR ( 50 ) ,
CustomerGender VARCHAR ( 10 ) NOT NULL
CHECK (CustomerGender LIKE 'Male' OR CustomerGender LIKE 'Female'),
CustomerPhone VARCHAR ( 13 ) ,
CustomerAddress VARCHAR ( 100 )
)