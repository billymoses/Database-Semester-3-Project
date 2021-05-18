/*Modul 3*/

/*Jaga-jaga kalo mau delete semua data dari 1 table*/
/*DELETE FROM MsStaff;*/

/*1. Insert da data */

/*
Insert Into
INSERT INTO table_name [ ( field1_name , field2_name [, ...] ) ]
VALUES ( value1 , value2 [, ...] ) 
*/ 

/* MsStaff */
INSERT INTO MsStaff (StaffId, StaffName, StaffGender, StaffPhone, StaffAddress, StaffSalary, StaffPosition)
VALUES ('SF006', 'Jeklin Harefa', 'Female', '085265433322', 'Kebon Jeruk Street no 140', '3000000', 'Stylist')

INSERT INTO MsStaff (StaffId, StaffName, StaffGender, StaffPhone, StaffAddress, StaffSalary, StaffPosition)
VALUES ('SF007', 'Lavinia', 'Female', '085755500011', 'Kebon Jeruk Street no 153', '3000000', 'Stylist')

INSERT INTO MsStaff (StaffId, StaffName, StaffGender, StaffPhone, StaffAddress, StaffSalary, StaffPosition)
VALUES ('SF008', 'Stephen Adrianto', 'Male', '085564223311', 'Mandala Street no 14', '3000000', 'Stylist')

INSERT INTO MsStaff (StaffId, StaffName, StaffGender, StaffPhone, StaffAddress, StaffSalary, StaffPosition)
VALUES ('SF009', 'Rico Wijaya', 'Male', '085710252525', 'Keluarga Street no 78', '3000000', 'Stylist')

/*Additional Data MsCustomer*/
INSERT INTO MsCustomer
VALUES ('CU001', 'Franky', 'Male', '628566543338', 'Daan mogot baru Street no 6'),
('CU002', 'Emalia Dewi ', 'Female', '6285264782135', 'Tanjung Duren Street no 185'),
('CU003', 'Elysia Chen', 'Female', '6285754206611', 'Kebon Jeruk Street no 120'),
('CU004', 'Brando Kartawijaya', 'Male', '6281170225561', 'Greenvil Street no 88'),
('CU005', 'Andy Putra', 'Male', '6287751321421', 'Sunter Street no 42');

/*Additional Data MsStaff*/
INSERT INTO MsStaff
VALUES ('SF001', 'Dian Felita Tanoto', 'Female', '085265442222', 'Palmerah Street no 56', '15000000.00', 'Top Stylist'),
('SF002', 'Mellisa Pratiwi', 'Female', '085755552011', 'Kebon Jeruk Street no 151', '10000000.00', 'Top Stylist'),
('SF003', 'Livia Ashianti', 'Female', '085218542222', 'Kebon Jeruk Street no 19', '7000000.00', 'Stylist'),
('SF004', 'Indra Saswita', 'Male', '085564223311', 'Sunter Street no 91', '7000000.00', 'Stylist'),
('SF005', 'Ryan Nixon Salim', 'Male', '085710255522', 'Kebon Jeruk Street no 123', '3000000.00', 'Stylist'),
('SF006', 'Jeklin Harefa', 'Female', '085265433322', 'Kebon Jeruk Street no 140', '3000000.00', 'Stylist'),
('SF007', 'Lavinia', 'Female', '085755500011', 'Kebon Jeruk Street no 153', '3000000.00', 'Stylist'),
('SF008', 'Stephen Adrianto', 'Male', '085564223311', 'Mandala Street no 14', '3000000.00', 'Stylist'),
('SF009', 'Rico Wijaya', 'Male', '085710252525', 'Keluarga Street no 78', '3000000.00', 'Stylist');

/*Additional Data MsTreatment*/
INSERT INTO MsTreatmentType (TreatmentTypeId, TreatmentTypeName)
VALUES ('TT001', 'Hair Treatment'),
('TT002', 'Hair Spa Treatment'),
('TT003', 'Make Up and Facial'),
('TT004', 'Menicure Pedicure'),
('TT005', 'Premium Treatment');

/*Additional Data MsTreatmentType*/
INSERT INTO MsTreatment
VALUES ('TM001', 'TT001', 'Cutting by Stylist', '150000'),
('TM002', 'TT001', 'Cutting by Top Stylist', '450000'),
('TM003', 'TT001', 'Cutting Pony', '50000'),
('TM004', 'TT001', 'Blow', '90000'),
('TM005', 'TT001', 'Coloring', '480000'),
('TM006', 'TT001', 'Highlight', '320000'),
('TM007', 'TT001', 'Japanese Perm', '700000'),
('TM008', 'TT001', 'Digital Perm', '1100000'),
('TM009', 'TT001', 'Special Perm', '1100000'),
('TM010', 'TT001', 'Rebonding Treatment', '1100000'),
('TM011', 'TT002', 'Creambath', '150000'),
('TM012', 'TT002', 'Hair Spa', '250000'),
('TM013', 'TT002', 'Hair Mask', '250000'),
('TM014', 'TT002', 'Hand Spa Reflexy', '200000'),
('TM015', 'TT002', 'Reflexy', '250000'),
('TM016', 'TT002', 'Back Theraphy Massage', '300000'),
('TM017', 'TT003', 'Make Up', '500000'),
('TM018', 'TT003', 'Make Up Wedding', '5000000'),
('TM019', 'TT003', 'Facial', '300000'),
('TM020', 'TT004', 'Manicure', '80000'),
('TM021', 'TT004', 'Pedicure', '100000'),
('TM022', 'TT004', 'Nail Extension', '250000'),
('TM023', 'TT004', 'Nail Acrylic Infill', '340000'),
('TM024', 'TT005', 'Japanese Treatment', '350000'),
('TM025', 'TT005', 'Scalp Treatment', '250000'),
('TM026', 'TT005', 'Crystal Treatment', '400000');

/* HeaderSalonServices */
INSERT INTO HeaderSalonServices
VALUES('TR010','CU001','SF004','2012/12/23','Credit'),
('TR011','CU002','SF006','2012/12/24','Credit'),
('TR012','CU003','SF007','2012/12/24','Cash'),
('TR013','CU004','SF005','2012/12/25','Debit'),
('TR014','CU005','SF007','2012/12/25','Debit'),
('TR015','CU005','SF005','2012/12/26','Credit'),
('TR016','CU002','SF001','2012/12/26','Cash'),
('TR017','CU003','SF002','2012/12/26','Credit'),
('TR018','CU005','SF001','2012/12/27','Debit');

/* DetailSalonServices */
INSERT INTO DetailSalonServices (TransactionId, TreatmentId)
VALUES ('TR010', 'TM003'),
('TR010','TM005'),
('TR010','TM010'),
('TR011','TM015'),
('TR011','TM025'),
('TR012','TM009'),
('TR013','TM003'),
('TR013','TM006'),
('TR013','TM015'),
('TR014','TM016'),
('TR015','TM016'),
('TR015','TM006'),
('TR016','TM015'),
('TR016','TM003'),
('TR016','TM005'),
('TR017','TM003'),
('TR018','TM006'),
('TR018','TM005'),
('TR018','TM007');

/*2. Insert da data		using dateadd, day, getdate*/
INSERT INTO HeaderSalonServices
VALUES('TR019','CU005','SF004',DATEADD(day,3,GETDATE()),'Credit');

/*3. Insert Random Number to MsStaff */
INSERT INTO MsStaff
VALUES('SF010','Effendy Lesmana','Male','085218587878','Tangerang City Street no 88',ROUND(RAND()*(5000000-3000000+1)+3000000,0),'Stylist');

/*4. Change CustomerPhone by replacing ‘08’ with ‘628’ on MsCustomer table. Then display all data on MsStaff table. */

/*Update
UPDATE table1_name
SET field1_name = new_value [, …]
[ FROM table1_name, table2_name [, …] ]
WHERE condition */

UPDATE MsCustomer
SET CustomerPhone = REPLACE(CustomerPhone,'628','08');

/*5. Change the StaffPosition into ‘Top Stylist ‘and add StaffSalary by 7000000 on MsStaff table for 
every staff whose name is ‘Effendy Lesmana’. Then display all data on MsStaff table.
(update, like) */

UPDATE MsStaff
SET StaffPosition = 'Top Stylist', StaffSalary = StaffSalary + 7000000
WHERE StaffName LIKE 'Effendy Lesmana';

/*6. Change the CustomerName into the first name of CustomerName (obtained from the first character
of CustomerName until character before space) on MsCustomer table for every customer who did
transaction on 24th day. Then display all data on MsCustomer table.
(update, left, charindex, datepart, day)*/

UPDATE MsCustomer
SET CustomerName = LEFT(CustomerName,CHARINDEX(' ',CustomerName))
FROM MsCustomer
INNER JOIN HeaderSalonServices
ON(MsCustomer.CustomerId = HeaderSalonServices.CustomerId)
WHERE DATEPART(day,TransactionDate) = 24;

/*7. Change CustomerName by adding ‘Ms. ’ in front of it on MsCustomer table for every customer
whose id is ‘CU002’ or ’ CU003’. Then display all data on MsCustomer table.
(update, in)*/

UPDATE MsCustomer
SET CustomerName = CONCAT ('Ms. ',CustomerName)
WHERE CustomerId IN ('CU002','CU003');

/*8. Change CustomerAddress into ‘Daan Mogot Baru Street No. 23’ on MsCustomer table for every
customer that has been served by staff whose name is ‘Indra Saswita’ and the transaction occurred
on Thursday. Then display all data on MsCustomer table.
(update, in, exists, datename, weekday) */

UPDATE MsCustomer
SET CustomerAddress = ('Daan Mogot Baru Street No. 23')
FROM MsCustomer
INNER JOIN HeaderSalonServices ON MsCustomer.CustomerId = HeaderSalonServices.CustomerId
INNER JOIN MsStaff ON HeaderSalonServices.StaffId = MsStaff.StaffId
WHERE EXISTS(SELECT StaffName FROM MsStaff WHERE MsStaff.StaffName = 'Indra Saswita'
AND DATENAME(WEEKDAY,HeaderSalonServices.TransactionDate) = 'Thursday');

/*Additional Data HeaderSalonServices*/
INSERT INTO HeaderSalonServices
VALUES ('TR001', 'CU001','SF004','2012/12/20','Credit'),
('TR002', 'CU002','SF005','2012/12/20','Credit'),
('TR003', 'CU003','SF003','2012/12/20','Cash'),
('TR004', 'CU004','SF005','2012/12/20','Debit'),
('TR005', 'CU005','SF003','2012/12/21','Debit'),
('TR006', 'CU001','SF005','2012/12/21','Credit'),
('TR007', 'CU002','SF001','2012/12/22','Cash'),
('TR008', 'CU003','SF002','2012/12/22','Credit'),
('TR009', 'CU005','SF004','2012/12/22','Debit');

/*9. Delete data on HeaderSalonServices table for every transaction which is done by the customer
whose name doesn’t contains space. Then display all data on HeaderSalonServices table.
(delete, join, charindex) */

DELETE FROM HeaderSalonServices
FROM HeaderSalonServices
INNER JOIN MsCustomer ON MsCustomer.CustomerId = HeaderSalonServices.CustomerId
WHERE (CHARINDEX(' ',CustomerName)) = 0;

/*10.Delete data on MsTreatment table for every treatment which type doesn’t contains ‘treatment’
word. Then display all data on MsTreatment table.
(delete, in, not like) */

DELETE FROM MsTreatment
FROM MsTreatment
INNER JOIN MsTreatmentType ON MsTreatmentType.TreatmentTypeId = MsTreatment.TreatmentTypeId
WHERE TreatmentTypeName NOT LIKE '%treatment%';

/*Change Join to only FROM & WHERE*/

/*	column(field) name harus sama, sementara variable name berbeda
FROM tablename1 variablename1, tablename2 variablename2


Where variablename1.column(field)name = variablename2.column(field)name
*/