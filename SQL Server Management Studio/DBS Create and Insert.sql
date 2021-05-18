CREATE TABLE MsCustomer (
    CustomerId CHAR(5) NOT NULL,
    CustomerName VARCHAR(50),
    CustomerGender VARCHAR(10),
    CustomerPhone VARCHAR(13),
    CustomerAddress VARCHAR(100),
    PRIMARY KEY (CustomerId),
    CONSTRAINT Check_CustId CHECK (CustomerId LIKE ('CU[0-9][0-9][0-9]')),
    CONSTRAINT Check_CustGen CHECK (CustomerGender IN ('Male', 'Female'))
);

CREATE TABLE MsStaff (
    StaffId CHAR(5) NOT NULL,
    StaffName VARCHAR(50),
    StaffGender VARCHAR(10),
    StaffPhone VARCHAR(13),
    StaffAddress VARCHAR(100),
    StaffSalary NUMERIC(11,2),
    StaffPosition VARCHAR(20),
    PRIMARY KEY (StaffId),
    CONSTRAINT Check_StaffId CHECK (StaffId LIKE ('SF[0-9][0-9][0-9]'))
);

CREATE TABLE MsTreatmentType (
    TreatmentTypeId CHAR(5) NOT NULL,
    TreatmentTypeName VARCHAR(50),
    PRIMARY KEY (TreatmentTypeId),
    CONSTRAINT Check_TreatTypeId CHECK (TreatmentTypeId LIKE ('TT[0-9][0-9][0-9]'))
);

CREATE TABLE MsTreatment (
    TreatmentId CHAR(5) NOT NULL,
    TreatmentTypeId CHAR(5) NOT NULL,
    TreatmentName VARCHAR(50),
    Price NUMERIC(11,2),
    PRIMARY KEY (TreatmentId),
    FOREIGN KEY (TreatmentTypeId) REFERENCES MsTreatmentType(TreatmentTypeId) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Check_TreatId CHECK (TreatmentId LIKE ('TM[0-9][0-9][0-9]'))
);

CREATE TABLE HeaderSalonServices (
    TransactionId CHAR(5) NOT NULL,
    CustomerId CHAR(5) NOT NULL,
    StaffId CHAR(5) NOT NULL,
    TransactionDate DATE,
    PaymentType VARCHAR(20),
    PRIMARY KEY (TransactionId),
    FOREIGN KEY (CustomerId) REFERENCES MsCustomer(CustomerId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (StaffId) REFERENCES MsStaff(StaffId) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Check_TransId CHECK (TransactionId LIKE ('TR[0-9][0-9][0-9]'))
);

-- 
-- Detail Salon Services Table
-- 
CREATE TABLE DetailSalonServices (
    TransactionId CHAR(5) NOT NULL,
    TreatmentId CHAR(5) NOT NULL,
    FOREIGN KEY (TransactionId) REFERENCES HeaderSalonServices(TransactionId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (TreatmentId) REFERENCES MsTreatment(TreatmentId) ON UPDATE CASCADE ON DELETE CASCADE
);

/* INSERT */
-- MsCustomer
--

INSERT INTO MsCustomer (CustomerId,CustomerName,CustomerGender, CustomerPhone,CustomerAddress)
VALUES
    ('CU001', 'Franky', 'Male', '08566543338', 'Daan Mogot Baru Street no 6'),
    ('CU002', 'Emalia Dewi', 'Female', '085264782135', 'Tanjung Duren Street no 185'),
    ('CU003', 'Elysia Chen', 'Female', '085754206611', 'Kebon Jeruk Street no 120'),
    ('CU004', 'Brando Kartawijaya', 'Male', '081170225561', 'Greenvile Street no 88'),
    ('CU005', 'Andy Putra', 'Male', '087751321421', 'Sunter Street no 42');

--
-- MsStaff
--
INSERT INTO MsStaff
    (StaffId, StaffName, StaffGender, StaffPhone, StaffAddress, StaffSalary, StaffPosition)
VALUES
    ('SF001', 'Dian Felita Tanoto', 'Female', '085265442222', 'Palmerah Street no 56', 15000000, 'Top Stylist'),
    ('SF002', 'Mellissa Pratiwi', 'Female', '085755552011', 'Kebon Jerus Street no 151', 10000000, 'Top Stylist'),
    ('SF003', 'Livia Ashianti', 'Female', '085218542222', 'Kebon Jerus Street no 19', 7000000, 'Stylist'),
    ('SF004', 'Indra Saswita', 'Male', '085564223311', 'Sunter Street no 91', 7000000, 'Stylist'),
    ('SF005', 'Ryan Nixon Salim', 'Male', '085710255522', 'Sunter Street no 91', 3000000, 'Stylist'),
    ('SF006', 'Jeklin Harefa', 'Female', '085265433322', 'Kebon Jeruk Street no 140', 3000000, 'Stylist'),
    ('SF007', 'Lavinia', 'Female', '085755500011', 'Kebon Jeruk Street no 153', 3000000, 'Stylist'),
    ('SF008', 'Stephen Adrianto', 'Male', '085564223311', 'Mandala Street no 14', 3000000, 'Stylist'),
    ('SF009', 'Rico Wijaya', 'Male', '085710252525', 'Keluarga Street no 78', 3000000, 'Stylist'),
    ('SF010', 'Effendy Lesmana', 'Male', '085218587878', 'Tanggerang City Street no 88', FLOOR(RAND() * (5000000 - 3000000 + 1) + 3000000), 'Stylist');

--
-- MsTreatmentType
--

INSERT INTO MsTreatmentType
VALUES	
    ('TT001', 'Hair Treatment'),
    ('TT002', 'Hair Spa Treatment'),
    ('TT003', 'Make Up and Facial'),
    ('TT004', 'Menicure Pedicure'),
    ('TT005', 'Premium Treatment');

--
-- MsTreatment
--

INSERT INTO MsTreatment (TreatmentId, TreatmentTypeId, TreatmentName, Price)
VALUES 
    ('TM001','TT001','Cutting by Stylist','150000'),
	('TM002','TT001','Cutting by Top Stylist','450000'),
	('TM003','TT001','Cutting by Pony','50000'),
	('TM004','TT001','Blow','90000'),
	('TM005','TT001','Coloring','480000'),
	('TM006','TT001','Highlight','320000'),
	('TM007','TT001','Japanese Perm','700000'),
	('TM008','TT001','Digital Perm','1100000'),
	('TM009','TT001','Special Perm','1100000'),
	('TM010','TT001','Rebonding Treatment','110000'),
	('TM011','TT002','Creambath','150000'),
	('TM012','TT002','Hair Spa','250000'),
	('TM013','TT002','Hair Mask','250000'),
	('TM014','TT002','Hand Spa Reflexy','200000'),
	('TM015','TT002','Reflexy','250000'),
	('TM016','TT002','Back Teraphy Massage','300000'),
	('TM017','TT003','Make Up','500000'),
	('TM018','TT003','Make Up Wedding','5000000'),
	('TM019','TT003','Facial','300000'),
	('TM020','TT004','Manicure','80000'),
	('TM021','TT004','Pedicure','100000'),
	('TM022','TT004','Nail Extension','250000'),
	('TM023','TT004','Nail Acrylic Infill','340000'),
	('TM024','TT005','Japanese Treatment','350000'),
	('TM025','TT005','Scalp Treatment','250000'),
	('TM026','TT005','Crystal Treatment','400000');

--
-- HeaderSalonServices
-- 

INSERT INTO HeaderSalonServices (TransactionId, CustomerId, StaffId, TransactionDate, PaymentType)
VALUES
    ('TR001', 'CU001', 'SF004', '2012/12/20', 'Credit'),
    ('TR002', 'CU002', 'SF005', '2012/12/20', 'Credit'),
    ('TR003', 'CU003', 'SF003', '2012/12/20', 'Cash'),
    ('TR004', 'CU004', 'SF005', '2012/12/20', 'Debit'),
    ('TR005', 'CU005', 'SF003', '2012/12/21', 'Debit'), 
    ('TR006', 'CU001', 'SF005', '2012/12/21', 'Credit'),
    ('TR007', 'CU002', 'SF001', '2012/12/22', 'Cash'),
    ('TR008', 'CU003', 'SF002', '2012/12/22', 'Credit'),
    ('TR009', 'CU005', 'SF004', '2012/12/22', 'Debit'),
    ('TR010', 'CU001', 'SF004', '2012/12/23', 'Credit'),
    ('TR011', 'CU002', 'SF006', '2012/12/24', 'Credit'), -- 23 to 24 //
    ('TR012', 'CU003', 'SF007', '2012/12/24', 'Cash'),
    ('TR013', 'CU004', 'SF005', '2012/12/25', 'Debit'), -- 24 to 25 //
    ('TR014', 'CU005', 'SF007', '2012/12/25', 'Debit'),
    ('TR015', 'CU005', 'SF005', '2012/12/26', 'Credit'), -- 25 to 26 //
    ('TR016', 'CU002', 'SF001', '2012/12/26', 'Cash'),
    ('TR017', 'CU003', 'SF002', '2012/12/26', 'Credit'),
    ('TR018', 'CU005', 'SF001', '2012/12/27', 'Debit'); --

--
-- DetailSalonServices
--

INSERT INTO DetailSalonServices (TransactionId, TreatmentId)
VALUES
    ('TR010', 'TM003'),
    ('TR010', 'TM005'),
    ('TR010', 'TM010'),
    ('TR011', 'TM015'),
    ('TR011', 'TM025'),
    ('TR012', 'TM009'),
    ('TR013', 'TM003'),
    ('TR013', 'TM006'),
    ('TR013', 'TM015'),
    ('TR014', 'TM016'),
    ('TR015', 'TM016'),
    ('TR015', 'TM006'),
    ('TR016', 'TM015'),
    ('TR016', 'TM003'),
    ('TR016', 'TM005'),
    ('TR017', 'TM003'),
    ('TR018', 'TM006'),
    ('TR018', 'TM005'),
    ('TR018', 'TM007');