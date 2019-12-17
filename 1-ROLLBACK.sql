/*
TAREA         : Precotizador cocina
FECHA         : [17/10/2019]
AUTOR         : [Arnold Jair Jimenez Vargas (arnold.jimenez@areamovil.com.co)]
*/

--use pechera
--GO

--Value
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[VALUE_ISJON]') AND OBJECTPROPERTY(id, 'IsCheckCnst') = 1) 
BEGIN
	ALTER TABLE [dbo].[Value] DROP CONSTRAINT [VALUE_ISJON]
END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_VALUE_FIELD]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
BEGIN
	ALTER TABLE [dbo].[Value] DROP CONSTRAINT [FK_VALUE_FIELD]
END
GO

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Value')
BEGIN
	DROP TABLE [dbo].[Value]
END
GO

--Field

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_FIELD_STEP]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
BEGIN
	ALTER TABLE [dbo].[Field] DROP CONSTRAINT [FK_FIELD_STEP]
END
GO

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Field')
BEGIN
	DROP TABLE [dbo].[Field]
END
GO

--Step
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('[FK_STEP_CALC]') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1) 
BEGIN
	ALTER TABLE [dbo].[Step] DROP CONSTRAINT [FK_STEP_CALC]
END
GO

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Step')
BEGIN
	DROP TABLE [dbo].[Step]
END
GO

--Calculator
IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Calculator')
BEGIN
	DROP TABLE [dbo].[Calculator]
END
GO

--Recommended
IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Recommended')
BEGIN
	DROP TABLE [dbo].[Recommended]
END

--Others
IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Calculadora')
BEGIN
	DROP TABLE [dbo].[Calculadora]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'GrupoProductos')
BEGIN
	DROP TABLE [dbo].[GrupoProductos]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'GrupoXCalculadora')
BEGIN
	DROP TABLE [dbo].[GrupoXCalculadora]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'LightbulbResult')
BEGIN
	DROP TABLE [dbo].[LightbulbResult]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'LogErrores')
BEGIN
	DROP TABLE [dbo].[LogErrores]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'MesonSkuResult')
BEGIN
	DROP TABLE [dbo].[MesonSkuResult]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'NavegacionSite')
BEGIN
	DROP TABLE [dbo].[NavegacionSite]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Parametro')
BEGIN
	DROP TABLE [dbo].[Parametro]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Product')
BEGIN
	DROP TABLE [dbo].[Product]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'ProductoRelacionado')
BEGIN
	DROP TABLE [dbo].[ProductoRelacionado]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'ProductoXCalculadora')
BEGIN
	DROP TABLE [dbo].[ProductoXCalculadora]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'ProductoXGrupo')
BEGIN
	DROP TABLE [dbo].[ProductoXGrupo]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'ProductoXZona')
BEGIN
	DROP TABLE [dbo].[ProductoXZona]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'ReglaGrupoXGrupo')
BEGIN
	DROP TABLE [dbo].[ReglaGrupoXGrupo]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'RelacionEntreGrupos')
BEGIN
	DROP TABLE [dbo].[RelacionEntreGrupos]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'RendimientoDependiente')
BEGIN
	DROP TABLE [dbo].[RendimientoDependiente]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'TablaRendimientos')
BEGIN
	DROP TABLE [dbo].[TablaRendimientos]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'UnidadaMedida')
BEGIN
	DROP TABLE [dbo].[UnidadaMedida]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'ValorPermitidoParametro')
BEGIN
	DROP TABLE [dbo].[ValorPermitidoParametro]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Zona')
BEGIN
	DROP TABLE [dbo].[Zona]
END

IF EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'ZonaXCalculadora')
BEGIN
	DROP TABLE [dbo].[ZonaXCalculadora]
END

GO;

GO;