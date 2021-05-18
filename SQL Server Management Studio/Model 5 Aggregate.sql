/*Modul 5 Aggregate */
/*
Select
SELECT { * | field_name [, …] }
FROM table_name [, …]
Distinct
SELECT DISTINCT { * | field_name [, …] }
FROM table_name [, …]
Where
SELECT { * | field_name [, …] }
FROM table_name [, …]
WHERE {condition}
Between
SELECT { * | field_name [, …] }
FROM table_name [, …]
WHERE field_name BETWEEN value1 AND value2
Like
SELECT { * | field_name [, …] }
FROM table_name [, …]
WHERE field_name LIKE {PATTERN}
*/

/*
Aggregate
These are the aggregate functions:
1. Sum(field_name) = to sum the total content of the field.
2. Count(field_name) = to count the total of rows from the data.
3. Avg(field_name)= to count the average from content of the rows.
4. Max(field_name)= to count the maximum value from content of the rows.
5. Min(field_name)= to count the minimum value from content of the rows.
Additional syntax:
1. Order by = to sort the data. The default format is ascending.
2. Group by = to group the data that not use the aggregate function.
3. Having = to make a condition for aggregate function that we used.
The order of using the syntax:
o group by
o having (to use having, must use group by)
o order by
*/

/*1. Display Maximum Price (obtained from the maximum price of all treatment), Minimum Price
(obtained from minimum price of all treatment), and Average Price (obtained by rounding the
average value of Price in 2 decimal format).
(max, min, cast, round, avg)*/
SELECT MAX(Price) [Maximum Price of All Treatment], --displays max
MIN(Price) [Minimum Price of All Treatment], --displays min
CAST (ROUND (AVG(Price),0) AS NUMERIC(11, 2)) [Average Price of All Treatment] -- Round to [0th] position from . AND Precision 11, scale of 2
FROM MsTreatment

/*2. Display StaffPosition, Gender (obtained from first character of staff’s gender), and Average Salary
(obtained by adding ‘Rp.’ in front of the average of StaffSalary in 2 decimal format).
(left, cast, avg, group by) */
SELECT StaffPosition,
LEFT(StaffGender,1) AS Gender, --takes 1st letter from left
CONCAT('Rp. ', CAST(AVG(StaffSalary) AS NUMERIC(11,2))) AS [Average Salary] -- concat adds string, cast gives precise numeric
FROM MsStaff
GROUP BY StaffPosition, StaffGender; --squishes them together

/*3. Display TransactionDate (obtained from TransactionDate in ‘Mon dd,yyyy’ format), and Total
Transaction per Day (obtained from the total number of transaction).
(convert, count, group by) */
SELECT CONVERT (VARCHAR, TransactionDate, 107) AS TransactionDate, -- converts a value (of any type) into a specified datatype
-- convert datetime to character (with century) = 107 is Mon dd,yyyy
COUNT (TransactionDate) AS [Total Number of Transaction] -- returns the number of records returned by a select query
FROM HeaderSalonServices
GROUP BY TransactionDate

/*4. Display CustomerGender (obtained from customer’s gender in uppercase format), and Total
Transaction (obtained from the total number of transaction).
(upper, count, group by) */
SELECT UPPER(CustomerGender) AS CustomerGender, -- uppercases all characters
COUNT (TransactionID) AS [Total Number of Transaction] -- counts the number of record
FROM MsCustomer mc, HeaderSalonServices hss
WHERE mc.CustomerID = hss.CustomerID
GROUP BY CustomerGender -- squish the genders

/*5. Display TreatmentTypeName, and Total Transaction (obtained from the total number of
transaction). Then sort the data in descending format based on the total of transaction.
(count, group by, order by) */
SELECT TreatmentTypeName,
COUNT(hss.TransactionId) AS [Total Transaction] -- counts number of transactions lalalala
FROM MsTreatmentType mtt, MsTreatment mt, DetailSalonServices dss, HeaderSalonServices hss
WHERE mtt.TreatmentTypeId = mt.TreatmentTypeId AND dss.TreatmentId = mt.TreatmentId AND dss.TransactionId = hss.TransactionId
GROUP BY TreatmentTypeName
ORDER BY [Total Transaction] DESC -- order in descending order (high - low)

/*6. Display Date (obtained from TransactionDate in ‘dd mon yyyy’ format), Revenue per Day
(obtained by adding ‘Rp. ’ in front of the total of price) for every transaction which Revenue Per
Day is between 1000000 and 5000000.
(convert, cast, sum, group by, having) */
SELECT 
CONVERT (VARCHAR, TransactionDate, 106) AS Date, --106 (With Century) is dd mon yyyy
CONCAT ('Rp.', CAST(SUM(Price) AS NUMERIC (11,2))) AS [Revenue Per Day] -- concat gabungin, cast numeric, sum jumlahin
FROM HeaderSalonServices hss, DetailSalonServices dss, MsTreatment mt
WHERE hss.TransactionId = dss.TransactionId AND mt.TreatmentId = dss.TreatmentId
GROUP BY TransactionDate -- squish transaction date
HAVING SUM(Price) BETWEEN 1000000 AND 5000000 -- mirip WHERE, but for aggregate functions
--doesn't diplay correctly (pdf has TR001 - 004 included, the table doesn't have any...)


/*7. Display ID (obtained by replacing ‘TT0’ in TreatmentTypeID with ‘Treatment Type’),
TreatmentTypeName, and Total Treatment per Type (obtained from the total number of treatment
and ended with ‘ Treatment ’) for treatment type that consists of more than 5 treatments. Then sort
the data in descending format based on Total Treatment per Type.
(replace, cast, count, group by, having, order by) */
SELECT 
REPLACE (mt.TreatmentTypeId, 'TT0', 'Treatment Type ') AS ID,
TreatmentTypeName,
CONCAT (CAST(COUNT(TreatmentId) AS NUMERIC), ' Treatment') AS [Total Treatment Per Type]
FROM MsTreatment mt, MsTreatmentType mtt
WHERE mt.TreatmentTypeId = mtt.TreatmentTypeId
GROUP BY TreatmentTypeName, mt.TreatmentTypeId
HAVING COUNT(TreatmentId) > 5 -- total treatment more than 5
ORDER BY COUNT(TreatmentId) DESC

/* 8. Display StaffName (obtained from first character of staff’s name until character before space),
TransactionID, and Total Treatment per Transaction (obtained from the total number of treatment).
(left, charindex, count, group by) */
SELECT
CASE
CHARINDEX(' ', ms.StaffName) WHEN 0 -- Shows StaffName without space
THEN ms.StaffName -- takes the staffname anyways
ELSE
LEFT(StaffName, CHARINDEX(' ', StaffName)) --  Doesn't show Lavinia // fixed with case above
END AS StaffName,
hss.TransactionId,
COUNT(hss.TransactionId) AS [Total Treatment per Transaction]
FROM MsStaff ms, HeaderSalonServices hss, DetailSalonServices dss, MsTreatment mt, MsTreatmentType mtt -- kurang di where
WHERE hss.StaffId = ms.StaffId AND dss.TransactionId = hss.TransactionId AND mt.TreatmentId = dss.TreatmentId AND mtt.TreatmentTypeId = mt.TreatmentTypeId
GROUP BY StaffName, hss.TransactionId
-- 5 WHERE // done

/*9. Display TransactionDate, CustomerName, TreatmentName, and Price for every transaction which
happened on ‘Thursday’ and handled by Staff whose name contains the word ‘Ryan’. Then order
the data based on TransactionDate and CustomerName in ascending format.
(datename, weekday, like, order by) */
SELECT 
TransactionDate,
CustomerName,
TreatmentName,
Price
FROM MsStaff ms, HeaderSalonServices hss, MsCustomer mc, MsTreatment mt, DetailSalonServices dss
WHERE StaffName LIKE '%Ryan%' AND DATENAME(WEEKDAY, TransactionDate) = 'Thursday' AND ms.StaffId = hss.StaffId AND
hss.CustomerId = mc.CustomerId AND dss.TreatmentId = mt.TreatmentId AND dss.TreatmentId = mt.TreatmentId
ORDER BY TransactionDate, CustomerName ASC

/*10. Display TransactionDate, CustomerName, and TotalPrice (obtained from the total amount of
price) for every transaction that happened after 20th day. Then order the data based on
TransactionDate in ascending format.
(sum, day, group by, order by) */
SELECT TransactionDate,
CustomerName,
SUM(Price) AS TotalPrice
FROM HeaderSalonServices hss, MsTreatment mt, MsCustomer mc, DetailSalonServices dss
WHERE hss.CustomerId = mc.CustomerId AND dss.TransactionId = hss.TransactionId AND dss.TreatmentId = mt.TreatmentId
AND DATENAME(DAY, hss.TransactionDate) > 20 -- after 20th day
GROUP BY hss.TransactionDate, mc.CustomerName
ORDER BY hss.TransactionDate ASC