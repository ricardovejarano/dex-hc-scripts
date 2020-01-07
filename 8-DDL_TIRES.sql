/*
TAREA         : Calculadora llantas y baterías
FECHA         : [18/12/2019]
AUTOR         : [Arnold Jair Jimenez Vargas (arnold.jimenez@areamovil.com.co)]
*/

--use pechera
--GO
--DDL


--Llantas y baterías
IF NOT EXISTS (SELECT [Id] FROM [Calculator] WHERE [Code] = 'tires_batteries')
BEGIN
INSERT INTO [Calculator]
           ([Name]
		   ,[Code])
     VALUES
           ('Llantas y baterías', 'tires_batteries')
END
GO

--TiresInfo
IF NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'TiresInfo')
BEGIN
	CREATE TABLE [dbo].[TiresInfo](
		[Id] [int] IDENTITY(1,1),
		[Brand] [nvarchar](100) NOT NULL,
		[Model] [nvarchar](100) NOT NULL,
		[Year] [int] NOT NULL,
		[Wheel] [int] NOT NULL,
		[Width] [int] NOT NULL,
		[Profile] [int] NOT NULL,
	 	CONSTRAINT PK_TiresInfo PRIMARY KEY (ID) 
	)
END
GO 
