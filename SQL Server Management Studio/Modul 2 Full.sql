/* Modul 2 */
/*1. Create*/
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

CREATE TABLE MsStaff
(
StaffId CHAR ( 5 ) NOT NULL PRIMARY KEY
CHECK(StaffId LIKE 'SF[0-9][0-9][0-9]'),
StaffName VARCHAR ( 50 ) ,
StaffGender VARCHAR ( 10 ) NOT NULL
CHECK (StaffGender LIKE 'Male' OR StaffGender LIKE 'Female'),
StaffPhone VARCHAR ( 13 ) ,
StaffAddress VARCHAR ( 100 ),
StaffSalary NUMERIC(11,2),
StaffPosition VARCHAR(20),
)

CREATE TABLE MsTreatmentType
(
TreatmentTypeId CHAR ( 5 ) NOT NULL PRIMARY KEY
CHECK(TreatmentTypeId LIKE 'TT[0-9][0-9][0-9]'),
TreatmentTypeName VARCHAR ( 50 ) ,
)

CREATE TABLE MsTreatment
(
TreatmentId CHAR(5) NOT NULL PRIMARY KEY
CHECK(TreatmentId LIKE 'TM[0-9][0-9][0-9]'),
TreatmentTypeId CHAR(5) NOT NULL FOREIGN KEY REFERENCES MsTreatmentType(TreatmentTypeId) ON UPDATE CASCADE ON DELETE CASCADE,
TreatmentName VARCHAR(50),
Price NUMERIC(11,2),
)

CREATE TABLE HeaderSalonServices
(
TransactionId CHAR(5) NOT NULL PRIMARY KEY
CHECK(TransactionId LIKE 'TR[0-9][0-9][0-9]'),
CustomerId CHAR(5) NOT NULL FOREIGN KEY REFERENCES MsCustomer(CustomerId) ON UPDATE CASCADE ON DELETE CASCADE,
StaffId CHAR(5) NOT NULL FOREIGN KEY REFERENCES MsStaff(StaffId) ON UPDATE CASCADE ON DELETE CASCADE,
TransactionDate DATE,
PaymentType VARCHAR(20),
)

CREATE TABLE DetailSalonServices
(
TransactionId CHAR(5) NOT NULL FOREIGN KEY REFERENCES HeaderSalonServices(TransactionId) ON UPDATE CASCADE ON DELETE CASCADE,
TreatmentId CHAR(5) NOT NULL FOREIGN KEY REFERENCES MsTreatment(TreatmentId) ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY(TransactionId,TreatmentId),
)

/*2. Drop Table*/
DROP TABLE DetailSalonServices

/*3. Create Detail and Alter*/
CREATE TABLE DetailSalonServices
(
TransactionId CHAR(5) NOT NULL FOREIGN KEY REFERENCES HeaderSalonServices(TransactionId) ON UPDATE CASCADE ON DELETE CASCADE,
TreatmentId CHAR(5) NOT NULL FOREIGN KEY REFERENCES MsTreatment(TreatmentId) ON UPDATE CASCADE ON DELETE CASCADE,
)

ALTER TABLE DetailSalonServices
ADD PRIMARY KEY (TransactionId, TreatmentId)

/*4. Add and Delete Constraint*/
ALTER TABLE MsStaff WITH NOCHECK
ADD CONSTRAINT ValidateStaffName CHECK(LEN(StaffName) BETWEEN 5 AND 20)

ALTER TABLE MsStaff
DROP CONSTRAINT ValidateStaffName

/*5. Add and Delete Description Column*/
ALTER TABLE MsTreatment
ADD Description varchar(100)

ALTER TABLE MsTreatment
DROP COLUMN Description