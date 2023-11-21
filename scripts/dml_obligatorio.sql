INSERT INTO public.producto (es_nuevo,precio_unitario,detalle,descripcion_producto,nombre_producto,stock,calificacion) VALUES
	 (false,19530.00,'Lámpara de escritorio','Lámpara de escritorio moderna con base de madera','Lámpara de escritorio',20,4),
	 (true,519999.99,'Samsung Galaxy S23 Fe 256gb 8gb Ram Negro','Procesador y memoria RAM de 8 GB, alcanzará un alto rendimiento con gran velocidad y memoria interna de 256 GB.','Samsung Galaxy S23 Fe',50,5),
	 (false,30990.00,'Mesa auxiliar','Mesa auxiliar redonda de metal con acabado dorado','Mesa auxiliar dorada',2,3),
	 (true,569999.99,'Notebook Ryzen 7 Asus Vivobook Amd 512gb Ssd 16gb Ram','ASUS VivoBook 15 39,6 cm (15.6") Full HD AMD Ryzen 7 5800H 16 GB DDR4-SDRAM 512 GB SSD Wi-Fi 6E (802.11ax) Windows 11 Home Quiet Blue','Notebook Ryzen 7 Asus Vivobook',10,4),
	 (true,259999.00,'Smart TV LG Smart TV 43ur8750 ','Televisor LED WebOS  de 44 pulgadas con resolución 4K UHD 220V','Smart TV LG Smart TV 43ur8750',5,5),
	 (false,45000.00,'Silla de comedor','Silla de comedor moderna y ergonómica','Silla de comedor ergonómica',4,3),
	 (false,60500.00,'Mesa de centro','Mesa de centro de madera maciza con cajones de almacenamiento','Mesa de centro moderna',1,4),
	 (true,28999.00,'Parlante Philco Djp10p Portátil Con Bluetooth 220v','Altavoz Bluetooth portátil con batería de larga duración','Parlante Philco Djp10p',40,4),
	 (false,30000.00,'Auriculares inalámbricos','Auriculares inalámbricos con cancelación de ruido','AirPods Pro 2da Generación',1,5),
	 (true,13999.99,'Reloj Unisex Gadnic Alarma Cronometro Elegante Digital Color de la malla Negro','Reloj de pulsera resistente al agua con malla negra','Reloj Unisex Gadnic',30,5);
INSERT INTO categoria (id_categoria, nombre) VALUES
    (1,'Electrónica'),
    (2,'Ropa y Accesorios'),
    (3,'Calzado'),
    (4,'Belleza y Cuidado Personal'),
    (5,'Hogar'),
    (6,'Jardín'),
    (7,'Deportes y Actividades al Aire Libre'),
    (8,'Juguetes y Juegos'),
    (9,'Libros y Material de Oficina'),
    (10,'Electrodomésticos'),
    (11,'Muebles'),
    (12,'Alimentos y Bebidas'),
    (13,'Automóviles y Accesorios'),
    (14,'Instrumentos Musicales'),
    (15,'Arte y Manualidades'),
    (16,'Electrónica de Consumo'),
    (17,'Salud y Bienestar'),
    (18,'Maletas y Equipaje'),
    (19,'Productos para Bebés y Niños'),
    (20,'Joyas y Relojes'),
    (21,'Electrodomésticos de Cocina'),
    (22,'Herramientas y Mejoras para el Hogar'),
    (23,'Productos para Mascotas'),
    (24,'Equipamiento para Negocios'),
    (25,'Productos para el Cuidado del Cabello'),
    (26,'Cámaras y Fotografía'),
    (27,'Equipamiento para Deportes y Fitness'),
    (28,'Equipos de Oficina'),
    (29,'Juegos de Mesa y Rompecabezas'),
    (30,'Suministros para Fiestas y Eventos'),
    (31,'Equipamiento para Viajes y Aventuras'),
    (32,'Productos para el Cuidado de la Piel'),
    (33,'Equipamiento para Acampar y Excursionismo'),
    (34,'Equipamiento para Actividades Acuáticas'),
    (35,'Electrodomésticos para la Limpieza'),
    (36,'Equipamiento para la Playa y Piscina'),
    (37,'Equipos de Sonido y Audio'),
    (38,'Equipamiento para Ciclismo'),
    (39,'Equipamiento para Deportes de Invierno'),
    (40,'Productos para el Cuidado de la Salud'),
    (41,'Equipamiento para Deportes de Raqueta'),
    (42,'Equipamiento para Deportes de Pelota'),
    (43,'Equipamiento para Deportes de Combate'),
    (44,'Productos para el Cuidado Oral'),
    (45,'Equipamiento para Deportes de Equipo'),
    (46,'Productos para el Cuidado de los Ojos'),
    (47,'Productos de Higiene Personal'),
    (48,'Equipamiento para Deportes de Agua'),
    (49,'Equipamiento para Deportes de Aventura'),
    (50,'Productos para el Cuidado de las Uñas'),
    (51,'Equipamiento para Deportes de Montaña'),
    (52,'Equipamiento para Deportes de Escalada'),
    (53,'Equipamiento para Deportes de Motor'),
    (54,'Productos para el Cuidado de la Barba'),
    (55,'Equipamiento para Deportes de Vuelo'),
    (56,'Equipamiento para Deportes de Tiro'),
    (57,'Productos de Aseo Personal'),
    (58,'Equipamiento para Deportes de Lucha');
INSERT INTO categoria_subcategoria (tiene_categoria, es_subcategoria) VALUES
    (1,10),
    (1,16),
    (1,26),
    (1,37),
    (2,3),
    (2,20),
    (4,17),
    (4,25),
    (4,47),
    (4,50),
    (4,54),
    (4,57),
    (5,6),
    (5,11),
    (5,22),
    (7,27),
    (7,31),
    (7,33),
    (7,34),
    (7,36),
    (7,38),
    (7,39),
    (7,41),
    (7,42),
    (7,43),
    (7,45),
    (7,48),
    (7,49),
    (7,51),
    (7,52),
    (7,53),
    (7,55),
    (7,56),
    (7,58),
    (8,29),
    (9,24),
    (9,28),
    (10,21),
    (10,35),
    (17,32),
    (17,40),
    (17,44),
    (17,46);
INSERT INTO pregunta VALUES
	 (0,'','1900-01-01');
INSERT INTO pregunta (preguntas_del_producto,fecha_de_la_pregunta) VALUES
	 ('¿La lámpara de escritorio incluye la bombilla?','2020-09-01'),
	 ('Hola, no. Cualquier otra consulta estoy a su disposición','2020-09-01'),
	 ('Bombita De cuantos w soporta el artefacto ? El portalámparas es universal ?','2020-09-01'),
	 ('¡Hola! Es el portalámparas convencional a rosca comúnmente denominado E27 Máximo 60w...cuando normalmente se utilizan lámparas entre 9w y 12w de led que te representan entre 60 a 75w de las antiguas lámparas incandescentes Saludos','2020-09-02'),
	 ('Okey, muchas gracias!','2020-09-02'),
	 ('¿La lámpara de escritorio tiene ajuste de intensidad de luz?','2020-09-17'),
	 ('¡Hola! No, no tiene ajuste de la intensidad de luz. Saludos','2020-09-18'),
	 ('¿Viene con garantía el Samsung Galaxy S23 Fe?','2023-05-02'),
	 ('¡Hola!Si viene con garantía. ¡Gracias por su consulta! Saludos.','2023-05-02');
INSERT INTO pregunta (preguntas_del_producto,fecha_de_la_pregunta) VALUES
	 ('Buenisimo! Gracias!.','2023-05-02'),
	 ('Por nada!  Estamos a tu disposición cualquier otra consulta que desee hacernos.','2023-05-03'),
	 ('Hola, ¿ tiene carga inalámbrica el Samsung Galaxy S23 Fe?','2023-05-12'),
	 ('Hola, esperamos se encuentre bien. Le informamos que el Samsung Galaxy S23 Fe 128gb 8gb Ram Violeta posee: 3.900 mAh-Carga rápida de 25 W-Carga inalámbrica de 10 W. Quedamos a disposición. ¡Gracias por su consulta! Saludos.','2023-05-13'),
	 ('¿El Samsung Galaxy S23 Fe tiene ranura para tarjeta de memoria externa?','2023-07-18'),
	 ('Hola, esperamos se encuentre bien. Le informamos que el Samsung Galaxy S23 Fe 128gb 8gb Ram Violeta si tiene ranura para tarjeta de memoria externa. Quedamos a disposición. ¡Gracias por su consulta! Saludos.','2023-05-13'),
	 ('Genial! Muchas gracias!','2023-05-13'),
	 ('Por nada!  Estamos a tu disposición cualquier otra consulta que desee hacernos.','2023-05-14'),
	 ('¿Cuál es el diámetro de la mesa auxiliar?','2021-11-03'),
	 ('¡Hola! El diámetro es de 41cm x 53cm de altura. Saludos','2021-11-03');
INSERT INTO pregunta (preguntas_del_producto,fecha_de_la_pregunta) VALUES
	 ('¿La mesa auxiliar requiere montaje?','2021-11-12'),
	 ('¡Hola! La mesa no requiere montaje','2021-11-12'),
	 ('¿Cuánto pesará el pedido entonces? Ya que viene montada','2021-11-12'),
	 ('¿Tiene la notebook Ryzen 7 Asus Vivobook teclado retroiluminado?','2022-12-24'),
	 ('Hola, muchas gracias por su consulta. Sí, cuenta con teclado retroiluminado. Cualquier otra duda quedamos a su disposición.','2022-12-25'),
	 ('Hola, ¿Sirve para  diseño 3D? La notebook Ryzen 7 Asus Vivobook','2023-08-11'),
	 ('Hola, muchas gracias por su consulta. Sí te sirve. Cualquier otra duda quedamos a su disposición.','2023-08-11'),
	 ('¡Gracias!','2023-08-11'),
	 ('De nada!. Cualquier otra consulta quedamos a su disposición. Saludos!','2023-08-11'),
	 ('¿La notebook Ryzen 7 Asus Vivobook tiene teclado numérico?','2023-05-25');
INSERT INTO pregunta (preguntas_del_producto,fecha_de_la_pregunta) VALUES
	 ('Hola, muchas gracias por su consulta. Sí tiene. Cualquier otra duda quedamos a su disposición.','2023-05-26'),
	 ('¿Es tactil el reloj unisex Gadnic?','2022-10-05'),
	 ('Hola ¿Cómo estás? Es con pantalla táctil. Estamos online las 24 horas para brindarte la mejor atención y responder todas tus consultas Saludos.','2022-10-05'),
	 ('¿Es fuerte la malla?','2022-10-05'),
	 ('Hola ¿Cómo estás? Si claro, la malla es super resistente.Estamos online las 24 horas para brindarte la mejor atención y responder todas tus consultas Saludos.','2022-10-06'),
	 ('Buenisimo! Entonces compraré.','2022-10-06'),
	 ('¿Viene con soporte de montaje en pared el Smart TV LG Smart TV 43ur8750?','2023-04-06'),
	 ('¡Hola! no está incluido. Saludos.','2023-04-06'),
	 ('ah bueno, está bien, gracias.','2023-04-06'),
	 ('¿El televisor LG Smart TV 43ur8750 trae control remoto?','2022-11-27');
INSERT INTO pregunta (preguntas_del_producto,fecha_de_la_pregunta) VALUES
	 ('¡Hola! SI Saludos.','2022-11-27'),
	 ('¿Se venden las sillas de comedor por separado?','2019-01-07'),
	 ('Hola, no se vende por separado. Saludos','2019-01-07'),
	 ('¿La silla de comedor es ajustable en altura?','2019-02-08'),
	 ('Hola, no es ajustable. Saludos','2019-02-09'),
	 ('¿Viene ensamblada la mesa de centro o requiere montaje?','2023-04-08'),
	 ('Hola, viene ensamblada. Saludos','2023-04-09'),
	 ('Hola, ¿Es stereo? ¿Y cuanto dura la batería aprox del parlante Philco Djp10p?','2021-11-09'),
	 ('Hola. Te confirmamos que si es estéreo y la duración de la batería depende del uso que se le dé al producto. Aguardamos tu compra. Saludos','2021-11-09'),
	 ('Pero me podrias dar un estimado de la duración?','2021-11-09');
INSERT INTO pregunta (preguntas_del_producto,fecha_de_la_pregunta) VALUES
	 ('¿Viene con estuche de carga los auriculares inalámbricos AirPods Pro 2da Generación?','2022-06-10'),
	 ('Hola y gracias por comunicarnos!Si trae estuche de carga. Quedamos a disposición, saludo ','2022-06-11'),
	 ('¿Los auriculares inalámbricos AirPods Pro 2da Generación son compatibles con Android?','2023-03-15'),
	 ('Hola, ¿cómo estás? Muchas gracias por contactarnos. No es compatible, desde ya muchas gracias y saludos.','2023-03-16'),
	 ('¿Los auriculares inalámbricos tienen cancelación activa de ruido?','2023-03-20'),
	 ('Hola, ¿cómo estás? Muchas gracias por contactarnos. Si tienen cancelación de ruido, desde ya muchas gracias y saludos.','2023-03-21');
INSERT INTO pregunta_producto_usuario (pregunta, producto, usuario) VALUES
	(0,301,18),
	(1,301,1),
	(2,301,18),
	(3,301,2),
	(4,301,18),
	(5,301,12),
	(6,301,12),
	(7,301,18),
	(0,302,5),
	(8,302,14),
	(9,302,5),
	(10,302,14),
	(11,302,5),
	(12,302,199),
	(13,302,5),
	(14,302,206),
	(15,302,5),
	(16,302,206),
	(17,302,5),
	(0,303,7),
    (18,303,173),
	(19,303,7),
	(20,303,228),
	(21,303,7),
	(22,303,228),
	(0,304,10),
	(23,304,63),
	(24,304,10),
	(25,304,128),
	(26,304,10),
	(27,304,128),
	(28,304,10),
	(29,304,145),
	(30,304,10),
	(0,305,4),
	(31,305,77),
	(32,305,4),
	(33,305,230),
	(34,305,4),
	(35,305,230),
	(0,306,8),
	(36,306,171),
	(37,306,8),
	(38,306,171),
	(39,306,224),
	(40,306,8),
	(0,307,13),
	(41,307,298),
	(42,307,13),
	(43,307,273),
	(44,307,13),
	(0,308,15),
	(45,308,67),
	(46,308,15),
	(0,309,11),
	(47,309,82),
    (48,309,11),
	(49,309,82),
	(0,310,16),
	(50,310,101),
	(51,310,16),
	(52,310,113),
	(53,310,16),
	(54,310,201),
	(55,310,16);