CREATE TABLE DetailSalonServices
(
TransactionId CHAR(5) NOT NULL FOREIGN KEY REFERENCES HeaderSalonServices(TransactionId) ON UPDATE CASCADE,
TreatmentId CHAR(5) NOT NULL FOREIGN KEY REFERENCES MsTreatment(TreatmentId) ON UPDATE CASCADE,
)