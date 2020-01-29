UPDATE Step SET Code = 'rt_1_aguas' WHERE Code = 'rt_1_wathers';
UPDATE Field SET Name = 'aguas' WHERE Name = 'wathers';


--RoofTilesInfo
IF NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'RoofTilesInfo')
BEGIN
	CREATE TABLE [dbo].[RoofTilesInfo](
		[Id] [int] IDENTITY(1,1),
		[Sku] [nvarchar](100) NOT NULL,
		[Product] [nvarchar](100) NOT NULL UNIQUE,
		[Thickness] [float] default 0,
		[Length] [float] default 0,
		[Width] [float] default 0,
		[Area] [float] default 0,
		[UsefullArea] [float] default 0,
		[FasteningsPerTile] [int] default 0,
		[FasteningSKu] [nvarchar](100),
		[Trestle] [nvarchar](100),
		[UE] [int] default 0,
        [EAN] [nvarchar](100),
	 	CONSTRAINT PK_RoofTilesInfo PRIMARY KEY (ID) 
	)
END
GO
