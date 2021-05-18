CREATE TABLE MsTreatmentType
(
TreatmentTypeId CHAR ( 5 ) NOT NULL PRIMARY KEY
CHECK(TreatmentTypeId LIKE 'TT[0-9][0-9][0-9]'),
TreatmentTypeName VARCHAR ( 50 ) ,
)