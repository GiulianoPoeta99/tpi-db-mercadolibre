# extern
from colorama import init, Fore
import psycopg2
from time import sleep

# interm
from connection import *
from components.createDataBase import *
from components.tables import *

# PLANTILLA

# tabla table_name
# numberTable += 1
# table = 'table_name'
# values = 'attr1, attr2, attr2'
# dataFunction = fakeTableNameData # nombre de la funcion hecha en fakerData
# minQuantity = 100
# maxQuantity = minQuantity # si se hace con esto se da a entender que es el mismo numero por lo tanto no hay intervalo
# warning = True/False # se escribe un mensaje de advertencia del paso anterior 
# # ¡No se toca!
# fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# Inicializa colorama para sistemas Windows
init(autoreset=True)

# Crear una conexión a la base de datos y habilitamos el cursor
connection = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT)
cursor = connection.cursor()

# creamos la bd si se solicita
clearScreen()
print('Quiere crear la base de datos?')
createDatabase = ''
while ((createDatabase != 's') & (createDatabase != 'n')):
    createDatabase = input(YES_NO + '\n')

clearScreen()
if (createDatabase == 's'):
    createDataBase(connection, cursor)

numberTable = 0

# tabla usuario
numberTable += 1
table = 'usuario'
values = 'correo_electronico, telefono, contrasenia'
dataFunction = fakeUserData
minQuantity = 100
maxQuantity = 5000
warning = True
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla empresa
numberTable += 1
table = 'empresa'
values = 'usuario, cuit, nombre_fantasia, fecha_creacion'
dataFunction = fakeCorporateData
minQuantity = 100
maxQuantity = minQuantity
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla particular
numberTable += 1
table = 'particular'
values = 'usuario, DNI, fecha_nacimiento, nombre, apellido'
dataFunction = fakeParticularData
minQuantity = len(getUsersNotCorporate(cursor))
maxQuantity = minQuantity
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla direccion
numberTable += 1
table = 'direccion'
values = 'codigo_postal, calle, altura'
dataFunction = fakeAdressData
minQuantity = 100
maxQuantity = 500
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla metodo_de_pago
numberTable += 1
table = 'metodo_de_pago'
values = 'titular, numero_tarjeta, clave_seguridad, fecha_caducidad, empresa_emisora, tipo, usuario'
dataFunction = fakePaymentMethodData
minQuantity = 100
maxQuantity = 500
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla producto
# CREATE TABLE producto (
#     numero_articulo SERIAL PRIMARY KEY,
#     es_nuevo BOOLEAN NOT NULL,
#     precio_unitario NUMERIC(10, 2) NOT NULL,
#     detalle VARCHAR(255) NULL,
#     descripcion_producto TEXT NULL,
#     nombre_producto VARCHAR(255) NOT NULL,
#     stock INT NOT NULL,
#     calificacion INT NOT NULL CHECK (calificacion >= 1 AND calificacion <= 5),
#     usuario INT NOT NULL REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE
# );

# tabla categoria
numberTable += 1
print('La tabla categoria para hacer la muestra se carga manualmente.\n\n')
sleep(2)

# tabla categoria_subcateoria
numberTable += 1
print('La tabla categoria_subcategoria para hacer la muestra se carga manualmente.\n\n')
sleep(2)

# tabla oferta
numberTable += 1
table = 'oferta'
values = 'porcentaje, fecha_desde, fecha_hasta'
dataFunction = fakeOfertData
minQuantity = 100
maxQuantity = 500
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# CREATE TABLE pregunta (
#     id_pregunta SERIAL NOT NULL PRIMARY KEY,
#     preguntas_del_producto TEXT NOT NULL,
#     fecha_de_la_pregunta DATE NOT NULL
# );

# CREATE TABLE imagen (
#     producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE,
#     imagen VARCHAR(255) NOT NULL,
#     PRIMARY KEY (producto, imagen)
# );

# CREATE TABLE envio (
#     id_envio SERIAL NOT NULL PRIMARY KEY,
#     tipo_envio VARCHAR(255) NOT NULL 
# );

# CREATE TABLE resenia (
#     id_resenia SERIAL NOT NULL PRIMARY KEY,
#     resenia_producto TEXT NOT NULL,
#     calificacion INT NOT NULL,
#     producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE
# );

# CREATE TABLE pedido (
#     numero_de_pedido SERIAL NOT NULL PRIMARY KEY,
#     fecha_pedido DATE NOT NULL,
#     metodo_pago INT NOT NULL REFERENCES metodo_de_pago(id_tarjeta) ON DELETE RESTRICT ON UPDATE CASCADE,
#     particular INT NOT NULL REFERENCES particular(usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
#     resenia INT NOT NULL REFERENCES resenia(id_resenia) ON DELETE RESTRICT ON UPDATE CASCADE
# );

# CREATE TABLE item (
#     id_item SERIAL PRIMARY KEY,
#     cantidad INT NOT null,
#     estado VARCHAR(255) NOT NULL CHECK (estado IN ('Preparando el envio', 'Listo para enviar', 'Enviado', 'Recibido')),
#     tipo_entrega VARCHAR(255) NOT NULL,
#     envio_domicilio BOOLEAN NOT NULL,
#     usuario INT NOT NULL REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
#     producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE,
#     direccion INT NOT NULL REFERENCES direccion(id_direccion) ON DELETE RESTRICT ON UPDATE CASCADE,
#     pedido INT NOT NULL REFERENCES pedido(numero_de_pedido) ON DELETE RESTRICT ON UPDATE CASCADE
# );

# CREATE TABLE usuario_direccion (
#     usuario INT NOT NULL REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
#     direccion INT NOT NULL REFERENCES direccion(id_direccion) ON DELETE RESTRICT ON UPDATE CASCADE,
#     PRIMARY KEY (usuario, direccion)
# );

# CREATE TABLE item_envio (
#     item INT NOT NULL PRIMARY KEY REFERENCES item(id_item) ON DELETE RESTRICT ON UPDATE CASCADE,
#     envio INT NOT NULL REFERENCES envio(id_envio) ON DELETE RESTRICT ON UPDATE CASCADE
# );

# CREATE TABLE pregunta_producto_usuario (
#     pregunta INT NOT NULL REFERENCES pregunta(id_pregunta) ON DELETE RESTRICT ON UPDATE CASCADE,
#     producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE,
#     usuario INT NOT NULL REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
#     PRIMARY KEY (pregunta, producto, usuario)
# );

# CREATE TABLE producto_categoria (
#     producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE,
#     categoria INT NOT NULL REFERENCES categoria(id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE,
#     PRIMARY KEY (producto, categoria)
# );

# CREATE TABLE pregunta_respuesta (
#     pregunta INT NOT NULL REFERENCES pregunta(id_pregunta) ON DELETE RESTRICT ON UPDATE CASCADE,
#     respuesta INT NOT NULL REFERENCES pregunta(id_pregunta) ON DELETE RESTRICT ON UPDATE CASCADE,
#     PRIMARY KEY (pregunta, respuesta)
# );

# CREATE TABLE oferta_producto (
#     oferta INT NOT NULL REFERENCES oferta(id_oferta) ON DELETE RESTRICT ON UPDATE CASCADE,
#     producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE,
#     PRIMARY KEY (oferta, producto)
# );

sleep(3)
clearScreen()
sleep(1)
print(Fore.GREEN + "✔ - La base de datos fue poblada exitosamente. - ✔")
sleep(0.10)

connection.commit()
cursor.close()
connection.close()


