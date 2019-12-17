/*
TAREA         : Precotizador cocina
FECHA         : [17/10/2019]
AUTOR         : [Arnold Jair Jimenez Vargas (arnold.jimenez@areamovil.com.co)]
*/

--use pechera
--GO
--DDL

--Calculator
IF NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Calculator')
BEGIN
	CREATE TABLE [dbo].[Calculator](
		[Id] [int] IDENTITY(1,1),
		[Name] [nvarchar](100) NOT NULL,
		[Code] [nvarchar](100) NOT NULL UNIQUE,
		[ZoneRequired] [bit] default 1,
	 	CONSTRAINT PK_Calculator PRIMARY KEY (ID) 
	)
END
GO

--Step
IF NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Step')
BEGIN
	CREATE TABLE [dbo].[Step](
		[Id] [int] IDENTITY(1,1),
		[Index] [int],
		[Code] [nvarchar](100) NOT NULL UNIQUE,
		[Title] [nvarchar](100) NOT NULL,
		[Id_Calculator] [int],
	 	CONSTRAINT PK_Step PRIMARY KEY (ID) 
	)
END
GO

--Field
IF NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Field')
BEGIN
	CREATE TABLE [dbo].[Field](
		[Id] [int] IDENTITY(1,1),
		[Name] [nvarchar](100) NOT NULL,
		[Type] [nvarchar](20) NOT NULL,
		[Label] [nvarchar](40) NOT NULL,
		[Measurement_Unit] [nvarchar] (10),
		[Id_Step] [int],
	 	CONSTRAINT PK_Field PRIMARY KEY (ID) 
	)
END
GO

--Value
IF NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Value')
BEGIN
	CREATE TABLE [dbo].[Value](
		[Id] [int] IDENTITY(1,1),
		[Name] [nvarchar](100) NOT NULL,
		[Data] [nvarchar](4000) NOT NULL,
		[Unit_Value] float default 0,
		[SKU] [nvarchar] (40),
		[Id_Field] [int],
		[Id_Parent] [int] default NULL,
	 	CONSTRAINT PK_Value PRIMARY KEY (ID) 
	)
END
GO

IF NOT EXISTS (SELECT *
				 FROM INFORMATION_SCHEMA.TABLES
				 WHERE TABLE_SCHEMA = 'dbo'
				 AND TABLE_NAME = 'Recommended')
BEGIN
	CREATE TABLE [dbo].[Recommended] (
		[Id] [int] IDENTITY(1,1),
		[Bath] [bit] default 1,
		[Kitchen] [bit] default 1,
		[Room] [bit] default 1,
		[Hall] [bit] default 1,
		[Outdoor] [bit] default 1,
		[Origin] [nvarchar](4000),
		[State] [nvarchar](4000),
		[Sub] [nvarchar](4000),
		[Group] [nvarchar](4000),
		[Set] [nvarchar](4000),
		[Sku] [nvarchar](4000),
		[Desc] [nvarchar](4000),
		CONSTRAINT PK_Recommended PRIMARY KEY (ID)
	)
END
GO

--Constraints
--Value
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[VALUE_ISJON]') AND OBJECTPROPERTY(id, 'IsCheckCnst') = 1)
BEGIN
	ALTER TABLE [dbo].[Value]
		ADD CONSTRAINT [VALUE_ISJON]
			CHECK (ISJSON(data) = 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_VALUE_FIELD]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
BEGIN
	ALTER TABLE [dbo].[Value]
		ADD CONSTRAINT [FK_VALUE_FIELD]
			FOREIGN KEY ([ID_Field]) REFERENCES [Field] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
END
GO

--Field
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_FIELD_STEP]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
BEGIN
	ALTER TABLE [dbo].[Field]
		ADD CONSTRAINT [FK_FIELD_STEP]
			FOREIGN KEY ([Id_Step]) REFERENCES [Step] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
END
GO

--Step
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_FIELD_CALC]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
BEGIN
	ALTER TABLE [dbo].[Step]
		ADD CONSTRAINT [FK_FIELD_CALC]
			FOREIGN KEY ([Id_Calculator]) REFERENCES [Calculator] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION
END
GO
