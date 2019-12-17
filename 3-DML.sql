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
