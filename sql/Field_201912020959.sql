INSERT INTO [DEX-HC].dbo.Field (Id,Name,[Type],Label,Measurement_Unit,Id_Step,NeedFilter) VALUES 
(1,'kitchenType','simple','Tipo de cocina','',1,0)
,(2,'length','number','Largo','cm',2,0)
,(3,'width','number','Ancho','cm',2,0)
,(4,'furnitureMaterial','feature','Material de los muebles','',3,0)
,(5,'mesonMaterial','feature','Material del mesón','',4,0)
,(6,'dishwasherType','simple','Tipo de lavaplatos','',5,0)
,(7,'accesories','multiselect','Accesorios','',6,0)
,(8,'space','simple','Espacio','',7,0)
,(9,'length','number','Ingresa el largo','cm',8,0)
,(10,'width','number','Ingresa el ancho','cm',8,0)
;
INSERT INTO [DEX-HC].dbo.Field (Id,Name,[Type],Label,Measurement_Unit,Id_Step,NeedFilter) VALUES 
(11,'floorOrWall','feature','Pared o piso','',9,0)
,(12,'material','feature','Material','',10,0)
,(13,'length','number','Largo','cm',11,0)
,(14,'mesonMaterial','feature','Material del mesón','',12,0)
,(15,'color','simple','Color','',13,1)
,(16,'space','simple','Espacio','',14,0)
,(17,'design','simple','Diseño','',15,0)
,(18,'collection','feature','Colección','',16,0)
,(19,'color','simple','Color','',17,0)
,(20,'length','number','Largo','cm',18,0)
;
INSERT INTO [DEX-HC].dbo.Field (Id,Name,[Type],Label,Measurement_Unit,Id_Step,NeedFilter) VALUES 
(21,'width','number','Ancho','cm',18,0)
,(22,'space','simple','Espacio',NULL,19,0)
,(23,'color','simple','Espacio',NULL,21,0)
,(24,'technology','simple','Tipo de tecnología',NULL,22,0)
,(25,'aguas','simple','Cantidad de aguas',NULL,25,0)
,(26,'type','simple','Tipo material',NULL,26,0)
,(27,'thickness','simplecheck','Selecciona grosor de tus ejes','',27,1)
,(28,'lenght','number','Ingresa el ancho del techo','m',27,0)
,(29,'width','number','Ingresa el ancho de tu techo','m',27,0)
,(30,'color','simple','Selecciona color de la cubierta',NULL,28,0)
;
INSERT INTO [DEX-HC].dbo.Field (Id,Name,[Type],Label,Measurement_Unit,Id_Step,NeedFilter) VALUES 
(31,'shape','simple','Selecciona forma',NULL,23,1)
,(32,'cap','simple','Selecciona tipo de rosca',NULL,23,1)
,(33,'lightbulb','simple','Selecciona tu bombillo',NULL,24,1)
;