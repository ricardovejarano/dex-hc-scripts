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
GO/*
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
/*
TAREA         : Precotizador cocina
FECHA         : [17/10/2019]
AUTOR         : [Arnold Jair Jimenez Vargas (arnold.jimenez@areamovil.com.co)]
*/

--Precotizador Cocina
IF NOT EXISTS (SELECT [Id] FROM [Calculator] WHERE [Code] = 'kitchen_precotizer')
BEGIN
INSERT INTO [Calculator]
           ([Name]
		   ,[Code])
     VALUES
           ('Precotizador Cocina', 'kitchen_precotizer')
END
GO

--Paso 1: Tipo de cocina
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_1_kitchen_type')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (1, 'kp_1_kitchen_type', 'Tipo de cocina', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'kitchen_precotizer'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'kitchenType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_1_kitchen_type'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('kitchenType', 'simple', 'Tipo de cocina', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_1_kitchen_type'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'kitchenType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_1_kitchen_type')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'kitchenType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_1_kitchen_type'))
END
GO

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('Lineal', '{"index":0,"title":"Lineal","imgUrl":"assets/images/kitchen-precotizer/lineal.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'kitchenType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_1_kitchen_type'))),
	  	   ('En L', '{"index":1,"title":"En L","imgUrl":"assets/images/kitchen-precotizer/en_l.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'kitchenType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_1_kitchen_type'))),
	  	   ('En U', '{"index":2,"title":"En U","imgUrl":"assets/images/kitchen-precotizer/en_u.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'kitchenType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_1_kitchen_type'))),
	  	   ('Lineal con isla', '{"index":3,"title":"Lineal con isla","imgUrl":"assets/images/kitchen-precotizer/lineal_con_isla.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'kitchenType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_1_kitchen_type')))

--Paso 2: Ingresa medidas
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_2_measurements')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (2,'kp_2_measurements', 'Ingresa medidas', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'kitchen_precotizer'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'length' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_2_measurements'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('length', 'number', 'Largo', 'cm', (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_2_measurements'))
END
GO

IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'width' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_2_measurements'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('width', 'number', 'Ancho', 'cm', (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_2_measurements'))
END
GO

--Paso 3: Acabado del mueble
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_3_furniture_material')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (3, 'kp_3_furniture_material', 'Acabado del mueble', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'kitchen_precotizer'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'furnitureMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_3_furniture_material'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('furnitureMaterial', 'feature', 'Acabado del mueble', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_3_furniture_material'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'furnitureMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_3_furniture_material')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'furnitureMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_3_furniture_material'))
END
GO



INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('Melamina', '{"index":0,"title":"Melamina","imgUrl":"assets/images/kitchen-precotizer/melamina.png","selected":false, "unitPrice": 1300000,"features":"Láminas compuestas en MDF de 18 mm de espesor, en acabado alto brillo, amaderados y mate. Cantos rígido sellados con maquinarias."}', (SELECT [Id] FROM [Field] WHERE [Name] = 'furnitureMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_3_furniture_material'))),
	  	   ('Highgloss', '{"index":1,"title":"Highgloss","imgUrl":"assets/images/kitchen-precotizer/highgloss.png","selected":false, "unitPrice": 1600000,"features":"MDG RH (Resistente a la Humedad), de 15 mm de espesor, color blanco, acabado mate, canto semi rígido sellado con maquinarias"}', (SELECT [Id] FROM [Field] WHERE [Name] = 'furnitureMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_3_furniture_material')))

--Paso 4: Material del mesón
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_4_meson_material')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (4, 'kp_4_meson_material', 'Material del mesón', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'kitchen_precotizer'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'mesonMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_4_meson_material'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('mesonMaterial', 'feature', 'Material del mesón', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_4_meson_material'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'mesonMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_4_meson_material')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'mesonMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_4_meson_material'))
END
GO



INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
		   ('Granito', '{"index":0,"title":"Granito","imgUrl":"assets/images/kitchen-precotizer/granito.png","selected":false, "unitPrice": 390000,"features":"Piedra natural en Granito. Estos, son productos de la naturaleza y por lo tanto, están sujetos a variaciones cromáticas."}', (SELECT [Id] FROM [Field] WHERE [Name] = 'mesonMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_4_meson_material'))),
	  	   ('Quartzone', '{"index":1,"title":"Quartzone","imgUrl":"assets/images/kitchen-precotizer/quartzone.png","selected":false, "unitPrice": 690000,"features":"Los Quarztone son productos artificiales y por lo tanto, pueden presentar ligeras variaciones cromáticas."}', (SELECT [Id] FROM [Field] WHERE [Name] = 'mesonMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_4_meson_material')))

--Paso 5: Lavaplatos
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_5_dishwasher')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (5, 'kp_5_dishwasher', 'Lavaplatos', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'kitchen_precotizer'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'dishwasherType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_5_dishwasher'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('dishwasherType', 'simple', 'Tipo de lavaplatos', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_5_dishwasher'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'dishwasherType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_5_dishwasher')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'dishwasherType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_5_dishwasher'))
END
GO

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('Doble', '{"index":0,"title":"Doble","imgUrl":"assets/images/kitchen-precotizer/doble.png","selected":false, "unitPrice": 220000}', (SELECT [Id] FROM [Field] WHERE [Name] = 'dishwasherType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_5_dishwasher'))),
	  	   ('Sencillo', '{"index":1,"title":"Sencillo","imgUrl":"assets/images/kitchen-precotizer/sencillo.png","selected":false, "unitPrice": 110000}', (SELECT [Id] FROM [Field] WHERE [Name] = 'dishwasherType' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_5_dishwasher')))


--Paso 6: Accesorios
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_6_accesories')
BEGIN
INSERT INTO [Step]
           ([Index]
           ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (6, 'kp_6_accesories', 'Accesorios', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'kitchen_precotizer'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'accesories' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_6_accesories'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('accesories', 'multiselect', 'Accesorios', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_6_accesories'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'accesories' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_6_accesories')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'accesories' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_6_accesories'))
END
GO

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('Escurreplatos', '{"index":0,"title":"Escurreplatos","imgUrl":"assets/images/kitchen-precotizer/escurreplatos.png","selected":false, "unitPrice": 66000}', (SELECT [Id] FROM [Field] WHERE [Name] = 'accesories' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_6_accesories'))),
	  	   ('Basurero', '{"index":1,"title":"Basurero","imgUrl":"assets/images/kitchen-precotizer/basurero.png","selected":false, "unitPrice": 86000}', (SELECT [Id] FROM [Field] WHERE [Name] = 'accesories' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_6_accesories'))),
	  	   ('Canasta multiusos', '{"index":2,"title":"Canasta multiusos","imgUrl":"assets/images/kitchen-precotizer/canasta_multiusos.png","selected":false, "unitPrice": 120000}', (SELECT [Id] FROM [Field] WHERE [Name] = 'accesories' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_6_accesories'))),
	  	   ('Canasta para utensilios', '{"index":3,"title":"Canasta para utensilios","imgUrl":"assets/images/kitchen-precotizer/canasta_para_utencilios.png","selected":false, "unitPrice": 136000}', (SELECT [Id] FROM [Field] WHERE [Name] = 'accesories' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'kp_6_accesories')))

--Pisos y paredes
IF NOT EXISTS (SELECT [Id] FROM [Calculator] WHERE [Code] = 'floorsAndWalls')
BEGIN
INSERT INTO [Calculator]
           ([Name]
		   ,[Code])
     VALUES
           ('Pisos y paredes', 'floorsAndWalls')
END
GO

--Paso 1: Selecciona el espacio de tu hogar
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_1_space')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (1, 'fw_1_space', 'Selecciona el espacio de tu hogar', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'floorsAndWalls'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_1_space'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('space', 'simple', 'Espacio', '', (SELECT [Id] FROM [Step] WHERE [Title] = 'Selecciona el espacio de tu hogar'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_1_space')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_1_space'))
END
GO

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('Todo el hogar', '{"index":0,"title":"Todo el hogar","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_1_space'))),
	  	   ('Cocina', '{"index":1,"title":"Cocina","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_1_space'))),
	  	   ('Sala comedor', '{"index":2,"title":"Sala comedor","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_1_space'))),
	  	   ('Baño', '{"index":3,"title":"Baño","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_1_space'))),
	  	   ('Habitación', '{"index":4,"title":"Habitación","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_1_space'))),
	  	   ('Garaje', '{"index":5,"title":"Garaje","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_1_space'))),
	  	   ('Espacio abierto', '{"index":6,"title":"Espacio abierto","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_1_space')))

--Paso 2: Ingresa el área del piso
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_2_floor_area')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (2, 'fw_2_floor_area', 'Ingresa el área del piso', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'floorsAndWalls'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'length' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_2_floor_area'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('length', 'number', 'Ingresa el largo', 'cm', (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_2_floor_area'))
END
GO

IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'width' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_2_floor_area'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('width', 'number', 'Ingresa el ancho', 'cm', (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_2_floor_area'))
END
GO

--Paso 3: Piso o pared
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_3_floor_wall')
BEGIN
INSERT INTO [Step]
           ([Index]
           ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (3, 'fw_3_floor_wall', 'Piso o pared', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'floorsAndWalls'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'floorOrWall' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_3_floor_wall'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('floorOrWall', 'feature', 'Pared o piso', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_3_floor_wall'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'floorOrWall' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_3_floor_wall')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'floorOrWall' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_3_floor_wall'))
END
GO



INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('Piso', '{"index":0,"title":"Piso","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 1300000,"features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin."}', (SELECT [Id] FROM [Field] WHERE [Name] = 'floorOrWall' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_3_floor_wall'))),
	  	   ('Pared', '{"index":1,"title":"Pared","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 1600000,"features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit."}', (SELECT [Id] FROM [Field] WHERE [Name] = 'floorOrWall' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_3_floor_wall')))

--Paso 4: Material
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_4_material')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (4, 'fw_4_material', 'Material', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'floorsAndWalls'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_4_material'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('material', 'feature', 'Material', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_4_material'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_4_material')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_4_material'))
END
GO

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('Cerámica', '{"index":0,"title":"Cerámica","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 132000,"features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin."}', (SELECT [Id] FROM [Field] WHERE [Name] = 'material'AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_4_material'))),
		   ('Porcelanato', '{"index":1,"title":"Porcelanato","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 390000,"features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin."}', (SELECT [Id] FROM [Field] WHERE [Name] = 'material'AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'fw_4_material')))
		   
		   
--Mesones
IF NOT EXISTS (SELECT [Id] FROM [Calculator] WHERE [Code] = 'mesons')
BEGIN
INSERT INTO [Calculator]
           ([Name]
		   ,[Code])
     VALUES
           ('Mesones', 'mesons')
END
GO

--Paso 1: Largo
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'me_1_length')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (1,'me_1_length', 'Ingresa el largo', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'mesons'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'length' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_1_length'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('length', 'number', 'Largo', 'cm', (SELECT [Id] FROM [Step] WHERE [Code] = 'me_1_length'))
END
GO

--Paso 2: Material
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'me_2_material')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (2, 'me_2_material', 'Material del mesón', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'mesons'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'mesonMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_2_material'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('mesonMaterial', 'feature', 'Material del mesón', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'me_2_material'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'mesonMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_2_material')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'mesonMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_2_material'))
END
GO

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
		   ('Granito', '{"index":0,"title":"Granito","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 390000,"features":"Piedra natural en Granito. Estos, son productos de la naturaleza y por lo tanto, están sujetos a variaciones cromáticas."}', (SELECT [Id] FROM [Field] WHERE [Name] = 'mesonMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_2_material'))),
	  	   ('Quartzone', '{"index":1,"title":"Quartzone","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 690000,"features":"Los Quarztone son productos artificiales y por lo tanto, pueden presentar ligeras variaciones cromáticas."}', (SELECT [Id] FROM [Field] WHERE [Name] = 'mesonMaterial' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_2_material')))

--Paso 3: Color
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'me_3_color')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (3, 'me_3_color', 'Color', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'mesons'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_3_color'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('color', 'simple', 'Color', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'me_3_color'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_3_color')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_3_color'))
END
GO

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('San gabriel', '{"index":0,"title":"San gabriel","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_3_color'))),
	  	   ('Gris clásico', '{"index":1,"title":"Gris clásico","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_3_color'))),
	  	   ('Salmón Brown', '{"index":2,"title":"Salmón Brown","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_3_color'))),
	  	   ('Blanco Polar', '{"index":3,"title":"Blanco Polar","imgUrl":"https://via.placeholder.com/150","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'me_3_color')))
DELETE FROM [Recommended]
DBCC CHECKIDENT ('Recommended', RESEED, 0)
GO

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS SAL SOLUBLE', '111480', 'PISO PORCELANATO BEIGE VETA SUAVE60x60 CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '142054', 'PISO CORDOBA ROJO 45.8x45.8 Cj 1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS SAL SOLUBLE', '205514', 'PISO PORCELANICO SELL BEIGE VETA60x60cm Cj.1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '206422', 'PISO PORCELANATO SELL BEIGE PLANO 80x80cm Cj1.92m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '209676', 'PISO TRAMANDAI BEIGE 33.8x33.8cm Cj 1.6 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '209684', 'PISO FORTALEZA BLANCO 33.8 X 33.8cm Cj 1.6 m2 COME');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '209685', 'PISO FORTALEZA NEGRO 33.8 X 33.8cm Cj 1.6 m2 COMER');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '209686', 'PISO LAVRA 2 BEIGE 33.8 X 33.8cm Cj 1.6 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '209687', 'PISO LAVRA 2 GRIS 33.8 X 33.8cm Cj 1.6 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '209702', 'PISO ANDINO SUPER CHOCOLATE 33.8X33.8CM CJ 1.6M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '209704', 'PISO PARED ARUBA ARENA 33.8x33.8cm Cj1.6 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '209706', 'PISO DUROPISO BLANCO 33.8 X 33.8cm Cj 1.6 m2 COMER');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '209707', 'PISO DUROPISO NEGRO 33.8 X 33.8cm Cj 1.6 m2 COMER');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '209710', 'PISO PARED PIZARRA NEGRO 33.8x33.8cm Cj1.6 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS LISAS', '209717', 'PISO-PARED EGEO BLANCO 33.8 X 33.8cm Cj 1.6 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '210440', 'PISO PORCELANATO SELL BEIGE 60x120cm Cj2.88m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '211851', 'PISO ALBORADA BLANCO 45.8x45.8cm Cj1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '211852', 'PISO ALBORADA NEGRO 45.8x45.8cm Cj1.89 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '213273', 'PARED NANTO BLANCO 30x60cm  Cj 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '213284', 'PISO CESPED VERDE 45.8x45.8cm  Cj 1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '214014', 'PARED VALPARAISO BEIGE  25x43cm Cj 1.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '214937', 'PORCELANATO PALMARES BEIGE56.6x56.6cmCj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '224894', 'PISO ORO BLANCO 56x56 Cj1.57 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '224895', 'PISO ORO NEGRO 56x56 Cj1.57 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '231682', 'PISO PARED VOLDA BEIGE 45.8x45.8cm Cj1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '231690', 'PARED MODERNA DINAMARCA BLANCA 25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '231691', 'PARED MODERNA DINAMARCA NEGRA 25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '231696', 'PARED ARIES BLANCO 30x60cm Cj1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '231724', 'FACHALETA RABAD BEIGE 13.1x41.7cm Cj0.98m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '231725', 'FACHALETA RABAD CAFE 13.1x41.7cm Cj0.98m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '232150', 'PISO LAJA CAFE 32.3x56cm Cj1.45 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '235254', 'PISO PORCELANATO SELL BLANCO PLANO 60X120CJ.2.88M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES LISOS', '235282', 'PISO GRES PORCELANICO ESM BEIGE 60X60. CJ1.44M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES LISOS', '235283', 'PISO GRES PORCELANICO ESM NEGRO60X60 CJ1.44M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES CEMENTICIOS / RUSTICOS', '235284', 'PISO GRES PORCELANICO ESM GRIS 60X60. CJ1.44M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES LISOS', '235285', 'PISO GRES PORCELANICO ESM BLANCO 60X60. CJ 1.44M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '237540', 'PARED DINAMARCA AZUL 25x35 Cj 2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS LISAS', '238213', 'PARED JAYA BLANCA 20.5x30.5cm Cj2.25m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '240173', 'PISO IRIS BLANCO 50x50cm Cj1.5 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '240175', 'PISO MONACO NEGRO 50x50cm Cj1.5 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '240180', 'PISO MANGLE ONDA 50x50cm Cj1.5 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '241492', 'PISO HONDA BEIGE 42.5x42.5cm CJ1.63m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '241499', 'PISO TRAVERTINO BONE 50x50cm Cj1.5m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '241502', 'PISO CATALINA MARFIL 50x50cm Cj1.5m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS LISAS', '243531', 'PARED PLANA BLANCO 30x60cm Cj1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '251455', 'PISO YAKARTA BEIGE 45.8x45.8CM CJ 1.89 MT2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '252067', 'FACHALETA JAEN BLANCO 25x41CM Cj1.54m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '253437', 'PISO LAPACHO TERRACOTA 45.8x45.8cm Cj1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '253457', 'PISO NATURAL PDRA ANGULAR GRIS55.2x55.2cmCj1.52m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '253459', 'PISO NATURAL PIEDRA SOL BEIGE55.2x55.2cm Cj1.52m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '253461', 'PISO SOLNA ARD AZUL33.8x33.8cm Cj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '253462', 'PISO SOLNA ARD NEGRO33.8x33.8cm Cj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '253463', 'PISO SOLNA ARD CAFE33.8x33.8cm Cj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '256524', 'PISO LIBRA PERLA  45.8x45.8CM CJ1.89 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '256864', 'PARED ODISH BLANCO 32.3x56cm Cj1.45 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '256865', 'PARED ODISH ROJO 32.3x56cm Cj1.45 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS LISAS', '256875', 'PISO BRILLANTE NEVADO BLANCO 45.8x45.8CM Cj1.89M');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '256877', 'PISO MIKONOS ARD GRIS 33.8x33.8CM Cj1.6M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '256885', 'FACHALETA TANZANIA MULTICOLOR 30x45CM Cj1.5M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS LISAS', '256930', 'PARED JAYA BLANCO 25X43.2cm cj1.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '256931', 'PARED PERLATO ARENA 32.3x56cm Cj1.45 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '257275', 'PISO MIKONOS ARD BLANCO33.8x33.8cm Cj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS LISAS', '258428', 'PARED CERAMICA BLANCO PLANO 30x60cm CJ 1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '258429', 'PARED CERAMICA BEIGE 30x60cm CJ 1.44 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '258772', 'PORCELANATO URBANGRISOSC 56.6x56.6cm CJ1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '262418', 'PARED PONCE BLANCO 25X35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '263131', 'PARED BALEIRA BEIGE 32.3x56cm Cj1.45 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS LISAS', '266931', 'PISO NEVADO BLANCO 33.8x33.8CM Cj1.6M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '267642', 'PORCELANATO URBAN PERLA 56.6x56.6cm Cj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '267721', 'PISO MIKONOS ARD AZUL 33.8x33.8CM Cj1.6M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '271803', 'PARED ARCOIRIS BLANCO25x43.2cm Cj1.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '271804', 'PARED ARCOIRIS AZUL OSCURO25x43.2cm Cj1.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '271805', 'PARED ARCOIRIS NARANJA25x43.2cm Cj1.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '271806', 'PARED ARCOIRIS NEGRO25x43.2cm Cj1.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '271811', 'PARED PRAVIA BEIGE30x45cm Cj1.5m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '271818', 'PARED GALIA BLANCO25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '271819', 'PARED MARCEL BLANCO25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '271822', 'PARED PIETRA SANTA MULTICOLOR30x45cm Cj1.5m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '271825', 'PARED SAMBAQUI COBRE30x60cm Cj1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '271828', 'PISO SAUCILLO BLANCO GRIS42.5x42.5cm Cj1.63m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '271829', 'PISO SAUCILLO BEIGE CAFE42.5x42.5cm Cj1.63m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '271833', 'PISO MANCORA ARD CAFE33.8x33.8cm Cj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '272259', 'PISO COCOA VAINILLA 50x50cm Cj1.5 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '272260', 'PISO PIZARRA CENIZA 56x56cm Cj1.57m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '272261', 'PISO PIZARRA OXIDO CARAMELO 56x56cm Cj1.57m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '272264', 'PISO PARED PIZARRA CENIZA 32.3x56cm Cj1.45 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '272265', 'PISO PARED BASALTICO NEGRO 32.3x56cm Cj1.45 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '272266', 'PARED BALEIRA MARRON 32.3x56cm Cj1.45 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '272267', 'PISO PARED ASTER VAINILLA 32.3x56cm Cj1.45 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '272269', 'PISO PARED PIZARRA OXID CARAMEL 32.3x56cm Cj1.45m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '272270', 'PARED THAMEL BEIGE 32.3x56cm Cj1.45m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '272271', 'PISO PARED BASALTICO BLANCO 32.3x56cm Cj1.45m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS LISAS', '275190', 'PARED JAYA BLANCO 25X35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS LISAS', '276685', 'PISO NEVADO BLANCO55.2x55.2cm Cj1.52m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '278132', 'PARED ECO BLANCO30x60cm Cj1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '278133', 'PARED BOLONIA BEIGE30x60cm Cj1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '278179', 'PISO PIETRA SANTA MULTICOLOR 42.5x42.5cm cj1.63m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '278389', 'PISO SOLADO BEIGE45.8x45.8cm Cj1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS LISAS', '281982', 'PISO PARED CAYEY BLANCO20.5x20.5cm Cj1.51m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS LISAS', '281983', 'PISO PARED CAYEY BEIGE20.5x20.5cm Cj1.51m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '282220', 'PARED ADRIATICO AZUL CLARO 20.5x20.5cm Cj1.51m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '282221', 'PARED ADRIATICO AGUA MARINA 20.5x20.5cm Cj1.51m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '282224', 'PISO JULIANA C/GOTA BGE 33.8X33.8cmCj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '283624', 'PISO PARED ARAGON GRIS MULTICOL 32.3x56cm Cj1.45m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '283628', 'PISO DAMEK SATIN MARFIL 56x56cm Cj1.57m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '283629', 'PISO PARED DAMEK SATIN MARFIL 32.3x56cm Cj1.45m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '283631', 'PISO VINTAGE CHOCOLATE 56x56cm Cj1.57m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '283790', 'PISO PORCELANATO SUPER NEGRO 60X60 cm Cj 1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '283791', 'PISO PORCELANATO SUPER WHITE BLA 60X60cmCj 1.44 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '287007', 'PISO PORTO MULTICOLOR45.8x45.8cm Cj1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '287008', 'PORCELANATO HATTERAS GRIS56.6x56.6cm Cj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS LISAS', '289443', 'PISO PARED NATAL AZUL 20.5X20.5cm Cj1.51m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '294287', 'PARED ANTICA MARFIL 30x45cm Cj1.5m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '294289', 'PISO ALFONSINA MULTICOLOR 45.8x45.8cm Cj1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '294294', 'PISO VILLAVICENCIO TERRACOTA 45.8x45.8cm Cj1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '294296', 'PISO  ALTAGRACIA BEIGE 45.8x45.8cm Cj1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '294297', 'PISO SAHARA BEIGE 45.8x45.8cm Cj1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '294409', 'PARED EST. AMATISTA 32.3x56cm Cj1.45m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '294412', 'PISO CHACANA MARRON 50x50cm Cj1.50m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '295304', 'PISO NEPAL BEIGE 56x56cm Cj1.57m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '295358', 'PARED GRES RIBASSOS MIX 32X47.5cm cj1.25 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '295359', 'PARED GRES ANDES ARENA 32x47.5cm cj1.36m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '295360', 'PARED GRES NEVADO MAGMA 23.5X40.5cm cj1.14m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '295361', 'PARED GRES SIERRA ARENA 32x47.5cm cj1.36m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '297460', 'PISO PAINE ARD BEIGE42.5x42.5cm Cj1.63m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '297461', 'PISO CARMINA TERRACOTA45.8x45.8cm Cj1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '297463', 'PISO PIEDRA AMAURI MULTICOLOR45.8x45.8cm Cj1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '297464', 'PARED AUREA MARFIL 30x45cm Cj 1.5 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '297466', 'PARED JARANA BLANCO 25x35cm Cj 2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '297467', 'PARED PAINE BEIGE 30x60cm Cj 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '297468', 'PARED PAINE EST BEIGE 30x60cm Cj 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '297470', 'FACHALETA ANTRACITA MULTICOLOR 25x41cm Cj 1.54m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '297474', 'PARED SALMA PLANA BEIGE 25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '297475', 'PARED SALMA BEIGE ESTRUCT 25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '297861', 'PISO AKILA BEIGE 45.8x45.8cm Cj 1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '299578', 'PARED SAVIA BLANCO25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '300722', 'PISO DEVA CAFE33.8x33.8cm Cj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '300726', 'PARED DEVA BEIGE25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '300727', 'PARED DEVA AZUL CLARO25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '300728', 'PARED DEVA AZUL OSCURO25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '300729', 'PARED DEVA CAFE25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '300731', 'PARED SAVIA AZUL25x35cm Cj2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '300733', 'PISO CALAR BLANCO42.5x42.5cm Cj1.63m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '302145', 'PARED PALMAS BLANCO 30X45cm Cj1.5m2 CORONA');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '302146', 'PARED FARO BLANCO 25X43.2cm Cj1.29m2 CORONA');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '302148', 'PARED OPAL BEIGE 30X45cm Cj1.5m2 CORONA');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '302149', 'FACHALETA STA JULIA MULTIC 25X41cm Cj1.54m2 CORONA');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '304560', 'PARED BELEM BEIGE 25X43.2 CM CJ 1.29 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '306113', 'PARED SANTA MARIA MATE MULT CU 30X45CM CJ1.5M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '306114', 'PARED SANTA MARIA BTE MULT CU 30X45CM CJ1.5M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '307895', 'PISO PORCELANATO STYLE GREIGE 60X60cm Cj 1.44cm');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '311574', 'PISO JAVA MARFIL 50x50cm Cj1.50m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '311575', 'PISO VOLTA NEGRO 56x56cm Cj1.57m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '311576', 'PISO ALICE GRIS 56x56cm Cj1.57m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '311577', 'PISO CENTURY GRIS 56x56cm Cj1.57m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '311578', 'PISO CENTURY CAFE 56x56cm Cj1.57m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '311579', 'PISO PARAISO NEGRO 50x50cm Cj1.50m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '311580', 'PISO PARAISO AZUL OSCURO 50x50cm Cj1.50m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '311581', 'PISO MADERA ORLEANS 50x50cm Cj1.50m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '311614', 'PARED NIEBLA BLANCO 25x43.2CM Cj1.29M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '311615', 'PARED PINZON BEIGE 30x45CM Cj1.5M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '312829', 'PORCELANATO AURA BEIGE 56.6x56.6cm Cj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '312830', 'PORCELANATO AURA GRIS 56.6x56.6cm Cj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '318022', 'PARED BARLOVENTO BEIGE CD 25X43.2cm Cj1.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '318025', 'PISO VIRGO BEIGE CD 55.2X55.2cm Cj1.52m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '326557', 'PARED BELISMA BEIGE CD 25X43.2 CM CJ 1.29 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '326559', 'PISO LAPONIA BEIGE CU 45.8X45.8 CM CJ 1.89 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '326560', 'PISO VIANA CAFE CD 45.8X45.8 CM CJ 1.89 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '326561', 'PISO NAIF BEIGE CU 45.8X45.8 CM CJ 1.89 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '326562', 'PARED ADARE BEIGE CU 30X60 CM CJ 1.08 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '326563', 'PARED ADARE ESTRUCTURADA BEIGE CU30X60cm CJ 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '326564', 'PISO GALO MULTICOLOR CD 45.8X45.8 CM CJ 1.89 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '326565', 'PISO CORUNA MULTICOLOR CU 45.8X45.8 CM CJ 1.89 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '326655', 'PARED SALAMANCA BEIGE 32.3X56  CM. CJ 1.45 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '327933', 'PISO PORCELANATO ESMAL BRILL 60X60 BEIGE CJ1.44M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '327934', 'PISO PORCELANATO PULIDO 60X60 MARM BEIGE CJ1.44M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '327935', 'PISO PORCELANATO PULIDO 80X80 MARM BEIGE CJ1.92M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '327936', 'PISO PORCELANATO PULIDO 60X60 MARM GRIS CJ1.44M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '327937', 'PISO PORCELANATO PULIDO 60X60 S. WHITE CJ 1.44M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '327938', 'PISO PORCELANATO PULIDO 80X80 S. WHITE CJ1.92M2.');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '330018', 'PISO AIRA BEIGE CD 45.8X45.8 CJ 1.89 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '330021', 'PISO SOLAR BEIGE CU 45.8X45.8 CJ 1.89 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '330027', 'PISO SION BEIGE CD 45.8X45.8 CJ 1.89 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '330028', 'PISO NATUR MULTICOLOR CD 45.8X45.8 CJ 1.89 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '330032', 'PARED ESTRUCTURADA MEMFIS BEIGE CD 30X60 CJ 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '330033', 'PARED ESTRUCTURADA MEMFIS TAUPE CD 30X60 CJ 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '330034', 'PARED DUOMO BLANCO CD 30X45 CJ 1.5 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '330035', 'PARED DUOMO NEGRO CD 30X45 CJ 1.5 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '330036', 'PARED TARTAGO BEIGE CU 30X60 CJ 1.08 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '330037', 'PARED AURORA ESTR BLANCO BRILLANTE CU30X60CJ1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '330038', 'PARED AURORA ESTRUCTURADO BLANCO CU 30X60 CJ1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '330039', 'PARED MAYAL BLANCO CU 25X35 CJ 2 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '330040', 'PARED MAYAL AZUL CU 25X35 CJ 2 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '330041', 'PARED VIANA BEIGE CD 30X60 CJ 1.08 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '330042', 'PARED CHANTARELA GRIS CD 30X45 CJ 1.5 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '330059', 'PISO PORCELANATO MADERA ETRO 15X90CM CJ 0.945M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '330060', 'PISO PORCELANATO REC  LAKEWOOD 20X120CM CJ1.2M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '330061', 'PISO PORCELANATOREC NATURAARCE 20X120CM CJ1.2M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '330062', 'PISO PORCELANATOREC NATURAROBLE 20X120CMCJ1.2M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '330063', 'PISO PORCELANATOREC NATURATORT 20X120CM CJ1.2M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS CENTICIAS / RUSTICAS', '330064', 'PARED GRES NAVIA ACERO 30X90CM  CJ1.35M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '330065', 'PISO PORCELANATO SAIL DARK 15X90CM CJ0.945M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '330066', 'PISO PORCELANATO  STYLE VISON 60X60CM CJ1.44M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '330067', 'PISO PORCELANATO TEXAS CAST 15X90CM CJ0.945M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '330068', 'PISO PORCELANATO TEXAS ROB 15X90CM CJ 0.95M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '330069', 'PISO PORCELANATO TEXAS COGN 15X90CM CJ0.95M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '330070', 'PISO PORCELANATO HABITAT BEIGE 30X90 CM CJ1.35M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '330071', 'PISO PORCELANATO HABITAT PERLA 30X90 CM CJ1.35M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS CENTICIAS / RUSTICAS', '330072', 'PARED GRES NAVIA TOPO 30X90CM  CJ1.35M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS CENTICIAS / RUSTICAS', '330073', 'PARED GRES NAVDEC ACERO 30X90CM  CJ1.35M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS CENTICIAS / RUSTICAS', '330074', 'PARED GRES NAVDEC TOPO 30X90CM CJ1.35M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '330425', 'PISO MARMOLANATO MADERA NF51X51 cm CJ 2.34 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '330426', 'PISO MADERA PARKET NF51X51 cm CJ 2.34 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '330427', 'PISO MADERA TARIMA MIX NF51X51 cm CJ 2.34 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '330428', 'PISO SAN NICOLAS 60X60 cm CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '330429', 'PISO SAN FELIPE BEIGE 60X60 cm CJ 1.44 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '330430', 'PISO MADERA PINARES BLANCO 60X60 cm CJ X 1.44 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '330486', 'PARED VERSANO GRAY 32X57 cm CJ2.03 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '330487', 'PARED VERSANO BEIGE 32X57 cm CJ2.03 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '330489', 'PISO APARIENCIALAMINATO BEIGE 53X53cm CJ2.29 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '330491', 'PISO APARIENCIALAMINATO MARRON 53X53cm CJ2.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '330494', 'PISO APARIENCIAMADERA ROSSANOLUX53X53cmCJ2.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '342296', 'PARED ESTRUC GANGES MARFIL CD 30X60CM CJ 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '342297', 'PISO OLIVERA BEIGE CD 55.2X55.2CM CJ 1.52m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '342298', 'PISO ADEL BEIGE CD 55.2X55.2CM CJ 1.52m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '345793', 'PISO PIEDRA FRANC OXID MT28.7x57.5cm CJ1.65M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '345794', 'PISO PIEDRA FRANCESA MAR MT 28.7x57.5cm CJ 1.65M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '345798', 'PARED MARIA MARFIL CD 25x35cm CJ 2 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '345799', 'PARED MILONGA BEIGE CD 25x35cm CJ 2 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '345800', 'PARED ROMA BEIGE CD 25x35cm CJ 2 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '345801', 'PARED ROMA AZUL CD 25x35cm CJ 2 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '345802', 'PARED ROMA VERDE CD 25x35cm CJ 2 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '345811', 'PARED JONICA BLANCO CU 25x35cm CJ 2 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '345812', 'PARED MARAJU BEIGE CU 25x35cm CJ 2 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '345814', 'PARED DEVA NEGRO CD 25x35cm CJ 2 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '345815', 'PISO PARED MIAMI BLANCO 24.5x50cm. CJ 1.96 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '345816', 'PARED SAUCE MARRON 24.5x50cm. CJ 1.96 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '345817', 'PARED SAUCE CREMA 24.5x50cm. CJ 1.96 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '345818', 'PARED ATENAS MARFIL 24.5x50cm. CJ 1.96 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '345819', 'PARED VELA BLANCO 24.5x50cm. CJ 1.96 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '345820', 'PARED MONT BLANC 24.5x50cm. CJ 1.96 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '345821', 'PARED BASKET AZUL 24.5x50cm. CJ 1.96 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '345822', 'PARED BASKET BLANCO 24.5x50cm. CJ 1.96 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '345823', 'PARED ARENA BLANCO 24.5x50cm. CJ 1.96 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '345824', 'PARED ARENA NEGRO 24.5x50cm. CJ 1.96 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '345825', 'PISO PARED NICOLO BEIGE SOFT 24.5x50cm. CJ 1.96 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '345826', 'PARED CARTAGENA MIx 32.3x56cm. CJ 1.45 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS LISAS', '345827', 'PISO BARRANQUILLA BLANCO 50x50cm. CJ 1.50 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '345828', 'PISO OLIMPO BEIGE 50x50cm. CJ 1.50 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '345829', 'PISO OLIMPO GRIS 50x50cm. CJ 1.50 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '345830', 'PISO SARGAZOS BEIGE 50x50cm. CJ 1.50 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '345831', 'PISO SARGAZOS GRIS 50x50cm. CJ 1.50 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '345832', 'PISO RIOBAMBA AZUL 50x50cm. CJ 1.50 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '345834', 'PISO BUGA BEIGE 56x56cm. CJ 1.57 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '345940', 'PISO PORCELANATO SUPER BLANCO DC 80x80cm CJ1.92M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '345941', 'PISO PORCELANATO SUPER BLANCO DC 60x120cm CJ1.44M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '345942', 'PISO PORCELANATO SUPER NEGRO FB 80x80cm CJ1.92M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '345943', 'PISO PORCELANATO SUPER NEGRO FB 60x120cm CJ1.44M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '349836', 'PISO CORINTIA GRIS 50X50 cm CJ 1.50 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES CEMENTICIOS / RUSTICOS', '350333', 'PISO GRESPORCELANICO SMOKMARFILMATE 60X60 CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES CEMENTICIOS / RUSTICOS', '350334', 'PISO PORCELANATO GRESSMOKE TAUPEMATE 60X60CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS LISAS', '350350', 'PARED 20X30cm BLANCA CJ 1.5m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '350351', 'PISOPORCELANATO TORINOBCOMARMOL BRILL60X60 1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '350352', 'PISOPORCELANATO TORINOBCOMARMOL BRIL60X120 1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES MADERADOS', '350353', 'PISO GRESPORCELANICO MADERASUMMER SUEDE 20X120 1.2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES MADERADOS', '350354', 'PISO GRESPORCELANICOMADERA TERRAIN TAN 20X120 1.2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES MADERADOS', '350355', 'PISO GRESPORCELANICO SMOAKED OAK 20X120 CJ1.2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES MADERADOS', '350356', 'PISO GRESPORCELANICOMADERATARNISHEDGOLD 15X90 1.08');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES MADERADOS', '350357', 'PISO GRESPORCELANICOMADERA EVEREST WHITE15X90 1.08');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES MADERADOS', '350358', 'PISO GRESPORCELANICOMADERA SILVER MIST 15X90 1.08');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '350359', 'PISO PORCELANATO CRYSTAL DCWHITE 60X60cm CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '350360', 'PISO PORCELANATO CRYSTAL DCWHITE 80X80cm CJ1.92m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '350470', 'PISO PORCELANATO SMOKE COBRE MATE 60X60cm CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '350471', 'PISO PORCELANATO SMOKECHOCO LAPPATO60X120 CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '350472', 'PISO PORCELANATO SMOKE GRAFITO MATE 60X60 CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS DECORADOS', '350473', 'PISO PORCELANATO BRUSHDECO GRIS MATE60X60 CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS DECORADOS', '350474', 'PISO PORCELANATO TEXTIL BEIGE MATE 60X60 CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS DECORADOS', '350475', 'PISO PORCELANATO TEXTIL GRIS MATE 60X60 CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '350476', 'PISO PORCELANATO TURINPLATAMARMOLBRILL60X60 1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '350477', 'PISO PORCELANATO SIENATAUPEMARMOLBRILL60X60 1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '350478', 'PISO PORCELANATO BARI PLATA MARMOLBRILL60X601.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '350479', 'PISO PORCELANATO TRAVERTINO BEIGE MATE 60X601.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '350480', 'PISO PORCELANATO TRAVERTINOBLANCOMATE 60X60 1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '351518', 'PISO PORCELANATO 20X120WOODSMAN COUNTRYASH CJ1.2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '351519', 'PISO PORCELANATO 20X120WOODSMAN HONEY OAK CJ1.2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '351520', 'PISO PORCELANATO 20X120WOODSMAN DEEP FORESTCJ1.2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS DECORADOS', '351521', 'PORCELANATO PARED BRICK 6X25 LISBON MIX CJ0.3m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS DECORADOS', '351522', 'PORCELANATO PARED BRICK 6X25 LISBON BEIGE CJ0.3m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS DECORADOS', '351523', 'PORCELANATO PARED BRICK 6X25 LONDON COTTON CJ0.3m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '351524', 'PISOPORCELANATO RECT 80X80CM VOLCANO GRIS CJ1.28m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '351525', 'PISO PORCELANATO RECT 80X80CMVOLCANO TAUPECJ1.28m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '351526', 'PISO PORCELANATO RECT80X80CMVOLCANO BEIGE CJ1.28m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '351527', 'PISO PORCELANATOREC60X120CMARDESIAGRISMATECJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '351528', 'PISOPORCELANATORECT60X120CMARDESIAMULTIMATCJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '351529', 'PISOPORCELANATORECT60X120CMARDESIATAUPEMATCJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS DECORADOS', '351530', 'PORCELANATO 30.5X60.5CM DENIM BLANCO CJ1.11m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS DECORADOS', '351531', 'PORCELANATO 30.5X60.5CM DENIM BEIGE CJ1.11m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS DECORADOS', '351532', 'PORCELANATO 30.5X60.5CM DENIM GRIS CLARO CJ1.11m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS DECORADOS', '351533', 'PORCELANATO 30.5X60.5CM DENIM AZUL CJ1.11m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS DECORADOS', '351534', 'PORCELANATO 30.5X60.5CM DENIM GRIS OSCURO CJ1.11m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES CEMENTICIOS / RUSTICOS', '351628', 'PISO GRESPORCELANICOSMOKE BEIGEMATE 60X60 CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO IMPORTADO', 'PRODUCTO ACTIVO', 'PORCELANATO', 'GRES PORCELANICOS', 'GRES CEMENTICIOS / RUSTICOS', '351629', 'PISOGRESPORCELANICO SMOKECENIZAMATE60X60 CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '354365', 'PISO PORCELANATO23X120cm ARTICWOODGRIS CJ1.104m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '354366', 'PISO PORCELANATO23X120cm ARTICWOODNATURALCJ1.104m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '354367', 'PISO PORCELANATO 23X120cm TIBER GRIS CJ1.104m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '354368', 'PISO PORCELANATO 23X120 TIBER NATURAL CJ1.104m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '354372', 'PISO PORCELANATORECT100X100cmEYRAPULIDOMATECJ1m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS TRAVERTINOS / MARMOLEADOS', '354373', 'PISO PORCELANATORECT100X100cmEYRAPULIDOBRILCJ1m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '354374', 'PISO PORCELANATO 23X120 DOUGLAS TORTORA CJ1.104m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '354375', 'PISO PORCELANATO 23X120 DOUGLAS WENGUE CJ1.104m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '354376', 'PORCELANATO RECT 40X120 TEMPEL WAY BLANCO CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '354377', 'PORCELANATO RECT 40X120 TEMPEL ROW BLANCO CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '354378', 'PORCELANATO RECT40X120 TEMPEL WAYGRAFITO CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '354379', 'PORCELANATORECT 40X120TEMPELROW GRAFITO CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '357815', 'PISO CASTANO MULTICOLOR MT 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '357816', 'PISO ALOE BEIGE MT 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '357817', 'PISO HEREDIA MARFIL CD 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '357819', 'PISO HARA MATE BEIGE CD 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '358074', 'PISO PORCELANATO MOONSTONE BEIGE 60X60cm CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '358075', 'PISOPORCELANATO CONCRET TAUPERUSTICO 60X60CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '358076', 'PISOPORCELANATO CONCRET PLATARUSTICO 60X60CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '358077', 'PISOPORCELANATO CONCRETGRAFITORUSTICO60X60CJ1.44m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '359284', 'PISO HARA BEIGE CD 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '362934', 'PISO ACUARELA AZUL 40x40cm CJ 1.76 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '362935', 'PISO ACUARELA BEIGE 40x40cm CJ 1.76 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '362936', 'PISO ACUARELA BLANCO 40x40cm CJ 1.76 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '362937', 'PISO KASANI BLANCO 40x40cm CJ 1.76 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '362938', 'PISO MAKI MIx 40x40cm CJ 1.76 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '362939', 'PISO MALANDI BLANCO 50x50cm CJ 1.50 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '362940', 'PISO PERSIA GRIS 50x50cm CJ 1.50 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '362941', 'PISO PARED MOSAICO ABISI 32.3x56cm CJ 1.45 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '362950', 'PARED DECORADO OXFORD BRANCO 34X50cm CJ1.66m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '362951', 'PARED DECORADO OXFORD AZUL 34X50 CJ1.66m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '362952', 'PARED DECORADO OXFORD NUDE 34X50cm CJ1.66m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '362953', 'PARED DECORADO OXFORD VERMELHO 34X50cm CJ1.66m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '362954', 'PARED DECORADO OXFORD PRETO 34X50cm CJ1.66m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '362955', 'PARED DECORADO QUEENS BRANCO 34X50cm 1.66m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '362956', 'PARED FACHALETA 34X50 PATAGONIA ROBLE CJ2.04m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '362957', 'PARED FACHALETA 34X50 PATAGONIA CINZA CJ2.04m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '362958', 'PARED FACHALETA 34X50 PATAGONIA NATURAL 2.04m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '362959', 'PARED FACHALETA 34X50 VALLEY WHITE CJ2.04m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '362960', 'PARED FACHALETA 34X50 VALLEY GREY CJ2.04m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '362961', 'PARED FACHALETA 34X50 VALLEY BROWN CJ2.04m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '363926', 'PARED FERRO OXIDO CD 30x75cm CJ 1.35m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '363930', 'PARED ESTRU BRISSA BLANCO CU 30x75cm CJ 1.35m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '363931', 'PARED PIZANO BLANCO CD 25x43.2cm CJ 1.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS MADERADOS', '363933', 'PORC REC CHICAGO BEIGE CD 19.5x88cm CJ1.03m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '363945', 'PORC ATLANTA MARFIL CD 56.6x56.6cm CJ1.60 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS CEMENTICIOS / RUSTICOS', '363951', 'PORC ATLANTA GRIS CD 56.6x56.6cm CJ1.60 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '373476', 'PISO MADERA NARANJO TERRACOTA CD 60x60cm Cj1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '373478', 'PISO VALI GRIS CD 60x60cm Cj1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '373479', 'PISO VALI PERLA CD 60x60cm Cj1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '373480', 'PISO LAIKA BEIGE MT 60x60cm Cj1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '373481', 'PISO PREZIOSI CARAMELO MT 60x60cm Cj1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '373482', 'PISO SIBILA BLANCO CD 60x60cm Cj1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '373488', 'PISO MARMARA GRIS MT 60x60cm Cj1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '373489', 'PISO EXTERIOR BALASTO BEIGE MT 60x60cm Cj1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '373490', 'PISO BUNES GRIS CD 60x60cm Cj1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '373491', 'PISO NUEVO ARUBA ARENA CD 60x60cm Cj1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '373496', 'PARED ADEL BEIGE CD 30x45cm Cj1.5m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '379544', 'PISO ROCA 50X50 cm CJ 1.50 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '379545', 'PISO ARANDA CHOCOLATE 50X50 cm CJ 1.50 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '379546', 'PISO KAVALA 50X50 cm CJ 1.50 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '379547', 'PISO PIZARRA NEGRO 50X50 cm CJ 1.50 M2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '384946', 'PISO SAN NICOLAS 60x60cm Cj2.16m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '384947', 'PISO MARMOLANATO MADERA 51x51cm Cj2.34m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '384948', 'PISO MADERA PINARES BLANCO 60x60cm Cj2.16m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '385911', 'PISO MADERA PARKET 51x51cm cj2.34m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '391622', 'PARED MALTA MARFIL CD 30x60cm Cj 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '395622', 'PISO CRATOS BEIGE CD45.8X45.8cm Cj 1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 1, 1, 0, 'PRODUCTO NACIONAL', 'PRODUCTO ACTIVO', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '395623', 'PISO AVELLANO TABACO CD 30X60cm Cj 1.62m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '395624', 'PISO AVELLANO BEIGE CD 30X60cm Cj 1.62m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '398374', 'PISO PIEDRA FRANCESA MARENGO MT 30X60cm Cj 1.62 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '398376', 'PISO PIEDRA FRANCESA OXIDO MT 30X60cm Cj 1.62 m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '402136', 'PISO BELAIRE DUROPISO GRIS 55.2X55.2cm Cj 1.52m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '402138', 'PISO JUAREZ OXIDO CD 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '402139', 'PISO NAZCA MULTIC CD 45.8X45.8cm CJ 1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (0, 0, 0, 0, 1, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS DE TERRAZA', '402140', 'PISO CUZCO MULTIC CU 55.2X55.2cm Cj 1.52m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '402141', 'PISO TAYRONA CAFE CD 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '402142', 'PISO ANKARA CAFE CD 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '402143', 'PISO INCA CAFE CD 45.8X45.8cm CJ 1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '402144', 'PISO OLMO HIELO CD 55.2X55.2cm Cj 1.52m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '402145', 'PISO CRESPINO CAFE CD 55.2X55.2cm Cj 1.52m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '402146', 'PISO SELENE MARFIL CD 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '402147', 'PISO ZEBRINO MARFIL CD CD 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '402149', 'PISO KAILANI MUTIC CD 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '402150', 'PISO OPERA BLANCO CD 55.2X55.2cm Cj 1.52m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 0, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '402151', 'PISO ARD SAN LUIS G MULTIC CU 33.8x33.8CM Cj1.6m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '402152', 'PISO DECO BEIGE CD 45.8X45.8cm CJ 1.89m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '402153', 'PISOESTRUCTURADO FENICIA OXIDO CD 60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '402154', 'PISOESTRUCTURADO FENICIABEIGE CD60X60cm CJ 1.8m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '402157', 'PISO PARED PLANOFENICIA OXIDO CD30X60cm CJ 1.62m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '402158', 'PISO PAREDPLANO FENICIA BEIGE CD 30X60CM CJ1.62m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '409542', 'PARED  ALCAIN BLANC0 30X60cm Cj 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS ACABADO MADERA', '411310', 'PISO APARIENCIA MADERA TARIMA MIX 51X51 CJ2.34m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'CERAMICAS', 'CERAMICAS PISO', 'CERAMICAS MARMOLEADAS', '411311', 'PISO SAN FELIPE BEIGE 60X60 CJ2.16m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '412639', 'FACHALETA ALDEA MULTICOLOR CD 30x60cm Cj 1.62m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '412640', 'PARED CHANTARELA OXIDO CD 30x45cm Cj 1.5m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '412642', 'PARED CALAIS MARFIL CD 25x35cm Cj 2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '412643', 'PARED ESTRUCT CALAIS BEIGE CD 25x35cm Cj 2m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '412644', 'PARED ESTRUCT ABRIL GRIS CLA CD 30x60cm Cj 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '412645', 'PARED ESTRUCT ABRIL GRIS OSC CD 30x60cm Cj 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '412646', 'PARED DANES CAFE 30x45cm Cj 1.5m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '412647', 'PARED DECO MULTICOLOR 25x43.2cm Cj 1.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '412648', 'PARED ESTRUCT MYRA BLANCO CU 30x45cm Cj 1.5m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '412649', 'PARED ESTRUCT MAYARI BLAN CU  25x43.2cm Cj 1.29m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICAS DECORADOS', '412653', 'PARED ESTRUC ALISON MARFIL CD 30x60cm Cj 1.08m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 0, 0, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'CERAMICA MARMOLEADAS', '412657', 'PISO PARED AMADEO BEIGE MT 30x60cm CJ 1.62m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '412660', 'FACHA STA CRISTINA PISO PAR MULT 30x60cm CJ 1.62m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '412662', 'FACHA SANTA JUANA MULTICOLOR MT  30x60cm CJ 1.62m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '412663', 'FACHALETA MACAO NEGRO CU 30x60cm CJ 1.62m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '412664', 'FACHA STA BIBIANA PISO PAR BEIGE 30x60cm CJ 1.62m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 0, 1, 1, '', '', 'CERAMICAS', 'CERAMICAS MURO', 'FACHALETAS', '412665', 'FACHA TEJARES PISO PAR BEIGE MT 30x60cm CJ 1.62m2');

INSERT INTO [Recommended]
        ([Bath]
        ,[Kitchen]
        ,[Room]
        ,[Hall]
        ,[Outdoor]
        ,[Origin]
        ,[State]
        ,[Sub]
        ,[Group]
        ,[Set]
        ,[Sku]
        ,[Desc])
  VALUES
        (1, 1, 1, 1, 0, '', '', 'PORCELANATO', 'PORCELANATOS', 'PORCELANATOS LISOS', '421779', 'PISO PORCELANATO BEIGE CRYSTAL 60X60CM CJ1.44M2');
/*
TAREA         : Diva
FECHA         : [28/10/2019]
AUTOR         : [Arnold Jair Jimenez Vargas (arnold.jimenez@areamovil.com.co)]
*/

--Diva
IF NOT EXISTS (SELECT [Id] FROM [Calculator] WHERE [Code] = 'diva')
BEGIN
INSERT INTO [Calculator]
           ([Name]
		   ,[Code])
     VALUES
           ('Diva', 'diva')
END
GO

--Paso 1: Espacio
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'di_1_space')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (1, 'di_1_space', 'Espacio', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'diva'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_1_space'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('space', 'simple', 'Espacio', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'di_1_space'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_1_space')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_1_space'))
END
GO

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('Todo el hogar', '{"index":0,"title":"Todo el hogar","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_1_space'))),
	  	   ('Cocina', '{"index":1,"title":"Cocina","imgUrl":"assets/images/diva/cocina.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_1_space'))),
	  	   ('Sala comedor', '{"index":2,"title":"Sala comedor","imgUrl":"assets/images/diva/sala_comedor.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_1_space'))),
	  	   ('Baño', '{"index":3,"title":"Baño","imgUrl":"assets/images/diva/baño.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_1_space'))),
	  	   ('Habitación', '{"index":4,"title":"Habitación","imgUrl":"assets/images/diva/habitacion.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_1_space'))),
	  	   ('Estudio', '{"index":5,"title":"Estudio","imgUrl":"assets/images/diva/estudio.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'space' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_1_space')))

--Paso 2: Diseño
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (2, 'di_2_design', 'Diseño', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'diva'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('design', 'simple', 'Diseño', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design'))
END
GO

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('Cortina enrrollable blackout', '{"index":0,"title":"Cortina enrrollable blackout","imgUrl":"assets/images/diva/diseño/cortina_enrollable_blackout.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design'))),
	  	   ('Cortina enrollable solar screen', '{"index":1,"title":"Cortina enrollable solar screen","imgUrl":"assets/images/diva/diseño/cortina_enrollable_solar_screen.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design'))),
	  	   ('Cortina enrollable traslucida', '{"index":2,"title":"Cortina enrollable traslucida","imgUrl":"assets/images/diva/diseño/cortina_enrollable_traslucida.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design'))),
	  	   ('Cortina panel japonés', '{"index":3,"title":"Cortina panel japonés","imgUrl":"assets/images/diva/diseño/cortina_panel_japones.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design'))),
	  	   ('Cortina enrollable roler duo', '{"index":4,"title":"Cortina enrollable roler duo","imgUrl":"assets/images/diva/diseño/cortina_enrollable_roler_duo.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design'))),
	  	   ('Persiana horizontal de madera 50 mm', '{"index":5,"title":"Persiana horizontal de madera 50 mm","imgUrl":"assets/images/diva/diseño/persiana_horizontal_de_madera_50_mm.png","selected":false, "unitPrice": 0}', (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design')))

--Paso 3: Colección
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'di_3_collection')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (3, 'di_3_collection', 'Colección', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'diva'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'collection' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_3_collection'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('collection', 'feature', 'Colección', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'di_3_collection'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'collection' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_3_collection')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'collection' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_3_collection'))
END
GO

DECLARE @id_field int
DECLARE @id_parent int

--Cortina enrrollable blackout

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'collection' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_3_collection'))
SET @id_parent = (SELECT [Id] from [Value] where [Name] = 'Cortina enrrollable blackout' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Absolut Blackout', '{"index":0,"title":"Absolut Blackout","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Terra Blackout', '{"index":1,"title":"Terra Blackout","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent)
	  	   
--Cortina enrollable solar screen
SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'collection' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_3_collection'))
SET @id_parent = (SELECT [Id] from [Value] where [Name] = 'Cortina enrollable solar screen' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Solar Screen Apertura 10%', '{"index":0,"title":"Solar Screen Apertura 10%","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Solar Screen Apertura 5%', '{"index":1,"title":"Solar Screen Apertura 5%","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Solar Screen Apertura 3%', '{"index":2,"title":"Solar Screen Apertura 3%","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Solar Screen Natura', '{"index":3,"title":"Solar Screen Natura","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Solar Screen Decorativa Damasco', '{"index":4,"title":"Solar Screen Decorativa Damasco","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent)
	  	   
--Cortina enrollable traslucida
SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'collection' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_3_collection'))
SET @id_parent = (SELECT [Id] from [Value] where [Name] = 'Cortina enrollable traslucida' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Traslúcida Decorativa Cross Texture', '{"index":0,"title":"Traslúcida Decorativa Cross Texture","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Traslúcida Decorativa Biaggio', '{"index":1,"title":"Traslúcida Decorativa Biaggio","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Traslúcida Decorativa Riviera', '{"index":2,"title":"Traslúcida Decorativa Riviera","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent)
	  	   
--Cortina panel japonés
SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'collection' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_3_collection'))
SET @id_parent = (SELECT [Id] from [Value] where [Name] = 'Cortina panel japonés' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Solar Screen 5%', '{"index":0,"title":"Solar Screen 5%","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Traslúcido Cross Texture', '{"index":1,"title":"Traslúcido Cross Texture","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Rayas Verticales Riviera', '{"index":2,"title":"Rayas Verticales Riviera","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin.", "privacy": 20}', @id_field, @id_parent)
	  	   
--Cortina enrollable roler duo
SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'collection' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_3_collection'))
SET @id_parent = (SELECT [Id] from [Value] where [Name] = 'Cortina enrollable roler duo' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Sheer Elegance Classic', '{"index":0,"title":"Sheer Elegance Classic","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Sheer Elegance Solar Screen Prado', '{"index":1,"title":"Sheer Elegance Solar Screen Prado","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Sheer Elegance Linen', '{"index":2,"title":"Sheer Elegance Linen","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Sheer Elegance Flamenco', '{"index":3,"title":"Sheer Elegance Flamenco","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Sheer Elegance Murano', '{"index":4,"title":"Sheer Elegance Murano","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Sheer Elegance Blackout Misty', '{"index":5,"title":"Sheer Elegance Blackout Misty","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Sheer Elegance Dark XL', '{"index":6,"title":"Sheer Elegance Dark XL","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Sheer Elegance Creppe', '{"index":7,"title":"Sheer Elegance Creppe","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Sheer Elegance Style', '{"index":8,"title":"Sheer Elegance Style","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Sheer Elegance Trendy', '{"index":9,"title":"Sheer Elegance Trendy","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Sheer Elegance Oasis', '{"index":10,"title":"Sheer Elegance Oasis","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent)
	  	   
--Persiana horizontal de madera 50 mm
SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'collection' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_3_collection'))
SET @id_parent = (SELECT [Id] from [Value] where [Name] = 'Persiana horizontal de madera 50 mm' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_2_design')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Persiana Madera Alaska', '{"index":0,"title":"Persiana Madera Alaska","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0,"features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Persiana Madera Avellana', '{"index":1,"title":"Persiana Madera Avellana","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Persiana Madera Marmol', '{"index":2,"title":"Persiana Madera Marmol","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Persiana Madera Nuez', '{"index":3,"title":"Persiana Madera Nuez","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent),
	  	   ('Persiana Madera Roble', '{"index":4,"title":"Persiana Madera Roble","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0, "features":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed laoreet eget lectus non sollicitudin", "privacy": 20}', @id_field, @id_parent)

--Paso 4: Color
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'di_4_color')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (4, 'di_4_color', 'Color', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'diva'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_4_color'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('color', 'simple', 'Color', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'di_4_color'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_4_color')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_4_color'))
END
GO

DECLARE @id_field int
SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_4_color'))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('Beige', '{"index":0,"title":"Beige","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0}', @id_field),
	  	   ('Gris', '{"index":1,"title":"Gris","imgUrl":"assets/images/diva/hogar.png","selected":false, "unitPrice": 0}', @id_field)
	  	   
--Paso 5: Ingresa medidas
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'di_5_measurements')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (5,'di_5_measurements', 'Ingresa medidas', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'diva'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'length' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_5_measurements'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('length', 'number', 'Largo', 'cm', (SELECT [Id] FROM [Step] WHERE [Code] = 'di_5_measurements'))
END
GO

IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'width' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'di_5_measurements'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('width', 'number', 'Ancho', 'cm', (SELECT [Id] FROM [Step] WHERE [Code] = 'di_5_measurements'))
END
GO
