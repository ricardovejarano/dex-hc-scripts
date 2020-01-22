/*
TAREA         : Calculadora llantas y baterías
FECHA         : [18/12/2019]
AUTOR         : [Arnold Jair Jimenez Vargas (arnold.jimenez@areamovil.com.co)]
*/

--use pechera
--GO
--DDL


--Llantas y baterías
IF EXISTS (SELECT [Id] FROM [Calculator] WHERE [Code] = 'tires_batteries')
BEGIN
DELETE FROM CALCULATOR WHERE [Code] = 'tires_batteries'
END
GO

--TiresInfo
IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'TiresInfo')
BEGIN
	DROP TABLE [dbo].[TiresInfo]
END
GO 

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_IDNAME_IDNAME]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
BEGIN
    ALTER TABLE [dbo].[IdName] DROP CONSTRAINT [FK_IDNAME_IDNAME]
END
GO

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'IdName')
BEGIN
	DROP TABLE [dbo].[IdName]
END
GO 





