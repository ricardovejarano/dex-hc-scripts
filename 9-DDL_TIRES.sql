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
		[Year] [float] NOT NULL,
		[Wheel] [float] NOT NULL,
		[Width] [float] NOT NULL,
		[Profile] [float] NOT NULL,
	 	CONSTRAINT PK_TiresInfo PRIMARY KEY (ID) 
	)
END
GO 

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TiresInfo' AND COLUMN_NAME = 'Sku')
BEGIN
	ALTER TABLE TiresInfo
	ADD Sku NVARCHAR(24) NOT NULl DEFAULT '1234321'
END
GO

--BatteriesInfo
IF NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'BatteriesInfo')
BEGIN
	CREATE TABLE [dbo].[BatteriesInfo](
		[Id] [int] IDENTITY(1,1),
		[Brand] [nvarchar](100) NOT NULL,
		[Model] [nvarchar](100) NOT NULL,
		[Year] [float] NOT NULL,
	 	CONSTRAINT PK_BatteriesInfo PRIMARY KEY (ID) 
	)
END
GO 

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BatteriesInfo' AND COLUMN_NAME = 'Sku')
BEGIN
	ALTER TABLE BatteriesInfo
	ADD Sku NVARCHAR(24) NOT NULl DEFAULT '1234321'
END
GO

--Carcenter
IF NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Carcenter')
BEGIN
	CREATE TABLE [dbo].[Carcenter](
		[Id] [int] IDENTITY(1,1),
		[Name] [nvarchar](100) NOT NULL,
        [Description] [nvarchar](100) NOT NULL,
		[Zone] [int],
		[Url] [nvarchar](1000) NOT NULL,
		
        CONSTRAINT PK_Carcenter PRIMARY KEY (ID) 
	)
END
GO 

--IdName
IF NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'IdName')
BEGIN
	CREATE TABLE [dbo].[IdName](
		[Id] [int] IDENTITY(1,1),
		[Name] [nvarchar](100) NOT NULL,
		[Group] [nvarchar](100) NOT NULL,
		[Id_Parent] [int] default NULL,	
	 	CONSTRAINT PK_IdName PRIMARY KEY (ID) 
	)
END
GO 

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_IDNAME_IDNAME]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
BEGIN
	ALTER TABLE [dbo].[IdName]
		ADD CONSTRAINT [FK_IDNAME_IDNAME]
			FOREIGN KEY ([ID_Parent]) REFERENCES [IdName] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
END
GO

--TODO: Test if index exists
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name='TIRES_INFO_GRPBY' AND object_id = OBJECT_ID('dbo.TiresInfo'))
BEGIN
	CREATE NONCLUSTERED INDEX TIRES_INFO_GRPBY ON dbo.TiresInfo ( brand )
END
GO



