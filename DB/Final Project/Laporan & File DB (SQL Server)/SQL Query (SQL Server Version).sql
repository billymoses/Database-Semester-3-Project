/* Final Project Database Systems 
Billy Moses - 2301930476
Jonathan Evan Sampurna - 2301876612 
Gusti Sandyaga Putra Wardhana - 2301927916*/ 

-- create db
create database Final_Project

USE Final_Project

-- create tables
CREATE TABLE Patient 
(
	PatientId CHAR(5) PRIMARY KEY NOT NULL		
		CHECK(PatientId LIKE 'PT[0-9][0-9][0-9]'),
	PatientName VARCHAR(50) NOT NULL,
	PatientGender VARCHAR(10) NOT NULL
	 	CHECK(PatientGender IN ('Male', 'Female')),
	PatientAge NUMERIC(3) NOT NULL,
	PatientAddress VARCHAR(100) NOT NULL,
	PatientPhone VARCHAR(20) NOT NULL,
)

CREATE TABLE Staff
(
	StaffId CHAR(5) PRIMARY KEY NOT NULL
		CHECK(StaffId LIKE 'SF[0-9][0-9][0-9]'),
	StaffName VARCHAR(50) NOT NULL,
	StaffGender VARCHAR(10) NOT NULL
		CHECK(StaffGender IN ('Male', 'Female')),
	StaffAddress VARCHAR(100) NOT NULL,
	StaffPhone VARCHAR(20) NOT NULL,
	StaffSalary NUMERIC (11,2) NOT NULL,
)

CREATE TABLE Specialization
(
	SpecialistId CHAR(5) PRIMARY KEY NOT NULL
		CHECK(SpecialistId LIKE 'SP[0-9][0-9][0-9]'),
	Category VARCHAR(50) NOT NULL,
)

CREATE TABLE Doctor
(
	DoctorId CHAR(5) PRIMARY KEY NOT NULL
		CHECK(DoctorId LIKE 'DR[0-9][0-9][0-9]'),
	DoctorName VARCHAR(50) NOT NULL,
	DoctorGender VARCHAR(10) NOT NULL
		CHECK(DoctorGender IN ('Male', 'Female')),
	DoctorAddress VARCHAR(100) NOT NULL,
	DoctorPhone VARCHAR(20) NOT NULL,
	DoctorSalary NUMERIC (11,2) NOT NULL,
	SpecialistId CHAR(5) NOT NULL FOREIGN KEY REFERENCES Specialization(SpecialistId),
)

CREATE TABLE TreatmentType 
(
    TreatmentTypeId CHAR(5) PRIMARY KEY NOT NULL
  		CHECK(TreatmentTypeId LIKE 'TT[0-9][0-9][0-9]'),
    TreatmentTypeName VARCHAR(20) NOT NULL,
)

CREATE TABLE Treatment
(
	TreatmentId CHAR(5) PRIMARY KEY NOT NULL
		CHECK(TreatmentId LIKE 'TM[0-9][0-9][0-9]'),
	TreatmentName VARCHAR(50) NOT NULL,
	TreatmentPrice NUMERIC(11,2) NOT NULL,
	TreatmentTypeId CHAR(5) NOT NULL FOREIGN KEY REFERENCES TreatmentType(TreatmentTypeId) ON UPDATE CASCADE ON DELETE CASCADE,
)

CREATE TABLE Transactions
(
	TransactionId CHAR(5) PRIMARY KEY NOT NULL
		CHECK (TransactionId LIKE 'TR[0-9][0-9][0-9]'),
	PatientId CHAR(5) NOT NULL FOREIGN KEY REFERENCES Patient(PatientId) ON UPDATE CASCADE ON DELETE CASCADE,
	StaffId CHAR(5) NOT NULL FOREIGN KEY REFERENCES Staff(StaffId) ON UPDATE CASCADE ON DELETE CASCADE,
	DoctorId CHAR(5) NOT NULL FOREIGN KEY REFERENCES Doctor(DoctorId) ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionDate DATE NOT NULL,
	PaymentType VARCHAR(10) NOT NULL,
)

CREATE TABLE DetailTransaction
(
	PRIMARY KEY (TransactionId, TreatmentId),
	TransactionId CHAR(5) NOT NULL FOREIGN KEY REFERENCES Transactions(TransactionId) ON UPDATE CASCADE ON DELETE CASCADE,
	TreatmentId CHAR(5) NOT NULL FOREIGN KEY REFERENCES Treatment(TreatmentId) ON UPDATE CASCADE ON DELETE CASCADE,
)

CREATE TABLE DetailSchedule
(
	ShiftId CHAR(5) PRIMARY KEY NOT NULL
		CHECK(ShiftId LIKE 'SH[0-9][0-9][0-9]'),
	Day VARCHAR(10) NOT NULL,
	TimeStart VARCHAR(10) NOT NULL,
	TimeEnd VARCHAR(10) NOT NULL,
)

CREATE TABLE Schedule
(
	ScheduleId CHAR(5) PRIMARY KEY NOT NULL
		CHECK(ScheduleId LIKE 'SC[0-9][0-9][0-9]'),
	TransactionId CHAR(5) NOT NULL FOREIGN KEY REFERENCES Transactions(TransactionId) ON UPDATE CASCADE ON DELETE CASCADE,
	ShiftId CHAR(5) NOT NULL FOREIGN KEY REFERENCES DetailSchedule(ShiftId) ON UPDATE CASCADE ON DELETE CASCADE,
	ScheduleDate DATE NOT NULL,
)

CREATE TABLE Result 
(
	ResultId CHAR(5) PRIMARY KEY NOT NULL
		CHECK(ResultId LIKE 'RS[0-9][0-9][0-9]'),
	TransactionId CHAR(5) NOT NULL FOREIGN KEY REFERENCES Transactions(TransactionId) ON UPDATE CASCADE ON DELETE CASCADE,
	ResultDate DATE NOT NULL,
	TestResult VARCHAR(50) NOT NULL,
	Comment VARCHAR(100),
)

CREATE TABLE Tracing
(
	PatientId CHAR(5) NOT NULL FOREIGN KEY REFERENCES Patient(PatientId) ON UPDATE CASCADE ON DELETE CASCADE,
	RelatedName VARCHAR(50) NOT NULL,
	RelatedPhone VARCHAR(20) NOT NULL,
)

-- Insert Patient
INSERT INTO Patient
VALUES ('PT001', 'Mahesa Hakim', 'Male', '17', 'Perumahan Anya B4-7', '08515179716'),
       ('PT002', 'Nyoman Pranowo', 'Male', '70', 'Jl. Mustofa no.53', '08708343338'),
	   ('PT003', 'Paulin Laksmiwati', 'Female', '52', 'Jl. Sungai Vivian no.36', '08184656955'),
	   ('PT004', 'Cakrawala Kuswoyo', 'Male', '33', 'Jl. Bendungan Diana no.98', '083605264035'),
	   ('PT005', 'Bala Putra', 'Male', '36', 'Jl. Mardhiyah no.07', '08817341485'),
	   ('PT006', 'Dariati Rajata', 'Male', '48', 'Jl. Uwais no.08', '087050546644'),
	   ('PT007', 'Mahesa Situmorang', 'Male', '49', 'Jl. Siprus no.33', '08917083066'),
	   ('PT008', 'Vanya Yuliarti', 'Female', '19', 'Perumahan Dharmaputri A5', '085182066543'),
	   ('PT009', 'Raina Agustina', 'Female', '30', 'Jl. Sigura-gura no.42', '0806502764'),
	   ('PT010', 'Prasetya Adriansyah', 'Male', '51', 'Jl. Jembatan Julio no.5', '086648735411'),
	   ('PT011', 'Restu Mayasari', 'Female', '54', 'Jl. Macan no.11', '085320581604'),
	   ('PT012', 'Jindra Megantara', 'Male', '29', 'Jl. Tidar Selatan no.14', '089296752684'),
	   ('PT013', 'Ika Oktaviani', 'Female', '38', 'Jl. Puri Indah Sentosa no.27', '0851984036'),
	   ('PT014', 'Daniswara Hakim', 'Male', '45', 'Jl. Merauke no.31', '08453298997'),
	   ('PT015', 'Lantar Hidayanto', 'Male', '34', 'Jl. Teluk Bell no.55', '086296225391'),
	   ('PT016', 'Yusuf Rajasa', 'Male', '48', 'Jl. Sindoro no.4', '08737465540'),
	   ('PT017', 'Among Firmansyah', 'Male', '55', 'Jl. Kecapi no.88', '08733992479'),
	   ('PT018', 'Farhunnisa Namaga', 'Female', '61', 'Jl. Lumba Lumba Utara no.5', '086069582578'),
	   ('PT019', 'Gilda Palastri', 'Female', '31', 'Perumahan Bukit Emas LL4', '08630029431'),
	   ('PT020', 'Prabawa Latupono', 'Male', '34', 'Jl. Gereja no.14', '086828472898')

-- Insert Staff
INSERT INTO Staff
VALUES ('SF001', 'Catur Waluyo', 'Female', 'Jl. Wijayanti Green no.44', '08134130622', '4200000'),
       ('SF002', 'Maria Permata', 'Female', 'Jl. Mansur no.250', '082498535965', '4200000'),
	   ('SF003', 'Hari Rajata', 'Male', 'Jl. Bukit Marpaung no.45B', '087218899178', '2800000'),
	   ('SF004', 'Prima Simbolon', 'Female', 'Jl. Prabowo no.24', '08380696970', '2800000'),
	   ('SF005', 'Baktiono Wibowo', 'Male', 'Jl. Purnawati no.02', '0881415279', '2800000'),
	   ('SF006', 'Harjasa Hutasoit', 'Male', 'Jl. Dinding Tarihoran no.39', '08275334752', '2800000'),
	   ('SF007', 'Siska Astuti', 'Female', 'Jl. Jenderal Sudirman no.7', '088601410779', '2800000'),
	   ('SF008', 'Uchiha Itachi', 'Male', 'Jl. Konohagakure no.10', '088342533351', '2800000')

-- Insert Specialization
insert into Specialization 
values('SP001', 'Umum'),
	  ('SP002', 'Jantung dan Pembuluh Darah'),
	  ('SP003', 'Penyakit Dalam'),
	  ('SP004', 'Paru Paru dan Pernapasan'),
	  ('SP005', 'Telinga Hidung dan Tenggorokan')

-- Insert Doctor
insert into Doctor
values('DR001', 'Aswani Permadi', 'Male', 'Jl. Guntur no.69', '081622737483', '12500000', 'SP001'),
      ('DR002', 'Cahyanto Siregar', 'Male', 'Jl. Durian Runtuh no.8', '081622137423', '12500000', 'SP001'),
	  ('DR003', 'Calista Wahyuni', 'Female', 'Jl. Meriam no.5', '08142457483', '12500000', 'SP001'),
	  ('DR004', 'Sakura Pertiwi', 'Female', 'Jl. Konohagakure no.17', '081555788100', '15000000', 'SP001'),
	  ('DR005', 'Baktianto Samosir', 'Male', 'Jl. Hujan Lebat no.44', '0876551633', '42000000', 'SP002'),
	  ('DR006', 'Capa Pradana', 'Male', 'Jl. Arab Saudi no.90', '081622588900', '35000000', 'SP003'),
	  ('DR007', 'Jasmin Padmasari', 'Female', 'Jl. Serta Yesus no.78', '085888333100', '32000000', 'SP003'),
	  ('DR008', 'Praba Lazuardi', 'Male', 'Jl. Ketapel Perak no.31', '081233244255', '30000000', 'SP003'),
	  ('DR009', 'Eva Nuraini', 'Female', 'Jl. Salak no.99', '085655677688', '28000000', 'SP004'),
	  ('DR010', 'Sandiaga Uno', 'Male', 'Jl. Sengsara no.69', '081622737100', '23000000', 'SP005')

-- Insert TreatmentType
insert into TreatmentType
values('TT001', 'Laboratorium'),
	  ('TT002', 'Pencitraan'),
	  ('TT003', 'Fungsi Jantung'),
	  ('TT004', 'Fungsi Pernapasan'),
	  ('TT005', 'Fungsi Hati'),
	  ('TT006', 'Fungsi Ginjal'),
	  ('TT007', 'Coronavirus')

-- Insert Treatment
insert into Treatment 
values('TM001', 'Tes Darah Lengkap', '300000', 'TT001'),
	  ('TM002', 'Tes Urine', '65000', 'TT001'),
	  ('TM003', 'Tes Kolesterol', '63000', 'TT001'),
	  ('TM004', 'Tes Asam Urat', '72000', 'TT001'),
	  ('TM005', 'USG Abdomen', '300000', 'TT002'),
	  ('TM006', 'USG Mamae', '188000', 'TT002'),
	  ('TM007', 'Fotorontgen Dada', '220000', 'TT002'),
	  ('TM008', 'Fotorontgen Perut', '500000', 'TT002'),
	  ('TM009', 'MRI', '2000000', 'TT002'),
	  ('TM010', 'CT Scan', '1000000', 'TT002'),
	  ('TM011', 'Elektrokardiogram', '130000', 'TT003'),
	  ('TM012', 'Ekokardiografi', '970000', 'TT003'),
	  ('TM013', 'THT', '200000', 'TT004'),
	  ('TM014', 'Spirometry', '250000', 'TT004'),
	  ('TM015', 'ALP', '25000', 'TT005'),
	  ('TM016', 'Bilirubin', '350000', 'TT005'),
	  ('TM017', 'Albumin', '150000', 'TT005'),
	  ('TM018', 'Blood Urea Nitrogen', '68000', 'TT006'),
	  ('TM019', 'Kreatinin Darah', '70000', 'TT006'),
	  ('TM020', 'Rapid Antigen', '300000', 'TT007'),
	  ('TM021', 'Rapid Antibody', '1000000', 'TT007'),
	  ('TM022', 'Swab Test', '900000', 'TT007')

-- Insert Transaction
insert into Transactions 
values('TR001', 'PT001', 'SF001', 'DR001', '2021/01/04', 'Cash'),
('TR002', 'PT002', 'SF007', 'DR009', '2021/01/05', 'Credit'),
('TR003', 'PT003', 'SF004', 'DR005', '2021/01/06', 'Credit'),
('TR004', 'PT003', 'SF004', 'DR005', '2021/01/06', 'Credit'),
('TR005', 'PT004', 'SF005', 'DR006', '2021/01/07', 'Cash'),
('TR006', 'PT005', 'SF006', 'DR007', '2021/01/08', 'Cash')

-- Insert DetailTransaction
insert into DetailTransaction
values('TR001', 'TM020'),
('TR002','TM022'),
('TR003', 'TM011'),
('TR004','TM012'),
('TR005', 'TM020'),
('TR006', 'TM022')

-- Insert Detail Schedule
insert into DetailSchedule
values('SH001', 'Senin', '07:00', '11:00'),
	  ('SH002', 'Senin', '14:00', '17:00'),
	  ('SH003', 'Selasa', '07:00', '11:00'),
	  ('SH004', 'Selasa', '14:00', '17:00'),
	  ('SH005', 'Rabu', '07:00', '11:00'),
	  ('SH006', 'Rabu', '14:00', '17:00'),
	  ('SH007', 'Kamis', '07:00', '11:00'),
	  ('SH008', 'Kamis', '14:00', '17:00'),
	  ('SH009', 'Jumat', '07:00', '10:00'),
	  ('SH010', 'Jumat', '14:00', '17:00'),
	  ('SH011', 'Sabtu', '07:00', '11:00')

-- Insert Schedule
insert into Schedule 
values('SC001', 'TR001', 'SH001', '2021/01/04'),
('SC002', 'TR002', 'SH003', '2021/01/05'), 
('SC003', 'TR003', 'SH005', '2021/01/06'),
('SC004', 'TR004', 'SH005', '2021/01/07'),
('SC005', 'TR005', 'SH009', '2021/01/08'),
('SC006', 'TR006', 'SH011', '2021/01/09')

-- Insert Result
insert into Result 
values('RS001', 'TR001', '2021/01/05', 'Positive', 'Mohon isolasi di rumah selama dua minggu.'),
('RS002', 'TR002', '2021/01/06', 'Negative', 'Mohon dijaga kesehatannya'),
('RS003', 'TR003', '2021/01/07', 'Diagnosa jantung lemah', 'Mohon lakukan pemeriksaan lebih lanjut'),
('RS004', 'TR004', '2021/01/08', 'Pembengkakan jantung akibat obesitas', 'Minum obat secara teratur, Atur pola makan dan berolahraga ringan'),
('RS005', 'TR005', '2021/01/09', 'Positive', 'Mohon isolasi mandiri selama dua minggu'),
('RS006', 'TR006', '2021/01/11', 'Positive', 'Mohon isolasi mandiri selama dua minggu')

-- Insert Tracing
insert into Tracing
values('PT004', 'Billy Meses', '0895395196606'),
	  ('PT004', 'Gusti Sandyaga', '084384670913'),
	  ('PT004', 'Jonathan Evan', '087835681229'),
	  ('PT005', 'Christicia Jean', '083367841288')

-- Mencari Staff Paling Laku
CREATE VIEW [Staff Paling Laku] AS
SELECT TOP 1
 Staff.StaffId [Staff ID],
 Staff.StaffId [Staff Name],
 COUNT(Transactions.StaffId) [Jumlah Penanganan]
FROM Staff
INNER JOIN Transactions ON Staff.StaffId = Transactions.StaffId
GROUP BY Staff.StaffId, Staff.StaffName
ORDER BY COUNT(Transactions.StaffId) DESC

SELECT * FROM [Staff Paling Laku]

-- Mencari Staff Paling Gak Laku
CREATE VIEW [Staff Paling Tidak Laku] AS
SELECT TOP 1
 Staff.StaffId [Staff ID],
 Staff.StaffId [Staff Name],
 COUNT(Transactions.StaffId) [Jumlah Penanganan]
FROM Staff
INNER JOIN Transactions ON Staff.StaffId = Transactions.StaffId
GROUP BY Staff.StaffId, Staff.StaffName
ORDER BY COUNT(Transactions.StaffId) ASC

SELECT * FROM [Staff Paling Tidak Laku]


/*===============VIEW================== */
-- View All Related With Positive Patient
CREATE VIEW [ViewRelatedContact] AS
SELECT 
	Tracing.PatientId [Patient ID],
	Patient.PatientName [Patient Name],
	Patient.PatientPhone [Patient Phone],
	Result.ResultDate [First Day Of Isolation],
	DATEADD(day, 14, Result.ResultDate) [Until The Day After 2 Weeks],
	Staff.StaffId [Staff ID],
	Staff.StaffName [Staff Name],
	Staff.StaffPhone [Staff Phone],
	Doctor.DoctorId [Doctor ID],
	Doctor.DoctorName [Doctor Name],
	Doctor.DoctorPhone [Doctor Phone],
	Tracing.RelatedName [Other Related Person],
	Tracing.RelatedPhone [Other's Phone]
FROM Tracing
INNER JOIN Patient ON Tracing.PatientId = Patient.PatientId
INNER JOIN Transactions ON Patient.PatientId = Transactions.PatientId
INNER JOIN Staff ON Transactions.StaffId = Staff.StaffId
INNER JOIN Doctor ON Transactions.DoctorId = Doctor.DoctorId
INNER JOIN Result ON Transactions.TransactionId = Result.TransactionId

SELECT * FROM ViewRelatedContact

DROP VIEW ViewRelatedContact

-- View All Treatment Category, Name, and Price
CREATE VIEW [ViewTreatmentList] AS
SELECT 
	TreatmentType.TreatmentTypeName [Treatment Category],
	Treatment.TreatmentName [Treatment Name],
	Treatment.TreatmentPrice [Price]
FROM TreatmentType
INNER JOIN Treatment ON TreatmentType.TreatmentTypeId = Treatment.TreatmentTypeId

SELECT * FROM ViewTreatmentList

DROP VIEW ViewTreatmentList

-- View Treatment Taken By Patient
CREATE VIEW [ViewPatientTreatment] AS
SELECT 
	Patient.PatientId [Patient ID],
	Patient.PatientName [Patient Name],
	Treatment.TreatmentName [Treatment Name],
	Treatment.TreatmentPrice [Price],
	Transactions.TransactionDate [Transaction Date]
FROM Patient
INNER JOIN Transactions ON Patient.PatientId = Transactions.PatientId
INNER JOIN DetailTransaction ON Transactions.TransactionId = DetailTransaction.TransactionId
INNER JOIN Treatment ON DetailTransaction.TreatmentId = Treatment.TreatmentId

SELECT * FROM ViewPatientTreatment

DROP VIEW ViewPatientTreatment


/*===========STORED PROCEDURE=============*/
-- Stored Procedure 1
create procedure show_nota @nama varchar(50)
as
begin
select 
	transactions.TransactionId,
	patient.PatientId,
	patient.PatientName,
	transactions.TransactionDate,
	treatment.TreatmentName,
	treatment.TreatmentPrice,
	schedule.ScheduleDate
from 
	Patient,
	Transactions,
	DetailTransaction,
	Treatment,
	Schedule
where 
	patient.PatientId = Transactions.PatientId and
	transactions.TransactionId = DetailTransaction.TransactionId and
	DetailTransaction.TreatmentId = Treatment.TreatmentId and
	transactions.TransactionId = schedule.TransactionId and
	patientname = @nama 
end;

exec show_nota @nama = 'Mahesa Hakim';
exec show_nota @nama = 'Nyoman Pranowo';

drop procedure show_nota

-- Stored Procedure 2
create procedure show_result @nama2 varchar(50)
as
begin
select
	patient.PatientId,
	patient.PatientName,
	result.ResultDate,
	treatment.TreatmentName,
	result.TestResult,
	result.Comment,
	doctor.DoctorName
from 
	Patient,
	Transactions,
	Result,
	Doctor,
	DetailTransaction,
	Treatment
where
	patient.PatientId = transactions.PatientId and
	transactions.TransactionId = Result.TransactionId and
	transactions.DoctorId = doctor.DoctorId and
	transactions.TransactionId = DetailTransaction.TransactionId and
	DetailTransaction.TreatmentId = Treatment.TreatmentId
end;

exec show_result @nama2 = 'Mahesa Hakim'

drop procedure show_result

-- PROCEDURE 3, liat pasien
CREATE PROCEDURE SelectConfirmedPatients @InputTTID CHAR(5) AS
SELECT pt.PatientId, PatientName, PatientGender, PatientAge, PatientAddress, PatientPhone, TreatmentName FROM Patient pt, Transactions tr, DetailTransaction dt, Treatment tm, TreatmentType tt
WHERE pt.PatientId = tr.PatientId AND tr.TransactionId = dt.TransactionId AND dt.TreatmentId = tm.TreatmentId AND tm.TreatmentTypeId = tt.TreatmentTypeId
AND tm.TreatmentTypeID = @InputTTID
GO

EXEC SelectConfirmedPatients @InputTTID = 'TT007'

DROP PROCEDURE SelectConfirmedPatients

-- PROCEDURE 4, liat dokter dan spesialisasinya
CREATE PROCEDURE SelectSpecializedDoctor @InputCategory VARCHAR(50) AS
SELECT DoctorId, DoctorName, DoctorGender, DoctorAddress, DoctorPhone, DoctorSalary, Category
FROM Doctor dc, Specialization sp
WHERE dc.SpecialistId = sp.SpecialistId AND sp.Category = @InputCategory
GO

EXEC SelectSpecializedDoctor @InputCategory = 'Penyakit Dalam'

DROP PROCEDURE SelectSpecializedDoctor


/*=============TRIGGER==============*/
CREATE TRIGGER TrigTrans ON Transactions
AFTER INSERT AS
BEGIN
 SELECT TOP 1 *
 FROM Transactions ORDER BY TransactionID DESC
 END

BEGIN TRAN
INSERT INTO Transactions
VALUES ('TR005', 'PT004', 'SF005', 'DR006', '2021/01/07', 'Cash')

ROLLBACK

SELECT * FROM Transactions

DROP TRIGGER TrigTrans

-- Trigger detail transaction
CREATE TRIGGER TrigDetTrans ON DetailTransaction
AFTER INSERT AS
BEGIN
 SELECT TOP 1 *
 FROM DetailTransaction ORDER BY TransactionID DESC
 END

BEGIN TRAN
INSERT INTO DetailTransaction
VALUES ('TR005', 'TM018')

ROLLBACK

SELECT * FROM DetailTransaction

DROP TRIGGER TrigDetTrans

-- schedule
CREATE TRIGGER TrigSch ON Schedule
AFTER INSERT AS
BEGIN
 SELECT TOP 1 *
 FROM Schedule
 ORDER BY ScheduleId DESC
 END

BEGIN TRAN
INSERT INTO Schedule
VALUES ('SC005', 'TR005', 'SH005', '2021/01/07')

ROLLBACK

SELECT * FROM Schedule

DROP TRIGGER TrigSch

-- result
CREATE TRIGGER TrigRes ON Result
AFTER INSERT AS
BEGIN
 SELECT TOP 1 * FROM Result
 END

BEGIN TRAN
INSERT INTO Result
VALUES ('RS005', 'TR005', '2021/01/08', 'Negative', 'Mohon dijaga kesehatannya')

ROLLBACK

SELECT * FROM Result

DROP TRIGGER TrigRes


/*==============FUNCTION===============*/
 select 
 patient.PatientName,
 tracing.RelatedName,
 tracing.RelatedPhone,
 doctor.DoctorName,
 staff.StaffName,
 result.TestResult,
 result.Comment
from tracing, patient, transactions, Doctor, Staff, Result
where
 tracing.PatientId = patient.PatientId and
 patient.PatientId = transactions.PatientId and
 transactions.DoctorId = Doctor.DoctorId and
 Transactions.StaffId = Staff.StaffId and
 Transactions.TransactionId = Result.TransactionId

-- Treatment yang harganya kurang dari 1jt
SELECT 
	TreatmentType.TreatmentTypeName [Treatment Type],
	Treatment.TreatmentName [Treatment Name],
	Treatment.TreatmentPrice [Price]
FROM TreatmentType
INNER JOIN Treatment ON TreatmentType.TreatmentTypeId = Treatment.TreatmentTypeId
WHERE Treatment.TreatmentPrice < 1000000

-- Transaksi yang dibayar dengan uang cash
SELECT 
	Transactions.TransactionId [Transaction ID],
	Patient.PatientName [Patient Name],
	Transactions.TransactionDate [Transaction Date],
	Transactions.PaymentType [Payment Type]
FROM Transactions
INNER JOIN Patient ON Transactions.PatientId = Patient.PatientId
WHERE PaymentType LIKE 'Cash'
