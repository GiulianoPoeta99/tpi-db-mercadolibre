CREATE TABLE usuario (
	numero_cliente serial NOT NULL PRIMARY KEY,
	correo_electronico VARCHAR(255) UNIQUE NOT NULL,
	telefono VARCHAR(20) UNIQUE NOT NULL,
	contrasenia VARCHAR(255) NOT NULL
);

CREATE TABLE empresa (
    usuario INT NOT NULL PRIMARY KEY REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    cuit VARCHAR(15) NOT NULL UNIQUE,
    nombre_fantasia VARCHAR(255) NOT NULL UNIQUE,
    fecha_creacion DATE NOT NULL 
);

CREATE TABLE particular (
    usuario INT NOT NULL PRIMARY KEY REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    DNI VARCHAR(15) NOT NULL UNIQUE,
    fecha_nacimiento DATE NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL
);

CREATE TABLE direccion (
    id_direccion SERIAL PRIMARY KEY,
    codigo_postal VARCHAR(10) NOT NULL,
    calle VARCHAR(255) NOT NULL,
    altura INT NOT NULL,
    CONSTRAINT direccion_unique UNIQUE (codigo_postal, calle, altura)
);

CREATE TABLE metodo_de_pago (
    id_tarjeta SERIAL PRIMARY KEY,
    titular VARCHAR(255) NOT NULL,
    numero_tarjeta VARCHAR(16) NOT NULL UNIQUE,
    clave_seguridad VARCHAR(10) NOT NULL,
    fecha_caducidad DATE NOT NULL,
    empresa_emisora VARCHAR(255) NOT NULL CHECK (empresa_emisora IN ('Visa', 'MasterCard', 'American Express', 'Maestro')),
    tipo VARCHAR(255) NOT NULL CHECK (tipo IN ('Crédito', 'Debito')),
    usuario INT NOT NULL REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE producto (
    numero_articulo SERIAL PRIMARY KEY,
    es_nuevo BOOLEAN NOT NULL,
    precio_unitario NUMERIC(10, 2) NOT NULL,
    detalle VARCHAR(255) NULL,
    descripcion_producto TEXT NULL,
    nombre_producto VARCHAR(255) NOT NULL,
    stock INT NOT NULL,
    calificacion INT NOT NULL CHECK (calificacion >= 1 AND calificacion <= 5)
);

CREATE TABLE categoria (
    id_categoria SERIAL NOT NULL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE categoria_subcategoria (
    tiene_categoria INT NOT NULL REFERENCES categoria(id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE,
    es_subcategoria INT NOT NULL REFERENCES categoria(id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (tiene_categoria, es_subcategoria)
);

CREATE TABLE oferta (
    id_oferta SERIAL NOT NULL PRIMARY KEY,
    porcentaje NUMERIC(5, 2) NOT NULL,
    fecha_desde DATE NOT NULL,
    fecha_hasta DATE NOT NULL
);

CREATE TABLE pregunta (
    id_pregunta SERIAL NOT NULL PRIMARY KEY,
    preguntas_del_producto TEXT NOT NULL,
    fecha_de_la_pregunta DATE NOT NULL
);

CREATE TABLE imagen (
    producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE,
    imagen VARCHAR(255) NOT NULL,
    PRIMARY KEY (producto, imagen)
);

CREATE TABLE envio (
    id_envio SERIAL NOT NULL PRIMARY KEY,
    tipo_envio VARCHAR(255) NOT NULL CHECK (tipo_envio IN ('envio rapido','envio normal a domicilio', 'envio a correo', 'retiro en sucursal'))
);

CREATE TABLE resenia (
    id_resenia SERIAL NOT NULL PRIMARY KEY,
    resenia_producto TEXT NOT NULL,
    calificacion INT NOT NULL,
    producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE pedido (
    numero_de_pedido SERIAL NOT NULL PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    metodo_pago INT NOT NULL REFERENCES metodo_de_pago(id_tarjeta) ON DELETE RESTRICT ON UPDATE CASCADE,
    particular INT NOT NULL REFERENCES particular(usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    resenia INT NOT NULL REFERENCES resenia(id_resenia) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE item (
    id_item SERIAL PRIMARY KEY,
    cantidad INT NOT null,
    estado VARCHAR(255) NOT NULL CHECK (estado IN ('Preparando el envio', 'Listo para enviar', 'Enviado', 'Recibido')),
    tipo_entrega VARCHAR(255) NOT NULL,
    envio_domicilio BOOLEAN NOT NULL,
    usuario INT NOT NULL REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE,
    direccion INT NOT NULL REFERENCES direccion(id_direccion) ON DELETE RESTRICT ON UPDATE CASCADE,
    pedido INT NOT NULL REFERENCES pedido(numero_de_pedido) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE usuario_direccion (
    usuario INT NOT NULL REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    direccion INT NOT NULL REFERENCES direccion(id_direccion) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (usuario, direccion)
);

CREATE TABLE item_envio (
    item INT NOT NULL PRIMARY KEY REFERENCES item(id_item) ON DELETE RESTRICT ON UPDATE CASCADE,
    envio INT NOT NULL REFERENCES envio(id_envio) ON DELETE RESTRICT ON UPDATE CASCADE 
);

CREATE TABLE pregunta_producto_usuario (
    pregunta INT NOT NULL REFERENCES pregunta(id_pregunta) ON DELETE RESTRICT ON UPDATE CASCADE,
    producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE,
    usuario INT NOT NULL REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (pregunta, producto, usuario)
);

CREATE TABLE producto_categoria (
    producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE,
    categoria INT NOT NULL REFERENCES categoria(id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (producto, categoria)
);

CREATE TABLE pregunta_respuesta (
    pregunta INT NOT NULL REFERENCES pregunta(id_pregunta) ON DELETE RESTRICT ON UPDATE CASCADE,
    respuesta INT NOT NULL REFERENCES pregunta(id_pregunta) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (pregunta, respuesta)
);

CREATE TABLE oferta_producto (
    oferta INT NOT NULL REFERENCES oferta(id_oferta) ON DELETE RESTRICT ON UPDATE CASCADE,
    producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (oferta, producto)
);

CREATE VIEW getCalificacionPromedio AS
SELECT 
	p.numero_articulo,
	-- count(r.calificacion)AS cantidad,
	CASE 
		WHEN avg(r.calificacion) IS NULL THEN 0.00
		ELSE avg(r.calificacion)
	END AS promedio
FROM producto AS p
LEFT JOIN resenia AS r ON (p.numero_articulo = r.producto)
GROUP BY p.numero_articulo
ORDER BY p.numero_articulo ASC;

CREATE VIEW montos_item AS -- esta vista sirve para obtener total de item
SELECT
    i.pedido,
	CASE
   	 WHEN e.tipo_envio = 'envio rapido' THEN  i.cantidad * p.precio_unitario + 400
   	 WHEN e.tipo_envio = 'envio normal a domicilio' THEN i.cantidad * p.precio_unitario + 200
   	 WHEN e.tipo_envio = 'envio a correo' THEN i.cantidad * p.precio_unitario + 150
   	 WHEN e.tipo_envio = 'retiro en sucursal' THEN i.cantidad * p.precio_unitario
	END AS monto  --momento hardcoder
FROM
	item AS i
INNER JOIN producto AS p ON (i.producto = p.numero_articulo)
INNER JOIN item_envio AS ie ON (ie.item  = i.id_item)  
INNER JOIN envio AS e ON (e.id_envio = ie.envio)
GROUP BY monto, i.pedido
ORDER by pedido ASC;

CREATE VIEW producto_detallado as
SELECT 
	p.numero_articulo,
	p.precio_unitario AS precio,
	p.detalle AS nombre_producto,
	p.descripcion_producto,
	concat(u.numero_cliente,' - ',u.nombre) AS vendedor,
	p.es_nuevo,
	p.stock,
	CASE 
		WHEN i.cantidad_vendido IS NULL THEN 0
		ELSE i.cantidad_vendido
	END,
	cp.promedio AS calificacion,
	pc.categorias,
	p2.cantidad_preguntas,
	p2.preguntas,
	count(r.resenia_producto) AS cantidad_resenias,
	CASE 
		WHEN count(r.resenia_producto) != 0 THEN array_agg(r.resenia_producto)
		ELSE null
	END AS resenias
FROM producto p
-- traemos los usuarios publicadores
LEFT JOIN (
	SELECT *
	FROM pregunta_producto_usuario
	WHERE pregunta = 0
) AS ppu ON (p.numero_articulo = ppu.producto)
-- traemos el nombre y tipo de usuario
LEFT JOIN (
	SELECT 
		u2.*,
		CASE 
			WHEN e.usuario IS NOT NULL AND p.usuario IS NULL THEN e.nombre_fantasia
			WHEN p.usuario IS NOT NULL AND e.usuario IS NULL THEN concat_ws(' ', p.nombre, p.apellido)
		END AS nombre
	FROM usuario AS u2
		LEFT JOIN empresa AS e ON (u2.numero_cliente = e.usuario)
		LEFT JOIN particular AS p ON (u2.numero_cliente = p.usuario)
) AS u ON (ppu.usuario = u.numero_cliente)
-- traemos el promedio de la calificacion
LEFT JOIN getCalificacionPromedio AS cp ON (p.numero_articulo = cp.numero_articulo)
-- traemos todas las resenias del producto
LEFT JOIN resenia AS r ON (p.numero_articulo = r.producto)
-- traemos todas las preguntas del producto
LEFT JOIN (
	SELECT
		p.numero_articulo,
		count(p2.id_pregunta) AS cantidad_preguntas,
		CASE 
			WHEN count(p2.preguntas_del_producto) != 0 THEN array_agg(
					CASE 
						WHEN p2.id_pregunta != 0 THEN concat(p2.id_pregunta, ' - ', p2.preguntas_del_producto)
					END
				)
			ELSE null
		END AS preguntas
	FROM producto p
	LEFT JOIN pregunta_producto_usuario AS ppu ON (p.numero_articulo = ppu.producto)
	LEFT JOIN (
		SELECT *
		FROM pregunta
		WHERE id_pregunta != 0
	) AS p2 ON (ppu.pregunta = p2.id_pregunta)
	GROUP BY p.numero_articulo
	ORDER BY p.numero_articulo ASC
) AS p2 ON (ppu.producto = p2.numero_articulo)
-- tabla intermedia con categoria
-- traemos las categorias del producto
LEFT JOIN (
	SELECT 
		pc.producto,
		CASE 
			WHEN count(c.nombre) != 0 THEN array_agg(c.nombre)
			ELSE null
		END AS categorias
	FROM producto_categoria AS pc
	LEFT JOIN categoria AS c ON (pc.categoria = c.id_categoria)
	GROUP BY pc.producto
) AS pc ON (p.numero_articulo = pc.producto)
LEFT JOIN (
	SELECT 
		p.numero_articulo,
		count(i.id_item) AS cantidad_vendido
	FROM producto AS p 
	LEFT JOIN item AS i ON (p.numero_articulo = i.producto)
	INNER JOIN pedido AS p2 ON (i.pedido = p2.numero_de_pedido)
	GROUP BY p.numero_articulo
	ORDER BY p.numero_articulo ASC
) AS i ON (p.numero_articulo = i.numero_articulo)
GROUP BY 
	p.numero_articulo,
	u.numero_cliente,
	u.nombre,
	cp.promedio,
	pc.categorias,
	p2.cantidad_preguntas,
	p2.preguntas,
	i.cantidad_vendido
ORDER BY p.numero_articulo;