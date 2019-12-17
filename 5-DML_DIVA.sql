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
