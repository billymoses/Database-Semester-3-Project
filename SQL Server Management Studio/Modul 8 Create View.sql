/*MODUL 8

Create view
Create view view_name
[ ( column , .....) ]
As subquery
[ with check option]

CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

Drop View
Drop view [view_name]

Alter View
ALTER VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;*/

/*1. Create a view named ‘ViewBonus’ to display BinusId (obtained from CustomerID by replacing
the first 2 characters with ‘BN ’), and CustomerName for every customer whose name is more
than 10 characters.
(create view, stuff, len) */

-- STUFF(string, start, length, new_string)
-- Stuff deletes [length] characters from [string] at starting position [start]
-- and inserts a [new_string].... ANGGAP AJA REPLACE :V

CREATE VIEW [ViewBonus] AS -- membuat fungsi view
SELECT STUFF (CustomerID, 1, 2, 'BN') AS BinusId, -- delete 2 character dari depan pada CustomerID, dan masukkan BN
CustomerName
FROM MsCustomer
WHERE LEN (CustomerName) > 10;

SELECT * FROM ViewBonus

DROP VIEW ViewBonus

/*2. Create a view named ‘ViewCustomerData’ to display Name (obtained from customer’s name from
the first character until a character before space), Address (obtained from CustomerAddress), and
Phone (obtained from CustomerPhone) for every customer whose name contains space.
(create view, substring, charindex) */

--SUBSTRING(string, start, length)	CHARINDEX(substring, string, start)

CREATE VIEW [ViewCustomerData] AS
SELECT SUBSTRING (CustomerName, 1, CHARINDEX(' ', CustomerName)) AS [Name], -- hanya mengambil character dari posisi 1 sampai spasi
CustomerAddress AS [Address],
CustomerPhone AS [Phone]
FROM MsCustomer
WHERE CustomerName LIKE '% %' -- bagi customername yang memiliki spasi

SELECT * FROM ViewCustomerData

DROP VIEW ViewCustomerData

/*3. Create a view named ‘ViewTreatment’ to display TreatmentName, TreatmentTypeName, Price
(obtained from Price by adding ‘Rp. ’ in front of Price) for every treatment which type is ‘Hair
Treatment’ and price is between 450000 and 800000.
(create view, cast, between) */

-- CAST(expression AS datatype(length))

CREATE VIEW [ViewTreatment] AS
SELECT TreatmentName,
TreatmentTypeName,
'Rp. ' + CAST (Price AS VARCHAR) AS [Price] -- dikarenakan price sebenarnya numerical, maka ganti aja jadi VARCHAR biar bs sambung string
FROM MsTreatment mt
INNER JOIN MsTreatmentType mtt ON mtt.TreatmentTypeId = mt.TreatmentTypeId
WHERE Price BETWEEN 450000 AND 800000 AND TreatmentTypeName LIKE 'Hair Treatment'

SELECT * FROM ViewTreatment

DROP VIEW ViewTreatment

/*4. Create a view named ‘ViewTransaction’ to display StaffName, CustomerName, TransactionDate
(obtained from TransactionDate in ‘dd mon yyyy’ format), and PaymentType for every transaction
which the transaction is between 21st and 25th day and was paid by ‘Credit’.
(create view, convert, day, between)*/

-- CONVERT(data_type(length), expression, style)

CREATE VIEW [ViewTransaction] AS
SELECT StaffName,
CustomerName,
CONVERT (DATE, TransactionDate,106) AS TransactionDate, -- 106 = dd Mon yyyy
PaymentType
FROM MsStaff ms, MsCustomer mc, HeaderSalonServices hss, DetailSalonServices dss
WHERE dss.TransactionId = hss.TransactionId AND hss.StaffId = ms.StaffId AND hss.CustomerId = mc.CustomerId
AND DAY (TransactionDate) BETWEEN 21 AND 25
AND PaymentType LIKE 'Credit'

SELECT * FROM ViewTransaction

DROP VIEW ViewTransaction

/*5. Create a view named ‘ViewBonusCustomer’ to display BonusId (obtained from CustomerId by
replacing ‘CU’ with ‘BN’), Name (Obtained from CustomerName by taking the next character
after space until the last character in lower case format), Day (obtained from the day when the
transaction happened), and TransactionDate (obtained from TransactionDate in ‘mm/dd/yy’
format) for every transaction which customer’s name contains space and staff’s last name contains
‘a’ character.
(create view, replace, lower, substring, charindex, len, datename, weekday, convert, like)*/

-- REPLACE(string, old_string, new_string)
-- SUBSTRING(string, start, length)
-- CHARINDEX(substring, string, start)

CREATE VIEW [ViewBonusCustomer] AS
SELECT REPLACE (mc.CustomerId, 'CU', 'BN') AS [BonusId],
LOWER (SUBSTRING (CustomerName, CHARINDEX (' ', CustomerName) + 1, LEN(CustomerName))) AS [Name], -- kapital jadi kecil
-- string +1 (agar tidak mengambil spasi), LEN = customer name (agar tidak kekurangan maupun kelebihan)
DATENAME(WEEKDAY, TransactionDate) AS [Day],
CONVERT (VARCHAR, TransactionDate, 1) AS [TransactionDate] -- data style 1 doesn't have century in the year (ikuti soal, bukan contoh)
FROM MsCustomer mc
INNER JOIN HeaderSalonServices hss ON hss.CustomerId = mc.CustomerId
INNER JOIN MsStaff ms ON ms.StaffId = hss.StaffId
WHERE CustomerName LIKE '% %'
AND RIGHT (StaffName, CHARINDEX (' ', StaffName)) LIKE '%a%' -- setelah spasi, cari awalan a

SELECT * FROM ViewBonusCustomer

DROP VIEW ViewBonusCustomer

/*6. Create a view named ‘ViewTransactionByLivia’ to display TransactionId, Date (obtained from
TransactionDate in ‘Mon dd, yyyy’ format), and TreatmentName for every transaction which
occurred on the 21st day and handled by staff whose name is ‘Livia Ashianti’.
(create view, convert, day, like) */

CREATE VIEW [ViewTransactionByLivia] AS
SELECT hss.TransactionId,
CONVERT (VARCHAR, TransactionDate, 107) AS [Date],
TreatmentName
FROM HeaderSalonServices hss
INNER JOIN MsStaff ms ON ms.StaffId = hss.StaffId
INNER JOIN DetailSalonServices dss ON dss.TransactionId = hss.TransactionId
INNER JOIN MsTreatment mt ON mt.TreatmentId = dss.TreatmentId
WHERE DAY(TransactionDate) = 24 AND StaffName LIKE 'Lavinia'

SELECT * FROM ViewTransactionByLivia -- data not shown correctly due to dss not having anything below TR010
--changed to date = 24 and staffname = Lavinia to show an existing data

DROP VIEW ViewTransactionByLivia

/*7. Change the view named ‘ViewCustomerData’ to ID (obtained from the last 3 digit characters of
CustomerID), Name (obtained from CustomerName), Address (obtained from CustomerAddress),
and Phone (obtained from CustomerPhone) for every customer whose name contains space.
(alter view, right, charindex) */

/*ALTER VIEW [ schema_name . ] view_name [ ( column [ ,...n ] ) ]   
[ WITH <view_attribute> [ ,...n ] ]   
AS select_statement   
[ WITH CHECK OPTION ] [ ; ]  */

ALTER VIEW [ViewCustomerData] AS
SELECT RIGHT (CustomerId, 3) AS ID,
CustomerName AS [Name], -- hanya mengambil character dari posisi 1 sampai spasi
CustomerAddress AS [Address],
CustomerPhone AS [Phone]
FROM MsCustomer
WHERE CustomerName LIKE '% %' -- bagi customername yang memiliki spasi

SELECT * FROM ViewCustomerData

DROP VIEW ViewCustomerData

/*8. Create a view named ‘ViewCustomer’ to display CustomerId, CustomerName, CustomerGender
from MsCustomer, then add the data to ViewCustomer with the following specifications: */
/* CustomerId: CU006
CustomerName: Cristian
CustomerGender: Male
CustomerPhone: NULL --
CustomerAddress: NULL --*/

CREATE VIEW [ViewCustomer] AS
SELECT CustomerId,
CustomerName,
CustomerGender,
CustomerPhone,
CustomerAddress
FROM MsCustomer

INSERT INTO ViewCustomer (CustomerId,CustomerName, CustomerGender) -- insert data ke View
VALUES ('CU006', 'Cristian', 'Male');

SELECT * FROM ViewCustomer
SELECT * FROM MsCustomer -- masuk table aslinya juga awokwokwok

DROP VIEW ViewCustomer

DELETE FROM MsCustomer
WHERE CustomerId LIKE 'CU006'

INSERT INTO MsCustomer
VALUES ('CU005', 'Andy Putra', 'Male', '087751321421', 'Sunter Street no 42')

/*9. Delete data in view ‘ViewCustomerData’ that has ID ‘005’. Then display all data from
ViewCustomerData.
(delete) */

DELETE FROM ViewCustomerData
WHERE ID = '005' -- delete 005 hya hya hya

SELECT * FROM ViewCustomerData
SELECT * FROM MsCustomer -- ntah napa ilang sini jg :') Astaga pengen nangis aaaaaaaaaaaaaaaaaaaaaaaa

/*10. Delete the view named ‘ViewCustomerData’.
(drop view)*/

DROP VIEW ViewCustomerData

SELECT * FROM ViewCustomerData