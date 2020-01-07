/*
TAREA         : Puertas-ventanas
FECHA         : [04/12/2019]
AUTOR         : [Ricardo Andrés Vejarano Garcia (ricardo.vejarano@areamovil.com.co)]
*/

--Puertas-Ventanas
IF NOT EXISTS (SELECT [Id] FROM [Calculator] WHERE [Code] = 'doors_windows')
BEGIN
INSERT INTO [Calculator]
           ([Name]
		   ,[Code])
     VALUES
           ('Puertas Ventanas', 'doors_windows')
END
GO

--Paso 1: Puerta o ventana
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (1, 'dw_1_door_or_window', 'Puerta o ventana', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'doors_windows'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('doorWindow', 'simple', 'Puerta o ventana', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window'))
END
GO

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field])
	   VALUES
	  	   ('Puerta Interiores', '{"index":0,"title":"Puerta Interiores","imgUrl":"assets/images/doors/step1/puerta_interiores.png","selected":false, "unitPrice": 0, "active": true}', (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window'))),
	  	   ('Ventana', '{"index":1,"title":"Ventana","imgUrl":"assets/images/doors/step1/ventana.png","selected":false, "unitPrice": 0, "active": true}', (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window'))),
	  	   ('Puertaventana', '{"index":2,"title":"Puertaventana","imgUrl":"assets/images/doors/step1/puertaventana.png","selected":false, "unitPrice": 0, "active": true}', (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window'))),
	  	   ('Puerta plegable', '{"index":3,"title":"Puerta plegable","imgUrl":"assets/images/doors/step1/puerta_plegable.png","selected":false, "unitPrice": 0, "active": true}', (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))


--Paso 2: Material
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (2, 'dw_2_material', 'Material', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'doors_windows'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('material', 'simple', 'Material', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material'))
END
GO

DECLARE @id_field int
DECLARE @id_parent int

--Puerta Interiores

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material'))
SET @id_parent = (SELECT [Id] from [Value] where [Name] = 'Puerta Interiores' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Laminados', '{"index":0,"title":"Laminados","imgUrl":"assets/images/doors/step2/puerta_interiores/laminados.png","selected":false, "unitPrice": 0, "features":"Puertas con acabado en melamina con colores de tendencia.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Raices', '{"index":1,"title":"Raices","imgUrl":"assets/images/doors/step2/puerta_interiores/raices.png","selected":false, "unitPrice": 0, "features":"Puertas pintadas con colores vivos para espacios creativos.", "privacy": 20}', @id_field, @id_parent),
           ('HDF', '{"index":2,"title":"HDF","imgUrl":"assets/images/doors/step2/puerta_interiores/hdf.png","selected":false, "unitPrice": 0, "features":"Puertas moldeadas con diseños tradicionales.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Triplex', '{"index":3,"title":"Triplex","imgUrl":"assets/images/doors/step2/puerta_interiores/triplex.png","selected":false, "unitPrice": 0, "features":"Puertas en chapilla de madera natural pintada.", "privacy": 20}', @id_field, @id_parent)

--Ventana

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Ventana' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Premium', '{"index":0,"title":"Premium","imgUrl":"assets/images/doors/step2/ventana_puertaventana/premium.png","selected":false, "unitPrice": 0, "features":"Vidrio termo acústico.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Elite', '{"index":1,"title":"Elite","imgUrl":"assets/images/doors/step2/ventana_puertaventana/elite.png","selected":false, "unitPrice": 0, "features":"Vidrio laminado.", "privacy": 20}', @id_field, @id_parent),
           ('Good', '{"index":2,"title":"Good","imgUrl":"assets/images/doors/step2/ventana_puertaventana/good.png","selected":false, "unitPrice": 0, "features":"Vidrio monolítico T.", "privacy": 20}', @id_field, @id_parent)

--Puertaventana

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Puertaventana' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Premium', '{"index":0,"title":"Premium","imgUrl":"assets/images/doors/step2/ventana_puertaventana/premium.png","selected":false, "unitPrice": 0, "features":"Vidrio termo acústico.", "privacy": 20}', @id_field, @id_parent),
	  	   ('Elite', '{"index":1,"title":"Elite","imgUrl":"assets/images/doors/step2/ventana_puertaventana/elite.png","selected":false, "unitPrice": 0, "features":"Vidrio laminado.", "privacy": 20}', @id_field, @id_parent),
           ('Good', '{"index":2,"title":"Good","imgUrl":"assets/images/doors/step2/ventana_puertaventana/good.png","selected":false, "unitPrice": 0, "features":"Vidrio monolítico T.", "privacy": 20}', @id_field, @id_parent)

--Puerta plegable

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Puerta plegable' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Material 1', '{"index":0,"title":"Material 1","imgUrl":"assets/images/doors/step2/puerta_plegable/material1.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
	  	   ('Material 2', '{"index":1,"title":"Material 2","imgUrl":"assets/images/doors/step2/puerta_plegable/material2.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
           ('Material 3', '{"index":2,"title":"Material 3","imgUrl":"assets/images/doors/step2/puerta_plegable/material3.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent)


--Paso 3: Ingresa medidas
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_3_measurements')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (3,'dw_3_measurements', 'Ingresa medidas', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'doors_windows'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'height' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_3_measurements'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('height', 'number', 'Alto', 'cm', (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_3_measurements'))
END
GO

IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'width' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_3_measurements'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
     VALUES
           ('width', 'number', 'Ancho', 'cm', (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_3_measurements'))
END
GO

--Paso 4: Color
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (4, 'dw_4_color', 'Color', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'doors_windows'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('color', 'simple', 'Color', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color'))
END
GO

DECLARE @id_field int
DECLARE @id_parent int

--Ventana

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Ventana' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Ventana 1', '{"index":0,"title":"Ventana 1","imgUrl":"assets/images/doors/step4/ventana_puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
	  	   ('Ventana 2', '{"index":1,"title":"Ventana 2","imgUrl":"assets/images/doors/step4/ventana_puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
           ('Ventana 3', '{"index":2,"title":"Ventana 3","imgUrl":"assets/images/doors/step4/ventana_puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
		   ('Ventana 4', '{"index":3,"title":"Ventana 4","imgUrl":"assets/images/doors/step4/ventana_puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent)

--Puertaventana

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Puertaventana' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Ventana 1', '{"index":0,"title":"Ventana 1","imgUrl":"assets/images/doors/step4/ventana_puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
	  	   ('Ventana 2', '{"index":1,"title":"Ventana 2","imgUrl":"assets/images/doors/step4/ventana_puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
           ('Ventana 3', '{"index":2,"title":"Ventana 3","imgUrl":"assets/images/doors/step4/ventana_puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
		   ('Ventana 4', '{"index":3,"title":"Ventana 4","imgUrl":"assets/images/doors/step4/ventana_puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent)

--Puerta plegable

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Puerta plegable' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Plegable 1', '{"index":0,"title":"Plegable 1","imgUrl":"assets/images/doors/step4/puerta_plegable/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
	  	   ('Plegable 2', '{"index":1,"title":"Plegable 2","imgUrl":"assets/images/doors/step4/puerta_plegable/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
           ('Plegable 3', '{"index":2,"title":"Plegable 3","imgUrl":"assets/images/doors/step4/puerta_plegable/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
		   ('Plegable 4', '{"index":3,"title":"Plegable 4","imgUrl":"assets/images/doors/step4/puerta_plegable/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
		   ('Plegable 5', '{"index":4,"title":"Plegable 5","imgUrl":"assets/images/doors/step4/puerta_plegable/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
           ('Plegable 6', '{"index":5,"title":"Plegable 6","imgUrl":"assets/images/doors/step4/puerta_plegable/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
		   ('Plegable 7', '{"index":6,"title":"Plegable 7","imgUrl":"assets/images/doors/step4/puerta_plegable/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent)

--Puertas de interior laminados

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Laminados' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Laminados 1', '{"index":0,"title":"Laminados 1","imgUrl":"assets/images/doors/step4/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
	  	   ('Laminados 2', '{"index":1,"title":"Laminados 2","imgUrl":"assets/images/doors/step4/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
           ('Laminados 3', '{"index":2,"title":"Laminados 3","imgUrl":"assets/images/doors/step4/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
		   ('Laminados 4', '{"index":3,"title":"Laminados 4","imgUrl":"assets/images/doors/step4/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
		   ('Laminados 5', '{"index":4,"title":"Laminados 5","imgUrl":"assets/images/doors/step4/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
           ('Laminados 6', '{"index":5,"title":"Laminados 6","imgUrl":"assets/images/doors/step4/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent)

--Puertas de interior raices

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Raices' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Raices 1', '{"index":0,"title":"Raices 1","imgUrl":"assets/images/doors/step4/raices/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
	  	   ('Raices 2', '{"index":1,"title":"Raices 2","imgUrl":"assets/images/doors/step4/raices/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
           ('Raices 3', '{"index":2,"title":"Raices 3","imgUrl":"assets/images/doors/step4/raices/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
		   ('Raices 4', '{"index":3,"title":"Raices 4","imgUrl":"assets/images/doors/step4/raices/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent)

--Puertas de interior HDF

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'HDF' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('HDF 1', '{"index":0,"title":"HDF 1","imgUrl":"assets/images/doors/step4/hdf/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
	  	   ('HDF 2', '{"index":1,"title":"HDF 2","imgUrl":"assets/images/doors/step4/hdf/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
           ('HDF 3', '{"index":2,"title":"HDF 3","imgUrl":"assets/images/doors/step4/hdf/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent)

--Puertas de interior triplex

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'color' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_4_color'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Triplex' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Triplex 1', '{"index":0,"title":"Triplex 1","imgUrl":"assets/images/doors/step4/triplex/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
	  	   ('Triplex 2', '{"index":1,"title":"Triplex 2","imgUrl":"assets/images/doors/step4/triplex/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent),
           ('Triplex 3', '{"index":2,"title":"Triplex 3","imgUrl":"assets/images/doors/step4/triplex/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent)


--Paso 5: Diseño
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (5, 'dw_5_design', 'Diseño', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'doors_windows'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('design', 'simple', 'Diseño', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design'))
END
GO

--Values
IF EXISTS (SELECT [Name] FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design')))
BEGIN
	DELETE FROM [Value] WHERE [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design'))
END
GO

DECLARE @id_field int
DECLARE @id_parent int


--Puertas de interior laminados

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Laminados' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Ruteado 1', '{"index":0,"title":"Ruteado 1","imgUrl":"assets/images/doors/step5/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
	  	   ('Ruteado 2', '{"index":1,"title":"Ruteado 2","imgUrl":"assets/images/doors/step5/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
           ('Ruteado 3', '{"index":2,"title":"Ruteado 3","imgUrl":"assets/images/doors/step5/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
		   ('Ruteado 4', '{"index":3,"title":"Ruteado 4","imgUrl":"assets/images/doors/step5/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
		   ('Incrustación 1', '{"index":4,"title":"Incrustación 1","imgUrl":"assets/images/doors/step5/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
           ('Incrustación 2', '{"index":5,"title":"Incrustación 2","imgUrl":"assets/images/doors/step5/laminados/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent)

--Puertas de interior raices

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Raices' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Ruteado 1', '{"index":0,"title":"Ruteado 1","imgUrl":"assets/images/doors/step5/raices/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
	  	   ('Ruteado 2', '{"index":1,"title":"Ruteado 2","imgUrl":"assets/images/doors/step5/raices/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
           ('Ruteado 3', '{"index":2,"title":"Ruteado 3","imgUrl":"assets/images/doors/step5/raices/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
		   ('Ruteado 4', '{"index":3,"title":"Ruteado 4","imgUrl":"assets/images/doors/step5/raices/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
		   ('Moldeado 1', '{"index":4,"title":"Moldeado 1","imgUrl":"assets/images/doors/step5/raices/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}],"optionCheckActive": true}', @id_field, @id_parent),
           ('Moldeado 2', '{"index":5,"title":"Moldeado 2","imgUrl":"assets/images/doors/step5/raices/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent)

--Puertas de interior HDF

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'HDF' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Sinfonía', '{"index":0,"title":"Sinfonía","imgUrl":"assets/images/doors/step5/hdf/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
	  	   ('Prestige', '{"index":1,"title":"Prestige","imgUrl":"assets/images/doors/step5/hdf/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
           ('Valerie', '{"index":2,"title":"Valerie","imgUrl":"assets/images/doors/step5/hdf/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent)

--Puertas de interior triplex

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Triplex' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'material' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_2_material')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Ruteado 1', '{"index":0,"title":"Ruteado 1","imgUrl":"assets/images/doors/step5/triplex/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
	  	   ('Ruteado 2', '{"index":1,"title":"Ruteado 2","imgUrl":"assets/images/doors/step5/triplex/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
           ('Ruteado 3', '{"index":2,"title":"Ruteado 3","imgUrl":"assets/images/doors/step5/triplex/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
		   ('Ruteado 4', '{"index":3,"title":"Ruteado 4","imgUrl":"assets/images/doors/step5/triplex/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
		   ('Ruteado 5', '{"index":4,"title":"Ruteado 5","imgUrl":"assets/images/doors/step5/triplex/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent)

--Puertaventana

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Puertaventana' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Premium design', '{"index":0,"title":"Premium design","imgUrl":"assets/images/doors/step5/puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
	  	   ('Elite design', '{"index":1,"title":"Elite design","imgUrl":"assets/images/doors/step5/puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
           ('Elite high design', '{"index":2,"title":"Elite high design","imgUrl":"assets/images/doors/step5/puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
		   ('Premium high design', '{"index":3,"title":"Premium high design","imgUrl":"assets/images/doors/step5/puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
		   ('Elite design', '{"index":4,"title":"Elite design","imgUrl":"assets/images/doors/step5/puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
		   ('Good standar design', '{"index":5,"title":"Good standar design","imgUrl":"assets/images/doors/step5/puertaventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Izq", "value": false}, {"name": "Der", "value": false}], "optionCheckActive": true}', @id_field, @id_parent)

--Ventana

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Ventana' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Elite fijo', '{"index":0,"title":"Elite fijo","imgUrl":"assets/images/doors/step5/ventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Arr", "value": false}, {"name": "Aba", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
	  	   ('Elite proyectante', '{"index":1,"title":"Elite proyectante","imgUrl":"assets/images/doors/step5/ventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Arr", "value": false}, {"name": "Aba", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
           ('Elite oscilobatiente', '{"index":2,"title":"Elite oscilobatiente","imgUrl":"assets/images/doors/step5/ventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Arr", "value": false}, {"name": "Aba", "value": false}], "optionCheckActive": true}', @id_field, @id_parent),
		   ('Elite corrediza', '{"index":3,"title":"Elite corrediza","imgUrl":"assets/images/doors/step5/ventana/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionsCheck": [{"name": "Arr", "value": false}, {"name": "Aba", "value": false}], "optionCheckActive": true}', @id_field, @id_parent)

--Puerta plegable

SET @id_field = (SELECT [Id] FROM [Field] WHERE [Name] = 'design' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_5_design'))
SET @id_parent = (SELECT [Id] FROM [Value] WHERE [Name] = 'Puerta plegable' AND [Id_Field] = (SELECT [Id] FROM [Field] WHERE [Name] = 'doorWindow' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_1_door_or_window')))

INSERT INTO [Value]
		   ([Name]
		   ,[Data]
		   ,[Id_Field]
           ,[Id_Parent])
	   VALUES
	  	   ('Apertura izquierda a derecha', '{"index":0,"title":"Apertura izquierda a derecha","imgUrl":"assets/images/doors/step5/puerta_plegable/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionCheckActive": false}', @id_field, @id_parent),
	  	   ('Apertura derecha a izquierda', '{"index":1,"title":"Apertura derecha a izquierda","imgUrl":"assets/images/doors/step5/puerta_plegable/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20, "optionCheckActive": false}', @id_field, @id_parent),
           ('Apertura central', '{"index":2,"title":"Apertura central","imgUrl":"assets/images/doors/step5/puerta_plegable/color.png","selected":false, "unitPrice": 0, "features":"", "privacy": 20}', @id_field, @id_parent)


--Paso 6: Interior
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_6_inside')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (6, 'dw_6_inside', 'Interior', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'doors_windows'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'inside' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_6_inside'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('inside', 'simple', 'Interior', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_6_inside'))
END
GO

--Paso 7: Marco
IF NOT EXISTS (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_7_frame')
BEGIN
INSERT INTO [Step]
           ([Index]
		   ,[Code]
           ,[Title]
           ,[Id_Calculator])
     VALUES
           (7, 'dw_7_frame', 'Marco', (SELECT [Id] FROM [Calculator] WHERE [Code] = 'doors_windows'))
END
GO

--Fields
IF NOT EXISTS (SELECT [Id] FROM [Field] WHERE [Name] = 'frame' AND [Id_Step] = (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_7_frame'))
BEGIN
INSERT INTO [Field]
           ([Name]
		   ,[Type]
		   ,[Label]
		   ,[Measurement_Unit]
		   ,[Id_Step])
	   VALUES
           ('frame', 'simple', 'Marco', '', (SELECT [Id] FROM [Step] WHERE [Code] = 'dw_7_frame'))
END
GO