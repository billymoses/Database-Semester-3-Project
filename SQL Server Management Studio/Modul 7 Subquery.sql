/*
Session 07 - SQL – Data Manipulation (5)

Alias
-- for field name
SELECT { field_name AS field_alias | field_alias = field_name }
FROM table_name
-- for table name
SELECT { * | field_name [, …] }
FROM table_name [AS] table_alias
-- for subquery name
( SELECT { * | field_name [, …] }
FROM table_name [, …] )
[AS] table_alias

In
SELECT { * | field_name [, …] }
FROM table_name [, …]
WHERE field_name [NOT] IN ( { value1, value2 [, ...] | select_query } )

Exists
SELECT { * | field_name [, …] }
FROM table_name [, …]
WHERE [NOT] EXISTS (select_query)

All, Any, Some
SELECT { * | field_name [, …] }
FROM table_name [, …]
WHERE field_name { relational_operator} {ALL | ANY | SOME} ( select_query )

Select Into
SELECT { * | field_name [, …] }
INTO new_table [IN external_database]
FROM source
*/

/* 1. Display TreatmentId, and TreatmentName for every treatment which id is ‘TM001’ or
‘TM002’.
(in) */

SELECT TreatmentId,
TreatmentName
FROM MsTreatment
WHERE TreatmentId IN ('TM001', 'TM002')

/* 2. Display TreatmentName, and Price for every treatment which type is not ‘Hair Treatment’ and
‘Message / Spa’.
(in, not in) */

SELECT TreatmentName,
Price
FROM MsTreatment mt
WHERE mt.TreatmentTypeId IN (SELECT MsTreatmentType.TreatmentTypeId
-- IN defines a subquery (with the usage of WHERE in this case)
FROM MsTreatmentType 
WHERE TreatmentTypeName NOT IN ('Hair Treatment', 'Hair Spa Treatment')) -- doesn't include hair treatment nor hair spa treatment

/* 3. Display CustomerName, CustomerPhone, and CustomerAddress for every customer whose
name is more than 8 charactes and did transaction on Friday.
(len, in, datename, weekday) */

SELECT CustomerName,
CustomerPhone,
CustomerAddress
FROM MsCustomer mc
WHERE LEN (CustomerName) > 8 AND
mc.CustomerId IN (SELECT HeaderSalonServices.CustomerId -- start of the subquery with IN
FROM HeaderSalonServices -- IN ner join
WHERE DATENAME(WEEKDAY, TransactionDate) = 'Friday' ) -- weekday name is friday

/* 4. Display TreatmentTypeName, TreatmentName, and Price for every treatment that taken by
customer whose name contains ‘Putra’ and happened on day 22th.
(in, like, day) */

SELECT TreatmentTypeName,
TreatmentName,
Price
FROM MsTreatmentType mtt,
MsTreatment mt,
MsCustomer mc,
DetailSalonServices dss,
HeaderSalonServices hss
WHERE mtt.TreatmentTypeId = mt.TreatmentTypeId AND
mt.TreatmentId = dss.TreatmentId AND
hss.CustomerId = mc.CustomerId AND
dss.TransactionId = hss.TransactionId AND
mc.CustomerName IN (SELECT CustomerName
FROM MsCustomer
WHERE CustomerName LIKE '%Putra%' AND DAY(TransactionDate) = 26)

/* 5. Display StaffName, CustomerName, and TransactionDate (obtained from TransactionDate in
‘Mon dd,yyyy’ format) for every treatment which the last character of treatmentid is an even
number.
(convert, exists, right) */

SELECT StaffName,
CustomerName,
CONVERT (VARCHAR, TransactionDate, 107) AS TransactionDate, -- 107 untuk format Mon dd,yyyy
mt.TreatmentId -- tambahan untuk memastikan TreatmentId adalah genap
FROM MsStaff ms,
MsCustomer mc,
HeaderSalonServices hss,
DetailSalonServices dss,
MsTreatment mt
WHERE ms.StaffId = hss.StaffId AND -- pengen nangis liat ginian aha :V
mc.CustomerId = hss.CustomerId AND
dss.TransactionId = hss.TransactionId AND
dss.TreatmentId = mt.TreatmentId AND
EXISTS(SELECT TreatmentId -- tidak perlu diapa-apakan karena kondisi berada pada WHERE
FROM MsTreatment
WHERE MsTreatment.TreatmentId = dss.TreatmentId AND
RIGHT(TreatmentId, 2) % 2 = 0) -- mengambil angka paling belakang dari TreatmentId dan di mod 2 sampai sisa 0 (genap)

/* 6. Display CustomerName, CustomerPhone, and CustomerAddress for every customer that was
served by staff whose name’s length is an odd number.
(exists, len) */

SELECT CustomerName,
CustomerPhone,
CustomerAddress
FROM MsCustomer mc
WHERE EXISTS(SELECT StaffName
FROM MsStaff ms, HeaderSalonServices hss
WHERE mc.CustomerId = hss.CustomerId AND
ms.StaffId = hss.StaffId AND
LEN(StaffName) % 2 != 0); -- mengambil length dari nama staff dan di mod 2 sampai TIDAK sisa 0 (ganjil)

/* 7. Display ID (obtained form last 3 characters of StaffID), and Name (obtained by taking
character after the first space until character before second space in StaffName) for every staff
whose name contains at least 3 words and hasn’t served male customer .
(right, substring, charindex, len, exists, in,not like, like) */

--SUBSTRING(string, start, length)
/*string	Required. The string to extract from
start	Required. The start position. The first position in string is 1
length	Required. The number of characters to extract. Must be a positive number */

--CHARINDEX(substring, string, start)
/* substring	Required. The substring to search for
string	Required. The string to be searched
start	Optional. The position where the search will start (if you do not want to start at the beginning of string). The first position in string is 1 */

SELECT RIGHT(StaffId, 3) AS 'ID',
SUBSTRING(
StaffName, -- dari string staffname
CHARINDEX(' ', StaffName) + 1, -- kita mengambil posisi setelah spasi sebagai start
CHARINDEX(' ', StaffName) + 1 -- kemudian ngambil dari spasi lagi sebagai length
) AS 'Name'
FROM MsStaff
WHERE EXISTS (SELECT  StaffName, -- exists function
CustomerName
FROM    MsCustomer mc, HeaderSalonServices hss
WHERE   mc.CustomerId = hss.CustomerId AND
CustomerGender IN (SELECT CustomerGender -- function in with the WHERE condition
FROM MsCustomer
WHERE CustomerGender NOT LIKE 'Male') AND -- customer gender not male
LEN(StaffName) - LEN(REPLACE(StaffName, ' ', '')) + 1 LIKE 3 ) -- at least 3 words (after deduction, where staffname's length is decreased from
-- the length of staffname without spaces

/* 8. Display TreatmentTypeName, TreatmentName, and Price for every treatment which price is
higher than average of all treatment’s price.
(alias subquery, avg) */

SELECT TreatmentTypeName,
TreatmentName,
PRICE
FROM (SELECT AVG (Price) AS 'AveragePrice' -- start of alias subquery involving Average (Price)
FROM MsTreatment mt) pr, MsTreatmentType mtt -- alias is pr
INNER JOIN MsTreatment mt ON mt.TreatmentTypeId = mtt.TreatmentTypeId -- could also use WHERE
WHERE Price > pr.AveragePrice -- using the alias for reference and comparison

/* 9. Display StaffName, StaffPosition, and StaffSalary for every staff with highest salary or lowest
salary.
(alias subquery, max, min) */

SELECT StaffName,
StaffPosition,
ms.StaffSalary
FROM MsStaff ms, (SELECT MAX(StaffSalary) AS 'StaffSalary' -- start of subquery involving MAX and MIN from Staff Salary
FROM MsStaff) staffsalmax, (SELECT MIN(StaffSalary) AS 'StaffSalary'
FROM MsStaff) staffsalmin -- alias names are staffsalmax for max and staffsalmin for min
WHERE ms.StaffSalary = staffsalmax.StaffSalary OR ms.StaffSalary = staffsalmin.StaffSalary -- condition using the alias subquery

/* 10. Display CustomerName,CustomerPhone,CustomerAddress, and Count Treatment (obtained
from the total number of treatment) for every transaction which has the highest total number of
treatment.
(alias subquery, group by, max, count) */

SELECT CustomerName,
CustomerPhone,
CustomerAddress,
COUNT(dss.TreatmentId) AS [Count Treatment]
FROM MsCustomer mc, HeaderSalonServices hss, DetailSalonServices dss, MsTreatment mt,
(SELECT MAX(totalcount.total) AS maximum -- first subquery using the alias totalcount and the column total
FROM
(SELECT COUNT(dss.TreatmentId) AS total -- second subquery using the alias max
FROM MsCustomer mc, DetailSalonServices dss, HeaderSalonServices hss, MsTreatment mt
WHERE hss.CustomerId = mc.CustomerId AND
dss.TransactionId = hss.TransactionId AND
dss.TreatmentId = mt.TreatmentId
GROUP BY mc.CustomerName, mc.CustomerPhone, mc.CustomerAddress) totalcount) max
WHERE hss.CustomerId = mc.CustomerId AND
dss.TransactionId = hss.TransactionId AND
dss.TreatmentId = mt.TreatmentId -- ini membuat dss.TreatmentId dan mt.TreatmentId sama, jadi bisa menggantikan syarat lainnya
GROUP BY mc.CustomerName, mc.CustomerPhone, mc.CustomerAddress, max.maximum
HAVING COUNT(dss.TreatmentId) = max.maximum -- agar hanya menampilkan maximum