/*
Session 06 - SQL – Data Manipulation (4)

Join
SELECT { * | field_name [, …] }
FROM first_table [INNER | LEFT | RIGHT | FULL] JOIN second_table
ON first_table.keyfield = second_table.foreign_keyfield

Union
select_query1
{UNION | UNION ALL | INTERSECT | EXCEPT }
select_query2
*/

/*1. Display TreatmentTypeName, TreatmentName, and Price for every treatment which name
contains ‘hair’ or start with ‘nail’ word and has price below 100000.
(join, like) */

SELECT TreatmentTypeName, TreatmentName, Price
FROM MsTreatment
INNER JOIN MsTreatmentType -- gabung MsTT dengan Mt
ON MsTreatment.TreatmentTypeId = MsTreatmentType.TreatmentTypeId -- lanjutan Inner Join
WHERE (TreatmentTypeName LIKE '%hair%' OR TreatmentTypeName LIKE 'menicure%') AND Price < 100000 -- nail diganti menicure (sesuai tabel)
-- %hair% untuk posisi manapun, menicure% untuk posisi pertama

--versi kondisi join ada di WHERE
SELECT TreatmentTypeName, TreatmentName, Price
FROM MsTreatment mt, MsTreatmentType mtt
WHERE mt.TreatmentTypeId = mtt.TreatmentTypeId AND
(TreatmentTypeName LIKE '%hair%' OR TreatmentTypeName LIKE 'menicure%') AND Price < 100000

/*2. Display StaffName and StaffEmail (obtained from the first character of staff’s name in
lowercase format and followed with last word of staff’s name and ‘@oosalon.com’ word) for
every staff who handle transaction on Thursday.The duplicated data must be displayed only
once.
(distinct, lower, left, reverse, left, charindex, join, datename, weekday, like) */

SELECT DISTINCT MsStaff.StaffName, -- distinct = unik (1 hasil saja)
LOWER(LEFT(MsStaff.StaffName, 1)) + 
-- ambil huruf pertama dari staffname mulai dari kiri
LOWER(REVERSE(LEFT(REVERSE(StaffNAme), CHARINDEX (' ', REVERSE(StaffName)) -1))) + '@oosalon.com' AS 'Staff Email'
-- pakai - 1 agar spasi tidak diterima (karena pencarian charindex menghitung dari spasi)
FROM MsStaff
INNER JOIN HeaderSalonServices ON HeaderSalonServices.StaffId = MsStaff.StaffId
WHERE DATENAME(WEEKDAY, HeaderSalonServices.TransactionDate) = 'Thursday'; -- hari adalah kamis

/*3. Display New Transaction ID (obtained by replacing ‘TR’ in TransactionID with ‘Trans’), Old
Transaction ID (obtained from TransactionId), TransactionDate, StaffName, and
CustomerName for every transaction which happened 2 days before 24th December 2012.
(replace, join, datediff, day) */

SELECT 
REPLACE (TransactionId, 'TR', 'Trans ') AS 'New Transaction ID', --replace TR dengan Trans
TransactionId AS 'Old Transaction ID',
TransactionDate,
StaffName,
CustomerName
FROM HeaderSalonServices
INNER JOIN MsStaff ON HeaderSalonServices.StaffId = MsStaff.StaffId
INNER JOIN MsCustomer ON HeaderSalonServices.CustomerId = MsCustomer.CustomerId
WHERE DATEDIFF(DAY, TransactionDate, '2012-12-24') = 2 -- perbedaan hari 2

-- apabila mau menggunakan Tdate di belakang
WHERE DATEDIFF(DAY, '2012-12-24', TransactionDate) = -2 -- perbedaan hari -2

/*4. . Display New Transaction Date (obtained by adding 5 days to TransactionDate), Old
Transaction Date (obtained from TransactionDate), and CustomerName for every transaction
which didn’t happen on day 20th
(dateadd, day, join, datepart) */

SELECT
DATEADD (DAY, 5, TransactionDate) AS 'New Transaction Date', -- transaction date ditambah 5
TransactionDate AS 'Old Transaction Date',
CustomerName
FROM HeaderSalonServices
INNER JOIN MsCustomer ON MsCustomer.CustomerId = HeaderSalonServices.CustomerId
WHERE DATEPART (DAY, TransactionDate) != 20 -- datepart = return specified date

/*5. Display Day (obtained from the day transaction happened), CustomerName, and
TreatmentName for every Customer who was handled by female staff that has position name
begin with ‘TOP’ word. Then order the data based on CustomerName in ascending format.
(datename, weekday, join, in, like, order by) */
-- gak tau ini subquery apa bukan
SELECT
DATENAME (WEEKDAY, TransactionDate) AS 'Day',
CustomerName,
TreatmentName
FROM HeaderSalonServices
INNER JOIN MsCustomer ON MsCustomer.CustomerId = HeaderSalonServices.CustomerId
INNER JOIN DetailSalonServices ON DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId
INNER JOIN MsTreatment ON MsTreatment.TreatmentId = DetailSalonServices.TreatmentId
INNER JOIN MsStaff ON MsStaff.StaffId = HeaderSalonServices.StaffId
WHERE StaffGender IN ('Female') AND StaffPosition LIKE 'TOP%'
ORDER BY CustomerName ASC

/*6. Display the first data of CustomerId, CustomerName, TransactionId, Total Treatment
(obtained from the total number of treatment). Then sort the data based on Total Treatment in
descending format.
(top, count, join, group by, order by) */

SELECT TOP 1 MsCustomer.CustomerId,
CustomerName,
DetailSalonServices.TransactionId,
COUNT (MsTreatment.TreatmentId) AS 'Total Number of Treatment'
FROM MsCustomer
INNER JOIN HeaderSalonServices ON HeaderSalonServices.CustomerId = MsCustomer.CustomerId
INNER JOIN DetailSalonServices ON DetailSalonServices.TransactionId = HeaderSalonServices.TransactionId
INNER JOIN MsTreatment ON MsTreatment.TreatmentId = DetailSalonServices.TreatmentId
GROUP BY MsCustomer.CustomerId, MsCustomer.CustomerName, DetailSalonServices.TransactionId
ORDER BY [Total Number of Treatment] DESC

/*7. Display CustomerId, TransactionId, CustomerName, and Total Price (obtained from total
amount of price) for every transaction with total price is higher than the average value of
treatment price from every transaction. Then sort the data based on Total Price in descending
format.
(sum, join, alias subquery,avg, group by, having, order by) */

-- alias subquery = subquery yang memiliki alias, fungsinya adalah untuk menampung nilai yang ada
-- alias = nama singkat / panggilan untuk tabel

SELECT MsCustomer.CustomerId,
HeaderSalonServices.TransactionId,
CustomerName,
SUM(Price) AS [Total Price]
FROM (SELECT AVG(Price) AS 'Average' FROM MsTreatment ) avr, MsCustomer
INNER JOIN HeaderSalonServices ON HeaderSalonServices.CustomerId = MsCustomer.CustomerId
INNER JOIN DetailSalonServices ON HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId
INNER JOIN MsTreatment ON DetailSalonServices.TreatmentId = MsTreatment.TreatmentId
GROUP BY MsCustomer.CustomerId, HeaderSalonServices.TransactionId, MsCustomer.CustomerName, avr.Average
HAVING SUM(Price) > avr.Average
ORDER BY [Total Price] DESC;

/*8. Display Name (obtained by adding ‘Mr. ’ in front of StaffName), StaffPosition, and
StaffSalary for every male staff. The combine it with Name (obtained by adding ‘Ms. ’ in front
of StaffName), StaffPosition, and StaffSalary for every female staff. Then sort the data based
on Name and StaffPosition in ascending format.
(union, order by) */

SELECT CONCAT ('Mr. ', StaffName) AS 'Name',
StaffPosition,
StaffSalary
FROM MsStaff
WHERE StaffGender LIKE 'Male'
UNION -- gabungin SELECT A dengan SELECT B agar berada di tabel dan kolom yang sama
SELECT CONCAT ('Ms. ', StaffName) AS 'Name',
StaffPosition,
StaffSalary
FROM MsStaff
WHERE StaffGender LIKE 'Female'
ORDER BY 'Name', StaffPosition ASC

/*9. Display TreatmentName, Price (obtained by adding ‘Rp. ’ in front of Price), and Status as
‘Maximum Price’ for every Treatment which price is the highest treatment’s price. Then
combine it with TreatmentName, Price (obtained by adding ‘Rp. ’ in front of Price), and Status
as ‘Minimum Price’ for every Treatment which price is the lowest treatment’s price.
(cast, max, alias subquery, union, min) */

SELECT TreatmentName,
'Rp. ' + CAST(Price AS VARCHAR) AS Price,
'Maximum Price' AS 'Status' -- tabel baru untuk mendefinisikan Maximum Price
FROM MsTreatment mtr, (SELECT MAX (Price) AS 'Maximum'
FROM MsTreatment) mt -- alias subquery, dimana MAX price kita bisa sebut sebagai tabel bernama mt dan Maximum sebagai kolomnya
WHERE Price = mt.Maximum -- WOW
UNION
SELECT TreatmentName,
'Rp. ' + CAST(Price AS VARCHAR) AS Price,
'Minimum Price' AS 'Status' -- tabel baru untuk mendefinisikan Minimum Price
FROM MsTreatment mtr, (SELECT Min (Price) AS 'Minimum'
FROM MsTreatment) mt -- alias subquery
WHERE Price = mt.Minimum -- WOW

/*10. Display Longest Name of Staff and Customer (obtained from CustomerName), Length of
Name (obtained from length of customer’s name), Status as ‘Customer’ for every customer
who has the longest name. Then combine it with Longest Name of Staff and Customer
(obtained from StaffName), Length of Name (obtained from length of staff’s name), Status as
‘Staff’ for every staff who has the longest name
(len, max, alias subquery, union) */

SELECT CustomerName AS 'Longest Name of Staff and Customer',
LEN (CustomerName) AS 'Length of Name', -- return int dengan value dari jumlah panjang customername
'Customer' AS 'Status' -- status menyatakan customer
FROM MsCustomer mc, (SELECT Max (LEN(CustomerName)) AS 'Customer'
FROM MsCustomer) mcc -- alias subquery dimana mcc menampung tabel bernama mcc dengan nama customer terpanjang, disebut Customer
WHERE LEN(CustomerName) = mcc.Customer -- length customername = max length customername (diambil maksimum)
UNION
SELECT StaffName AS 'Longest Name of Staff and Customer',
LEN (StaffName) AS 'Length of Name',
'Staff' AS 'Status'
FROM MsStaff ms, (SELECT Max (LEN(StaffName)) AS 'Staff'
FROM MsStaff) mss -- alias subquery
WHERE LEN(StaffName) = mss.Staff