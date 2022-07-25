use master 
go

CREATE DATABASE TifLabo3
GO

USE TifLabo3
GO

CREATE TABLE Usuarios
(
	DNI_Usuario CHAR(10) NOT NULL,
	Nombre_Usuario VARCHAR(20) NOT NULL,
	Apellido_Usuario VARCHAR(20),
	Email_Usuario VARCHAR(50) NOT NULL,
	Contrase�a_Usuario VARCHAR(20) NOT NULL,
	EsAdmin_Usuario BIT DEFAULT 0,
	Estado_Usuario BIT DEFAULT 1

	CONSTRAINT PK_Usuarios PRIMARY KEY (DNI_Usuario),
	CONSTRAINT UQ_Usuarios_Email UNIQUE (Email_Usuario)
)
GO

CREATE TABLE Categorias
(
	Id_Categoria int NOT NULL Identity(1,1),
	Descripcion_Categoria VARCHAR(30) NOT NULL,
	Estado_Categoria BIT DEFAULT 1

	CONSTRAINT PK_CATEGORIAS PRIMARY KEY (Id_Categoria)
)
GO

CREATE TABLE Subcategorias
(
	Id_Categoria_Subcategoria int NOT NULL,
	Id_Subcategoria int NOT NULL Identity(1,1),
	Descripcion_Subcategoria VARCHAR(30),
	Estado_Subcategoria BIT DEFAULT 1

	CONSTRAINT PK_SUBCATEGORIAS PRIMARY KEY (Id_Categoria_Subcategoria,Id_Subcategoria)
	CONSTRAINT FK_SUBCATEGORIAS_CATEGORIAS FOREIGN KEY (Id_Categoria_Subcategoria)
		REFERENCES Categorias(Id_Categoria)
)
GO

CREATE TABLE Productos
(
	Id_Producto int NOT NULL Identity(1,1),
	Nombre_Producto VARCHAR(50),
	Descripcion_Producto VARCHAR(400),
	Precio_Producto decimal(8,2),
	Id_Categoria_Producto int,
	Id_Subcategoria_Producto int,
	Stock_Producto INT,
	Estado_Producto BIT DEFAULT 1,
	UrlImagen_Producto VARCHAR(150)

	CONSTRAINT PK_PRODUCTOS PRIMARY KEY (Id_Producto),
	CONSTRAINT FK_PRODUCTOS_CATEGORIAS FOREIGN KEY (Id_Categoria_Producto,Id_Subcategoria_Producto) 
		REFERENCES Subcategorias(Id_Categoria_Subcategoria,Id_Subcategoria)
)
GO	

CREATE TABLE Rese�as
(
	Id_Producto_Rese�a int NOT NULL,
	DNI_Usuario_Rese�a CHAR(10) NOT NULL,
	Contenido_Rese�a TEXT,
	Calificacion_Rese�a INT CHECK(Calificacion_Rese�a > 0 AND Calificacion_Rese�a <= 5),
	Fecha_Rese�a SMALLDATETIME DEFAULT GETDATE(),
	Estado_Rese�a BIT DEFAULT 1

	CONSTRAINT PK_RESE�AS PRIMARY KEY (Id_Producto_Rese�a,DNI_Usuario_Rese�a),
	CONSTRAINT FK_RESE�AS_PRODUCTOS FOREIGN KEY (Id_Producto_Rese�a) 
		REFERENCES Productos(Id_Producto),
	CONSTRAINT FK_RESE�AS_USUARIOS FOREIGN KEY (DNI_Usuario_Rese�a) 
		REFERENCES Usuarios(DNI_Usuario)
)
GO

CREATE TABLE Tarjetas
(
	Numero_Tarjeta CHAR(20) NOT NULL,
	DNI_Usuario_Tarjeta CHAR(10) NOT NULL,
	CodSeguridad_Tarjeta CHAR(3) NOT NULL,
	FechaExpiracion_Tarjeta DATE NOT NULL,
	Estado_Tarjeta BIT DEFAULT 1

	CONSTRAINT PK_TARJETAS PRIMARY KEY (Numero_Tarjeta),
	CONSTRAINT FK_TARJETAS_USUARIOS FOREIGN KEY (DNI_Usuario_Tarjeta) 
		REFERENCES Usuarios(DNI_Usuario)
)
GO

CREATE TABLE Provincias
(
	Id_Provincia int NOT NULL,
	Nombre_Provincia VARCHAR(30),
	Estado_Provincia BIT DEFAULT 1

	CONSTRAINT PK_PROVINCIAS PRIMARY KEY (Id_Provincia)
)
GO

CREATE TABLE Localidades
(
	Id_Provincia_Localidad int NOT NULL,
	Id_Localidad int NOT NULL,
	Nombre_Localidad VARCHAR(50) ,
	Estado_Localidad BIT DEFAULT 1

	CONSTRAINT PK_LOCALIDADES PRIMARY KEY (Id_Provincia_Localidad,Id_Localidad),
	CONSTRAINT FK_LOCALIDADES_PROVINCIAS FOREIGN KEY (Id_Provincia_Localidad) 
		REFERENCES Provincias(Id_Provincia)
)
GO

CREATE TABLE Facturas
(
	Id_Factura int NOT NULL Identity(1,1),
	Numero_Tarjeta_Factura CHAR(20) NOT NULL,
	ValorTotal_Factura DECIMAL(8,2) DEFAULT 0,
	FechaEmision_Factura SMALLDATETIME NOT NULL,
	SeEnvia_Factura BIT DEFAULT 0,
	DireccionEnvio_Factura VARCHAR(50),
	RangoHorario_Factura VARCHAR(20),
	Id_Provincia_Factura int,
	Id_Localidad_Factura int,
	Estado_Factura BIT DEFAULT 1,

	CONSTRAINT PK_FACTURAS PRIMARY KEY (Id_Factura),
	CONSTRAINT FK_FACTURAS_LOCALIDADES FOREIGN KEY (Id_Provincia_Factura,Id_Localidad_Factura) 
		REFERENCES Localidades(Id_Provincia_Localidad,Id_Localidad),
	CONSTRAINT FK_FACTURAS_TARJETAS FOREIGN KEY(Numero_Tarjeta_Factura) 
		REFERENCES Tarjetas(Numero_Tarjeta)
)
go


CREATE TABLE DetallesFacturas
(
	Id_Factura_Detalle int,
	Id_Producto_Detalle int,
	PrecioUnitario_Detalle DECIMAL(8,2),
	Cantidad_Detalle INT DEFAULT 0,
	Estado_Detalle BIT DEFAULT 1

	CONSTRAINT PK_DETALLESFACTURAS PRIMARY KEY (Id_Factura_Detalle,Id_Producto_Detalle),
	CONSTRAINT FK_DETALLESFACTURAS_FACTURAS FOREIGN KEY (Id_Factura_Detalle)
		REFERENCES Facturas(Id_Factura),
	CONSTRAINT FK_DETALLESFACTURAS_PRODUCTOS FOREIGN KEY (Id_Producto_Detalle)
		REFERENCES Productos(Id_Producto)
)
GO

insert into Categorias ([Descripcion_Categoria])
select 'Memorias' union -- memorias ram y sodimm
select 'Almacenamiento' union -- ssd, hdd
select 'Procesadores' union  -- amd e intel
select 'Perif�ricos' union -- perifericos de entrada y salida
select 'Placas' union -- placas de video, placas madre, placas de audio
select 'Fuentes alimentaci�n' union -- certificaciones
select 'Gabinetes' -- Full Tower, Mid Tower y Mini Tower
go


insert into Subcategorias([Id_Categoria_Subcategoria], [Descripcion_Subcategoria])
select 4, 'Memorias ram' union
select 4, 'Memorias ram sodimm' union

select 1, 'Discos s�lidos' union
select 1, 'Discos mec�nicos' union

select 7, 'Procesadores AMD' union
select 7, 'Procesadores INTEL' union

select 5, 'Perifericos de entrada' union
select 5, 'Perifericos de salida' union

select 6, 'Placas de video' union
select 6, 'Placas madre' union
select 6, 'Placas de audio' union

select 2, 'Certificadas' union
select 2, 'No Certificadas' union

select 3, 'Dimensiones full-tower' union
select 3, 'Dimensiones mid-tower' union
select 3, 'Dimensiones mini-tower'
go

insert into Productos([Nombre_Producto], [Descripcion_Producto], [Precio_Producto], [Id_Categoria_Producto], [Id_Subcategoria_Producto], [Stock_Producto], [UrlImagen_Producto])

select 'Memoria ram DDR4 4GB 2666MHz', 'Capacidad 4 gb, Velocidad 2666 mhz, Tipo DDR4, marca ADATA, Disipador: No, Disipador Alto: No',
4130, 4, 8, 800, '~/ProductosImagenes/Memoria ram DDR4 4GB 2666MHz.jpg' union

select 'Memoria SODIMM 8GB DDR4 2666MHz', 'Capacidad 8GB, Velocidad 2666MHz Basic SODIMM, tipo Notebook, Marca Crucial, Disipador: No, Disipador Alto: No',
4520, 4, 9, 200, '~/ProductosImagenes/Memoria SODIMM 8GB DDR4 2666MHz.jpg' union

select 'Disco R�gido WD 1TB BLUE', 
'Marca: Western Digital, Tipo De Conexi�n: SATA, Consumo: 30 w, Tipo De Disco: Mec�nico, Memoria: Cache 64 mb, Velocidad De Rotaci�n: 7200 rmp, Tasa De Transferencia: 6.0 gb/s, Factor 3.5, Capacidad: 1000 gb.'
,5965, 1, 1, 450, '~/ProductosImagenes/Disco R�gido WD 1TB BLUE.jpg' union

select 'Disco S�lido SSD WD 240GB GREEN', 
'Tipo De Conexi�n: SATA, Consumo: 5 w, Tipo De Disco: S�lido, Memoria Cache: 0 mb, Velocidad De Rotaci�n: 0 rmp, Tasa De Transferencia: 6.0 gb/s, Vel Lectura Secuencial: 545 mb/s, Vel Escritura Secuencial: 435 mb/s, Vel Lectura Random: 37000 iops, Vel Escritura Random: 68000 iops, Vida �til: 1000000 horas, Terabytes Written: 80 tb, Factor 2.5, Capacidad: 240 gb.',
4399, 1, 2, 370, '~/ProductosImagenes/Disco S�lido SSD WD 240GB GREEN.jpg' union

select 'Fuente Gigabyte 450W 80 Plus Bronze', 
'Watts Nominal: 450 w, Watts Reales: 432 w, Formato ATX Compatible Con Posici�n Inferior: Si, Certificaci�n: 80 PLUS Bronze, Modo H�brido: No, Tipo De Cableado: Cables fijos Ampers En Linea +12V 36 a Fuente Digital: No, Color: Negro, no incluye kit 220v.',
6990, 2, 3, 200, '~/ProductosImagenes/Fuente Gigabyte 450W 80 Plus Bronze.jpg' union

select 'Fuente Thermaltake 500W', 
'Watts Nominal: 500 w, Watts Reales: 420 w, Formato ATX Compatible Con Posici�n Inferior: Si, Certificacion 80 Plus: No, Modo H�brido: No, Tipo De Cableado Cables fijos Ampers En Linea +12V 35 a Fuente Digital: No, Color Negro, incluye kit 220v.',
6990, 2, 4, 300, '~/ProductosImagenes/Fuente Thermaltake 500W.jpg' union

select 'Gabinete Slim Performance 5836 Cx', 
'Modelo: SLIM MAX. Tama�o: 29.5 x 9.9 x 36.5 Color: Negro, Bahia Ext: 1 5 1/4, Bahia Int: 2 3 1/2, Soporta Motherboard: Micro ATX/ITX Slot I/O, 4 Material: SECC/SGCC/SPCC, ABS Plastico Grosor chapa: 0.5 mm, USB/AUDIO: 2, USB/AUDIO/MIC, Conector Auxiliar: 4.',
8600, 3, 7, 60, '~/ProductosImagenes/Gabinete Slim Performance 5836 Cx.jpg' union

select 'Gabinete Gamer Kolink Void Rgb Vidrio Templado', 
'Modelo: SLIM MAX. Tama�o: 29.5 x 9.9 x 36.5 Color: Negro, Bahia Ext: 1 5 1/4, Bahia Int: 2 3 1/2, Soporta Motherboard: Micro ATX/ITX Slot I/O, 4 Material: SECC/SGCC/SPCC, ABS Plastico Grosor chapa: 0.5 mm, USB/AUDIO: 2, USB/AUDIO/MIC, Conector Auxiliar: 4.',
12500, 3, 6, 75, '~/ProductosImagenes/Gabinete Gamer Kolink Void Rgb Vidrio Templado.jpg' union

select 'Gabinete Corsair 5000d Airflow Blanco Tg Mesh', 
'Marca Corsair, L�nea Airflow, Modelo; 5000, Incluye fuente de alimentaci�n: No, Tipo de estructura: Mid towe,r Puertos: (1x) USB 3.1, Type C,(2x) USB 3.0,(1x) Audio in/out Bah�as: (x2) 3.5in (x4) 2.5in Altura x Ancho x Largo: 520 cm x 245 cm x 520 cm, Es gamer: S�.',
25200, 3, 5, 35, '~/ProductosImagenes/Gabinete Corsair 5000d Airflow Blanco Tg Mesh.jpg' union

select 'Mouse Logitech Pro Series G Pro', 
'Marca: Logitech, L�nea: Pro Series Modelo G Pro Hero, Color: Negro, Sensor Tipo: �ptico, Tecnolog�a del sensor: Hero 25K, Resoluci�n del sensor: 25600 dpi. Peso y dimensiones: Largo 116.6 mm Ancho 62.15 mm, Altura 38.2 mm, Especificaciones.',
3560, 5, 10, 250, '~/ProductosImagenes/Mouse Logitech Pro Series G Pro.jpg' union

select 'Monitor Acer 20 V206HQL', 
'Tipo De Iluminaci�n: LED, Tipo De Panel: TN, Pantalla Curva; No,  Conexi�n 3.5 Mm - Entrada No Conector Auriculares: No, Hdmi 1 Dvi 0 Vga 1 Display Port 0 Puertos Usb 2.0 0 Puertos Usb 3.0 0 Puertos Usb 3.1 0 Mini Display Port..',
28020, 5, 11, 25, '~/ProductosImagenes/Monitor Acer 20 V206HQL.jpg' union

select 'Placa Sonido Pci Express 5.1 Sound Audio', 
'Marca: Logitech, L�nea: Pro Series Modelo G Pro Hero, Color: Negro, Sensor Tipo: �ptico, Tecnolog�a del sensor: Hero 25K, Resoluci�n del sensor: 25600 dpi. Peso y dimensiones: Largo 116.6 mm Ancho 62.15 mm, Altura 38.2 mm, Especificaciones.',
2850, 6, 12, 30, '~/ProductosImagenes/Placa Sonido Pci Express 5.1 Sound Audio.jpg' union

select 'Placa de Video Zotac GeForce RTX 2060 12GB', 
'Tipo: pcie, Chipset: Gpu RTX 2060, Entrada Video: No, Puente Para Sli/croosfirex - Doble Puente: No, Caracter�sticas Especiales: Ray Tracing + DLSS. CONECTIVIDAD: Vga 0 Dv. Digital 0 Hdmi 1 Displayports 3 Usb Type-c.',
69900, 6, 13, 50, '~/ProductosImagenes/Placa de Video Zotac GeForce RTX 2060 12GB.jpg' union

select 'Mother Gigabyte B560M-DS3H', 
'Plataforma: Intel, Socket: 1200 Rocket Lake-S,1200 Comet Lake, Chipsets Principal: Intel B560, Boton Bios,Flashback: No.',
14.600, 6, 14, 30, '~/ProductosImagenes/Mother Gigabyte B560M-DS3H.jpg' union

select 'Mother ASUS TUF B450-PLUS II', 
'Plataforma: AMD, Socket: AM4 APU 1th Gen,AM4 APU 2th Gen,AM4 Ryzen 1th Gen,AM4 Ryzen 2th Gen,AM4 Ryzen 3th Gen,AM4 APU 3th Gen,AM4 Ryzen 4th Gen,AM4 APU 5000, Chipsets Principal: AMD B450, Boton Bios Flashback: Si.',
19.200, 6, 14, 24, '~/ProductosImagenes/Mother ASUS TUF B450-PLUS II.jpg' union

select 'Procesador AMD Ryzen 7 5800X', 
'Modelo: 5800X. Socket: AM4 Ryzen 4th Gen. N�cleos: 8, Frecuencia: 3800.00 mhz. Proceso De Fabricaci�n: 7 nm. Chipset Gpu: NO Posee Gr�ficos Integrados, Hilos: 16, Frecuencia Turbo: 4700 mhz, Tdp: 105 w, Incluye Cooler Cpu: No.',
51990, 7, 15, 35, '~/ProductosImagenes/Procesador AMD Ryzen 7 5800X.jpg' union

select 'Procesador Intel Core i3 10100F', 
'Modelo; 10100F Socket 1200 Comet Lake. N�cleos: 4. Frecuencia: 3600.00 mhz. Proceso De Fabricaci�n: 14 nm, Chipset Gpu: NO Posee Gr�ficos Integrados. Hilos: 8. Frecuencia Turbo: 4300 mhz. Tdp: 65 w, Incluye Cooler Cpu: Si.',
13801, 7, 16, 55, '~/ProductosImagenes/Procesador Intel Core i3 10100F.jpg' 
go

INSERT INTO provincias (Id_Provincia, [Nombre_Provincia]) VALUES
(1, 'Buenos Aires'),
(2, 'Buenos Aires-GBA'),
(3, 'Capital Federal'),
(4, 'Catamarca'),
(5, 'Chaco'),
(6, 'Chubut'),
(7, 'C�rdoba'),
(8, 'Corrientes'),
(9, 'Entre R�os'),
(10, 'Formosa'),
(11, 'Jujuy'),
(12, 'La Pampa'),
(13, 'La Rioja'),
(14, 'Mendoza'),
(15, 'Misiones'),
(16, 'Neuqu�n'),
(17, 'R�o Negro'),
(18, 'Salta'),
(19, 'San Juan'),
(20, 'San Luis'),
(21, 'Santa Cruz'),
(22, 'Santa Fe'),
(23, 'Santiago del Estero'),
(24, 'Tierra del Fuego'),
(25, 'Tucum�n');
go

INSERT INTO localidades ([Id_Localidad], [Id_Provincia_Localidad],[Nombre_Localidad]) VALUES
(1, 1, '25 de Mayo'),
(2, 1, '3 de febrero'),
(3, 1, 'A. Alsina'),
(4, 1, 'A. Gonz�les Ch�ves'),
(5, 1, 'Aguas Verdes'),
(6, 1, 'Alberti'),
(7, 1, 'Arrecifes'),
(8, 1, 'Ayacucho'),
(9, 1, 'Azul'),
(10, 1, 'Bah�a Blanca'),
(11, 1, 'Balcarce'),
(12, 1, 'Baradero'),
(13, 1, 'Benito Ju�rez'),
(14, 1, 'Berisso'),
(15, 1, 'Bol�var'),
(16, 1, 'Bragado'),
(17, 1, 'Brandsen'),
(18, 1, 'Campana'),
(19, 1, 'Ca�uelas'),
(20, 1, 'Capilla del Se�or'),
(21, 1, 'Capit�n Sarmiento'),
(22, 1, 'Carapachay'),
(23, 1, 'Carhue'),
(24, 1, 'Caril�'),
(25, 1, 'Carlos Casares'),
(26, 1, 'Carlos Tejedor'),
(27, 1, 'Carmen de Areco'),
(28, 1, 'Carmen de Patagones'),
(29, 1, 'Castelli'),
(30, 1, 'Chacabuco'),
(31, 1, 'Chascom�s'),
(32, 1, 'Chivilcoy'),
(33, 1, 'Col�n'),
(34, 1, 'Coronel Dorrego'),
(35, 1, 'Coronel Pringles'),
(36, 1, 'Coronel Rosales'),
(37, 1, 'Coronel Suarez'),
(38, 1, 'Costa Azul'),
(39, 1, 'Costa Chica'),
(40, 1, 'Costa del Este'),
(41, 1, 'Costa Esmeralda'),
(42, 1, 'Daireaux'),
(43, 1, 'Darregueira'),
(44, 1, 'Del Viso'),
(45, 1, 'Dolores'),
(46, 1, 'Don Torcuato'),
(47, 1, 'Ensenada'),
(48, 1, 'Escobar'),
(49, 1, 'Exaltaci�n de la Cruz'),
(50, 1, 'Florentino Ameghino'),
(51, 1, 'Gar�n'),
(52, 1, 'Gral. Alvarado'),
(53, 1, 'Gral. Alvear'),
(54, 1, 'Gral. Arenales'),
(55, 1, 'Gral. Belgrano'),
(56, 1, 'Gral. Guido'),
(57, 1, 'Gral. Lamadrid'),
(58, 1, 'Gral. Las Heras'),
(59, 1, 'Gral. Lavalle'),
(60, 1, 'Gral. Madariaga'),
(61, 1, 'Gral. Pacheco'),
(62, 1, 'Gral. Paz'),
(63, 1, 'Gral. Pinto'),
(64, 1, 'Gral. Pueyrred�n'),
(65, 1, 'Gral. Rodr�guez'),
(66, 1, 'Gral. Viamonte'),
(67, 1, 'Gral. Villegas'),
(68, 1, 'Guamin�'),
(69, 1, 'Guernica'),
(70, 1, 'Hip�lito Yrigoyen'),
(71, 1, 'Ing. Maschwitz'),
(72, 1, 'Jun�n'),
(73, 1, 'La Plata'),
(74, 1, 'Laprida'),
(75, 1, 'Las Flores'),
(76, 1, 'Las Toninas'),
(77, 1, 'Leandro N. Alem'),
(78, 1, 'Lincoln'),
(79, 1, 'Loberia'),
(80, 1, 'Lobos'),
(81, 1, 'Los Cardales'),
(82, 1, 'Los Toldos'),
(83, 1, 'Lucila del Mar'),
(84, 1, 'Luj�n'),
(85, 1, 'Magdalena'),
(86, 1, 'Maip�'),
(87, 1, 'Mar Chiquita'),
(88, 1, 'Mar de Aj�'),
(89, 1, 'Mar de las Pampas'),
(90, 1, 'Mar del Plata'),
(91, 1, 'Mar del Tuy�'),
(92, 1, 'Marcos Paz'),
(93, 1, 'Mercedes'),
(94, 1, 'Miramar'),
(95, 1, 'Monte'),
(96, 1, 'Monte Hermoso'),
(97, 1, 'Munro'),
(98, 1, 'Navarro'),
(99, 1, 'Necochea'),
(100, 1, 'Olavarr�a'),
(101, 1, 'Partido de la Costa'),
(102, 1, 'Pehuaj�'),
(103, 1, 'Pellegrini'),
(104, 1, 'Pergamino'),
(105, 1, 'Pig��'),
(106, 1, 'Pila'),
(107, 1, 'Pilar'),
(108, 1, 'Pinamar'),
(109, 1, 'Pinar del Sol'),
(110, 1, 'Polvorines'),
(111, 1, 'Pte. Per�n'),
(112, 1, 'Pu�n'),
(113, 1, 'Punta Indio'),
(114, 1, 'Ramallo'),
(115, 1, 'Rauch'),
(116, 1, 'Rivadavia'),
(117, 1, 'Rojas'),
(118, 1, 'Roque P�rez'),
(119, 1, 'Saavedra'),
(120, 1, 'Saladillo'),
(121, 1, 'Salliquel�'),
(122, 1, 'Salto'),
(123, 1, 'San Andr�s de Giles'),
(124, 1, 'San Antonio de Areco'),
(125, 1, 'San Antonio de Padua'),
(126, 1, 'San Bernardo'),
(127, 1, 'San Cayetano'),
(128, 1, 'San Clemente del Tuy�'),
(129, 1, 'San Nicol�s'),
(130, 1, 'San Pedro'),
(131, 1, 'San Vicente'),
(132, 1, 'Santa Teresita'),
(133, 1, 'Suipacha'),
(134, 1, 'Tandil'),
(135, 1, 'Tapalqu�'),
(136, 1, 'Tordillo'),
(137, 1, 'Tornquist'),
(138, 1, 'Trenque Lauquen'),
(139, 1, 'Tres Lomas'),
(140, 1, 'Villa Gesell'),
(141, 1, 'Villarino'),
(142, 1, 'Z�rate'),
(143, 2, '11 de Septiembre'),
(144, 2, '20 de Junio'),
(145, 2, '25 de Mayo'),
(146, 2, 'Acassuso'),
(147, 2, 'Adrogu�'),
(148, 2, 'Aldo Bonzi'),
(149, 2, '�rea Reserva Cintur�n Ecol�gico'),
(150, 2, 'Avellaneda'),
(151, 2, 'Banfield'),
(152, 2, 'Barrio Parque'),
(153, 2, 'Barrio Santa Teresita'),
(154, 2, 'Beccar'),
(155, 2, 'Bella Vista'),
(156, 2, 'Berazategui'),
(157, 2, 'Bernal Este'),
(158, 2, 'Bernal Oeste'),
(159, 2, 'Billinghurst'),
(160, 2, 'Boulogne'),
(161, 2, 'Burzaco'),
(162, 2, 'Carapachay'),
(163, 2, 'Caseros'),
(164, 2, 'Castelar'),
(165, 2, 'Churruca'),
(166, 2, 'Ciudad Evita'),
(167, 2, 'Ciudad Madero'),
(168, 2, 'Ciudadela'),
(169, 2, 'Claypole'),
(170, 2, 'Crucecita'),
(171, 2, 'Dock Sud'),
(172, 2, 'Don Bosco'),
(173, 2, 'Don Orione'),
(174, 2, 'El Jag�el'),
(175, 2, 'El Libertador'),
(176, 2, 'El Palomar'),
(177, 2, 'El Tala'),
(178, 2, 'El Tr�bol'),
(179, 2, 'Ezeiza'),
(180, 2, 'Ezpeleta'),
(181, 2, 'Florencio Varela'),
(182, 2, 'Florida'),
(183, 2, 'Francisco �lvarez'),
(184, 2, 'Gerli'),
(185, 2, 'Glew'),
(186, 2, 'Gonz�lez Cat�n'),
(187, 2, 'Gral. Lamadrid'),
(188, 2, 'Grand Bourg'),
(189, 2, 'Gregorio de Laferrere'),
(190, 2, 'Guillermo Enrique Hudson'),
(191, 2, 'Haedo'),
(192, 2, 'Hurlingham'),
(193, 2, 'Ing. Sourdeaux'),
(194, 2, 'Isidro Casanova'),
(195, 2, 'Ituzaing�'),
(196, 2, 'Jos� C. Paz'),
(197, 2, 'Jos� Ingenieros'),
(198, 2, 'Jos� Marmol'),
(199, 2, 'La Lucila'),
(200, 2, 'La Reja'),
(201, 2, 'La Tablada'),
(202, 2, 'Lan�s'),
(203, 2, 'Llavallol'),
(204, 2, 'Loma Hermosa'),
(205, 2, 'Lomas de Zamora'),
(206, 2, 'Lomas del Mill�n'),
(207, 2, 'Lomas del Mirador'),
(208, 2, 'Longchamps'),
(209, 2, 'Los Polvorines'),
(210, 2, 'Luis Guill�n'),
(211, 2, 'Malvinas Argentinas'),
(212, 2, 'Mart�n Coronado'),
(213, 2, 'Mart�nez'),
(214, 2, 'Merlo'),
(215, 2, 'Ministro Rivadavia'),
(216, 2, 'Monte Chingolo'),
(217, 2, 'Monte Grande'),
(218, 2, 'Moreno'),
(219, 2, 'Mor�n'),
(220, 2, 'Mu�iz'),
(221, 2, 'Olivos'),
(222, 2, 'Pablo Nogu�s'),
(223, 2, 'Pablo Podest�'),
(224, 2, 'Paso del Rey'),
(225, 2, 'Pereyra'),
(226, 2, 'Pi�eiro'),
(227, 2, 'Pl�tanos'),
(228, 2, 'Pontevedra'),
(229, 2, 'Quilmes'),
(230, 2, 'Rafael Calzada'),
(231, 2, 'Rafael Castillo'),
(232, 2, 'Ramos Mej�a'),
(233, 2, 'Ranelagh'),
(234, 2, 'Remedios de Escalada'),
(235, 2, 'S�enz Pe�a'),
(236, 2, 'San Antonio de Padua'),
(237, 2, 'San Fernando'),
(238, 2, 'San Francisco Solano'),
(239, 2, 'San Isidro'),
(240, 2, 'San Jos�'),
(241, 2, 'San Justo'),
(242, 2, 'San Mart�n'),
(243, 2, 'San Miguel'),
(244, 2, 'Santos Lugares'),
(245, 2, 'Sarand�'),
(246, 2, 'Sourigues'),
(247, 2, 'Tapiales'),
(248, 2, 'Temperley'),
(249, 2, 'Tigre'),
(250, 2, 'Tortuguitas'),
(251, 2, 'Trist�n Su�rez'),
(252, 2, 'Trujui'),
(253, 2, 'Turdera'),
(254, 2, 'Valent�n Alsina'),
(255, 2, 'Vicente L�pez'),
(256, 2, 'Villa Adelina'),
(257, 2, 'Villa Ballester'),
(258, 2, 'Villa Bosch'),
(259, 2, 'Villa Caraza'),
(260, 2, 'Villa Celina'),
(261, 2, 'Villa Centenario'),
(262, 2, 'Villa de Mayo'),
(263, 2, 'Villa Diamante'),
(264, 2, 'Villa Dom�nico'),
(265, 2, 'Villa Espa�a'),
(266, 2, 'Villa Fiorito'),
(267, 2, 'Villa Guillermina'),
(268, 2, 'Villa Insuperable'),
(269, 2, 'Villa Jos� Le�n Su�rez'),
(270, 2, 'Villa La Florida'),
(271, 2, 'Villa Luzuriaga'),
(272, 2, 'Villa Martelli'),
(273, 2, 'Villa Obrera'),
(274, 2, 'Villa Progreso'),
(275, 2, 'Villa Raffo'),
(276, 2, 'Villa Sarmiento'),
(277, 2, 'Villa Tesei'),
(278, 2, 'Villa Udaondo'),
(279, 2, 'Virrey del Pino'),
(280, 2, 'Wilde'),
(281, 2, 'William Morris'),
(282, 3, 'Agronom�a'),
(283, 3, 'Almagro'),
(284, 3, 'Balvanera'),
(285, 3, 'Barracas'),
(286, 3, 'Belgrano'),
(287, 3, 'Boca'),
(288, 3, 'Boedo'),
(289, 3, 'Caballito'),
(290, 3, 'Chacarita'),
(291, 3, 'Coghlan'),
(292, 3, 'Colegiales'),
(293, 3, 'Constituci�n'),
(294, 3, 'Flores'),
(295, 3, 'Floresta'),
(296, 3, 'La Paternal'),
(297, 3, 'Liniers'),
(298, 3, 'Mataderos'),
(299, 3, 'Monserrat'),
(300, 3, 'Monte Castro'),
(301, 3, 'Nueva Pompeya'),
(302, 3, 'N��ez'),
(303, 3, 'Palermo'),
(304, 3, 'Parque Avellaneda'),
(305, 3, 'Parque Chacabuco'),
(306, 3, 'Parque Chas'),
(307, 3, 'Parque Patricios'),
(308, 3, 'Puerto Madero'),
(309, 3, 'Recoleta'),
(310, 3, 'Retiro'),
(311, 3, 'Saavedra'),
(312, 3, 'San Crist�bal'),
(313, 3, 'San Nicol�s'),
(314, 3, 'San Telmo'),
(315, 3, 'V�lez S�rsfield'),
(316, 3, 'Versalles'),
(317, 3, 'Villa Crespo'),
(318, 3, 'Villa del Parque'),
(319, 3, 'Villa Devoto'),
(320, 3, 'Villa Gral. Mitre'),
(321, 3, 'Villa Lugano'),
(322, 3, 'Villa Luro'),
(323, 3, 'Villa Ort�zar'),
(324, 3, 'Villa Pueyrred�n'),
(325, 3, 'Villa Real'),
(326, 3, 'Villa Riachuelo'),
(327, 3, 'Villa Santa Rita'),
(328, 3, 'Villa Soldati'),
(329, 3, 'Villa Urquiza'),
(330, 4, 'Aconquija'),
(331, 4, 'Ancasti'),
(332, 4, 'Andalgal�'),
(333, 4, 'Antofagasta'),
(334, 4, 'Bel�n'),
(335, 4, 'Capay�n'),
(336, 4, 'Capital'),
(337, 4, '4'),
(338, 4, 'Corral Quemado'),
(339, 4, 'El Alto'),
(340, 4, 'El Rodeo'),
(341, 4, 'F.Mamerto Esqui�'),
(342, 4, 'Fiambal�'),
(343, 4, 'Hualf�n'),
(344, 4, 'Huillapima'),
(345, 4, 'Ica�o'),
(346, 4, 'La Puerta'),
(347, 4, 'Las Juntas'),
(348, 4, 'Londres'),
(349, 4, 'Los Altos'),
(350, 4, 'Los Varela'),
(351, 4, 'Mutqu�n'),
(352, 4, 'Pacl�n'),
(353, 4, 'Poman'),
(354, 4, 'Pozo de La Piedra'),
(355, 4, 'Puerta de Corral'),
(356, 4, 'Puerta San Jos�'),
(357, 4, 'Recreo'),
(358, 4, 'S.F.V de 4'),
(359, 4, 'San Fernando'),
(360, 4, 'San Fernando del Valle'),
(361, 4, 'San Jos�'),
(362, 4, 'Santa Mar�a'),
(363, 4, 'Santa Rosa'),
(364, 4, 'Saujil'),
(365, 4, 'Tapso'),
(366, 4, 'Tinogasta'),
(367, 4, 'Valle Viejo'),
(368, 4, 'Villa Vil'),
(369, 5, 'Avi� Tera�'),
(370, 5, 'Barranqueras'),
(371, 5, 'Basail'),
(372, 5, 'Campo Largo'),
(373, 5, 'Capital'),
(374, 5, 'Capit�n Solari'),
(375, 5, 'Charadai'),
(376, 5, 'Charata'),
(377, 5, 'Chorotis'),
(378, 5, 'Ciervo Petiso'),
(379, 5, 'Cnel. Du Graty'),
(380, 5, 'Col. Ben�tez'),
(381, 5, 'Col. Elisa'),
(382, 5, 'Col. Popular'),
(383, 5, 'Colonias Unidas'),
(384, 5, 'Concepci�n'),
(385, 5, 'Corzuela'),
(386, 5, 'Cote Lai'),
(387, 5, 'El Sauzalito'),
(388, 5, 'Enrique Urien'),
(389, 5, 'Fontana'),
(390, 5, 'Fte. Esperanza'),
(391, 5, 'Gancedo'),
(392, 5, 'Gral. Capdevila'),
(393, 5, 'Gral. Pinero'),
(394, 5, 'Gral. San Mart�n'),
(395, 5, 'Gral. Vedia'),
(396, 5, 'Hermoso Campo'),
(397, 5, 'I. del Cerrito'),
(398, 5, 'J.J. Castelli'),
(399, 5, 'La Clotilde'),
(400, 5, 'La Eduvigis'),
(401, 5, 'La Escondida'),
(402, 5, 'La Leonesa'),
(403, 5, 'La Tigra'),
(404, 5, 'La Verde'),
(405, 5, 'Laguna Blanca'),
(406, 5, 'Laguna Limpia'),
(407, 5, 'Lapachito'),
(408, 5, 'Las Bre�as'),
(409, 5, 'Las Garcitas'),
(410, 5, 'Las Palmas'),
(411, 5, 'Los Frentones'),
(412, 5, 'Machagai'),
(413, 5, 'Makall�'),
(414, 5, 'Margarita Bel�n'),
(415, 5, 'Miraflores'),
(416, 5, 'Misi�n N. Pompeya'),
(417, 5, 'Napenay'),
(418, 5, 'Pampa Almir�n'),
(419, 5, 'Pampa del Indio'),
(420, 5, 'Pampa del Infierno'),
(421, 5, 'Pdcia. de La Plaza'),
(422, 5, 'Pdcia. Roca'),
(423, 5, 'Pdcia. Roque S�enz Pe�a'),
(424, 5, 'Pto. Bermejo'),
(425, 5, 'Pto. Eva Per�n'),
(426, 5, 'Puero Tirol'),
(427, 5, 'Puerto Vilelas'),
(428, 5, 'Quitilipi'),
(429, 5, 'Resistencia'),
(430, 5, 'S�enz Pe�a'),
(431, 5, 'Samuh�'),
(432, 5, 'San Bernardo'),
(433, 5, 'Santa Sylvina'),
(434, 5, 'Taco Pozo'),
(435, 5, 'Tres Isletas'),
(436, 5, 'Villa �ngela'),
(437, 5, 'Villa Berthet'),
(438, 5, 'Villa R. Bermejito'),
(439, 6, 'Aldea Apeleg'),
(440, 6, 'Aldea Beleiro'),
(441, 6, 'Aldea Epulef'),
(442, 6, 'Alto R�o Sengerr'),
(443, 6, 'Buen Pasto'),
(444, 6, 'Camarones'),
(445, 6, 'Carrenleuf�'),
(446, 6, 'Cholila'),
(447, 6, 'Co. Centinela'),
(448, 6, 'Colan Conhu�'),
(449, 6, 'Comodoro Rivadavia'),
(450, 6, 'Corcovado'),
(451, 6, 'Cushamen'),
(452, 6, 'Dique F. Ameghino'),
(453, 6, 'Dolav�n'),
(454, 6, 'Dr. R. Rojas'),
(455, 6, 'El Hoyo'),
(456, 6, 'El Mait�n'),
(457, 6, 'Epuy�n'),
(458, 6, 'Esquel'),
(459, 6, 'Facundo'),
(460, 6, 'Gaim�n'),
(461, 6, 'Gan Gan'),
(462, 6, 'Gastre'),
(463, 6, 'Gdor. Costa'),
(464, 6, 'Gualjaina'),
(465, 6, 'J. de San Mart�n'),
(466, 6, 'Lago Blanco'),
(467, 6, 'Lago Puelo'),
(468, 6, 'Lagunita Salada'),
(469, 6, 'Las Plumas'),
(470, 6, 'Los Altares'),
(471, 6, 'Paso de los Indios'),
(472, 6, 'Paso del Sapo'),
(473, 6, 'Pto. Madryn'),
(474, 6, 'Pto. Pir�mides'),
(475, 6, 'Rada Tilly'),
(476, 6, 'Rawson'),
(477, 6, 'R�o Mayo'),
(478, 6, 'R�o Pico'),
(479, 6, 'Sarmiento'),
(480, 6, 'Tecka'),
(481, 6, 'Telsen'),
(482, 6, 'Trelew'),
(483, 6, 'Trevelin'),
(484, 6, 'Veintiocho de Julio'),
(485, 7, 'Achiras'),
(486, 7, 'Adelia Maria'),
(487, 7, 'Agua de Oro'),
(488, 7, 'Alcira Gigena'),
(489, 7, 'Aldea Santa Maria'),
(490, 7, 'Alejandro Roca'),
(491, 7, 'Alejo Ledesma'),
(492, 7, 'Alicia'),
(493, 7, 'Almafuerte'),
(494, 7, 'Alpa Corral'),
(495, 7, 'Alta Gracia'),
(496, 7, 'Alto Alegre'),
(497, 7, 'Alto de Los Quebrachos'),
(498, 7, 'Altos de Chipion'),
(499, 7, 'Amboy'),
(500, 7, 'Ambul'),
(501, 7, 'Ana Zumaran'),
(502, 7, 'Anisacate'),
(503, 7, 'Arguello'),
(504, 7, 'Arias'),
(505, 7, 'Arroyito'),
(506, 7, 'Arroyo Algodon'),
(507, 7, 'Arroyo Cabral'),
(508, 7, 'Arroyo Los Patos'),
(509, 7, 'Assunta'),
(510, 7, 'Atahona'),
(511, 7, 'Ausonia'),
(512, 7, 'Avellaneda'),
(513, 7, 'Ballesteros'),
(514, 7, 'Ballesteros Sud'),
(515, 7, 'Balnearia'),
(516, 7, 'Ba�ado de Soto'),
(517, 7, 'Bell Ville'),
(518, 7, 'Bengolea'),
(519, 7, 'Benjamin Gould'),
(520, 7, 'Berrotaran'),
(521, 7, 'Bialet Masse'),
(522, 7, 'Bouwer'),
(523, 7, 'Brinkmann'),
(524, 7, 'Buchardo'),
(525, 7, 'Bulnes'),
(526, 7, 'Cabalango'),
(527, 7, 'Calamuchita'),
(528, 7, 'Calchin'),
(529, 7, 'Calchin Oeste'),
(530, 7, 'Calmayo'),
(531, 7, 'Camilo Aldao'),
(532, 7, 'Caminiaga'),
(533, 7, 'Ca�ada de Luque'),
(534, 7, 'Ca�ada de Machado'),
(535, 7, 'Ca�ada de Rio Pinto'),
(536, 7, 'Ca�ada del Sauce'),
(537, 7, 'Canals'),
(538, 7, 'Candelaria Sud'),
(539, 7, 'Capilla de Remedios'),
(540, 7, 'Capilla de Siton'),
(541, 7, 'Capilla del Carmen'),
(542, 7, 'Capilla del Monte'),
(543, 7, 'Capital'),
(544, 7, 'Capitan Gral B. O�Higgins'),
(545, 7, 'Carnerillo'),
(546, 7, 'Carrilobo'),
(547, 7, 'Casa Grande'),
(548, 7, 'Cavanagh'),
(549, 7, 'Cerro Colorado'),
(550, 7, 'Chaj�n'),
(551, 7, 'Chalacea'),
(552, 7, 'Cha�ar Viejo'),
(553, 7, 'Chancan�'),
(554, 7, 'Charbonier'),
(555, 7, 'Charras'),
(556, 7, 'Chaz�n'),
(557, 7, 'Chilibroste'),
(558, 7, 'Chucul'),
(559, 7, 'Chu�a'),
(560, 7, 'Chu�a Huasi'),
(561, 7, 'Churqui Ca�ada'),
(562, 7, 'Cienaga Del Coro'),
(563, 7, 'Cintra'),
(564, 7, 'Col. Almada'),
(565, 7, 'Col. Anita'),
(566, 7, 'Col. Barge'),
(567, 7, 'Col. Bismark'),
(568, 7, 'Col. Bremen'),
(569, 7, 'Col. Caroya'),
(570, 7, 'Col. Italiana'),
(571, 7, 'Col. Iturraspe'),
(572, 7, 'Col. Las Cuatro Esquinas'),
(573, 7, 'Col. Las Pichanas'),
(574, 7, 'Col. Marina'),
(575, 7, 'Col. Prosperidad'),
(576, 7, 'Col. San Bartolome'),
(577, 7, 'Col. San Pedro'),
(578, 7, 'Col. Tirolesa'),
(579, 7, 'Col. Vicente Aguero'),
(580, 7, 'Col. Videla'),
(581, 7, 'Col. Vignaud'),
(582, 7, 'Col. Waltelina'),
(583, 7, 'Colazo'),
(584, 7, 'Comechingones'),
(585, 7, 'Conlara'),
(586, 7, 'Copacabana'),
(587, 7, '7'),
(588, 7, 'Coronel Baigorria'),
(589, 7, 'Coronel Moldes'),
(590, 7, 'Corral de Bustos'),
(591, 7, 'Corralito'),
(592, 7, 'Cosqu�n'),
(593, 7, 'Costa Sacate'),
(594, 7, 'Cruz Alta'),
(595, 7, 'Cruz de Ca�a'),
(596, 7, 'Cruz del Eje'),
(597, 7, 'Cuesta Blanca'),
(598, 7, 'Dean Funes'),
(599, 7, 'Del Campillo'),
(600, 7, 'Despe�aderos'),
(601, 7, 'Devoto'),
(602, 7, 'Diego de Rojas'),
(603, 7, 'Dique Chico'),
(604, 7, 'El Ara�ado'),
(605, 7, 'El Brete'),
(606, 7, 'El Chacho'),
(607, 7, 'El Crisp�n'),
(608, 7, 'El Fort�n'),
(609, 7, 'El Manzano'),
(610, 7, 'El Rastreador'),
(611, 7, 'El Rodeo'),
(612, 7, 'El T�o'),
(613, 7, 'Elena'),
(614, 7, 'Embalse'),
(615, 7, 'Esquina'),
(616, 7, 'Estaci�n Gral. Paz'),
(617, 7, 'Estaci�n Ju�rez Celman'),
(618, 7, 'Estancia de Guadalupe'),
(619, 7, 'Estancia Vieja'),
(620, 7, 'Etruria'),
(621, 7, 'Eufrasio Loza'),
(622, 7, 'Falda del Carmen'),
(623, 7, 'Freyre'),
(624, 7, 'Gral. Baldissera'),
(625, 7, 'Gral. Cabrera'),
(626, 7, 'Gral. Deheza'),
(627, 7, 'Gral. Fotheringham'),
(628, 7, 'Gral. Levalle'),
(629, 7, 'Gral. Roca'),
(630, 7, 'Guanaco Muerto'),
(631, 7, 'Guasapampa'),
(632, 7, 'Guatimozin'),
(633, 7, 'Gutenberg'),
(634, 7, 'Hernando'),
(635, 7, 'Huanchillas'),
(636, 7, 'Huerta Grande'),
(637, 7, 'Huinca Renanco'),
(638, 7, 'Idiazabal'),
(639, 7, 'Impira'),
(640, 7, 'Inriville'),
(641, 7, 'Isla Verde'),
(642, 7, 'Ital�'),
(643, 7, 'James Craik'),
(644, 7, 'Jes�s Mar�a'),
(645, 7, 'Jovita'),
(646, 7, 'Justiniano Posse'),
(647, 7, 'Km 658'),
(648, 7, 'L. V. Mansilla'),
(649, 7, 'La Batea'),
(650, 7, 'La Calera'),
(651, 7, 'La Carlota'),
(652, 7, 'La Carolina'),
(653, 7, 'La Cautiva'),
(654, 7, 'La Cesira'),
(655, 7, 'La Cruz'),
(656, 7, 'La Cumbre'),
(657, 7, 'La Cumbrecita'),
(658, 7, 'La Falda'),
(659, 7, 'La Francia'),
(660, 7, 'La Granja'),
(661, 7, 'La Higuera'),
(662, 7, 'La Laguna'),
(663, 7, 'La Paisanita'),
(664, 7, 'La Palestina'),
(665, 7, '12'),
(666, 7, 'La Paquita'),
(667, 7, 'La Para'),
(668, 7, 'La Paz'),
(669, 7, 'La Playa'),
(670, 7, 'La Playosa'),
(671, 7, 'La Poblaci�n'),
(672, 7, 'La Posta'),
(673, 7, 'La Puerta'),
(674, 7, 'La Quinta'),
(675, 7, 'La Rancherita'),
(676, 7, 'La Rinconada'),
(677, 7, 'La Serranita'),
(678, 7, 'La Tordilla'),
(679, 7, 'Laborde'),
(680, 7, 'Laboulaye'),
(681, 7, 'Laguna Larga'),
(682, 7, 'Las Acequias'),
(683, 7, 'Las Albahacas'),
(684, 7, 'Las Arrias'),
(685, 7, 'Las Bajadas'),
(686, 7, 'Las Caleras'),
(687, 7, 'Las Calles'),
(688, 7, 'Las Ca�adas'),
(689, 7, 'Las Gramillas'),
(690, 7, 'Las Higueras'),
(691, 7, 'Las Isletillas'),
(692, 7, 'Las Junturas'),
(693, 7, 'Las Palmas'),
(694, 7, 'Las Pe�as'),
(695, 7, 'Las Pe�as Sud'),
(696, 7, 'Las Perdices'),
(697, 7, 'Las Playas'),
(698, 7, 'Las Rabonas'),
(699, 7, 'Las Saladas'),
(700, 7, 'Las Tapias'),
(701, 7, 'Las Varas'),
(702, 7, 'Las Varillas'),
(703, 7, 'Las Vertientes'),
(704, 7, 'Leguizam�n'),
(705, 7, 'Leones'),
(706, 7, 'Los Cedros'),
(707, 7, 'Los Cerrillos'),
(708, 7, 'Los Cha�aritos (C.E)'),
(709, 7, 'Los Chanaritos (R.S)'),
(710, 7, 'Los Cisnes'),
(711, 7, 'Los Cocos'),
(712, 7, 'Los C�ndores'),
(713, 7, 'Los Hornillos'),
(714, 7, 'Los Hoyos'),
(715, 7, 'Los Mistoles'),
(716, 7, 'Los Molinos'),
(717, 7, 'Los Pozos'),
(718, 7, 'Los Reartes'),
(719, 7, 'Los Surgentes'),
(720, 7, 'Los Talares'),
(721, 7, 'Los Zorros'),
(722, 7, 'Lozada'),
(723, 7, 'Luca'),
(724, 7, 'Luque'),
(725, 7, 'Luyaba'),
(726, 7, 'Malague�o'),
(727, 7, 'Malena'),
(728, 7, 'Malvinas Argentinas'),
(729, 7, 'Manfredi'),
(730, 7, 'Maquinista Gallini'),
(731, 7, 'Marcos Ju�rez'),
(732, 7, 'Marull'),
(733, 7, 'Matorrales'),
(734, 7, 'Mattaldi'),
(735, 7, 'Mayu Sumaj'),
(736, 7, 'Media Naranja'),
(737, 7, 'Melo'),
(738, 7, 'Mendiolaza'),
(739, 7, 'Mi Granja'),
(740, 7, 'Mina Clavero'),
(741, 7, 'Miramar'),
(742, 7, 'Morrison'),
(743, 7, 'Morteros'),
(744, 7, 'Mte. Buey'),
(745, 7, 'Mte. Cristo'),
(746, 7, 'Mte. De Los Gauchos'),
(747, 7, 'Mte. Le�a'),
(748, 7, 'Mte. Ma�z'),
(749, 7, 'Mte. Ralo'),
(750, 7, 'Nicol�s Bruzone'),
(751, 7, 'Noetinger'),
(752, 7, 'Nono'),
(753, 7, 'Nueva 7'),
(754, 7, 'Obispo Trejo'),
(755, 7, 'Olaeta'),
(756, 7, 'Oliva'),
(757, 7, 'Olivares San Nicol�s'),
(758, 7, 'Onagolty'),
(759, 7, 'Oncativo'),
(760, 7, 'Ordo�ez'),
(761, 7, 'Pacheco De Melo'),
(762, 7, 'Pampayasta N.'),
(763, 7, 'Pampayasta S.'),
(764, 7, 'Panaholma'),
(765, 7, 'Pascanas'),
(766, 7, 'Pasco'),
(767, 7, 'Paso del Durazno'),
(768, 7, 'Paso Viejo'),
(769, 7, 'Pilar'),
(770, 7, 'Pinc�n'),
(771, 7, 'Piquill�n'),
(772, 7, 'Plaza de Mercedes'),
(773, 7, 'Plaza Luxardo'),
(774, 7, 'Porte�a'),
(775, 7, 'Potrero de Garay'),
(776, 7, 'Pozo del Molle'),
(777, 7, 'Pozo Nuevo'),
(778, 7, 'Pueblo Italiano'),
(779, 7, 'Puesto de Castro'),
(780, 7, 'Punta del Agua'),
(781, 7, 'Quebracho Herrado'),
(782, 7, 'Quilino'),
(783, 7, 'Rafael Garc�a'),
(784, 7, 'Ranqueles'),
(785, 7, 'Rayo Cortado'),
(786, 7, 'Reducci�n'),
(787, 7, 'Rinc�n'),
(788, 7, 'R�o Bamba'),
(789, 7, 'R�o Ceballos'),
(790, 7, 'R�o Cuarto'),
(791, 7, 'R�o de Los Sauces'),
(792, 7, 'R�o Primero'),
(793, 7, 'R�o Segundo'),
(794, 7, 'R�o Tercero'),
(795, 7, 'Rosales'),
(796, 7, 'Rosario del Saladillo'),
(797, 7, 'Sacanta'),
(798, 7, 'Sagrada Familia'),
(799, 7, 'Saira'),
(800, 7, 'Saladillo'),
(801, 7, 'Sald�n'),
(802, 7, 'Salsacate'),
(803, 7, 'Salsipuedes'),
(804, 7, 'Sampacho'),
(805, 7, 'San Agust�n'),
(806, 7, 'San Antonio de Arredondo'),
(807, 7, 'San Antonio de Lit�n'),
(808, 7, 'San Basilio'),
(809, 7, 'San Carlos Minas'),
(810, 7, 'San Clemente'),
(811, 7, 'San Esteban'),
(812, 7, 'San Francisco'),
(813, 7, 'San Ignacio'),
(814, 7, 'San Javier'),
(815, 7, 'San Jer�nimo'),
(816, 7, 'San Joaqu�n'),
(817, 7, 'San Jos� de La Dormida'),
(818, 7, 'San Jos� de Las Salinas'),
(819, 7, 'San Lorenzo'),
(820, 7, 'San Marcos Sierras'),
(821, 7, 'San Marcos Sud'),
(822, 7, 'San Pedro'),
(823, 7, 'San Pedro N.'),
(824, 7, 'San Roque'),
(825, 7, 'San Vicente'),
(826, 7, 'Santa Catalina'),
(827, 7, 'Santa Elena'),
(828, 7, 'Santa Eufemia'),
(829, 7, 'Santa Maria'),
(830, 7, 'Sarmiento'),
(831, 7, 'Saturnino M.Laspiur'),
(832, 7, 'Sauce Arriba'),
(833, 7, 'Sebasti�n Elcano'),
(834, 7, 'Seeber'),
(835, 7, 'Segunda Usina'),
(836, 7, 'Serrano'),
(837, 7, 'Serrezuela'),
(838, 7, 'Sgo. Temple'),
(839, 7, 'Silvio Pellico'),
(840, 7, 'Simbolar'),
(841, 7, 'Sinsacate'),
(842, 7, 'Sta. Rosa de Calamuchita'),
(843, 7, 'Sta. Rosa de R�o Primero'),
(844, 7, 'Suco'),
(845, 7, 'Tala Ca�ada'),
(846, 7, 'Tala Huasi'),
(847, 7, 'Talaini'),
(848, 7, 'Tancacha'),
(849, 7, 'Tanti'),
(850, 7, 'Ticino'),
(851, 7, 'Tinoco'),
(852, 7, 'T�o Pujio'),
(853, 7, 'Toledo'),
(854, 7, 'Toro Pujio'),
(855, 7, 'Tosno'),
(856, 7, 'Tosquita'),
(857, 7, 'Tr�nsito'),
(858, 7, 'Tuclame'),
(859, 7, 'Tutti'),
(860, 7, 'Ucacha'),
(861, 7, 'Unquillo'),
(862, 7, 'Valle de Anisacate'),
(863, 7, 'Valle Hermoso'),
(864, 7, 'V�lez Sarfield'),
(865, 7, 'Viamonte'),
(866, 7, 'Vicu�a Mackenna'),
(867, 7, 'Villa Allende'),
(868, 7, 'Villa Amancay'),
(869, 7, 'Villa Ascasubi'),
(870, 7, 'Villa Candelaria N.'),
(871, 7, 'Villa Carlos Paz'),
(872, 7, 'Villa Cerro Azul'),
(873, 7, 'Villa Ciudad de Am�rica'),
(874, 7, 'Villa Ciudad Pque Los Reartes'),
(875, 7, 'Villa Concepci�n del T�o'),
(876, 7, 'Villa Cura Brochero'),
(877, 7, 'Villa de Las Rosas'),
(878, 7, 'Villa de Mar�a'),
(879, 7, 'Villa de Pocho'),
(880, 7, 'Villa de Soto'),
(881, 7, 'Villa del Dique'),
(882, 7, 'Villa del Prado'),
(883, 7, 'Villa del Rosario'),
(884, 7, 'Villa del Totoral'),
(885, 7, 'Villa Dolores'),
(886, 7, 'Villa El Chancay'),
(887, 7, 'Villa Elisa'),
(888, 7, 'Villa Flor Serrana'),
(889, 7, 'Villa Fontana'),
(890, 7, 'Villa Giardino'),
(891, 7, 'Villa Gral. Belgrano'),
(892, 7, 'Villa Gutierrez'),
(893, 7, 'Villa Huidobro'),
(894, 7, 'Villa La Bolsa'),
(895, 7, 'Villa Los Aromos'),
(896, 7, 'Villa Los Patos'),
(897, 7, 'Villa Mar�a'),
(898, 7, 'Villa Nueva'),
(899, 7, 'Villa Pque. Santa Ana'),
(900, 7, 'Villa Pque. Siquiman'),
(901, 7, 'Villa Quillinzo'),
(902, 7, 'Villa Rossi'),
(903, 7, 'Villa Rumipal'),
(904, 7, 'Villa San Esteban'),
(905, 7, 'Villa San Isidro'),
(906, 7, 'Villa 21'),
(907, 7, 'Villa Sarmiento (G.R)'),
(908, 7, 'Villa Sarmiento (S.A)'),
(909, 7, 'Villa Tulumba'),
(910, 7, 'Villa Valeria'),
(911, 7, 'Villa Yacanto'),
(912, 7, 'Washington'),
(913, 7, 'Wenceslao Escalante'),
(914, 7, 'Ycho Cruz Sierras'),
(915, 8, 'Alvear'),
(916, 8, 'Bella Vista'),
(917, 8, 'Ber�n de Astrada'),
(918, 8, 'Bonpland'),
(919, 8, 'Ca� Cati'),
(920, 8, 'Capital'),
(921, 8, 'Chavarr�a'),
(922, 8, 'Col. C. Pellegrini'),
(923, 8, 'Col. Libertad'),
(924, 8, 'Col. Liebig'),
(925, 8, 'Col. Sta Rosa'),
(926, 8, 'Concepci�n'),
(927, 8, 'Cruz de Los Milagros'),
(928, 8, 'Curuz�-Cuati�'),
(929, 8, 'Empedrado'),
(930, 8, 'Esquina'),
(931, 8, 'Estaci�n Torrent'),
(932, 8, 'Felipe Yofr�'),
(933, 8, 'Garruchos'),
(934, 8, 'Gdor. Agr�nomo'),
(935, 8, 'Gdor. Mart�nez'),
(936, 8, 'Goya'),
(937, 8, 'Guaviravi'),
(938, 8, 'Herlitzka'),
(939, 8, 'Ita-Ibate'),
(940, 8, 'Itat�'),
(941, 8, 'Ituzaing�'),
(942, 8, 'Jos� Rafael G�mez'),
(943, 8, 'Juan Pujol'),
(944, 8, 'La Cruz'),
(945, 8, 'Lavalle'),
(946, 8, 'Lomas de Vallejos'),
(947, 8, 'Loreto'),
(948, 8, 'Mariano I. Loza'),
(949, 8, 'Mburucuy�'),
(950, 8, 'Mercedes'),
(951, 8, 'Mocoret�'),
(952, 8, 'Mte. Caseros'),
(953, 8, 'Nueve de Julio'),
(954, 8, 'Palmar Grande'),
(955, 8, 'Parada Pucheta'),
(956, 8, 'Paso de La Patria'),
(957, 8, 'Paso de Los Libres'),
(958, 8, 'Pedro R. Fernandez'),
(959, 8, 'Perugorr�a'),
(960, 8, 'Pueblo Libertador'),
(961, 8, 'Ramada Paso'),
(962, 8, 'Riachuelo'),
(963, 8, 'Saladas'),
(964, 8, 'San Antonio'),
(965, 8, 'San Carlos'),
(966, 8, 'San Cosme'),
(967, 8, 'San Lorenzo'),
(968, 8, '20 del Palmar'),
(969, 8, 'San Miguel'),
(970, 8, 'San Roque'),
(971, 8, 'Santa Ana'),
(972, 8, 'Santa Luc�a'),
(973, 8, 'Santo Tom�'),
(974, 8, 'Sauce'),
(975, 8, 'Tabay'),
(976, 8, 'Tapebicu�'),
(977, 8, 'Tatacua'),
(978, 8, 'Virasoro'),
(979, 8, 'Yapey�'),
(980, 8, 'Yatait� Calle'),
(981, 9, 'Alarc�n'),
(982, 9, 'Alcaraz'),
(983, 9, 'Alcaraz N.'),
(984, 9, 'Alcaraz S.'),
(985, 9, 'Aldea Asunci�n'),
(986, 9, 'Aldea Brasilera'),
(987, 9, 'Aldea Elgenfeld'),
(988, 9, 'Aldea Grapschental'),
(989, 9, 'Aldea Ma. Luisa'),
(990, 9, 'Aldea Protestante'),
(991, 9, 'Aldea Salto'),
(992, 9, 'Aldea San Antonio (G)'),
(993, 9, 'Aldea San Antonio (P)'),
(994, 9, 'Aldea 19'),
(995, 9, 'Aldea San Miguel'),
(996, 9, 'Aldea San Rafael'),
(997, 9, 'Aldea Spatzenkutter'),
(998, 9, 'Aldea Sta. Mar�a'),
(999, 9, 'Aldea Sta. Rosa'),
(1000, 9, 'Aldea Valle Mar�a');
INSERT INTO localidades ([Id_Localidad], [Id_Provincia_Localidad],[Nombre_Localidad]) VALUES
(1001, 9, 'Altamirano Sur'),
(1002, 9, 'Antelo'),
(1003, 9, 'Antonio Tom�s'),
(1004, 9, 'Aranguren'),
(1005, 9, 'Arroyo Bar�'),
(1006, 9, 'Arroyo Burgos'),
(1007, 9, 'Arroyo Cl�'),
(1008, 9, 'Arroyo Corralito'),
(1009, 9, 'Arroyo del Medio'),
(1010, 9, 'Arroyo Maturrango'),
(1011, 9, 'Arroyo Palo Seco'),
(1012, 9, 'Banderas'),
(1013, 9, 'Basavilbaso'),
(1014, 9, 'Betbeder'),
(1015, 9, 'Bovril'),
(1016, 9, 'Caseros'),
(1017, 9, 'Ceibas'),
(1018, 9, 'Cerrito'),
(1019, 9, 'Chajar�'),
(1020, 9, 'Chilcas'),
(1021, 9, 'Clodomiro Ledesma'),
(1022, 9, 'Col. Alemana'),
(1023, 9, 'Col. Avellaneda'),
(1024, 9, 'Col. Avigdor'),
(1025, 9, 'Col. Ayu�'),
(1026, 9, 'Col. Baylina'),
(1027, 9, 'Col. Carrasco'),
(1028, 9, 'Col. Celina'),
(1029, 9, 'Col. Cerrito'),
(1030, 9, 'Col. Crespo'),
(1031, 9, 'Col. Elia'),
(1032, 9, 'Col. Ensayo'),
(1033, 9, 'Col. Gral. Roca'),
(1034, 9, 'Col. La Argentina'),
(1035, 9, 'Col. Merou'),
(1036, 9, 'Col. Oficial N�3'),
(1037, 9, 'Col. Oficial N�13'),
(1038, 9, 'Col. Oficial N�14'),
(1039, 9, 'Col. Oficial N�5'),
(1040, 9, 'Col. Reffino'),
(1041, 9, 'Col. Tunas'),
(1042, 9, 'Col. Virar�'),
(1043, 9, 'Col�n'),
(1044, 9, 'Concepci�n del Uruguay'),
(1045, 9, 'Concordia'),
(1046, 9, 'Conscripto Bernardi'),
(1047, 9, 'Costa Grande'),
(1048, 9, 'Costa San Antonio'),
(1049, 9, 'Costa Uruguay N.'),
(1050, 9, 'Costa Uruguay S.'),
(1051, 9, 'Crespo'),
(1052, 9, 'Crucecitas 3�'),
(1053, 9, 'Crucecitas 7�'),
(1054, 9, 'Crucecitas 8�'),
(1055, 9, 'Cuchilla Redonda'),
(1056, 9, 'Curtiembre'),
(1057, 9, 'Diamante'),
(1058, 9, 'Distrito 6�'),
(1059, 9, 'Distrito Cha�ar'),
(1060, 9, 'Distrito Chiqueros'),
(1061, 9, 'Distrito Cuarto'),
(1062, 9, 'Distrito Diego L�pez'),
(1063, 9, 'Distrito Pajonal'),
(1064, 9, 'Distrito Sauce'),
(1065, 9, 'Distrito Tala'),
(1066, 9, 'Distrito Talitas'),
(1067, 9, 'Don Crist�bal 1� Secci�n'),
(1068, 9, 'Don Crist�bal 2� Secci�n'),
(1069, 9, 'Durazno'),
(1070, 9, 'El Cimarr�n'),
(1071, 9, 'El Gramillal'),
(1072, 9, 'El Palenque'),
(1073, 9, 'El Pingo'),
(1074, 9, 'El Quebracho'),
(1075, 9, 'El Redom�n'),
(1076, 9, 'El Solar'),
(1077, 9, 'Enrique Carbo'),
(1078, 9, '9'),
(1079, 9, 'Espinillo N.'),
(1080, 9, 'Estaci�n Campos'),
(1081, 9, 'Estaci�n Escri�a'),
(1082, 9, 'Estaci�n Lazo'),
(1083, 9, 'Estaci�n Ra�ces'),
(1084, 9, 'Estaci�n Yer�a'),
(1085, 9, 'Estancia Grande'),
(1086, 9, 'Estancia L�baros'),
(1087, 9, 'Estancia Racedo'),
(1088, 9, 'Estancia Sol�'),
(1089, 9, 'Estancia Yuquer�'),
(1090, 9, 'Estaquitas'),
(1091, 9, 'Faustino M. Parera'),
(1092, 9, 'Febre'),
(1093, 9, 'Federaci�n'),
(1094, 9, 'Federal'),
(1095, 9, 'Gdor. Echag�e'),
(1096, 9, 'Gdor. Mansilla'),
(1097, 9, 'Gilbert'),
(1098, 9, 'Gonz�lez Calder�n'),
(1099, 9, 'Gral. Almada'),
(1100, 9, 'Gral. Alvear'),
(1101, 9, 'Gral. Campos'),
(1102, 9, 'Gral. Galarza'),
(1103, 9, 'Gral. Ram�rez'),
(1104, 9, 'Gualeguay'),
(1105, 9, 'Gualeguaych�'),
(1106, 9, 'Gualeguaycito'),
(1107, 9, 'Guardamonte'),
(1108, 9, 'Hambis'),
(1109, 9, 'Hasenkamp'),
(1110, 9, 'Hernandarias'),
(1111, 9, 'Hern�ndez'),
(1112, 9, 'Herrera'),
(1113, 9, 'Hinojal'),
(1114, 9, 'Hocker'),
(1115, 9, 'Ing. Sajaroff'),
(1116, 9, 'Irazusta'),
(1117, 9, 'Isletas'),
(1118, 9, 'J.J De Urquiza'),
(1119, 9, 'Jubileo'),
(1120, 9, 'La Clarita'),
(1121, 9, 'La Criolla'),
(1122, 9, 'La Esmeralda'),
(1123, 9, 'La Florida'),
(1124, 9, 'La Fraternidad'),
(1125, 9, 'La Hierra'),
(1126, 9, 'La Ollita'),
(1127, 9, 'La Paz'),
(1128, 9, 'La Picada'),
(1129, 9, 'La Providencia'),
(1130, 9, 'La Verbena'),
(1131, 9, 'Laguna Ben�tez'),
(1132, 9, 'Larroque'),
(1133, 9, 'Las Cuevas'),
(1134, 9, 'Las Garzas'),
(1135, 9, 'Las Guachas'),
(1136, 9, 'Las Mercedes'),
(1137, 9, 'Las Moscas'),
(1138, 9, 'Las Mulitas'),
(1139, 9, 'Las Toscas'),
(1140, 9, 'Laurencena'),
(1141, 9, 'Libertador San Mart�n'),
(1142, 9, 'Loma Limpia'),
(1143, 9, 'Los Ceibos'),
(1144, 9, 'Los Charruas'),
(1145, 9, 'Los Conquistadores'),
(1146, 9, 'Lucas Gonz�lez'),
(1147, 9, 'Lucas N.'),
(1148, 9, 'Lucas S. 1�'),
(1149, 9, 'Lucas S. 2�'),
(1150, 9, 'Maci�'),
(1151, 9, 'Mar�a Grande'),
(1152, 9, 'Mar�a Grande 2�'),
(1153, 9, 'M�danos'),
(1154, 9, 'Mojones N.'),
(1155, 9, 'Mojones S.'),
(1156, 9, 'Molino Doll'),
(1157, 9, 'Monte Redondo'),
(1158, 9, 'Montoya'),
(1159, 9, 'Mulas Grandes'),
(1160, 9, '�ancay'),
(1161, 9, 'Nogoy�'),
(1162, 9, 'Nueva Escocia'),
(1163, 9, 'Nueva Vizcaya'),
(1164, 9, 'Omb�'),
(1165, 9, 'Oro Verde'),
(1166, 9, 'Paran�'),
(1167, 9, 'Pasaje Guayaquil'),
(1168, 9, 'Pasaje Las Tunas'),
(1169, 9, 'Paso de La Arena'),
(1170, 9, 'Paso de La Laguna'),
(1171, 9, 'Paso de Las Piedras'),
(1172, 9, 'Paso Duarte'),
(1173, 9, 'Pastor Britos'),
(1174, 9, 'Pedernal'),
(1175, 9, 'Perdices'),
(1176, 9, 'Picada Ber�n'),
(1177, 9, 'Piedras Blancas'),
(1178, 9, 'Primer Distrito Cuchilla'),
(1179, 9, 'Primero de Mayo'),
(1180, 9, 'Pronunciamiento'),
(1181, 9, 'Pto. Algarrobo'),
(1182, 9, 'Pto. Ibicuy'),
(1183, 9, 'Pueblo Brugo'),
(1184, 9, 'Pueblo Cazes'),
(1185, 9, 'Pueblo Gral. Belgrano'),
(1186, 9, 'Pueblo Liebig'),
(1187, 9, 'Puerto Yeru�'),
(1188, 9, 'Punta del Monte'),
(1189, 9, 'Quebracho'),
(1190, 9, 'Quinto Distrito'),
(1191, 9, 'Raices Oeste'),
(1192, 9, 'Rinc�n de Nogoy�'),
(1193, 9, 'Rinc�n del Cinto'),
(1194, 9, 'Rinc�n del Doll'),
(1195, 9, 'Rinc�n del Gato'),
(1196, 9, 'Rocamora'),
(1197, 9, 'Rosario del Tala'),
(1198, 9, 'San Benito'),
(1199, 9, 'San Cipriano'),
(1200, 9, 'San Ernesto'),
(1201, 9, 'San Gustavo'),
(1202, 9, 'San Jaime'),
(1203, 9, 'San Jos�'),
(1204, 9, 'San Jos� de Feliciano'),
(1205, 9, 'San Justo'),
(1206, 9, 'San Marcial'),
(1207, 9, 'San Pedro'),
(1208, 9, 'San Ram�rez'),
(1209, 9, 'San Ram�n'),
(1210, 9, 'San Roque'),
(1211, 9, 'San Salvador'),
(1212, 9, 'San V�ctor'),
(1213, 9, 'Santa Ana'),
(1214, 9, 'Santa Anita'),
(1215, 9, 'Santa Elena'),
(1216, 9, 'Santa Luc�a'),
(1217, 9, 'Santa Luisa'),
(1218, 9, 'Sauce de Luna'),
(1219, 9, 'Sauce Montrull'),
(1220, 9, 'Sauce Pinto'),
(1221, 9, 'Sauce Sur'),
(1222, 9, 'Segu�'),
(1223, 9, 'Sir Leonard'),
(1224, 9, 'Sosa'),
(1225, 9, 'Tabossi'),
(1226, 9, 'Tezanos Pinto'),
(1227, 9, 'Ubajay'),
(1228, 9, 'Urdinarrain'),
(1229, 9, 'Veinte de Septiembre'),
(1230, 9, 'Viale'),
(1231, 9, 'Victoria'),
(1232, 9, 'Villa Clara'),
(1233, 9, 'Villa del Rosario'),
(1234, 9, 'Villa Dom�nguez'),
(1235, 9, 'Villa Elisa'),
(1236, 9, 'Villa Fontana'),
(1237, 9, 'Villa Gdor. Etchevehere'),
(1238, 9, 'Villa Mantero'),
(1239, 9, 'Villa Paranacito'),
(1240, 9, 'Villa Urquiza'),
(1241, 9, 'Villaguay'),
(1242, 9, 'Walter Moss'),
(1243, 9, 'Yacar�'),
(1244, 9, 'Yeso Oeste'),
(1245, 10, 'Buena Vista'),
(1246, 10, 'Clorinda'),
(1247, 10, 'Col. Pastoril'),
(1248, 10, 'Cte. Fontana'),
(1249, 10, 'El Colorado'),
(1250, 10, 'El Espinillo'),
(1251, 10, 'Estanislao Del Campo'),
(1252, 10, '10'),
(1253, 10, 'Fort�n Lugones'),
(1254, 10, 'Gral. Lucio V. Mansilla'),
(1255, 10, 'Gral. Manuel Belgrano'),
(1256, 10, 'Gral. Mosconi'),
(1257, 10, 'Gran Guardia'),
(1258, 10, 'Herradura'),
(1259, 10, 'Ibarreta'),
(1260, 10, 'Ing. Ju�rez'),
(1261, 10, 'Laguna Blanca'),
(1262, 10, 'Laguna Naick Neck'),
(1263, 10, 'Laguna Yema'),
(1264, 10, 'Las Lomitas'),
(1265, 10, 'Los Chiriguanos'),
(1266, 10, 'Mayor V. Villafa�e'),
(1267, 10, 'Misi�n San Fco.'),
(1268, 10, 'Palo Santo'),
(1269, 10, 'Piran�'),
(1270, 10, 'Pozo del Maza'),
(1271, 10, 'Riacho He-He'),
(1272, 10, 'San Hilario'),
(1273, 10, 'San Mart�n II'),
(1274, 10, 'Siete Palmas'),
(1275, 10, 'Subteniente Per�n'),
(1276, 10, 'Tres Lagunas'),
(1277, 10, 'Villa Dos Trece'),
(1278, 10, 'Villa Escolar'),
(1279, 10, 'Villa Gral. G�emes'),
(1280, 11, 'Abdon Castro Tolay'),
(1281, 11, 'Abra Pampa'),
(1282, 11, 'Abralaite'),
(1283, 11, 'Aguas Calientes'),
(1284, 11, 'Arrayanal'),
(1285, 11, 'Barrios'),
(1286, 11, 'Caimancito'),
(1287, 11, 'Calilegua'),
(1288, 11, 'Cangrejillos'),
(1289, 11, 'Caspala'),
(1290, 11, 'Catu�'),
(1291, 11, 'Cieneguillas'),
(1292, 11, 'Coranzulli'),
(1293, 11, 'Cusi-Cusi'),
(1294, 11, 'El Aguilar'),
(1295, 11, 'El Carmen'),
(1296, 11, 'El C�ndor'),
(1297, 11, 'El Fuerte'),
(1298, 11, 'El Piquete'),
(1299, 11, 'El Talar'),
(1300, 11, 'Fraile Pintado'),
(1301, 11, 'Hip�lito Yrigoyen'),
(1302, 11, 'Huacalera'),
(1303, 11, 'Humahuaca'),
(1304, 11, 'La Esperanza'),
(1305, 11, 'La Mendieta'),
(1306, 11, 'La Quiaca'),
(1307, 11, 'Ledesma'),
(1308, 11, 'Libertador Gral. San Martin'),
(1309, 11, 'Maimara'),
(1310, 11, 'Mina Pirquitas'),
(1311, 11, 'Monterrico'),
(1312, 11, 'Palma Sola'),
(1313, 11, 'Palpal�'),
(1314, 11, 'Pampa Blanca'),
(1315, 11, 'Pampichuela'),
(1316, 11, 'Perico'),
(1317, 11, 'Puesto del Marqu�s'),
(1318, 11, 'Puesto Viejo'),
(1319, 11, 'Pumahuasi'),
(1320, 11, 'Purmamarca'),
(1321, 11, 'Rinconada'),
(1322, 11, 'Rodeitos'),
(1323, 11, 'Rosario de R�o Grande'),
(1324, 11, 'San Antonio'),
(1325, 11, 'San Francisco'),
(1326, 11, 'San Pedro'),
(1327, 11, 'San Rafael'),
(1328, 11, 'San Salvador'),
(1329, 11, 'Santa Ana'),
(1330, 11, 'Santa Catalina'),
(1331, 11, 'Santa Clara'),
(1332, 11, 'Susques'),
(1333, 11, 'Tilcara'),
(1334, 11, 'Tres Cruces'),
(1335, 11, 'Tumbaya'),
(1336, 11, 'Valle Grande'),
(1337, 11, 'Vinalito'),
(1338, 11, 'Volc�n'),
(1339, 11, 'Yala'),
(1340, 11, 'Yav�'),
(1341, 11, 'Yuto'),
(1342, 12, 'Abramo'),
(1343, 12, 'Adolfo Van Praet'),
(1344, 12, 'Agustoni'),
(1345, 12, 'Algarrobo del Aguila'),
(1346, 12, 'Alpachiri'),
(1347, 12, 'Alta Italia'),
(1348, 12, 'Anguil'),
(1349, 12, 'Arata'),
(1350, 12, 'Ataliva Roca'),
(1351, 12, 'Bernardo Larroude'),
(1352, 12, 'Bernasconi'),
(1353, 12, 'Caleuf�'),
(1354, 12, 'Carro Quemado'),
(1355, 12, 'Catril�'),
(1356, 12, 'Ceballos'),
(1357, 12, 'Chacharramendi'),
(1358, 12, 'Col. Bar�n'),
(1359, 12, 'Col. Santa Mar�a'),
(1360, 12, 'Conhelo'),
(1361, 12, 'Coronel Hilario Lagos'),
(1362, 12, 'Cuchillo-C�'),
(1363, 12, 'Doblas'),
(1364, 12, 'Dorila'),
(1365, 12, 'Eduardo Castex'),
(1366, 12, 'Embajador Martini'),
(1367, 12, 'Falucho'),
(1368, 12, 'Gral. Acha'),
(1369, 12, 'Gral. Manuel Campos'),
(1370, 12, 'Gral. Pico'),
(1371, 12, 'Guatrach�'),
(1372, 12, 'Ing. Luiggi'),
(1373, 12, 'Intendente Alvear'),
(1374, 12, 'Jacinto Arauz'),
(1375, 12, 'La Adela'),
(1376, 12, 'La Humada'),
(1377, 12, 'La Maruja'),
(1378, 12, '12'),
(1379, 12, 'La Reforma'),
(1380, 12, 'Limay Mahuida'),
(1381, 12, 'Lonquimay'),
(1382, 12, 'Loventuel'),
(1383, 12, 'Luan Toro'),
(1384, 12, 'Macach�n'),
(1385, 12, 'Maisonnave'),
(1386, 12, 'Mauricio Mayer'),
(1387, 12, 'Metileo'),
(1388, 12, 'Miguel Can�'),
(1389, 12, 'Miguel Riglos'),
(1390, 12, 'Monte Nievas'),
(1391, 12, 'Parera'),
(1392, 12, 'Per�'),
(1393, 12, 'Pichi-Huinca'),
(1394, 12, 'Puelches'),
(1395, 12, 'Puel�n'),
(1396, 12, 'Quehue'),
(1397, 12, 'Quem� Quem�'),
(1398, 12, 'Quetrequ�n'),
(1399, 12, 'Rancul'),
(1400, 12, 'Realic�'),
(1401, 12, 'Relmo'),
(1402, 12, 'Rol�n'),
(1403, 12, 'Rucanelo'),
(1404, 12, 'Sarah'),
(1405, 12, 'Speluzzi'),
(1406, 12, 'Sta. Isabel'),
(1407, 12, 'Sta. Rosa'),
(1408, 12, 'Sta. Teresa'),
(1409, 12, 'Tel�n'),
(1410, 12, 'Toay'),
(1411, 12, 'Tomas M. de Anchorena'),
(1412, 12, 'Trenel'),
(1413, 12, 'Unanue'),
(1414, 12, 'Uriburu'),
(1415, 12, 'Veinticinco de Mayo'),
(1416, 12, 'Vertiz'),
(1417, 12, 'Victorica'),
(1418, 12, 'Villa Mirasol'),
(1419, 12, 'Winifreda'),
(1420, 13, 'Arauco'),
(1421, 13, 'Capital'),
(1422, 13, 'Castro Barros'),
(1423, 13, 'Chamical'),
(1424, 13, 'Chilecito'),
(1425, 13, 'Coronel F. Varela'),
(1426, 13, 'Famatina'),
(1427, 13, 'Gral. A.V.Pe�aloza'),
(1428, 13, 'Gral. Belgrano'),
(1429, 13, 'Gral. J.F. Quiroga'),
(1430, 13, 'Gral. Lamadrid'),
(1431, 13, 'Gral. Ocampo'),
(1432, 13, 'Gral. San Mart�n'),
(1433, 13, 'Independencia'),
(1434, 13, 'Rosario Penaloza'),
(1435, 13, 'San Blas de Los Sauces'),
(1436, 13, 'Sanagasta'),
(1437, 13, 'Vinchina'),
(1438, 14, 'Capital'),
(1439, 14, 'Chacras de Coria'),
(1440, 14, 'Dorrego'),
(1441, 14, 'Gllen'),
(1442, 14, 'Godoy Cruz'),
(1443, 14, 'Gral. Alvear'),
(1444, 14, 'Guaymall�n'),
(1445, 14, 'Jun�n'),
(1446, 14, 'La Paz'),
(1447, 14, 'Las Heras'),
(1448, 14, 'Lavalle'),
(1449, 14, 'Luj�n'),
(1450, 14, 'Luj�n De Cuyo'),
(1451, 14, 'Maip�'),
(1452, 14, 'Malarg�e'),
(1453, 14, 'Rivadavia'),
(1454, 14, 'San Carlos'),
(1455, 14, 'San Mart�n'),
(1456, 14, 'San Rafael'),
(1457, 14, 'Sta. Rosa'),
(1458, 14, 'Tunuy�n'),
(1459, 14, 'Tupungato'),
(1460, 14, 'Villa Nueva'),
(1461, 15, 'Alba Posse'),
(1462, 15, 'Almafuerte'),
(1463, 15, 'Ap�stoles'),
(1464, 15, 'Arist�bulo Del Valle'),
(1465, 15, 'Arroyo Del Medio'),
(1466, 15, 'Azara'),
(1467, 15, 'Bdo. De Irigoyen'),
(1468, 15, 'Bonpland'),
(1469, 15, 'Ca� Yari'),
(1470, 15, 'Campo Grande'),
(1471, 15, 'Campo Ram�n'),
(1472, 15, 'Campo Viera'),
(1473, 15, 'Candelaria'),
(1474, 15, 'Capiov�'),
(1475, 15, 'Caraguatay'),
(1476, 15, 'Cdte. Guacurar�'),
(1477, 15, 'Cerro Azul'),
(1478, 15, 'Cerro Cor�'),
(1479, 15, 'Col. Alberdi'),
(1480, 15, 'Col. Aurora'),
(1481, 15, 'Col. Delicia'),
(1482, 15, 'Col. Polana'),
(1483, 15, 'Col. Victoria'),
(1484, 15, 'Col. Wanda'),
(1485, 15, 'Concepci�n De La Sierra'),
(1486, 15, 'Corpus'),
(1487, 15, 'Dos Arroyos'),
(1488, 15, 'Dos de Mayo'),
(1489, 15, 'El Alc�zar'),
(1490, 15, 'El Dorado'),
(1491, 15, 'El Soberbio'),
(1492, 15, 'Esperanza'),
(1493, 15, 'F. Ameghino'),
(1494, 15, 'Fachinal'),
(1495, 15, 'Garuhap�'),
(1496, 15, 'Garup�'),
(1497, 15, 'Gdor. L�pez'),
(1498, 15, 'Gdor. Roca'),
(1499, 15, 'Gral. Alvear'),
(1500, 15, 'Gral. Urquiza'),
(1501, 15, 'Guaran�'),
(1502, 15, 'H. Yrigoyen'),
(1503, 15, 'Iguaz�'),
(1504, 15, 'Itacaruar�'),
(1505, 15, 'Jard�n Am�rica'),
(1506, 15, 'Leandro N. Alem'),
(1507, 15, 'Libertad'),
(1508, 15, 'Loreto'),
(1509, 15, 'Los Helechos'),
(1510, 15, 'M�rtires'),
(1511, 15, '15'),
(1512, 15, 'Moj�n Grande'),
(1513, 15, 'Montecarlo'),
(1514, 15, 'Nueve de Julio'),
(1515, 15, 'Ober�'),
(1516, 15, 'Olegario V. Andrade'),
(1517, 15, 'Panamb�'),
(1518, 15, 'Posadas'),
(1519, 15, 'Profundidad'),
(1520, 15, 'Pto. Iguaz�'),
(1521, 15, 'Pto. Leoni'),
(1522, 15, 'Pto. Piray'),
(1523, 15, 'Pto. Rico'),
(1524, 15, 'Ruiz de Montoya'),
(1525, 15, 'San Antonio'),
(1526, 15, 'San Ignacio'),
(1527, 15, 'San Javier'),
(1528, 15, 'San Jos�'),
(1529, 15, 'San Mart�n'),
(1530, 15, 'San Pedro'),
(1531, 15, 'San Vicente'),
(1532, 15, 'Santiago De Liniers'),
(1533, 15, 'Santo Pipo'),
(1534, 15, 'Sta. Ana'),
(1535, 15, 'Sta. Mar�a'),
(1536, 15, 'Tres Capones'),
(1537, 15, 'Veinticinco de Mayo'),
(1538, 15, 'Wanda'),
(1539, 16, 'Aguada San Roque'),
(1540, 16, 'Alumin�'),
(1541, 16, 'Andacollo'),
(1542, 16, 'A�elo'),
(1543, 16, 'Bajada del Agrio'),
(1544, 16, 'Barrancas'),
(1545, 16, 'Buta Ranquil'),
(1546, 16, 'Capital'),
(1547, 16, 'Caviahu�'),
(1548, 16, 'Centenario'),
(1549, 16, 'Chorriaca'),
(1550, 16, 'Chos Malal'),
(1551, 16, 'Cipolletti'),
(1552, 16, 'Covunco Abajo'),
(1553, 16, 'Coyuco Cochico'),
(1554, 16, 'Cutral C�'),
(1555, 16, 'El Cholar'),
(1556, 16, 'El Huec�'),
(1557, 16, 'El Sauce'),
(1558, 16, 'Gua�acos'),
(1559, 16, 'Huinganco'),
(1560, 16, 'Las Coloradas'),
(1561, 16, 'Las Lajas'),
(1562, 16, 'Las Ovejas'),
(1563, 16, 'Loncopu�'),
(1564, 16, 'Los Catutos'),
(1565, 16, 'Los Chihuidos'),
(1566, 16, 'Los Miches'),
(1567, 16, 'Manzano Amargo'),
(1568, 16, '16'),
(1569, 16, 'Octavio Pico'),
(1570, 16, 'Paso Aguerre'),
(1571, 16, 'Pic�n Leuf�'),
(1572, 16, 'Piedra del Aguila'),
(1573, 16, 'Pilo Lil'),
(1574, 16, 'Plaza Huincul'),
(1575, 16, 'Plottier'),
(1576, 16, 'Quili Malal'),
(1577, 16, 'Ram�n Castro'),
(1578, 16, 'Rinc�n de Los Sauces'),
(1579, 16, 'San Mart�n de Los Andes'),
(1580, 16, 'San Patricio del Cha�ar'),
(1581, 16, 'Santo Tom�s'),
(1582, 16, 'Sauzal Bonito'),
(1583, 16, 'Senillosa'),
(1584, 16, 'Taquimil�n'),
(1585, 16, 'Tricao Malal'),
(1586, 16, 'Varvarco'),
(1587, 16, 'Villa Cur� Leuvu'),
(1588, 16, 'Villa del Nahueve'),
(1589, 16, 'Villa del Puente Pic�n Leuv�'),
(1590, 16, 'Villa El Choc�n'),
(1591, 16, 'Villa La Angostura'),
(1592, 16, 'Villa Pehuenia'),
(1593, 16, 'Villa Traful'),
(1594, 16, 'Vista Alegre'),
(1595, 16, 'Zapala'),
(1596, 17, 'Aguada Cecilio'),
(1597, 17, 'Aguada de Guerra'),
(1598, 17, 'All�n'),
(1599, 17, 'Arroyo de La Ventana'),
(1600, 17, 'Arroyo Los Berros'),
(1601, 17, 'Bariloche'),
(1602, 17, 'Calte. Cordero'),
(1603, 17, 'Campo Grande'),
(1604, 17, 'Catriel'),
(1605, 17, 'Cerro Polic�a'),
(1606, 17, 'Cervantes'),
(1607, 17, 'Chelforo'),
(1608, 17, 'Chimpay'),
(1609, 17, 'Chinchinales'),
(1610, 17, 'Chipauquil'),
(1611, 17, 'Choele Choel'),
(1612, 17, 'Cinco Saltos'),
(1613, 17, 'Cipolletti'),
(1614, 17, 'Clemente Onelli'),
(1615, 17, 'Col�n Conhue'),
(1616, 17, 'Comallo'),
(1617, 17, 'Comic�'),
(1618, 17, 'Cona Niyeu'),
(1619, 17, 'Coronel Belisle'),
(1620, 17, 'Cubanea'),
(1621, 17, 'Darwin'),
(1622, 17, 'Dina Huapi'),
(1623, 17, 'El Bols�n'),
(1624, 17, 'El Ca�n'),
(1625, 17, 'El Manso'),
(1626, 17, 'Gral. Conesa'),
(1627, 17, 'Gral. Enrique Godoy'),
(1628, 17, 'Gral. Fernandez Oro'),
(1629, 17, 'Gral. Roca'),
(1630, 17, 'Guardia Mitre'),
(1631, 17, 'Ing. Huergo'),
(1632, 17, 'Ing. Jacobacci'),
(1633, 17, 'Laguna Blanca'),
(1634, 17, 'Lamarque'),
(1635, 17, 'Las Grutas'),
(1636, 17, 'Los Menucos'),
(1637, 17, 'Luis Beltr�n'),
(1638, 17, 'Mainqu�'),
(1639, 17, 'Mamuel Choique'),
(1640, 17, 'Maquinchao'),
(1641, 17, 'Mencu�'),
(1642, 17, 'Mtro. Ramos Mexia'),
(1643, 17, 'Nahuel Niyeu'),
(1644, 17, 'Naupa Huen'),
(1645, 17, '�orquinco'),
(1646, 17, 'Ojos de Agua'),
(1647, 17, 'Paso de Agua'),
(1648, 17, 'Paso Flores'),
(1649, 17, 'Pe�as Blancas'),
(1650, 17, 'Pichi Mahuida'),
(1651, 17, 'Pilcaniyeu'),
(1652, 17, 'Pomona'),
(1653, 17, 'Prahuaniyeu'),
(1654, 17, 'Rinc�n Treneta'),
(1655, 17, 'R�o Chico'),
(1656, 17, 'R�o Colorado'),
(1657, 17, 'Roca'),
(1658, 17, 'San Antonio Oeste'),
(1659, 17, 'San Javier'),
(1660, 17, 'Sierra Colorada'),
(1661, 17, 'Sierra Grande'),
(1662, 17, 'Sierra Pailem�n'),
(1663, 17, 'Valcheta'),
(1664, 17, 'Valle Azul'),
(1665, 17, 'Viedma'),
(1666, 17, 'Villa Llanqu�n'),
(1667, 17, 'Villa Mascardi'),
(1668, 17, 'Villa Regina'),
(1669, 17, 'Yaminu�'),
(1670, 18, 'A. Saravia'),
(1671, 18, 'Aguaray'),
(1672, 18, 'Angastaco'),
(1673, 18, 'Animan�'),
(1674, 18, 'Cachi'),
(1675, 18, 'Cafayate'),
(1676, 18, 'Campo Quijano'),
(1677, 18, 'Campo Santo'),
(1678, 18, 'Capital'),
(1679, 18, 'Cerrillos'),
(1680, 18, 'Chicoana'),
(1681, 18, 'Col. Sta. Rosa'),
(1682, 18, 'Coronel Moldes'),
(1683, 18, 'El Bordo'),
(1684, 18, 'El Carril'),
(1685, 18, 'El Galp�n'),
(1686, 18, 'El Jard�n'),
(1687, 18, 'El Potrero'),
(1688, 18, 'El Quebrachal'),
(1689, 18, 'El Tala'),
(1690, 18, 'Embarcaci�n'),
(1691, 18, 'Gral. Ballivian'),
(1692, 18, 'Gral. G�emes'),
(1693, 18, 'Gral. Mosconi'),
(1694, 18, 'Gral. Pizarro'),
(1695, 18, 'Guachipas'),
(1696, 18, 'Hip�lito Yrigoyen'),
(1697, 18, 'Iruy�'),
(1698, 18, 'Isla De Ca�as'),
(1699, 18, 'J. V. Gonzalez'),
(1700, 18, 'La Caldera'),
(1701, 18, 'La Candelaria'),
(1702, 18, 'La Merced'),
(1703, 18, 'La Poma'),
(1704, 18, 'La Vi�a'),
(1705, 18, 'Las Lajitas'),
(1706, 18, 'Los Toldos'),
(1707, 18, 'Met�n'),
(1708, 18, 'Molinos'),
(1709, 18, 'Nazareno'),
(1710, 18, 'Or�n'),
(1711, 18, 'Payogasta'),
(1712, 18, 'Pichanal'),
(1713, 18, 'Prof. S. Mazza'),
(1714, 18, 'R�o Piedras'),
(1715, 18, 'Rivadavia Banda Norte'),
(1716, 18, 'Rivadavia Banda Sur'),
(1717, 18, 'Rosario de La Frontera'),
(1718, 18, 'Rosario de Lerma'),
(1719, 18, 'Saclant�s'),
(1720, 18, '18'),
(1721, 18, 'San Antonio'),
(1722, 18, 'San Carlos'),
(1723, 18, 'San Jos� De Met�n'),
(1724, 18, 'San Ram�n'),
(1725, 18, 'Santa Victoria E.'),
(1726, 18, 'Santa Victoria O.'),
(1727, 18, 'Tartagal'),
(1728, 18, 'Tolar Grande'),
(1729, 18, 'Urundel'),
(1730, 18, 'Vaqueros'),
(1731, 18, 'Villa San Lorenzo'),
(1732, 19, 'Albard�n'),
(1733, 19, 'Angaco'),
(1734, 19, 'Calingasta'),
(1735, 19, 'Capital'),
(1736, 19, 'Caucete'),
(1737, 19, 'Chimbas'),
(1738, 19, 'Iglesia'),
(1739, 19, 'Jachal'),
(1740, 19, 'Nueve de Julio'),
(1741, 19, 'Pocito'),
(1742, 19, 'Rawson'),
(1743, 19, 'Rivadavia'),
(1744, 19, '19'),
(1745, 19, 'San Mart�n'),
(1746, 19, 'Santa Luc�a'),
(1747, 19, 'Sarmiento'),
(1748, 19, 'Ullum'),
(1749, 19, 'Valle F�rtil'),
(1750, 19, 'Veinticinco de Mayo'),
(1751, 19, 'Zonda'),
(1752, 20, 'Alto Pelado'),
(1753, 20, 'Alto Pencoso'),
(1754, 20, 'Anchorena'),
(1755, 20, 'Arizona'),
(1756, 20, 'Bagual'),
(1757, 20, 'Balde'),
(1758, 20, 'Batavia'),
(1759, 20, 'Beazley'),
(1760, 20, 'Buena Esperanza'),
(1761, 20, 'Candelaria'),
(1762, 20, 'Capital'),
(1763, 20, 'Carolina'),
(1764, 20, 'Carpinter�a'),
(1765, 20, 'Concar�n'),
(1766, 20, 'Cortaderas'),
(1767, 20, 'El Morro'),
(1768, 20, 'El Trapiche'),
(1769, 20, 'El Volc�n'),
(1770, 20, 'Fort�n El Patria'),
(1771, 20, 'Fortuna'),
(1772, 20, 'Fraga'),
(1773, 20, 'Juan Jorba'),
(1774, 20, 'Juan Llerena'),
(1775, 20, 'Juana Koslay'),
(1776, 20, 'Justo Daract'),
(1777, 20, 'La Calera'),
(1778, 20, 'La Florida'),
(1779, 20, 'La Punilla'),
(1780, 20, 'La Toma'),
(1781, 20, 'Lafinur'),
(1782, 20, 'Las Aguadas'),
(1783, 20, 'Las Chacras'),
(1784, 20, 'Las Lagunas'),
(1785, 20, 'Las Vertientes'),
(1786, 20, 'Lavaisse'),
(1787, 20, 'Leandro N. Alem'),
(1788, 20, 'Los Molles'),
(1789, 20, 'Luj�n'),
(1790, 20, 'Mercedes'),
(1791, 20, 'Merlo'),
(1792, 20, 'Naschel'),
(1793, 20, 'Navia'),
(1794, 20, 'Nogol�'),
(1795, 20, 'Nueva Galia'),
(1796, 20, 'Papagayos'),
(1797, 20, 'Paso Grande'),
(1798, 20, 'Potrero de Los Funes'),
(1799, 20, 'Quines'),
(1800, 20, 'Renca'),
(1801, 20, 'Saladillo'),
(1802, 20, 'San Francisco'),
(1803, 20, 'San Ger�nimo'),
(1804, 20, 'San Mart�n'),
(1805, 20, 'San Pablo'),
(1806, 20, 'Santa Rosa de Conlara'),
(1807, 20, 'Talita'),
(1808, 20, 'Tilisarao'),
(1809, 20, 'Uni�n'),
(1810, 20, 'Villa de La Quebrada'),
(1811, 20, 'Villa de Praga'),
(1812, 20, 'Villa del Carmen'),
(1813, 20, 'Villa Gral. Roca'),
(1814, 20, 'Villa Larca'),
(1815, 20, 'Villa Mercedes'),
(1816, 20, 'Zanjitas'),
(1817, 21, 'Calafate'),
(1818, 21, 'Caleta Olivia'),
(1819, 21, 'Ca�ad�n Seco'),
(1820, 21, 'Comandante Piedrabuena'),
(1821, 21, 'El Calafate'),
(1822, 21, 'El Chalt�n'),
(1823, 21, 'Gdor. Gregores'),
(1824, 21, 'Hip�lito Yrigoyen'),
(1825, 21, 'Jaramillo'),
(1826, 21, 'Koluel Kaike'),
(1827, 21, 'Las Heras'),
(1828, 21, 'Los Antiguos'),
(1829, 21, 'Perito Moreno'),
(1830, 21, 'Pico Truncado'),
(1831, 21, 'Pto. Deseado'),
(1832, 21, 'Pto. San Juli�n'),
(1833, 21, 'Pto. 21'),
(1834, 21, 'R�o Cuarto'),
(1835, 21, 'R�o Gallegos'),
(1836, 21, 'R�o Turbio'),
(1837, 21, 'Tres Lagos'),
(1838, 21, 'Veintiocho De Noviembre'),
(1839, 22, 'Aar�n Castellanos'),
(1840, 22, 'Acebal'),
(1841, 22, 'Aguar� Grande'),
(1842, 22, 'Albarellos'),
(1843, 22, 'Alcorta'),
(1844, 22, 'Aldao'),
(1845, 22, 'Alejandra'),
(1846, 22, '�lvarez'),
(1847, 22, 'Ambrosetti'),
(1848, 22, 'Amen�bar'),
(1849, 22, 'Ang�lica'),
(1850, 22, 'Angeloni'),
(1851, 22, 'Arequito'),
(1852, 22, 'Arminda'),
(1853, 22, 'Armstrong'),
(1854, 22, 'Arocena'),
(1855, 22, 'Arroyo Aguiar'),
(1856, 22, 'Arroyo Ceibal'),
(1857, 22, 'Arroyo Leyes'),
(1858, 22, 'Arroyo Seco'),
(1859, 22, 'Arruf�'),
(1860, 22, 'Arteaga'),
(1861, 22, 'Ataliva'),
(1862, 22, 'Aurelia'),
(1863, 22, 'Avellaneda'),
(1864, 22, 'Barrancas'),
(1865, 22, 'Bauer Y Sigel'),
(1866, 22, 'Bella Italia'),
(1867, 22, 'Berabev�'),
(1868, 22, 'Berna'),
(1869, 22, 'Bernardo de Irigoyen'),
(1870, 22, 'Bigand'),
(1871, 22, 'Bombal'),
(1872, 22, 'Bouquet'),
(1873, 22, 'Bustinza'),
(1874, 22, 'Cabal'),
(1875, 22, 'Cacique Ariacaiquin'),
(1876, 22, 'Cafferata'),
(1877, 22, 'Calchaqu�'),
(1878, 22, 'Campo Andino'),
(1879, 22, 'Campo Piaggio'),
(1880, 22, 'Ca�ada de G�mez'),
(1881, 22, 'Ca�ada del Ucle'),
(1882, 22, 'Ca�ada Rica'),
(1883, 22, 'Ca�ada Rosqu�n'),
(1884, 22, 'Candioti'),
(1885, 22, 'Capital'),
(1886, 22, 'Capit�n Berm�dez'),
(1887, 22, 'Capivara'),
(1888, 22, 'Carcara��'),
(1889, 22, 'Carlos Pellegrini'),
(1890, 22, 'Carmen'),
(1891, 22, 'Carmen Del Sauce'),
(1892, 22, 'Carreras'),
(1893, 22, 'Carrizales'),
(1894, 22, 'Casalegno'),
(1895, 22, 'Casas'),
(1896, 22, 'Casilda'),
(1897, 22, 'Castelar'),
(1898, 22, 'Castellanos'),
(1899, 22, 'Cayast�'),
(1900, 22, 'Cayastacito'),
(1901, 22, 'Centeno'),
(1902, 22, 'Cepeda'),
(1903, 22, 'Ceres'),
(1904, 22, 'Chab�s'),
(1905, 22, 'Cha�ar Ladeado'),
(1906, 22, 'Chapuy'),
(1907, 22, 'Chovet'),
(1908, 22, 'Christophersen'),
(1909, 22, 'Classon'),
(1910, 22, 'Cnel. Arnold'),
(1911, 22, 'Cnel. Bogado'),
(1912, 22, 'Cnel. Dominguez'),
(1913, 22, 'Cnel. Fraga'),
(1914, 22, 'Col. Aldao'),
(1915, 22, 'Col. Ana'),
(1916, 22, 'Col. Belgrano'),
(1917, 22, 'Col. Bicha'),
(1918, 22, 'Col. Bigand'),
(1919, 22, 'Col. Bossi'),
(1920, 22, 'Col. Cavour'),
(1921, 22, 'Col. Cello'),
(1922, 22, 'Col. Dolores'),
(1923, 22, 'Col. Dos Rosas'),
(1924, 22, 'Col. Dur�n'),
(1925, 22, 'Col. Iturraspe'),
(1926, 22, 'Col. Margarita'),
(1927, 22, 'Col. Mascias'),
(1928, 22, 'Col. Raquel'),
(1929, 22, 'Col. Rosa'),
(1930, 22, 'Col. San Jos�'),
(1931, 22, 'Constanza'),
(1932, 22, 'Coronda'),
(1933, 22, 'Correa'),
(1934, 22, 'Crispi'),
(1935, 22, 'Culul�'),
(1936, 22, 'Curupayti'),
(1937, 22, 'Desvio Arij�n'),
(1938, 22, 'Diaz'),
(1939, 22, 'Diego de Alvear'),
(1940, 22, 'Egusquiza'),
(1941, 22, 'El Araz�'),
(1942, 22, 'El Rab�n'),
(1943, 22, 'El Sombrerito'),
(1944, 22, 'El Tr�bol'),
(1945, 22, 'Elisa'),
(1946, 22, 'Elortondo'),
(1947, 22, 'Emilia'),
(1948, 22, 'Empalme San Carlos'),
(1949, 22, 'Empalme Villa Constitucion'),
(1950, 22, 'Esmeralda'),
(1951, 22, 'Esperanza'),
(1952, 22, 'Estaci�n Alvear'),
(1953, 22, 'Estacion Clucellas'),
(1954, 22, 'Esteban Rams'),
(1955, 22, 'Esther'),
(1956, 22, 'Esustolia'),
(1957, 22, 'Eusebia'),
(1958, 22, 'Felicia'),
(1959, 22, 'Fidela'),
(1960, 22, 'Fighiera'),
(1961, 22, 'Firmat'),
(1962, 22, 'Florencia'),
(1963, 22, 'Fort�n Olmos'),
(1964, 22, 'Franck'),
(1965, 22, 'Fray Luis Beltr�n'),
(1966, 22, 'Frontera'),
(1967, 22, 'Fuentes'),
(1968, 22, 'Funes'),
(1969, 22, 'Gaboto'),
(1970, 22, 'Galisteo'),
(1971, 22, 'G�lvez'),
(1972, 22, 'Garabalto'),
(1973, 22, 'Garibaldi'),
(1974, 22, 'Gato Colorado'),
(1975, 22, 'Gdor. Crespo'),
(1976, 22, 'Gessler'),
(1977, 22, 'Godoy'),
(1978, 22, 'Golondrina'),
(1979, 22, 'Gral. Gelly'),
(1980, 22, 'Gral. Lagos'),
(1981, 22, 'Granadero Baigorria'),
(1982, 22, 'Gregoria Perez De Denis'),
(1983, 22, 'Grutly'),
(1984, 22, 'Guadalupe N.'),
(1985, 22, 'G�deken'),
(1986, 22, 'Helvecia'),
(1987, 22, 'Hersilia'),
(1988, 22, 'Hipat�a'),
(1989, 22, 'Huanqueros'),
(1990, 22, 'Hugentobler'),
(1991, 22, 'Hughes'),
(1992, 22, 'Humberto 1�'),
(1993, 22, 'Humboldt'),
(1994, 22, 'Ibarlucea'),
(1995, 22, 'Ing. Chanourdie'),
(1996, 22, 'Intiyaco'),
(1997, 22, 'Ituzaing�'),
(1998, 22, 'Jacinto L. Ar�uz'),
(1999, 22, 'Josefina'),
(2000, 22, 'Juan B. Molina');
INSERT INTO localidades ([Id_Localidad], [Id_Provincia_Localidad],[Nombre_Localidad]) VALUES
(2001, 22, 'Juan de Garay'),
(2002, 22, 'Juncal'),
(2003, 22, 'La Brava'),
(2004, 22, 'La Cabral'),
(2005, 22, 'La Camila'),
(2006, 22, 'La Chispa'),
(2007, 22, 'La Clara'),
(2008, 22, 'La Criolla'),
(2009, 22, 'La Gallareta'),
(2010, 22, 'La Lucila'),
(2011, 22, 'La Pelada'),
(2012, 22, 'La Penca'),
(2013, 22, 'La Rubia'),
(2014, 22, 'La Sarita'),
(2015, 22, 'La Vanguardia'),
(2016, 22, 'Labordeboy'),
(2017, 22, 'Laguna Paiva'),
(2018, 22, 'Landeta'),
(2019, 22, 'Lanteri'),
(2020, 22, 'Larrechea'),
(2021, 22, 'Las Avispas'),
(2022, 22, 'Las Bandurrias'),
(2023, 22, 'Las Garzas'),
(2024, 22, 'Las Palmeras'),
(2025, 22, 'Las Parejas'),
(2026, 22, 'Las Petacas'),
(2027, 22, 'Las Rosas'),
(2028, 22, 'Las Toscas'),
(2029, 22, 'Las Tunas'),
(2030, 22, 'Lazzarino'),
(2031, 22, 'Lehmann'),
(2032, 22, 'Llambi Campbell'),
(2033, 22, 'Logro�o'),
(2034, 22, 'Loma Alta'),
(2035, 22, 'L�pez'),
(2036, 22, 'Los Amores'),
(2037, 22, 'Los Cardos'),
(2038, 22, 'Los Laureles'),
(2039, 22, 'Los Molinos'),
(2040, 22, 'Los Quirquinchos'),
(2041, 22, 'Lucio V. Lopez'),
(2042, 22, 'Luis Palacios'),
(2043, 22, 'Ma. Juana'),
(2044, 22, 'Ma. Luisa'),
(2045, 22, 'Ma. Susana'),
(2046, 22, 'Ma. Teresa'),
(2047, 22, 'Maciel'),
(2048, 22, 'Maggiolo'),
(2049, 22, 'Malabrigo'),
(2050, 22, 'Marcelino Escalada'),
(2051, 22, 'Margarita'),
(2052, 22, 'Matilde'),
(2053, 22, 'Mau�'),
(2054, 22, 'M�ximo Paz'),
(2055, 22, 'Melincu�'),
(2056, 22, 'Miguel Torres'),
(2057, 22, 'Mois�s Ville'),
(2058, 22, 'Monigotes'),
(2059, 22, 'Monje'),
(2060, 22, 'Monte Obscuridad'),
(2061, 22, 'Monte Vera'),
(2062, 22, 'Montefiore'),
(2063, 22, 'Montes de Oca'),
(2064, 22, 'Murphy'),
(2065, 22, '�anducita'),
(2066, 22, 'Nar�'),
(2067, 22, 'Nelson'),
(2068, 22, 'Nicanor E. Molinas'),
(2069, 22, 'Nuevo Torino'),
(2070, 22, 'Oliveros'),
(2071, 22, 'Palacios'),
(2072, 22, 'Pav�n'),
(2073, 22, 'Pav�n Arriba'),
(2074, 22, 'Pedro G�mez Cello');
INSERT INTO localidades ([Id_Localidad], [Id_Provincia_Localidad],[Nombre_Localidad]) VALUES
(2075, 22, 'P�rez'),
(2076, 22, 'Peyrano'),
(2077, 22, 'Piamonte'),
(2078, 22, 'Pilar'),
(2079, 22, 'Pi�ero'),
(2080, 22, 'Plaza Clucellas'),
(2081, 22, 'Portugalete'),
(2082, 22, 'Pozo Borrado'),
(2083, 22, 'Progreso'),
(2084, 22, 'Providencia'),
(2085, 22, 'Pte. Roca'),
(2086, 22, 'Pueblo Andino'),
(2087, 22, 'Pueblo Esther'),
(2088, 22, 'Pueblo Gral. San Mart�n'),
(2089, 22, 'Pueblo Irigoyen'),
(2090, 22, 'Pueblo Marini'),
(2091, 22, 'Pueblo Mu�oz'),
(2092, 22, 'Pueblo Uranga'),
(2093, 22, 'Pujato'),
(2094, 22, 'Pujato N.'),
(2095, 22, 'Rafaela'),
(2096, 22, 'Ramay�n'),
(2097, 22, 'Ramona'),
(2098, 22, 'Reconquista'),
(2099, 22, 'Recreo'),
(2100, 22, 'Ricardone'),
(2101, 22, 'Rivadavia'),
(2102, 22, 'Rold�n'),
(2103, 22, 'Romang'),
(2104, 22, 'Rosario'),
(2105, 22, 'Rueda'),
(2106, 22, 'Rufino'),
(2107, 22, 'Sa Pereira'),
(2108, 22, 'Saguier'),
(2109, 22, 'Saladero M. Cabal'),
(2110, 22, 'Salto Grande'),
(2111, 22, 'San Agust�n'),
(2112, 22, 'San Antonio de Obligado'),
(2113, 22, 'San Bernardo (N.J.)'),
(2114, 22, 'San Bernardo (S.J.)'),
(2115, 22, 'San Carlos Centro'),
(2116, 22, 'San Carlos N.'),
(2117, 22, 'San Carlos S.'),
(2118, 22, 'San Crist�bal'),
(2119, 22, 'San Eduardo'),
(2120, 22, 'San Eugenio'),
(2121, 22, 'San Fabi�n'),
(2122, 22, 'San Fco. de Santa F�'),
(2123, 22, 'San Genaro'),
(2124, 22, 'San Genaro N.'),
(2125, 22, 'San Gregorio'),
(2126, 22, 'San Guillermo'),
(2127, 22, 'San Javier'),
(2128, 22, 'San Jer�nimo del Sauce'),
(2129, 22, 'San Jer�nimo N.'),
(2130, 22, 'San Jer�nimo S.'),
(2131, 22, 'San Jorge'),
(2132, 22, 'San Jos� de La Esquina'),
(2133, 22, 'San Jos� del Rinc�n'),
(2134, 22, 'San Justo'),
(2135, 22, 'San Lorenzo'),
(2136, 22, 'San Mariano'),
(2137, 22, 'San Mart�n de Las Escobas'),
(2138, 22, 'San Mart�n N.'),
(2139, 22, 'San Vicente'),
(2140, 22, 'Sancti Spititu'),
(2141, 22, 'Sanford'),
(2142, 22, 'Santo Domingo'),
(2143, 22, 'Santo Tom�'),
(2144, 22, 'Santurce'),
(2145, 22, 'Sargento Cabral'),
(2146, 22, 'Sarmiento'),
(2147, 22, 'Sastre'),
(2148, 22, 'Sauce Viejo'),
(2149, 22, 'Serodino'),
(2150, 22, 'Silva'),
(2151, 22, 'Soldini'),
(2152, 22, 'Soledad'),
(2153, 22, 'Soutomayor'),
(2154, 22, 'Sta. Clara de Buena Vista'),
(2155, 22, 'Sta. Clara de Saguier'),
(2156, 22, 'Sta. Isabel'),
(2157, 22, 'Sta. Margarita'),
(2158, 22, 'Sta. Maria Centro'),
(2159, 22, 'Sta. Mar�a N.'),
(2160, 22, 'Sta. Rosa'),
(2161, 22, 'Sta. Teresa'),
(2162, 22, 'Suardi'),
(2163, 22, 'Sunchales'),
(2164, 22, 'Susana'),
(2165, 22, 'Tacuarend�'),
(2166, 22, 'Tacural'),
(2167, 22, 'Tartagal'),
(2168, 22, 'Teodelina'),
(2169, 22, 'Theobald'),
(2170, 22, 'Timb�es'),
(2171, 22, 'Toba'),
(2172, 22, 'Tortugas'),
(2173, 22, 'Tostado'),
(2174, 22, 'Totoras'),
(2175, 22, 'Traill'),
(2176, 22, 'Venado Tuerto'),
(2177, 22, 'Vera'),
(2178, 22, 'Vera y Pintado'),
(2179, 22, 'Videla'),
(2180, 22, 'Vila'),
(2181, 22, 'Villa Amelia'),
(2182, 22, 'Villa Ana'),
(2183, 22, 'Villa Ca�as'),
(2184, 22, 'Villa Constituci�n'),
(2185, 22, 'Villa Elo�sa'),
(2186, 22, 'Villa Gdor. G�lvez'),
(2187, 22, 'Villa Guillermina'),
(2188, 22, 'Villa Minetti'),
(2189, 22, 'Villa Mugueta'),
(2190, 22, 'Villa Ocampo'),
(2191, 22, 'Villa San Jos�'),
(2192, 22, 'Villa Saralegui'),
(2193, 22, 'Villa Trinidad'),
(2194, 22, 'Villada'),
(2195, 22, 'Virginia'),
(2196, 22, 'Wheelwright'),
(2197, 22, 'Zavalla'),
(2198, 22, 'Zen�n Pereira'),
(2199, 23, 'A�atuya'),
(2200, 23, '�rraga'),
(2201, 23, 'Bandera'),
(2202, 23, 'Bandera Bajada'),
(2203, 23, 'Beltr�n'),
(2204, 23, 'Brea Pozo'),
(2205, 23, 'Campo Gallo'),
(2206, 23, 'Capital'),
(2207, 23, 'Chilca Juliana'),
(2208, 23, 'Choya'),
(2209, 23, 'Clodomira'),
(2210, 23, 'Col. Alpina'),
(2211, 23, 'Col. Dora'),
(2212, 23, 'Col. El Simbolar Robles'),
(2213, 23, 'El Bobadal'),
(2214, 23, 'El Charco'),
(2215, 23, 'El Moj�n'),
(2216, 23, 'Estaci�n Atamisqui'),
(2217, 23, 'Estaci�n Simbolar'),
(2218, 23, 'Fern�ndez'),
(2219, 23, 'Fort�n Inca'),
(2220, 23, 'Fr�as'),
(2221, 23, 'Garza'),
(2222, 23, 'Gramilla'),
(2223, 23, 'Guardia Escolta'),
(2224, 23, 'Herrera'),
(2225, 23, 'Ica�o'),
(2226, 23, 'Ing. Forres'),
(2227, 23, 'La Banda'),
(2228, 23, 'La Ca�ada'),
(2229, 23, 'Laprida'),
(2230, 23, 'Lavalle'),
(2231, 23, 'Loreto'),
(2232, 23, 'Los Jur�es'),
(2233, 23, 'Los N��ez'),
(2234, 23, 'Los Pirpintos'),
(2235, 23, 'Los Quiroga'),
(2236, 23, 'Los Telares'),
(2237, 23, 'Lugones'),
(2238, 23, 'Malbr�n'),
(2239, 23, 'Matara'),
(2240, 23, 'Medell�n'),
(2241, 23, 'Monte Quemado'),
(2242, 23, 'Nueva Esperanza'),
(2243, 23, 'Nueva Francia'),
(2244, 23, 'Palo Negro'),
(2245, 23, 'Pampa de Los Guanacos'),
(2246, 23, 'Pinto'),
(2247, 23, 'Pozo Hondo'),
(2248, 23, 'Quimil�'),
(2249, 23, 'Real Sayana'),
(2250, 23, 'Sachayoj'),
(2251, 23, 'San Pedro de Guasay�n'),
(2252, 23, 'Selva'),
(2253, 23, 'Sol de Julio'),
(2254, 23, 'Sumampa'),
(2255, 23, 'Suncho Corral'),
(2256, 23, 'Taboada'),
(2257, 23, 'Tapso'),
(2258, 23, 'Termas de Rio Hondo'),
(2259, 23, 'Tintina'),
(2260, 23, 'Tomas Young'),
(2261, 23, 'Vilelas'),
(2262, 23, 'Villa Atamisqui'),
(2263, 23, 'Villa La Punta'),
(2264, 23, 'Villa Ojo de Agua'),
(2265, 23, 'Villa R�o Hondo'),
(2266, 23, 'Villa Salavina'),
(2267, 23, 'Villa Uni�n'),
(2268, 23, 'Vilmer'),
(2269, 23, 'Weisburd'),
(2270, 24, 'R�o Grande'),
(2271, 24, 'Tolhuin'),
(2272, 24, 'Ushuaia'),
(2273, 25, 'Acheral'),
(2274, 25, 'Agua Dulce'),
(2275, 25, 'Aguilares'),
(2276, 25, 'Alderetes'),
(2277, 25, 'Alpachiri'),
(2278, 25, 'Alto Verde'),
(2279, 25, 'Amaicha del Valle'),
(2280, 25, 'Amberes'),
(2281, 25, 'Ancajuli'),
(2282, 25, 'Arcadia'),
(2283, 25, 'Atahona'),
(2284, 25, 'Banda del R�o Sali'),
(2285, 25, 'Bella Vista'),
(2286, 25, 'Buena Vista'),
(2287, 25, 'Burruyac�'),
(2288, 25, 'Capit�n C�ceres'),
(2289, 25, 'Cevil Redondo'),
(2290, 25, 'Choromoro'),
(2291, 25, 'Ciudacita'),
(2292, 25, 'Colalao del Valle'),
(2293, 25, 'Colombres'),
(2294, 25, 'Concepci�n'),
(2295, 25, 'Delf�n Gallo'),
(2296, 25, 'El Bracho'),
(2297, 25, 'El Cadillal'),
(2298, 25, 'El Cercado'),
(2299, 25, 'El Cha�ar'),
(2300, 25, 'El Manantial'),
(2301, 25, 'El Moj�n'),
(2302, 25, 'El Mollar'),
(2303, 25, 'El Naranjito'),
(2304, 25, 'El Naranjo'),
(2305, 25, 'El Polear'),
(2306, 25, 'El Puestito'),
(2307, 25, 'El Sacrificio'),
(2308, 25, 'El Timb�'),
(2309, 25, 'Escaba'),
(2310, 25, 'Esquina'),
(2311, 25, 'Estaci�n Ar�oz'),
(2312, 25, 'Famaill�'),
(2313, 25, 'Gastone'),
(2314, 25, 'Gdor. Garmendia'),
(2315, 25, 'Gdor. Piedrabuena'),
(2316, 25, 'Graneros'),
(2317, 25, 'Huasa Pampa'),
(2318, 25, 'J. B. Alberdi'),
(2319, 25, 'La Cocha'),
(2320, 25, 'La Esperanza'),
(2321, 25, 'La Florida'),
(2322, 25, 'La Ramada'),
(2323, 25, 'La Trinidad'),
(2324, 25, 'Lamadrid'),
(2325, 25, 'Las Cejas'),
(2326, 25, 'Las Talas'),
(2327, 25, 'Las Talitas'),
(2328, 25, 'Los Bulacio'),
(2329, 25, 'Los G�mez'),
(2330, 25, 'Los Nogales'),
(2331, 25, 'Los Pereyra'),
(2332, 25, 'Los P�rez'),
(2333, 25, 'Los Puestos'),
(2334, 25, 'Los Ralos'),
(2335, 25, 'Los Sarmientos'),
(2336, 25, 'Los Sosa'),
(2337, 25, 'Lules'),
(2338, 25, 'M. Garc�a Fern�ndez'),
(2339, 25, 'Manuela Pedraza'),
(2340, 25, 'Medinas'),
(2341, 25, 'Monte Bello'),
(2342, 25, 'Monteagudo'),
(2343, 25, 'Monteros'),
(2344, 25, 'Padre Monti'),
(2345, 25, 'Pampa Mayo'),
(2346, 25, 'Quilmes'),
(2347, 25, 'Raco'),
(2348, 25, 'Ranchillos'),
(2349, 25, 'R�o Chico'),
(2350, 25, 'R�o Colorado'),
(2351, 25, 'R�o Seco'),
(2352, 25, 'Rumi Punco'),
(2353, 25, 'San Andr�s'),
(2354, 25, 'San Felipe'),
(2355, 25, 'San Ignacio'),
(2356, 25, 'San Javier'),
(2357, 25, 'San Jos�'),
(2358, 25, 'San Miguel de 25'),
(2359, 25, 'San Pedro'),
(2360, 25, 'San Pedro de Colalao'),
(2361, 25, 'Santa Rosa de Leales'),
(2362, 25, 'Sgto. Moya'),
(2363, 25, 'Siete de Abril'),
(2364, 25, 'Simoca'),
(2365, 25, 'Soldado Maldonado'),
(2366, 25, 'Sta. Ana'),
(2367, 25, 'Sta. Cruz'),
(2368, 25, 'Sta. Luc�a'),
(2369, 25, 'Taco Ralo'),
(2370, 25, 'Taf� del Valle'),
(2371, 25, 'Taf� Viejo'),
(2372, 25, 'Tapia'),
(2373, 25, 'Teniente Berdina'),
(2374, 25, 'Trancas'),
(2375, 25, 'Villa Belgrano'),
(2376, 25, 'Villa Benjam�n Araoz'),
(2377, 25, 'Villa Chiligasta'),
(2378, 25, 'Villa de Leales'),
(2379, 25, 'Villa Quinteros'),
(2380, 25, 'Y�nima'),
(2381, 25, 'Yerba Buena'),
(2382, 25, 'Yerba Buena (S)');
GO

INSERT INTO Usuarios(DNI_Usuario, Nombre_Usuario, Apellido_Usuario, Email_Usuario, Contrase�a_Usuario,  EsAdmin_Usuario)
SELECT '1111111111', 'Admin', NULL, 'admin@gmail.com', '123', 1 UNION
SELECT '38290162', 'Maria', 'Solana', 'msolana@gmail.com', '77332', 0 UNION
SELECT '36901462', 'Matias', 'Ferrara', 'mati23@gmail.com', 'mkpo10', 0 UNION
SELECT '45106168', 'Gian', 'Galvan', 'giang@gmail.com', 'abc321', 0 UNION
SELECT '27829516', 'Romina','Peralta', 'romi96@gmail.com', '15596', 0 UNION
SELECT '43829201', 'German','Casas', 'casasger@hotmail.com', '77332', 0 UNION
SELECT '33906237', 'Olivia', 'Becerra', 'oli22@gmail.com', '2244', 0 UNION
SELECT '36492621', 'Soledad','Arriola', 'arriolas@gmail.com', 'sol155', 0 UNION
SELECT '42823468', 'Martin', 'Gomez', 'mg58@gmail.com', '77332', 0 UNION
SELECT '29616542', 'Daniel', 'Garcia', 'dani22@outlook.com', 'city86', 0 UNION
SELECT '26239872', 'Guillermo', 'Hernandez', 'Guille82@gmail.com', 'g4563', 0 UNION
SELECT '45099166', 'Oscar', 'Braz', 'obraz@gmail.com', 'b1mx6',0 UNION
SELECT '43162955', 'Alejandro', 'Roldan', 'ale160@gmail.com', 'y933', 0 UNION
SELECT '40762113', 'Natalia', 'Moreira', 'nat58@gmail.com', '877552', 0 UNION
SELECT '42916572', 'Daniela','Alvarez', 'dalva1@gmail.com', 'ddd55', 0 UNION
SELECT '37972884', 'Mario', 'Peralta', 'mper57@gmail.com', '77332', 0 
GO


insert into Tarjetas (Numero_Tarjeta, DNI_Usuario_Tarjeta, CodSeguridad_Tarjeta, FechaExpiracion_Tarjeta)
SELECT '1234432112342345', '27829516', '231', '02/10/2022 12:00:00' union
SELECT '2456261263410001', '29616542', '121', '03/11/2022 23:31:00' union
SELECT '4746512683190021', '26239872', '267', '04/12/2022 14:20:00' union
SELECT '7658281283218201', '37972884', '131', '05/11/2022 22:31:00' union
SELECT '2123453267460032', '38290162', '134', '07/06/2022 13:56:00' union
SELECT '9999888877776666', '42916572', '154', '06/02/2022 22:22:00' union
SELECT '2527683627712731', '43162955', '159', '09/03/2022 13:34:00' union
SELECT '2535172172382912', '43829201', '341', '10/11/2022 11:10:00'
GO

insert into Facturas 
(Numero_Tarjeta_Factura, [ValorTotal_Factura], [FechaEmision_Factura], [SeEnvia_Factura], [DireccionEnvio_Factura], [RangoHorario_Factura], [Id_Provincia_Factura], [Id_Localidad_Factura])
select '1234432112342345', 0, '02/10/2022 12:00:00', 0, null, null, null, null union
select '2456261263410001', 0, '03/11/2022 23:31:00', 1, 'sarmiento 1820', 'de 13:00 a 18:00', 2, 167 union
select '4746512683190021', 0, '04/12/2022 14:20:00', 1, 'savedra 1234', 'De 8:00 a 13:00', 1, 110 union
select '7658281283218201', 0, '05/11/2022 22:31:00', 1, 'chile 3021', 'De 8:00 a 13:00', 3, 285 union
select '9999888877776666', 0, '06/06/2022 22:22:00', 1, 'L. de la torre 210', 'De 8:00 a 13:00', 4, 333 union
select '2123453267460032', 0, '07/03/2022 13:56:00', 1, 'Alvear 321', 'de 13:00 a 18:00', 5, 380 union
select '1234432112342345', 0, '08/01/2022 14:32:00', 1, 'Pasteur 2931', 'De 8:00 a 13:00', 7, 489 union
select '2527683627712731', 0, '09/03/2022 13:34:00', 0, null, null, null, null union
select '2535172172382912', 0, '10/11/2022 11:10:00', 0, null, null, null, null
go

INSERT INTO Rese�as(Id_Producto_Rese�a,DNI_Usuario_Rese�a,Contenido_Rese�a,Calificacion_Rese�a)
SELECT 1,'26239872','Gran marca, confiable producto lo recomiendo' ,5 UNION
SELECT 1,'27829516','Mejor calidad precio del mercado actualmente' ,4 UNION
SELECT 1,'29616542','Producto muy confiable, recomendado para cualquier pc' ,3 UNION
SELECT 2,'33906237','Muy buena version, ya no hace ruido como versiones anteriores' ,5 UNION
SELECT 2,'37972884','Gran rendimiento y gran marca, recomendado para tenerlo buenos a�os' ,4 UNION
SELECT 3,'40762113','una porquer�a' ,1
go

insert into DetallesFacturas ([Id_Factura_Detalle], [Id_Producto_Detalle], [PrecioUnitario_Detalle], [Cantidad_Detalle]) 
select 1, 1, 5965, 30
go

insert into DetallesFacturas ([Id_Factura_Detalle], [Id_Producto_Detalle], [PrecioUnitario_Detalle], [Cantidad_Detalle]) 
select 2, 1, 5965, 70
go

insert into DetallesFacturas ([Id_Factura_Detalle], [Id_Producto_Detalle], [PrecioUnitario_Detalle], [Cantidad_Detalle]) 
select 3, 4, 6990, 20
go

insert into DetallesFacturas ([Id_Factura_Detalle], [Id_Producto_Detalle], [PrecioUnitario_Detalle], [Cantidad_Detalle]) 
select 4, 17, 13801, 9
go

insert into DetallesFacturas ([Id_Factura_Detalle], [Id_Producto_Detalle], [PrecioUnitario_Detalle], [Cantidad_Detalle]) 
select 5, 1, 5965, 1
go

insert into DetallesFacturas ([Id_Factura_Detalle], [Id_Producto_Detalle], [PrecioUnitario_Detalle], [Cantidad_Detalle]) 
select 6, 16, 34400, 1
go

insert into DetallesFacturas ([Id_Factura_Detalle], [Id_Producto_Detalle], [PrecioUnitario_Detalle], [Cantidad_Detalle]) 
select 7, 10, 23000, 1
go

insert into DetallesFacturas ([Id_Factura_Detalle], [Id_Producto_Detalle], [PrecioUnitario_Detalle], [Cantidad_Detalle]) 
select 8, 6, 22350, 2
go

insert into DetallesFacturas ([Id_Factura_Detalle], [Id_Producto_Detalle], [PrecioUnitario_Detalle], [Cantidad_Detalle]) 
select 9, 15, 2850, 80
go


Create VIEW ReportesProducto 
AS 
select Id_Factura_Detalle as [Numero de factura], Nombre_Producto as [Nombre del producto], FechaEmision_Factura as [Fecha de la factura], PrecioUnitario_Detalle * Cantidad_Detalle as [Precio total], Cantidad_Detalle as Cantidad, Descripcion_Categoria as Categor�a, Descripcion_Subcategoria as [Sub categor�a], SeEnvia_Factura as Envio 
from DetallesFacturas inner join Facturas 
	on DetallesFacturas.Id_Factura_Detalle = Facturas.Id_Factura 
inner join Productos 
	on Productos.Id_Producto = DetallesFacturas.Id_Producto_Detalle
inner join Subcategorias 
	on Productos.Id_Subcategoria_Producto = Subcategorias.Id_Subcategoria 
inner join Categorias 
on Categorias.Id_Categoria = Subcategorias.Id_Categoria_Subcategoria 
WHERE Estado_Factura=1
go


create view ProductosDeListView
 as 
SELECT [Nombre_Producto], [Precio_Producto], [UrlImagen_Producto], [Stock_Producto], [Id_Categoria_Producto], [Id_Subcategoria_Producto], [Id_Producto]
FROM [Productos]
WHERE [Estado_Producto] > 0

GO

create VIEW ProductosHabilitados

as

select * 
from Productos
where Estado_Producto = 1

GO



create view SubCategoriasHabilitadas
as
select * 
from Subcategorias 
where Estado_Subcategoria > 0
GO



CREATE VIEW grdProductosAdmin

as

SELECT Id_Producto, Id_Categoria_Producto, Id_Subcategoria_Producto, Nombre_Producto, Descripcion_Producto, Precio_Producto, Stock_Producto, UrlImagen_Producto
FROM dbo.Productos
WHERE (Estado_Producto > 0)
GO


create view CategoriasHabilitadas
as
select * 
from categorias 
where Estado_Categoria > 0
GO



CREATE VIEW DetallesXFacturas
AS
	SELECT Id_Factura_Detalle,Nombre_Producto, Precio_Producto, Cantidad_Detalle, Cantidad_Detalle * Precio_Producto as Total
	FROM DetallesFacturas inner join Productos
			on DetallesFacturas.Id_Producto_Detalle = Productos.Id_Producto
	WHERE Estado_Detalle = 1 and Estado_Producto = 1
GO



CREATE VIEW FacturasXcliente
AS
 SELECT DNI_Usuario,Id_Factura,ValorTotal_Factura,FechaEmision_Factura 
 FROM Facturas inner join Tarjetas
	ON Facturas.Numero_Tarjeta_Factura = Tarjetas.Numero_Tarjeta INNER JOIN Usuarios
		ON Tarjetas.DNI_Usuario_Tarjeta = Usuarios.DNI_Usuario
	where Estado_Factura = 1 and Estado_Factura = 1 and Estado_Usuario = 1
GO


create view UsuariosHabilitados
as
select * from Usuarios
where Estado_Usuario = 1
GO


CREATE view CategoriasInnerSubCategorias
as
select [Id_Categoria], [Descripcion_Categoria], [Id_Categoria_Subcategoria], [Id_Subcategoria], [Descripcion_Subcategoria]
from SubCategoriasHabilitadas inner join CategoriasHabilitadas
	on Id_Categoria_Subcategoria = Id_Categoria
GO



create view Rese�asHabilitadas
as
select [Id_Producto_Rese�a], [DNI_Usuario_Rese�a], [Contenido_Rese�a], [Calificacion_Rese�a], [Fecha_Rese�a]
from Rese�as
where Estado_Rese�a = 1
GO





CREATE TRIGGER TR_EliminarCategoria
ON [dbo].[Categorias] INSTEAD OF DELETE AS
	BEGIN
	SET NOCOUNT ON;
	UPDATE Categorias
	SET Estado_Categoria = 0
	WHERE Id_Categoria = (SELECT Id_Categoria from deleted)

	UPDATE Subcategorias
	SET Estado_Subcategoria = 0
	WHERE Id_Categoria_Subcategoria = (SELECT Id_Categoria from deleted)

	UPDATE Productos
	set Estado_Producto = 0
	where Id_Categoria_Producto = (SELECT Id_Categoria from deleted)
	END
GO



CREATE TRIGGER TR_AgregarDetalleFactura
ON DetallesFacturas AFTER INSERT AS
    BEGIN
    SET NOCOUNT ON;
    UPDATE Facturas
    SET ValorTotal_Factura += (SELECT Cantidad_Detalle * PrecioUnitario_Detalle from inserted)
    WHERE Id_Factura = (SELECT Id_Factura_Detalle FROM inserted)
    UPDATE Productos
    SET Stock_Producto -= (SELECT Cantidad_Detalle FROM inserted)
    WHERE Id_Producto = (SELECT Id_Producto_Detalle FROM inserted)
    END
GO



CREATE TRIGGER TR_EliminarDetalleFactura
ON DetallesFacturas INSTEAD OF DELETE AS
	BEGIN
	SET NOCOUNT ON;
	UPDATE DetallesFacturas
	SET Estado_Detalle = 0
	WHERE Id_Factura_Detalle = (Select Id_Factura_Detalle from deleted)
		AND Id_Producto_Detalle = (SELECT Id_Producto_Detalle from deleted)

	UPDATE Facturas --Resta el valor de los detalles borrados a la factura total
	SET ValorTotal_Factura -= (Select Cantidad_Detalle * PrecioUnitario_Detalle from deleted)
	WHERE Facturas.Id_Factura = (Select Id_Factura_Detalle from deleted)
	END
GO


CREATE TRIGGER TR_EliminarFactura
ON [dbo].[Facturas] INSTEAD OF DELETE AS
	BEGIN
		SET NOCOUNT ON;
		UPDATE Facturas
		SET Estado_Factura = 0
		WHERE Id_Factura = (Select Id_Factura from deleted)

		UPDATE DetallesFacturas
		SET Estado_Detalle = 0
		WHERE Id_Factura_Detalle = (Select Id_Factura from deleted)
	END
GO


CREATE TRIGGER TR_EliminarLocalidad
ON Localidades INSTEAD OF DELETE AS
	BEGIN
	SET NOCOUNT ON;
	UPDATE Localidades
	SET Estado_Localidad = 0
	WHERE Id_Localidad = (Select Id_Localidad from deleted)
		AND Id_Provincia_Localidad = (Select Id_Provincia_Localidad from deleted)
	END
GO


CREATE TRIGGER TR_EliminarProducto
ON Productos INSTEAD OF DELETE AS
	BEGIN
		SET NOCOUNT ON;
		UPDATE Productos
		SET Estado_Producto = 0
		WHERE Id_Producto = (SELECT Id_Producto from deleted)

		UPDATE Rese�as
		SET Estado_Rese�a = 0
		WHERE Id_Producto_Rese�a = (Select Id_Producto from deleted)
	END
GO


CREATE TRIGGER TR_EliminarProvincia
ON [dbo].[Provincias] INSTEAD OF DELETE AS
	BEGIN
	SET NOCOUNT ON;
	UPDATE Provincias
	SET Estado_Provincia = 0
	WHERE Id_Provincia = (SELECT Id_Provincia from deleted)

	UPDATE Localidades
	SET Estado_Localidad = 0
	WHERE Id_Provincia_Localidad = (SELECT Id_Provincia from deleted)
	END
GO


CREATE TRIGGER TR_EliminarResenia
ON [dbo].[Rese�as] INSTEAD OF DELETE AS
	BEGIN
	SET NOCOUNT ON;
	UPDATE Rese�as
	SET Estado_Rese�a = 0
	WHERE Id_Producto_Rese�a = (SELECT Id_Producto_Rese�a from deleted)
		AND DNI_Usuario_Rese�a = (SELECT DNI_Usuario_Rese�a from deleted)
	END
GO


CREATE TRIGGER TR_EliminarSubcategoria
ON Subcategorias INSTEAD OF DELETE AS
	BEGIN
	SET NOCOUNT ON;
	UPDATE Subcategorias
	SET Estado_Subcategoria = 0
	WHERE Id_Subcategoria = (SELECT Id_Subcategoria FROM deleted)
		AND Id_Categoria_Subcategoria = (SELECT Id_Categoria_Subcategoria FROM deleted)

	UPDATE Productos
	set Estado_Producto = 0
	where Id_Subcategoria_Producto = (SELECT Id_Categoria_Subcategoria from deleted)
	END
GO


CREATE TRIGGER TR_EliminarTarjeta
ON Tarjetas INSTEAD OF DELETE AS
	BEGIN
		SET NOCOUNT ON;
		UPDATE Tarjetas
		SET Estado_Tarjeta = 0
		WHERE Numero_Tarjeta = (SELECT Numero_Tarjeta from deleted)
	END
GO

CREATE TRIGGER TR_EliminarUsuario
ON Usuarios INSTEAD OF DELETE AS
	BEGIN
		SET NOCOUNT ON;
		UPDATE Usuarios
		SET Estado_Usuario = 0
		WHERE DNI_Usuario = (Select DNI_Usuario from deleted)

		UPDATE Rese�as
		SET Estado_Rese�a = 0
		WHERE DNI_Usuario_Rese�a = (Select DNI_Usuario from deleted)

		UPDATE Tarjetas
		SET Estado_Tarjeta = 0
		WHERE DNI_Usuario_Tarjeta = (Select DNI_Usuario from deleted)
	END
GO

--agregar cat
CREATE procedure SP_AgregarCategoria
@desc varchar(50)

as

insert into Categorias([Descripcion_Categoria])
select @desc

GO

CREATE PROCEDURE SP_AgregarDetalleFactura
@IDFACTURA int,
@IDPRODUCTO int,
@PRECIO decimal(8,2),
@CANTIDAD int
AS
	IF EXISTS(SELECT Id_Factura FROM Facturas where Id_Factura = @IDFACTURA and Estado_Factura = 1) and EXISTS(SELECT Id_Producto from Productos where Id_Producto = @IDPRODUCTO and Estado_Producto = 1)
	BEGIN	
		IF NOT EXISTS(SELECT * FROM DetallesFacturas where Id_Factura_Detalle = @IDFACTURA AND Id_Producto_Detalle = @IDPRODUCTO)
		BEGIN	
			INSERT INTO DetallesFacturas(Id_Factura_Detalle,Id_Producto_Detalle,PrecioUnitario_Detalle,Cantidad_Detalle)
			SELECT @IDFACTURA,@IDPRODUCTO,@PRECIO,@CANTIDAD
		END
		ELSE
		BEGIN
			UPDATE DetallesFacturas
			SET PrecioUnitario_Detalle = @PRECIO, Cantidad_Detalle = @CANTIDAD
			WHERE Id_Producto_Detalle = @IDPRODUCTO AND Id_Factura_Detalle = @IDFACTURA
		END
	END
GO

CREATE PROCEDURE SP_AgregarFactura
@NROTARJETA char(20),
@SEENVIA BIT,
@DIRECCION VARCHAR(50) = NULL,
@RANGO VARCHAR(20) = NULL,
@IDPROV INT = NULL,
@IDLOCAL INT = NULL
AS
	IF EXISTS(SELECT Numero_Tarjeta FROM Tarjetas where @NROTARJETA = Numero_Tarjeta and Estado_Tarjeta = 1)
	BEGIN
		INSERT INTO Facturas(Numero_Tarjeta_Factura,FechaEmision_Factura,SeEnvia_Factura,DireccionEnvio_Factura,RangoHorario_Factura,Id_Provincia_Factura,Id_Localidad_Factura)
		SELECT @NROTARJETA, GETDATE(), @SEENVIA,@DIRECCION,@RANGO,@IDPROV,@IDLOCAL
	END
GO

CREATE Procedure SP_AgregarProducto
@NOMBREPRODUCTO VARCHAR(50),
@DESCPRODUCTO VARCHAR(400),
@PRECIO decimal(8, 2),
@IDCATEGORIA INT,
@IDSUBCATEGORIA INT,
@STOCK INT,
@URLIMAGEN VARCHAR(100)

As

Insert into Productos(Nombre_Producto, Descripcion_Producto, Precio_Producto, Id_Categoria_Producto, Id_Subcategoria_Producto, Stock_Producto, UrlImagen_Producto)
Values(@NOMBREPRODUCTO, @DESCPRODUCTO, @PRECIO, @IDCATEGORIA, @IDSUBCATEGORIA, @STOCK, @URLIMAGEN)
GO

CREATE Procedure SP_AgregarRese�a
@IDPRODUCTOS INT,
@DNIUSUARIO CHAR(10),
@CONTENIDO Text,
@CALIFICACION INT
AS
IF EXISTS(SELECT Id_Producto from Productos where Id_Producto = @IDPRODUCTOS and Estado_Producto = 1) AND EXISTS(SELECT DNI_Usuario FROM Usuarios WHERE DNI_Usuario = @DNIUSUARIO AND Estado_Usuario = 1)
BEGIN	
	IF not exists(Select * from Rese�as where Id_Producto_Rese�a = @IDPRODUCTOS and DNI_Usuario_Rese�a = @DNIUSUARIO)
		BEGIN
		Insert into Rese�as(Id_Producto_Rese�a, DNI_Usuario_Rese�a, Contenido_Rese�a, Calificacion_Rese�a, Fecha_Rese�a)
		Values(@IDPRODUCTOS, @DNIUSUARIO, @CONTENIDO, @CALIFICACION, GETDATE())
		END
	ELSE
		BEGIN
		UPDATE Rese�as
		SET Id_Producto_Rese�a = @IDPRODUCTOS, DNI_Usuario_Rese�a = @DNIUSUARIO, Contenido_Rese�a = @CONTENIDO, Calificacion_Rese�a = @CALIFICACION, Fecha_Rese�a = GETDATE()
		END
END
GO

--agregar sub cat
CREATE procedure SP_AgregarSubCategoria
@desc varchar(50),
@Cat int
as
IF EXISTS(SELECT Id_Categoria FROM Categorias WHERE Id_Categoria = @Cat AND Estado_Categoria = 1)
BEGIN
	insert into Subcategorias([Descripcion_Subcategoria], Id_Categoria_Subcategoria)
	select @desc, @Cat
END
GO

CREATE PROCEDURE SP_AgregarTarjeta
@DNI CHAR(10),
@NROTARJETA CHAR(20),
@CODSEGURIDAD CHAR(3),
@FECHAEXP DATE
AS
IF EXISTS(SELECT DNI_Usuario FROM Usuarios WHERE DNI_Usuario = @DNI and Estado_Usuario = 1)
BEGIN
	IF NOT EXISTS(SELECT Numero_Tarjeta FROM Tarjetas WHERE Numero_Tarjeta = @NROTARJETA AND Estado_Tarjeta = 1)
	BEGIN
		INSERT INTO Tarjetas(Numero_Tarjeta,DNI_Usuario_Tarjeta,CodSeguridad_Tarjeta,FechaExpiracion_Tarjeta)
		SELECT @NROTARJETA,@DNI,@CODSEGURIDAD,@FECHAEXP
	END
	ELSE
	BEGIN
		UPDATE Tarjetas
		Set Numero_Tarjeta = @NROTARJETA, DNI_Usuario_Tarjeta = @DNI, CodSeguridad_Tarjeta = @CODSEGURIDAD, FechaExpiracion_Tarjeta = @FECHAEXP
	END
END
GO	


CREATE PROCEDURE SP_AgregarUsuario

@DNI CHAR(10),
@NOMBRE VARCHAR(20),
@APELLIDO VARCHAR(20),
@EMAIL VARCHAR(50),
@CONTRASE�A VARCHAR(20)

AS

if exists (Select DNI_Usuario from Usuarios where DNI_Usuario=@DNI AND Estado_Usuario=0)
	BEGIN
	SET NOCOUNT ON
	UPDATE Usuarios
		SET Estado_Usuario = 1,Nombre_Usuario = @Nombre,Apellido_Usuario=@APELLIDO, Email_Usuario=@EMAIL, Contrase�a_Usuario=@CONTRASE�A
		WHERE DNI_Usuario = @DNI
	END

else INSERT INTO Usuarios(DNI_Usuario,Nombre_Usuario,Apellido_Usuario,Email_Usuario,Contrase�a_Usuario)
    SELECT @DNI, @NOMBRE, @APELLIDO, @EMAIL, @CONTRASE�A
GO

--Editar admin
create procedure SP_EditarAdminUsuario
@DNI char(10),
@ADMIN Bit

as

IF EXISTS(select * from usuarios where [Estado_Usuario] = 1)
BEGIN
	update usuarios
	set EsAdmin_Usuario = @ADMIN
	where DNI_Usuario = @DNI
END
GO

--editar cat
CREATE procedure SP_EditarCategoria
@idCat int,
@Desc varchar(30)

as

if exists(select * from Categorias where Estado_Categoria = 1)
begin
	update categorias
	set Descripcion_Categoria = @Desc
	where Id_Categoria = @idCat
end

GO

--editar sub cat
create procedure SP_EditarSubCategoria
@idSubCat int,
@Desc varchar(30)

as

if exists(select * from subcategorias where [Estado_Subcategoria] = 1)
begin
	update subcategorias
	set Descripcion_Subcategoria = @Desc
	where Id_Subcategoria = @idSubCat
end

GO

--editar usuario
create procedure SP_EditarUsuario
@DNI char(10),
@NOMBRE varchar(20),
@APELLIDO varchar(20),
@EMAIL varchar(50),
@CONTRASE�A	varchar(20)

as

IF EXISTS(select * from usuarios where [Estado_Usuario] = 1)
BEGIN
	update Usuarios
	set Nombre_Usuario = @NOMBRE, Apellido_Usuario = @APELLIDO, Email_Usuario = @EMAIL, Contrase�a_Usuario = @CONTRASE�A
	where DNI_Usuario = @DNI
END
GO

--eliminar cat
create procedure SP_EliminarCategoria
@idCat int

as

delete Categorias
where Id_Categoria = @idCat

GO

CREATE PROCEDURE SP_EliminarFacturas
@idFactura INT 
AS
 DELETE FROM Facturas Where Id_Factura=@idFactura
GO


--eliminar prod
CREATE procedure SP_EliminarProducto
@idProd INT

as

update Productos
set Estado_Producto = 0
where Id_Producto = @idProd
GO

--eliminar sub cat
CREATE procedure SP_EliminarSubCategoria
@idSubCat int

as

delete subcategorias
where Id_Subcategoria = @idSubCat
GO

CREATE PROCEDURE SP_EliminarTarjeta
@NROTARJETA char(20)
AS
DELETE FROM Tarjetas
WHERE Numero_Tarjeta = @NROTARJETA
GO

CREATE PROCEDURE SP_EliminarUsuario
@DNI CHAR(10)
AS
DELETE FROM Usuarios WHERE DNI_Usuario = @DNI
GO

CREATE procedure SP_ModificarProducto
@idProd INT,
@nombre varchar(50),
@descrip varchar(400),
@cat INT,
@subCat INT,
@precio decimal,
@stock int,
@url varchar(150)

as
if exists(select * from productos where [Estado_Producto] = 1)
begin
update Productos
set Id_Categoria_Producto = @cat, Id_Subcategoria_Producto = @subCat, Nombre_Producto = @nombre, Descripcion_Producto = @descrip, Precio_Producto = @precio, Stock_Producto = @stock, UrlImagen_Producto = @url
where Id_Producto = @idProd
end
GO





CREATE PROCEDURE SP_VerificarUsuario
@email varchar(50),
@contrasenia varchar(20)

AS
IF EXISTS(
SELECT [Email_Usuario], [Contrase�a_Usuario] 
FROM Usuarios
WHERE [Email_Usuario] = @email AND [Contrase�a_Usuario] = @contrasenia
)
RETURN 1
else RETURN 0
GO











