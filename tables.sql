CREATE TABLE usuario (
	numero_cliente serial NOT NULL PRIMARY KEY,
	correo_electronico VARCHAR(255) UNIQUE NOT NULL,
	telefono VARCHAR(15) UNIQUE NOT NULL,
	contraseña VARCHAR(255) NOT NULL
);

CREATE TABLE empresa (
    usuario INT NOT NULL PRIMARY KEY REFERENCES usuario(numero_cliente),
    CUIT VARCHAR(15) NOT NULL UNIQUE,
    nombre_fantasia VARCHAR(255) NOT NULL UNIQUE,
    fecha_creacion DATE NOT NULL 
);

CREATE TABLE particular (
    usuario INT NOT NULL PRIMARY KEY REFERENCES usuario(numero_cliente),
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
    numero_tarjeta VARCHAR(20) NOT NULL UNIQUE,
    clave_seguridad VARCHAR(10) NOT NULL,
    fecha_caducidad DATE NOT NULL,
    empresa_emisora VARCHAR(255) NOT NULL, /* hay que agregar check */
    tipo VARCHAR(255) NOT NULL, /* hay que agregar check */
    usuario INT NOT NULL REFERENCES usuario(numero_cliente)
);

CREATE TABLE producto (
    numero_articulo SERIAL PRIMARY KEY,
    es_nuevo BOOLEAN NOT NULL,
    precio_unitario NUMERIC(10, 2) NOT NULL,
    detalle VARCHAR(255) NULL,
    descripcion_producto TEXT NULL,
    nombre_producto VARCHAR(255) NOT NULL,
    stock INT NOT NULL,
    calificacion INT NOT NULL, /* hay que agregar check */
    usuario INT NOT NULL REFERENCES usuario(numero_cliente)
);

CREATE TABLE categoria (
    id_categoria SERIAL NOT NULL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE categoria_subcategoria (
    tiene_categoria INT NOT NULL REFERENCES categoria(id_categoria),
    es_subcategoria INT NOT NULL REFERENCES categoria(id_categoria),
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
    producto INT NOT NULL REFERENCES producto(numero_articulo),
    imagen VARCHAR(255) NOT NULL,
    PRIMARY KEY (producto, imagen)
);

CREATE TABLE envio (
    id_envio SERIAL NOT NULL PRIMARY KEY,
    tipo_envio VARCHAR(255) NOT NULL 
);

CREATE TABLE resenia (
    id_reseña SERIAL NOT NULL PRIMARY KEY,
    reseña_producto TEXT NOT NULL,
    calificacion INT NOT NULL,
    producto INT NOT NULL REFERENCES producto(numero_articulo)
);

CREATE TABLE pedido (
    numero_de_pedido SERIAL NOT NULL PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    metodo_pago INT NOT NULL REFERENCES metodo_de_pago(id_tarjeta),
    particular INT NOT NULL REFERENCES particular(usuario),
    resenia INT NOT NULL REFERENCES resenia(id_reseña)
);

CREATE TABLE item (
    id_item SERIAL PRIMARY KEY,
    cantidad INT NOT null,
    estado VARCHAR(255) NOT NULL, /* hay que agregar check */
    tipo_entrega VARCHAR(255) NOT NULL,
    envio_domicilio BOOLEAN NOT NULL,
    usuario INT NOT NULL REFERENCES usuario(numero_cliente),
    producto INT NOT NULL REFERENCES producto(numero_articulo),
    direccion INT NOT NULL REFERENCES direccion(id_direccion),
    pedido INT NOT NULL REFERENCES pedido(numero_de_pedido)
);

CREATE TABLE usuario_direccion (
    usuario INT NOT NULL REFERENCES usuario(numero_cliente),
    direccion INT NOT NULL REFERENCES direccion(id_direccion),
    PRIMARY KEY (usuario, direccion)
);

CREATE TABLE item_envio (
    item INT NOT NULL PRIMARY KEY REFERENCES item(id_item),
    envio INT NOT NULL REFERENCES envio(id_envio)
);

CREATE TABLE pregunta_producto_usuario (
    pregunta INT NOT NULL REFERENCES pregunta(id_pregunta),
    producto INT NOT NULL REFERENCES producto(numero_articulo),
    usuario INT NOT NULL REFERENCES usuario(numero_cliente),
    PRIMARY KEY (pregunta, producto, usuario)
);

CREATE TABLE producto_categoria (
    producto INT NOT NULL REFERENCES producto(numero_articulo),
    categoria INT NOT NULL REFERENCES categoria(id_categoria),
    PRIMARY KEY (producto, categoria)
);

CREATE TABLE pregunta_respuesta (
    pregunta INT NOT NULL REFERENCES pregunta(id_pregunta),
    respuesta INT NOT NULL REFERENCES pregunta(id_pregunta),
    PRIMARY KEY (pregunta, respuesta)
);

CREATE TABLE oferta_producto (
    oferta INT NOT NULL REFERENCES oferta(id_oferta),
    producto INT NOT NULL REFERENCES producto(numero_articulo),
    PRIMARY KEY (oferta, producto)
);



