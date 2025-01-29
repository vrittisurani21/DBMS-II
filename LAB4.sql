
------------------------------------PART:A--------------------


--1. Write a function to print "hello world".
CREATE OR ALTER FUNCTION FN_HELLOWORLD()
RETURNS VARCHAR(20)
AS
	BEGIN
	RETURN 'HELLO WORLD'
END 

SELECT dbo.FN_HELLOWORLD()


--2. Write a function which returns addition of two numbers.
CREATE OR ALTER FUNCTION FN_ADDITION(@N1 INT, @N2 INT)
RETURNS INT 
AS
BEGIN
	DECLARE @SUM INT
	SET @SUM=@N1+@N2
	RETURN @SUM
END

select dbo.FN_ADDITION(17,6) as ADDITION

--3. Write a function to check whether the given number is ODD or EVEN.
CREATE OR ALTER FUNCTION FN_ODDEVEN(@N1 INT)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @MSG VARCHAR
	IF @N1%2=0
	SET @MSG='EVEN'
	ELSE
	SET @MSG='ODD'
	RETURN @MSG
END

SELECT dbo.FN_ODDEVEN(10) as NUMBER


--4. Write a function which returns a table with details of a person whose first name starts with B.
CREATE OR ALTER FUNCTION FN_PERSON()
RETURNS TABLE 
AS
	RETURN(SELECT * FROM PERSON WHERE FIRSTNAME LIKE 'B%')


SELECT * FROM dbo.FN_PERSON()


--5. Write a function which returns a table with unique first names from the person table.
CREATE OR ALTER FUNCTION FN_UNIQUE()
RETURNS TABLE
AS
	RETURN(SELECT DISTINCT FIRSTNAME FROM PERSON)

SELECT * FROM dbo.FN_UNIQUE()

--6. Write a function to print number from 1 to N. (Using while loop)
CREATE OR ALTER FUNCTION FN_1ToN(@N INT)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @MSG VARCHAR(20), @COUNT INT
	SET @MSG=''
	SET @COUNT=1
	WHILE (@COUNT<=@N)
BEGIN 
SET @MSG=@MSG+''+CAST (@COUNT AS VARCHAR)
SET @COUNT=@COUNT+1
END
RETURN @MSG
END

SELECT dbo.FN_1ToN(5)

--7. Write a function to find the factorial of a given integer.
CREATE OR ALTER FUNCTION FN_FACTORIAL(@N INT)
RETURNS INT
AS
BEGIN
	 DECLARE @NUM INT
	 SET @NUM=1
	 WHILE @N>=1
	 BEGIN
	 SET @NUM=@NUM*@N
	 SET @N=@N-1;
	 END
RETURN @NUM
END

SELECT dbo.FN_FACTORIAL(5)



---------------------------------PART:B------------------------



--8. Write a function to compare two integers and return the comparison result. (Using Case statement)
CREATE OR ALTER  FUNCTION FN_CompareIntegers (@a INT, @b INT)
RETURNS NVARCHAR(10)
AS
BEGIN
    RETURN CASE 
        WHEN @a > @b THEN 'GREATER'
        WHEN @a < @b THEN 'LESS'
        ELSE 'EQUAL'
    END
END

SELECT dbo.FN_CompareIntegers(5, 7) 


--9. Write a function to print the sum of even numbers between 1 to 20.
CREATE OR ALTER FUNCTION FN_SumOfEvenNumbers()
RETURNS INT
AS
BEGIN
    DECLARE @sum INT = 0
    DECLARE @i INT = 2
    WHILE @i <= 20
    BEGIN
        SET @sum = @sum + @i
        SET @i = @i + 2
    END
    RETURN @sum
END

SELECT dbo.FN_SumOfEvenNumbers()


--10. Write a function that checks if a given string is a palindrome
CREATE OR ALTER FUNCTION IsPalindrome (@str VARCHAR(100))
RETURNS VARCHAR(10)
AS
BEGIN
    RETURN CASE WHEN @str = REVERSE(@str) THEN 'Yes' ELSE 'No' END
END

SELECT dbo.IsPalindrome('madam')


-----------------------------PART:C-------------------

--11. Write a function to check whether a given number is prime or not.
CREATE OR ALTER FUNCTION FN_IsPrime (@num INT)
RETURNS BIT
AS
BEGIN
    IF @num <= 1 RETURN 0
    DECLARE @i INT = 2
    WHILE @i * @i <= @num
    BEGIN
        IF @num % @i = 0 RETURN 0
        SET @i = @i + 1
    END
    RETURN 1
END

SELECT dbo.FN_IsPrime(17) 


--12. Write a function which accepts two parameters start date & end date, and returns a difference in days.
CREATE OR ALTER FUNCTION FN_DateDifference (@startDate DATE, @endDate DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, @startDate, @endDate)
END

SELECT dbo.FN_DateDifference('2023-01-01', '2023-12-31') 


--13. Write a function which accepts two parameters year & month in integer and returns total days each year.
CREATE OR ALTER FUNCTION FN_GetDaysInMonth (@year INT, @month INT)
RETURNS INT
AS
BEGIN
    RETURN DAY(EOMONTH(DATEFROMPARTS(@year, @month, 1)))
END

SELECT dbo.FN_GetDaysInMonth(2023, 2) 


--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons.
CREATE OR ALTER FUNCTION FN_GetPersonDetailsByDepartment (@departmentID INT)
RETURNS TABLE
AS
RETURN (
    SELECT * FROM Person WHERE DepartmentID = @departmentID
)

SELECT * FROM dbo.FN_GetPersonDetailsByDepartment(1) 


--15. Write a function that returns a table with details of all persons who joined after 1-1-1991.
CREATE  OR ALTER FUNCTION FN_GetPersonsJoinedAfter1991()
RETURNS TABLE
AS
RETURN (
    SELECT * FROM Person WHERE JoiningDate > '1991-01-01'
)

SELECT * FROM dbo.FN_GetPersonsJoinedAfter1991()