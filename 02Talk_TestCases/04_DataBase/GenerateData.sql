--Drop and Create Table
USE playground
DROP TABLE TestTable

USE playground
CREATE TABLE TestTable (
    id int IDENTITY PRIMARY KEY,
    fullName varchar(255) NOT NULL,
    dateOfBirth DATE,
    totalScore int,
	studentId varchar(15)
);

-- 1 000 000 Random rows of data
USE playground
INSERT INTO TestTable(fullName, dateOfBirth, totalScore,studentId)
SELECT TOP 1000000
	CONVERT(varchar(50), NEWID()) as fullName,
	RAND(CHECKSUM(NEWID())) * 30000 + CAST('1945' AS DATETIME) as dateOfBirth,
	ABS(CHECKSUM(NEWID())) AS totalScore,
	CONVERT(varchar(50),ABS(CHECKSUM(NEWID()))) AS studentId
FROM master.dbo.syscolumns sc1, master.dbo.syscolumns sc2, master.dbo.syscolumns sc3


--Insert additional test data
INSERT INTO [playground].[dbo].[TestTable]
           ([fullName]
           ,[dateOfBirth]
           ,[totalScore]
           ,[studentId])
     VALUES
           ('TestName'
           ,'1994-01-21'
           ,1222222
           ,'12121212121')

INSERT INTO [playground].[dbo].[TestTable]
           ([fullName]
           ,[dateOfBirth]
           ,[totalScore]
           ,[studentId])
     VALUES
           ('Istvan'
           ,'1984-02-18'
           ,123456
           ,'87654321')


--Select Everything
 SET STATISTICS TIME ON
 SELECT * FROM [playground].[dbo].[TestTable]
 SET STATISTICS TIME OFF


--Select - parameter type is different than column type (impl. conv.)
SET STATISTICS TIME ON
DECLARE @name NVARCHAR(50) = 'Istvan'
SELECT * 
FROM [playground].[dbo].[TestTable]
WHERE fullName = @name
SET STATISTICS TIME OFF


--Select - parameter type is the same as column type
SET STATISTICS TIME ON
DECLARE @name2 VARCHAR(50) = 'TestName'
SELECT * 
FROM [playground].[dbo].[TestTable]
WHERE fullName = @name2
SET STATISTICS TIME OFF

