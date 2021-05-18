/*This will be Modul 4, for Data Manipulation*/

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

/*1. Display Female Staff MsStaff (select)*/
SELECT * FROM MsStaff
WHERE StaffGender LIKE 'Female';

/*2. Display StaffName, and StaffSalary(obtained by adding ‘Rp.’ In front of StaffSalary) for every
staff whose name contains ‘m’ character and has salary more than or equal to 10000000.
(cast, like)*/
SELECT StaffName, 
CONCAT ('Rp. ',CAST (StaffSalary AS VARCHAR)) AS [StaffSalary]
FROM MsStaff
WHERE (StaffSalary >= 10000000 AND CHARINDEX('m', StaffName) >= 1)

/*3. Display TreatmentName, and Price for every treatment which type is 'message / spa' or 'beauty
care'.
(in) */
SELECT TreatmentName, Price
FROM MsTreatment mt, MsTreatmentType mtt
WHERE mt.TreatmentTypeId = mtt.TreatmentTypeId
AND mtt.TreatmentTypeName IN ('Hair Spa Treatment', 'Make Up and Facial');

/*4.Display StaffName, StaffPosition, and TransactionDate (obtained from TransactionDate in Mon
dd,yyyy format) for every staff who has salary between 7000000 and 10000000.
(convert, between)*/
SELECT StaffName, StaffPosition,
CONVERT(VARCHAR, TransactionDate, 107) AS TransactionDate
FROM MsStaff a, HeaderSalonServices b
WHERE (StaffSalary BETWEEN 7000000 AND 10000000) AND (a.StaffId = b.StaffId)

/*5.Display Name (obtained by taking the first character of customer’s name until character before
space), Gender (obtained from first character of customer’s gender), and PaymentType for every
transaction that is paid by ‘Debit’.
(substring, charindex, left) */
SELECT SUBSTRING(CustomerName, 1, CHARINDEX(' ',CustomerName)) AS Name, LEFT(CustomerGender, 1) AS Gender, PaymentType
FROM MsCustomer, HeaderSalonServices
WHERE MsCustomer.CustomerId = HeaderSalonServices.CustomerId AND PaymentType LIKE 'Debit'

/*6. Display Initial (obtained from first character of customer’s name and followed by first character of
customer’s last name in uppercase format), and Day (obtained from the day when transaction
happened ) for every transaction which the day difference with 24th December 2012 is less than 3
days.
(upper, left, substring, charindex, datename, weekday, datediff, day) */
SELECT UPPER(LEFT(CustomerName,1) + SUBSTRING(CustomerName, CHARINDEX(' ',CustomerName)+ 1, 1)) AS Initial,
DATENAME(WEEKDAY, TransactionDate) AS Day
FROM MsCustomer, HeaderSalonServices
WHERE MsCustomer.CustomerId = HeaderSalonServices.CustomerId AND DATEDIFF(Day, TransactionDate, '2012-12-24') <3

/*7.Display TransactionDate, and CustomerName (obtained by taking the character after space until
the last character in CustomerName) for every customer whose name contains space and did the
transaction on Saturday.
(right, charindex, reverse, like, datename, weekday) */
SELECT TransactionDate, RIGHT(CustomerName, CHARINDEX(' ', REVERSE(CustomerName))) AS CustomerName
FROM HeaderSalonServices, MsCustomer
WHERE HeaderSalonServices.CustomerId = MsCustomer.CustomerId AND
CHARINDEX(' ', CustomerName) != 0 AND DATENAME(WEEKDAY, TransactionDate) = 'Saturday'

/*8. Display StaffName, CustomerName, CustomerPhone (obtained from customer’s phone by
replacing ‘0’ with ‘+62’), and CustomerAddress for every customer whose name contains vowel
character and handled by staff whose name contains at least 3 words.
(replace, like) */
SELECT StaffName, CustomerName, REPLACE(CustomerPhone, '08', '+62') AS CustomerPhone,
CustomerAddress
FROM MsStaff ms, MsCustomer mc, HeaderSalonServices hss
WHERE hss.CustomerId = mc.CustomerId
AND hss.StaffId = ms.StaffId
AND LEN(StaffName) - LEN(REPLACE(StaffName, ' ', '')) >= 2
AND (CustomerName LIKE '%a%' OR
CustomerName LIKE '%i%' OR CustomerName LIKE '%u%' OR CustomerName LIKE '%e%' OR CustomerName LIKE '%o%');

/*9. Display StaffName, TreatmentName, and Term of Transaction (obtained from the day difference
between transactionDate and 24th December 2012) for every treatment which name is more than
20 characters or contains more than one word.
(datediff, day, len, like) */
SELECT  StaffName, TreatmentName, DATEDIFF(DAY, TransactionDate, '2012-12-24') AS 'Term of Transaction'
FROM    MsStaff ms, MsTreatment mt, HeaderSalonServices hss, DetailSalonServices dss
WHERE   ms.StaffId = hss.StaffId
AND     dss.TransactionId = hss.TransactionId
AND     mt.TreatmentId = dss.TreatmentId
AND     (LEN(TreatmentName) > 20 OR LEN(TreatmentName) - LEN(REPLACE(TreatmentName, ' ', '')) >= 1);

/*10. Display TransactionDate, CustomerName, TreatmentName, Discount (obtainedby changing Price
data type into int and multiply it by 20%), and PaymentType for every transaction which
happened on 22th day.
(cast, day)*/
SELECT TransactionDate, CustomerName, TreatmentName, CAST((Price * 20) / 100 AS INT) AS Discount, PaymentType
FROM HeaderSalonServices hss, MsCustomer mc, DetailSalonServices dss, MsTreatment mt
WHERE hss.CustomerId = mc.CustomerId
AND hss.TransactionId = dss.TransactionId
AND dss.TreatmentId = mt.TreatmentId
AND DATEPART(DAY, hss.TransactionDate) = 26;