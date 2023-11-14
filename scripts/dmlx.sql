TABLA PRODUCTO insert

-- CREATE TABLE producto (
--     numero_articulo SERIAL PRIMARY KEY,
--     es_nuevo BOOLEAN NOT NULL,
--     precio_unitario NUMERIC(10, 2) NOT NULL,
--     detalle VARCHAR(255) NULL,
--     descripcion_producto TEXT NULL,
--     nombre_producto VARCHAR(255) NOT NULL,
--     stock INT NOT NULL,
--     calificacion INT NOT NULL CHECK (calificacion >= 1 AND calificacion <= 5),
--     usuario INT NOT NULL REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE
-- );

INSERT INTO producto VALUES
	(FALSE, 19530.00, 'Lámpara de escritorio', 'Lámpara de escritorio moderna con base de madera', 'Lámpara de escritorio', 20, 4, 18),
	(TRUE, 519999.99, 'Samsung Galaxy S23 Fe 256gb 8gb Ram Negro', 'Procesador y memoria RAM de 8 GB, alcanzará un alto rendimiento con gran velocidad y memoria interna de 256 GB.', 'Samsung Galaxy S23 Fe', 50, 5, 5),
	(FALSE, 30990.00, 'Mesa auxiliar', 'Mesa auxiliar redonda de metal con acabado dorado','Mesa auxiliar dorada', 2, 3, 7),
	(TRUE, 569999.99, 'Notebook Ryzen 7 Asus Vivobook Amd 512gb Ssd 16gb Ram', 'ASUS VivoBook 15 39,6 cm (15.6") Full HD AMD Ryzen 7 5800H 16 GB DDR4-SDRAM 512 GB SSD Wi-Fi 6E (802.11ax) Windows 11 Home Quiet Blue', 'Notebook Ryzen 7 Asus Vivobook', 10, 4, 10),
	(TRUE, 13999,99, 'Reloj Unisex Gadnic Alarma Cronometro Elegante Digital Color de la malla Negro', 'Reloj de pulsera resistente al agua con malla negra', 'Reloj Unisex Gadnic', 30, 5, 4),
	(TRUE, 259999.00, 'Smart TV LG Smart TV 43ur8750 ', 'Televisor LED WebOS  de 44 pulgadas con resolución 4K UHD 220V', 'Smart TV LG Smart TV 43ur8750' , 5, 5, 8),
	(FALSE, 45000.00, 'Silla de comedor', 'Silla de comedor moderna y ergonómica', 'Silla de comedor ergonómica', 4, 3, 13),
	(FALSE, 60500.00, 'Mesa de centro', 'Mesa de centro de madera maciza con cajones de almacenamiento', 'Mesa de centro moderna', 1, 4, 15),
	(TRUE, 28999.00, 'Parlante Philco Djp10p Portátil Con Bluetooth 220v', 'Altavoz Bluetooth portátil con batería de larga duración', 'Parlante Philco Djp10p', 40, 4, 11),
	(FALSE, 30000.00, 'Auriculares inalámbricos', 'Auriculares inalámbricos con cancelación de ruido', 'AirPods Pro 2da Generación', 1, 5, 16);

TABLA PREGUNTA insert

INSERT INTO pregunta VALUE
(1,'¿La lámpara de escritorio incluye la bombilla?', '2020-09-01'),
(2,'Hola, no. Cualquier otra consulta estoy a su disposición', '2020-09-01'),
(3,'Bombita De cuantos w soporta el artefacto ? El portalámparas es universal ?', '2020-09-01'),
(4,'Hola! Es el portalámparas convencional a rosca comúnmente denominado E27 Máximo 60w...cuando normalmente se utilizan lámparas entre 9w y 12w de led que te representan entre 60 a 75w de las antiguas lámparas incandescentes Saludos','2020-09-02'),
(5,'¿La lámpara de escritorio tiene ajuste de intensidad de luz?', '2020-09-17'),
(6,'Hola! No, no tiene ajuste de la intensidad de luz. Saludos', '2020-09-18'),
(7,'¿Viene con garantía el Samsung Galaxy S23 Fe?', '2023-05-02'),
(8,'¡Hola!Si viene con garantía. ¡Gracias por su consulta! Saludos.', '2023-05-02'),
(9,'Hola, ¿ tiene carga inalámbrica el Samsung Galaxy S23 Fe?', '2023-05-12'),
(10,'Hola, esperamos se encuentre bien. Le informamos que el Samsung Galaxy S23 Fe 128gb 8gb Ram Violeta posee: 3.900 mAh-Carga rápida de 25 W-Carga inalámbrica de 10 W. Quedamos a disposición. ¡Gracias por su consulta! Saludos.', '2023-05-13'),
(11,'¿El Samsung Galaxy S23 Fe tiene ranura para tarjeta de memoria externa?', '2023-07-18'),
(12,'Hola, esperamos se encuentre bien. Le informamos que el Samsung Galaxy S23 Fe 128gb 8gb Ram Violeta si tiene ranura para tarjeta de memoria externa. Quedamos a disposición. ¡Gracias por su consulta! Saludos.', '2023-05-13'),
(13,'¿Cuál es el diámetro de la mesa auxiliar?', '2021-11-03'),
(14,'Hola! El diámetro es de 41cm x 53cm de altura. Saludos', '2021-11-03'),
(15,'¿La mesa auxiliar requiere montaje?', '2021-11-12'),
(16,'Hola! La mesa no requiere montaje', '2021-11-12'),
(17,'¿Tiene la notebook Ryzen 7 Asus Vivobook teclado retroiluminado?', '2022-12-24'),
(18,'Hola, muchas gracias por su consulta. Sí, cuenta con teclado retroiluminado. Cualquier otra duda quedamos a su disposición.', '2022-12-25'),
(19,'Hola, ¿Sirve para  diseño 3D? La notebook Ryzen 7 Asus Vivobook', '2023-08-11'),
(20,'Hola, muchas gracias por su consulta. Sí te sirve. Cualquier otra duda quedamos a su disposición.', '2023-08-11'),
(21,'¿La notebook Ryzen 7 Asus Vivobook tiene teclado numérico?', '2023-05-25'),
(22,'Hola, muchas gracias por su consulta. Sí tiene. Cualquier otra duda quedamos a su disposición.', '2023-05-26'),
(23,'¿Es tactil el reloj unisex Gadnic?', '2022-10-05'),
(24,'Hola ¿Cómo estás? Es con pantalla táctil. Estamos online las 24 horas para brindarte la mejor atención y responder todas tus consultas Saludos.', '2022-10-05'),
(25,'¿Es fuerte la malla?', '2022-10-05'),
(26,'Hola ¿Cómo estás? Si claro, la malla es super resistente.Estamos online las 24 horas para brindarte la mejor atención y responder todas tus consultas Saludos.', '2022-10-06'),
(27,'¿Viene con soporte de montaje en pared el Smart TV LG Smart TV 43ur8750?', '2023-04-06'),
(28,'Hola! no está incluido. Saludos.', '2023-04-06'),
(29,'¿El televisor LG Smart TV 43ur8750 trae control remoto?', '2022-11-27'),
(30,'Hola! SI Saludos.', '2022-11-27'),
(31,'¿Se venden las sillas de comedor por separado?', '2019-01-07'),
(32,'Hola, no se vende por separado. Saludos', '2019-01-07'),
(33,'¿La silla de comedor es ajustable en altura?', '2019-02-08'),
(34,'Hola, no es ajustable. Saludos', '2019-02-09'),
(35,'¿Viene ensamblada la mesa de centro o requiere montaje?', '2023-04-08'),
(36,'Hola, viene ensamblada. Saludos', '2023-04-09'),
(37,'Hola, ¿Es stereo? ¿Y cuanto dura la batería aprox del parlante Philco Djp10p?', '2021-11-09'),
(38,'Hola. Te confirmamos que si es estéreo y la duración de la batería depende del uso que se le dé al producto. Aguardamos tu compra. Saludos', '2021-11-09'),
(39,'¿Viene con estuche de carga los auriculares inalámbricos AirPods Pro 2da Generación?', '2022-06-10'),
(40,'Hola y gracias por comunicarnos!Si trae estuche de carga. Quedamos a disposición, saludo ', '2022-06-11'),
(41,'¿Los auriculares inalámbricos AirPods Pro 2da Generación son compatibles con Android?', '2023-03-15'),
(42,'Hola, ¿cómo estás? Muchas gracias por contactarnos. No es compatible, desde ya muchas gracias y saludos.', '2023-03-16')
(43,'¿Los auriculares inalámbricos tienen cancelación activa de ruido?', '2023-03-20'),
(44,'Hola, ¿cómo estás? Muchas gracias por contactarnos. Si tienen cancelación de ruido, desde ya muchas gracias y saludos.', '2023-03-21');


INSERT INTO pregunta_respuesta VALUES
(1, 2),
(3, 4),
(5, 6),
(7, 8),
(9, 10),
(11, 12),
(13, 14),
(15, 16),
(17, 18),
(19, 20),
(21, 22),
(23, 24),
(25, 26),
(27, 28),
(29, 30),
(31, 32),
(33, 34),
(35, 36),
(37, 38),
(39, 40),
(41, 42),
(43, 44);

Tabla de 10

INSERT INTO producto_categoria VALUES
   (1, 5),  -- Lámpara de escritorio - Hogar
   (2, 1),  -- Samsung Galaxy S23 Fe - Electrónica
   (3, 5),  -- Mesa auxiliar - Hogar
   (4, 1), -- Notebook Ryzen 7 Asus Vivobook - Electrónica
   (5, 20), -- Reloj Unisex Gadnic - Joyas y Relojes
   (6, 1),  -- Smart TV LG Smart TV 43ur8750 - Electrónica
   (7, 11), -- Silla de comedor - Muebles
   (8, 11), -- Mesa de centro - Muebles
  (9, 16), -- Parlante Philco Djp10p - Electrónica de Consumo
   (10, 1); -- Auriculares inalámbricos - Electrónica

INSERT INTO public.usuario (correo_electronico,telefono,contrasenia) VALUES
	 ('mateo-valentingonzalez@example.org','+54 15 2478 3070','DSZfSzhrim'),
	 ('emma58@example.com','+54 15 2688 2193','xgGgdbILCz'),
	 ('bautistajuarez@example.org','+54 9 3515 3783','nLkTYGRjHh'),
	 ('vledesma@example.com','+54 9 3111 4287','sJjUhVGaeo'),
	 ('jsosa@example.com','+54 15 2677 1866','xTTNATwTZr'),
	 ('emmaperez@example.com','+54 15 2820 3943','VlDREUqCpP'),
	 ('juan-bautistabustos@example.org','+54 9 3656 3677','kovETfLBfq'),
	 ('benitezfaustino@example.com','+54 15 2202 5052','xDKqfJaNaA'),
	 ('bgutierrez@example.com','+54 9 3518 9952','tgFYouXoiK'),
	 ('santino28@example.org','+54 9 3216 3609','hQekhmMUxt'),
	 ('ayalamaia@example.net','+54 15 2599 9923','RrdbUsZUrb'),
	 ('mendezian-ezequiel@example.com','+54 9 3246 4753','ekObTHOYwn'),
	 ('juan05@example.net','+54 15 2493 7158','bMRgADGWwF'),
	 ('isabellaramirez@example.com','+54 9 3729 2299','pdEhbcRvSn'),
	 ('tizianodiaz@example.net','+54 15 2382 7985','KjZDrozFmq'),
	 ('emilia16@example.org','+54 15 2323 1094','VqnUTFxdtp'),
	 ('juana85@example.net','+54 15 2627 8040','qHrUSjElfA'),
	 ('vgonzalez@example.net','+54 15 2724 4917','rYNKGFVPdC'),
	 ('maldonadojuan-bautista@example.net','+54 9 3459 0566','iYCGAKPKcp'),
	 ('gonzalezbenjamin@example.net','+54 15 2930 4438','fTzOnEHEFg');


Usuarios que usare:

INSERT INTO public.usuario (correo_electronico,telefono,contrasenia) VALUES
PARTICULAR
1	 ('mateo-valentingonzalez@example.org','+54 15 2478 3070','DSZfSzhrim'),
2	 ('emma58@example.com','+54 15 2688 2193','xgGgdbILCz'),
4	 ('vledesma@example.com','+54 9 3111 4287','sJjUhVGaeo'),
5	 ('jsosa@example.com','+54 15 2677 1866','xTTNATwTZr'),
8	 ('benitezfaustino@example.com','+54 15 2202 5052','xDKqfJaNaA'),
10	 ('santino28@example.org','+54 9 3216 3609','hQekhmMUxt'),
11	 ('ayalamaia@example.net','+54 15 2599 9923','RrdbUsZUrb'),
12	 ('mendezian-ezequiel@example.com','+54 9 3246 4753','ekObTHOYwn'),
14	 ('isabellaramirez@example.com','+54 9 3729 2299','pdEhbcRvSn'),
17	 ('juana85@example.net','+54 15 2627 8040','qHrUSjElfA'),
18	 ('vgonzalez@example.net','+54 15 2724 4917','rYNKGFVPdC'),

EMPRESA
7	 ('juan-bautistabustos@example.org','+54 9 3656 3677','kovETfLBfq'),
13	 ('juan05@example.net','+54 15 2493 7158','bMRgADGWwF'),
15	 ('tizianodiaz@example.net','+54 15 2382 7985','KjZDrozFmq'),
16	 ('emilia16@example.org','+54 15 2323 1094','VqnUTFxdtp'),
	

INSERT INTO pregunta_producto_usuario (pregunta, producto, usuario) VALUES
	(1,1,17),
	(2,1,18),
	(3,1,17),
	(4,1,18),
	(5,1,14),
	(6,1,18),
	(7,2,12),
	(8,2,5),
	(9,2,12),
	(10,2,5),
	(11,2,1),
	(12,2,5),
	(13,3,2),
	(14,3,7),
	(15,3,2),
	(16,3,7),
	(17,4,1),
(18,4,10),
	(19,4,17),
	(20,4,10),
	(21,4,17),
	(22,4,10),
	(23,5,14),
	(24,5,4),
	(25,5,14),
	(26,5,4),
	(27,6,1),
	(28,6,8),
	(29,6,1),
	(30,6,8),
	(31,7,4),
	(32,7,13),
	(33,7,4),
	(34,7,13),
	(35,8,18),
	(36,8,15),
	(37,9,5),
	(38,9,15),
	(39,10,7),
	(40,10,11),
	(41,10,10),
	(42,10,11),
	(43,10,4),
	(44,10,11);




