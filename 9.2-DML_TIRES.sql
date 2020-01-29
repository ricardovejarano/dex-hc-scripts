DELETE FROM [Carcenter]
DBCC CHECKIDENT ('Carcenter', RESEED, 0)
GO

INSERT INTO [Carcenter]
        ([Name]
        ,[Description]
        ,[Zone]
        ,[Url])
  VALUES
        ('BOGOTÁ, EL DORADO', 'Calle 50 No. 82-55', 1, 'https://www.google.es/maps/place/Homecenter+-+Dorado/@4.6790199,-74.1178289,16z/data=!4m2!3m1!1s0x8e3f9b6499f37fc3:0x6b495c6599b0e071'),
        ('BOGOTA, CALLE 80', 'Avda. 68 No. 80-77', 1, 'https://www.google.es/maps/place/Homecenter+-+Calle+80/@4.684696,-74.078664,17z/data=!3m1!4b1!4m2!3m1!1s0x8e3f9b1fb6ff78f3:0x3c0f4072d5568286'),
        ('BOGOTÁ, SUR', 'Avda. 68 No. 37-37 Sur', 1, 'https://www.google.es/maps/place/Carrefour/@4.605302,-74.1311007,18z/data=!4m7!1m4!3m3!1s0x8e3f9b1fb7c4ac89:0x62ce9690f07fc2f3!2sHomecenter!3b1!3m1!1s0x0000000000000000:0x0b97c33d32df1f79'),
        ('BOGOTÁ, NORTE', 'Carrera 45 No. 175-50', 1, 'https://goo.gl/maps/Mgo9q'),
        ('BOGOTÁ, CEDRITOS', 'Avenida carrera 9 No 152A - 23', 1, 'https://goo.gl/maps/Ig8OQ'),
        ('CHIA', 'Via Cajica Km 27 (Fundación Sta Isabel)', 1, 'https://goo.gl/maps/4Cidr'),
        ('BOGOTÁ, TINTAL', 'Calle 10 B # 86 - 50', 1, 'https://goo.gl/maps/xBtxU'),
        ('MEDELLÍN, INDUSTRIALES', 'Avda. Los Industriales No. 14-135', 2, 'https://goo.gl/maps/gq701'),
        ('MEDELLÍN, SAN JUAN', 'Calle 44 No. 65-100', 2, 'https://www.google.es/maps/place/Homecenter+San+Juan/@6.249542,-75.583945,17z/data=!3m1!4b1!4m2!3m1!1s0x8e44290791df3b45:0xfadda28b79d7a56b'),
        ('ENVIGADO', 'Av Regional Carrera 49 # 32-B-SUR-24', 24, 'https://goo.gl/maps/OpljM'),
        ('RIONEGRO, SAN NICOLAS', 'Calle 43 # 54 - 139 Local 14 - 13 C.C San Nicolas', 25, 'https://goo.gl/maps/sXymy'),
        ('CALI, NORTE', 'Avda. 6 A No. 35-00 - Barrio Sta. Mónica', 22, 'https://goo.gl/maps/Y5JPK'),
        ('PALMIRA', 'Cra 39 # 42 esquina', 26, 'https://goo.gl/maps/VfK3F'),
        ('BARRANQUILLA', 'Carrera 53 No. 100 - 160', 21, 'https://goo.gl/maps/ueLSa'),
        ('MONTERIA', 'Calle 65 # 10 - 19 La Castellana', 14, 'https://goo.gl/maps/NyUUR'),
        ('SANTA MARTA', 'Carrera 35 # 29 - A - 355', 8, 'https://goo.gl/maps/tdrCe'),
        ('PEREIRA', 'Avda. Sur No. 46-06', 20, 'https://goo.gl/maps/rgmiO'),
        ('ARMENIA, C.C CALIMA', 'Av Centenario N 3 - 180 Centro Comercial Calima', 7, 'https://goo.gl/maps/mtzrG'),
        ('MANIZALES', 'Av La Sultana con Cra 18 Baja Suiza', 12, 'https://goo.gl/maps/sHX9m'),
        ('IBAGUE', 'Carrera 5 No. 83-100 - Vía El Salado', 19, 'https://goo.gl/maps/enAQ6'),
        ('NEIVA', 'Calle 50 # 16 - 02 Alamos Norte', 13, 'https://goo.gl/maps/rNix2'),
        ('CUCUTA', 'Diag Santander No. 11-200', 17, 'https://goo.gl/maps/XrvH0'),
        ('BUCARAMANGA', 'Cra 21 # 45 - 02 La Concordia', 15, 'https://goo.gl/maps/41OVK'),
        ('GIRADOT', 'Av Kennedy con Calle 35', 5, 'https://goo.gl/maps/GoRRF'),
        ('YOPAL', '', 6, 'https://goo.gl/maps/A84AZxvBNJ82')

