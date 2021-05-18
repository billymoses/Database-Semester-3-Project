-- Modul 9
/*
Create Store Procedure
CREATE {PROC | PROCEDURE} procedure_name [ @parameter datatype ( length ) [, …] ]
AS query

Alter Store Procedure
ALTER {PROC | PROCEDURE} procedure_name [ @parameter datatype ( length ) [, …] ]
AS query
Use ‘@’ for variable name, e.g.: @customerName

Execute Store Procedure
[EXEC | EXECUTE] procedure_name [ parameter [, …] ]

Drop Store Procedure
DROP {PROC | PROCEDURE} procedure_ name

Create Trigger
CREATE TRIGGER trigger_name ON {table_name | view_name}
{ FOR | AFTER | INSTEAD OF } { [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] }
AS query

After trigger not supported for views

Drop Trigger
DROP TRIGGER trigger_name

Cursor
DECLARE cursor_name CURSOR
[LOCAL | GLOBAL]
[FORWARD_ONLY | SCROLL]
[STATIC | KEYSET | DYNAMIC | FAST_FORWARD]
[READ_ONLY | SCROLL_LOCKS | OPTIMISTIC]
[TYPE_WARNING]
FOR select_query

OPEN cursor_name

FETCH [ NEXT | PRIOR | FIRST | LAST
 | ABSOLUTE { row_number }
 | RELATIVE { row_number } ]
FROM [GLOBAL] cursor_name
WHILE @@FETCH_STATUS = 0
BEGIN
query
FETCH NEXT FROM cursor_name
END

CLOSE [GLOBAL] cursor_name

DEALLOCATE [GLOBAL] cursor_name

*/

/*1. Create a store procedure with named ‘sp1’ to display CustomerId, CustomerName,
CustomerGender, and CustomerAddress for every Customer with Id based on user’s input.
(create procedure)*/
/* CREATE PROCEDURE procedure_name
AS
sql_statement
GO; */

CREATE PROCEDURE sp1 @InputId nvarchar(30) AS -- membuat procedue dengan inputan / reference InputId
SELECT CustomerId,
CustomerName,
CustomerGender,
CustomerAddress
FROM MsCustomer
WHERE CustomerId = @InputId -- customerid reference with inputid
GO

EXEC sp1 @InputId = 'CU001'

DROP PROCEDURE sp1

/*2. Create a store procedure with named ‘sp2’ that receives CustomerName as input from user with the
following specification:
- If the length of CustomerName is odd then procedure will give output ‘Character Length of
Mentor Name is an Odd Number’.
- If the length of CustomerName is even then procedure will display CustomerId,
CustomerName, CustomerGender, TransactionId, and TransactionDate for every transaction
with customer whose name contains the name that was inputted by user.
(create procedure, len, like)
 */

CREATE PROCEDURE sp2 @InputName VARCHAR(50)
AS
IF(LEN(@InputName)%2=0)
BEGIN
	SELECT 
		MsCustomer.CustomerId,
		CustomerName,
		CustomerGender,
		TransactionId,
		TransactionDate
	FROM MsCustomer
	INNER JOIN HeaderSalonServices On MsCustomer.CustomerId = HeaderSalonServices.CustomerId
	WHERE CustomerName LIKE '%'+@InputName+'%' AND (LEN(@InputName)%2=0)
END
ELSE
BEGIN
	PRINT 'Character Length of Customer Name is an Odd Number' 
END
GO

EXEC sp2 @InputName = 'Elysia Chen'

EXEC sp2 @InputName = 'Fran'

DROP PROCEDURE sp2

--percobaan doang
SELECT IIF (LEN(CustomerName) %2 = 0, 'Yes', CustomerId)
FROM MsCustomer
WHERE CustomerName LIKE 'Elysia Chen'

/*3. Create a store procedure named ‘sp3’ to update StaffId, StaffName, StaffGender, and StaffPhone on
MsStaff table based on StaffId, StaffName, StaffGender, and StaffPhone that was inputted by user.
Then display the updated data if the StaffId exists in MsStaff table. Otherwise show message ‘Staff
does not exists’.
(create procedure, update, exists) */

CREATE PROCEDURE sp3
@InputId CHAR(5),
@InputName VARCHAR(50),
@InputGender VARCHAR(10),
@InputPhone VARCHAR(13) AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT * FROM MsStaff WHERE @InputId = StaffId)
	UPDATE	MsStaff SET StaffId = @InputId,
						StaffName = @InputName,
						StaffGender = @InputGender,
						StaffPhone = @InputPhone
	WHERE @InputId = StaffId
	ELSE 
		PRINT 'Staff does not exists'
		END
GO

BEGIN TRAN NO3
EXEC sp3 'SF005', 'Ryan Nixon', 'Male', '08567756123'
ROLLBACK

BEGIN TRAN NO3
EXEC sp3 'SF080', 'Ryan Nixon', 'Male', '08567756123' -- 008 udh ada
ROLLBACK

DROP PROCEDURE sp3

SELECT * FROM MsStaff

/*
Create Trigger
CREATE TRIGGER trigger_name ON {table_name | view_name}
{ FOR | AFTER | INSTEAD OF } { [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] }
AS query

After trigger not supported for views

Drop Trigger
DROP TRIGGER trigger_name
*/

/*4. Create trigger named ‘trig1’ for MsCustomer table to validate if there are any data which had been
updated, it will display before and after updated data on MsCustomer table.
(create trigger, union) */

CREATE TRIGGER trig1 ON MsCustomer
AFTER UPDATE AS -- AFTER UPDATE because it's validating if there are any data which *had been updated*
BEGIN
	SELECT * FROM Deleted
	UNION ALL
	SELECT * FROM Inserted
	END

BEGIN TRAN
UPDATE MsCustomer
	SET CustomerName = 'Franky Quo'
	WHERE CustomerId = 'CU001'

ROLLBACK

SELECT * FROM MsCustomer

DROP TRIGGER trig1

/*5. Create trigger with name ‘trig2’ for MsCustomer table to validate if there are any new inserted
data, then the first data on MsCustomer will be deleted.
(create trigger, top, delete) */

CREATE TRIGGER trig2 ON MsCustomer
FOR INSERT AS
BEGIN
	DELETE MsCustomer
	WHERE CustomerId in ( SELECT TOP 1 CustomerId
		FROM MsCustomer
		ORDER BY CustomerId ASC )
	END

BEGIN TRAN
INSERT INTO MsCustomer
VALUES ( 'CU006' , 'Yogie soesanto' , 'Male' , '085562133000', 'Pelsakih Street no 52')

ROLLBACK

SELECT * FROM MsCustomer

DROP TRIGGER trig2

/*6. Create trigger with name ‘trig3’ on MsCustomer table to validate if the data on MsCustomer table
is deleted, then the deleted data will be insert into Removed table. If Removed table hasn’t been
created, then create the Removed table and insert the deleted data to Removed table.
(create trigger, object_id, is not null, insert, select into) */

CREATE TRIGGER trig3 ON MsCustomer
FOR DELETE AS -- if the data on MsCustomer table is deleted
BEGIN
	DECLARE @InputId VARCHAR(5) -- customid for object_id = removed
	IF OBJECT_ID ( 'Removed' ) IS NOT NULL 
/*Object_ID is a unique id number for an object within the database, this is used internally by SQL Server.
It should be noted, not all objects have an object_id.  DDL triggers for example do not as they are not schema-scoped. */
	BEGIN	
		INSERT INTO Removed
			SELECT * 
				FROM Deleted
		END
	ELSE
	BEGIN
		SELECT * INTO Removed 
			FROM Deleted
		END
	END
	
BEGIN TRAN 
DELETE FROM MsCustomer WHERE CustomerId = 'CU002'

SELECT * FROM MsCustomer
SELECT * FROM Removed
ROLLBACK

DROP TRIGGER trig3

/*
https://www.sqlservertutorial.net/sql-server-stored-procedures/sql-server-cursor/
https://www.sqlservertutorial.net/sql-server-basics/sql-server-offset-fetch/
DECLARE cursor_name CURSOR
[LOCAL | GLOBAL]
[FORWARD_ONLY | SCROLL]
[STATIC | KEYSET | DYNAMIC | FAST_FORWARD]
[READ_ONLY | SCROLL_LOCKS | OPTIMISTIC]
[TYPE_WARNING]
FOR select_query

OPEN cursor_name

FETCH [ NEXT | PRIOR | FIRST | LAST
 | ABSOLUTE { row_number }
 | RELATIVE { row_number } ]
FROM [GLOBAL] cursor_name
WHILE @@FETCH_STATUS = 0
BEGIN
query
FETCH NEXT FROM cursor_name
END
*/

/*7. Create cursor with name ‘cur1’ to validate whether the length of StaffName is odd or even then
show the message about result.
(declare cursor, len)*/

DECLARE @InputName VARCHAR(50)

DECLARE cur1 CURSOR
FOR SELECT StaffName 
	FROM MsStaff
	OPEN cur1
	FETCH NEXT FROM cur1 INTO @InputName
/*FETCH specifies the number of rows to return after the OFFSET clause has been processed.
The offset_row_count can a constant, variable or scalar that is greater or equal to one. */
	WHILE @@FETCH_STATUS = 0 /*This function is used to get the current fetch status of a latest opened cursor.
	This function is global function for all cursors in the application and it is non-deterministic.
	Because, the result is unpredictable.
For instance, a user executes a FETCH statement from one cursor,
and then calls a stored procedure that opens and processes the results from another cursor. 
When control is returned from the called stored procedure, @@FETCH_STATUS reflects the last FETCH executed in the stored procedure, not the FETCH statement executed before the stored procedure is called.
Function Syntax		@@FETCH_STATUS		It returns an integer value as given below.
0 = The FETCH statement was successful.
-1 = The FETCH statement failed or the row was beyond the result set or end of record.
-2 = The row fetched is missing. */
BEGIN
	IF LEN ( @InputName ) % 2 = 1 -- ganjil
	BEGIN 
		PRINT 'The length from Staff Name ' + @InputName + ' is an Odd Number'
		END
	ELSE -- genap
	BEGIN
		PRINT 'The length from Staff Name ' + @InputName + ' is an Even Number'
		END
	FETCH NEXT FROM cur1 INTO @InputName
	END

CLOSE cur1
DEALLOCATE cur1 /*Removes a cursor reference. 
When the last cursor reference is deallocated,
the data structures comprising the cursor are released by Microsoft SQL Server. */

/*8. Create procedure named ‘sp4’ that receive StaffName from user’s input to display StaffName and
StaffPosition for every staff which name contains the word that has been inputted by user.
(create procedure, declare cursor, like) */
CREATE PROCEDURE sp4 @SName VARCHAR (50) AS 
DECLARE @InputName VARCHAR(50) , @InputPosition VARCHAR(50)
DECLARE cur2 CURSOR
	FOR SELECT StaffName , StaffPosition
		FROM MsStaff
		WHERE StaffName like '%'+ @SName + '%'
	OPEN cur2
	FETCH NEXT FROM cur2 INTO @InputName , @InputPosition
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'Staff Name : ' + @InputName + ' Position : ' + @InputPosition
		FETCH NEXT FROM cur2 INTO @InputName , @InputPosition
		END
	CLOSE cur2
	DEALLOCATE cur2
	GO

EXEC sp4 'a'

DROP PROCEDURE sp4

/*9. Create procedure with name ‘sp5’ that receive CustomerId from user’s input to display
CustomerName, and TransactionDate for every customer which Id has been inputted by user and
did treatment which ID is an even number.
(create procedure, declare cursor, in, right) */

CREATE PROCEDURE sp5 @InputId VARCHAR (5) AS
	DECLARE @InputName VARCHAR(50) , @InputDate DATE
	DECLARE cur3 CURSOR
	FOR SELECT CustomerName , TransactionDate
		FROM HeaderSalonServices , MsCustomer , DetailSalonServices , MsTreatment
		WHERE HeaderSalonServices.CustomerId = MsCustomer.CustomerId
		and HeaderSalonServices.TransactionId = DetailSalonServices.TransactionId
		and DetailSalonServices.TreatmentId = MsTreatment.TreatmentId
		and HeaderSalonServices.CustomerId in ( @InputId )
		and CAST ( RIGHT ( MsTreatment.TreatmentId , 1 ) AS NUMERIC ) % 2 = 0
		-- did treatment which ID is an even number.
	OPEN cur3
	FETCH NEXT FROM cur3 INTO @InputName , @InputDate
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'Customer Name : ' + @InputName + ' Date : ' + CAST ( @InputDate AS VARCHAR(50) )
		FETCH NEXT FROM cur3 INTO @InputName , @InputDate
		END
	CLOSE cur3
	DEALLOCATE cur3
	GO

EXEC sp5 'CU001' -- dimunculkan tanggal 23 karena DSS mulai dari TR010, bukan TR001 maupun TR006
SELECT * FROM MsCustomer
SELECT * FROM DetailSalonServices -- TR010 -> TM010 % 2 = genap
SELECT * FROM HeaderSalonServices -- CU001 -> TR001 (20), TR006 (21), TR010 (23)

/*10. Delete all procedure and trigger that has been made.
(drop proc, drop trigger) */

DROP PROCEDURE sp1 , sp2 , sp3 , sp4 , sp5
DROP TRIGGER trig1 , trig2 , trig3