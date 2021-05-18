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