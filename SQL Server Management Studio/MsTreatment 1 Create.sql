CREATE TABLE MsTreatment
(
TreatmentId CHAR(5) NOT NULL PRIMARY KEY
CHECK(TreatmentId LIKE 'TM[0-9][0-9][0-9]'),
TreatmentTypeId CHAR(5) NOT NULL FOREIGN KEY REFERENCES MsTreatmentType(TreatmentTypeId) ON UPDATE CASCADE,
TreatmentName VARCHAR(50),
Price NUMERIC(11,2),
)