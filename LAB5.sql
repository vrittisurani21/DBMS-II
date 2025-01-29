CREATE TABLE PersonInfo (
 PersonID INT PRIMARY KEY,
 PersonName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8,2) NOT NULL,
 JoiningDate DATETIME NULL,
 City VARCHAR(100) NOT NULL,
 Age INT NULL,
 BirthDate DATETIME NOT NULL
);

CREATE TABLE PersonLog (
 PLogID INT PRIMARY KEY IDENTITY(1,1),
 PersonID INT NOT NULL,
 PersonName VARCHAR(250) NOT NULL,
 Operation VARCHAR(50) NOT NULL,
 UpdateDate DATETIME NOT NULL,
);

--Part – A
--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display
--a message “Record is Affected.”
CREATE TRIGGER tr_PersonInfo_RecordAffected
ON PersonInfo
AFTER INSERT,UPDATE,DELETE 
AS 
BEGIN
	PRINT 'RECORD IS AFFECTED'
END

INSERT INTO PersonInfo VALUES (1,'RAJVI',12000,'1-1-2025','MORBI',20,'04-10-2005')

--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that,
--log all operations performed on the person table into PersonLog.

CREATE TRIGGER tr_insertdata
ON PersonInfo
AFTER INSERT
AS 
BEGIN	
	DECLARE @PERSONID INT
	DECLARE @PERSONNAME VARCHAR(50)
	SELECT @PERSONID=PersonID from INSERTED
	SELECT @PERSONNAME=PersonName FROM INSERTED

	INSERT INTO PersonLog
	VALUES(@PERSONID,@PERSONNAME,'INSERT',GETDATE())
	
END

INSERT INTO PersonInfo
VALUES (2,'VRITTI',14000,'1-2-2025','MORBI',30,'05-10-2005')

SELECT * FROM PersonInfo
SELECT  *FROM PersonLog


CREATE TRIGGER tr_updatedata
ON PersonInfo
AFTER UPDATE
AS 
BEGIN	
	DECLARE @PERSONID INT
	DECLARE @PERSONNAME VARCHAR(50)
	SELECT @PERSONID=PersonID from INSERTED
	SELECT @PERSONNAME=PersonName FROM INSERTED

	INSERT INTO PersonLog
	VALUES(@PERSONID,@PERSONNAME,'UPDATE',GETDATE())
	
END

UPDATE PersonInfo
SET PersonName='DRASHTI'
WHERE PersonName='VRITTI'


SELECT * FROM PersonInfo
SELECT  *FROM PersonLog


CREATE TRIGGER tr_deletedata
ON PersonInfo
AFTER DELETE
AS 
BEGIN	
	DECLARE @PERSONID INT
	DECLARE @PERSONNAME VARCHAR(50)
	SELECT @PERSONID=PersonID from DELETED
	SELECT @PERSONNAME=PersonName FROM DELETED

	INSERT INTO PersonLog
	VALUES(@PERSONID,@PERSONNAME,'DELETE',GETDATE())
	
END

DELETE PersonInfo
WHERE PersonName='RAJVI'


SELECT * FROM PersonInfo
SELECT  *FROM PersonLog

--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo
--table. For that, log all operations performed on the person table into PersonLog.


--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into
--uppercase whenever the record is inserted.

CREATE TRIGGER tr_personinfo_nameupper_insert
ON PersonInfo
AFTER INSERT
AS
BEGIN
	DECLARE @NAME VARCHAR(50)
	DECLARE @ID INT
	SELECT @NAME=PersonName from INSERTED
	SELECT @ID=PersonId FROM INSERTED


	UPDATE PersonInfo
	SET PersonName=UPPER(@NAME)
	WHERE PersonId=@ID

END

INSERT INTO PersonInfo
VALUES (4,'DISHA',24000,'1-2-2025','MORBI',30,'05-10-2005')

SELECT* FROM PersonInfo
SELECT * FROM PersonLog

--5. Create trigger that prevent duplicate entries of person name on PersonInfo table.


--6. Create trigger that prevent Age below 18 years.