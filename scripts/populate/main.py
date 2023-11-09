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
maxQuantity = len(getUsers(cursor)) *2
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla metodo_de_pago
numberTable += 1
table = 'metodo_de_pago'
values = 'titular, numero_tarjeta, clave_seguridad, fecha_caducidad, empresa_emisora, tipo, usuario'
dataFunction = fakePaymentMethodData
minQuantity = 100
maxQuantity = 10000
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

#tabla producto
numberTable += 1
table = 'producto'
values = 'es_nuevo, precio_unitario, detalle, descripcion_producto, nombre_producto, stock, calificacion, usuario'
dataFunction = fakeProductData # nombre de la funcion hecha en fakerData
minProductQuantity = 300
maxQuantity = 3000 # si se hace con esto se da a entender que es el mismo numero por lo tanto no hay intervalo
warning = False # se escribe un mensaje de advertencia del paso anterior 
# ¡No se toca!
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)
# 

# tabla categoria
numberTable += 1
table = 'categoria'
notFillTable(table)
sleep(2)

# tabla categoria_subcateoria
numberTable += 1
table = 'categoria_subcateoria'
notFillTable(table)
sleep(2)

# tabla oferta
numberTable += 1
table = 'oferta'
values = 'porcentaje, fecha_desde, fecha_hasta'
dataFunction = fakeOfertData
minQuantity = 10
maxQuantity = 100
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla pregunta
numberTable += 1
table = 'pregunta'
notFillTable(table)
sleep(2)

# CREATE TABLE imagen (
#     producto INT NOT NULL REFERENCES producto(numero_articulo) ON DELETE RESTRICT ON UPDATE CASCADE,
#     imagen VARCHAR(255) NOT NULL,
#     PRIMARY KEY (producto, imagen)
# );

#tabla imagen
numberTable += 1
table = 'imagen'
values = 'producto, imagen'
dataFunction = fakeImage
minQuantity = minProductQuantity
maxQuantity = 50000
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla table_name
# numberTable += 1
# table = 'image'
# values = 'producto, imagen'
# dataFunction = fakeImageData # nombre de la funcion hecha en fakerData
# minQuantity = 100
# maxQuantity = minQuantity # si se hace con esto se da a entender que es el mismo numero por lo tanto no hay intervalo
# warning = True/False # se escribe un mensaje de advertencia del paso anterior 
# ¡No se toca!
# fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)


# tabla envio 
numberTable += 1
table = 'envio'
values = 'tipo_envio'
dataFunction = fakeShipping # nombre de la funcion hecha en fakerData
minQuantity = 300
maxQuantity = 3000 # si se hace con esto se da a entender que es el mismo numero por lo tanto no hay intervalo
warning = False 
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

#tabla resenia 
numberTable += 1
table = 'resenia'
values = 'resenia_producto, calificacion, producto'
dataFunction = fakeReview # nombre de la funcion hecha en fakerData
minQuantity = 300
maxQuantity = 3000 # si se hace con esto se da a entender que es el mismo numero por lo tanto no hay intervalo
warning = False 
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)


#tabla pedido 
numberTable += 1 
table = 'pedido'
values = 'fecha_pedido, metodo_pago, particular, resenia'
dataFunction = fakeOrder 
minOrderQuantity = 1000 
maxQuantity = 6000
warning = False 
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

#tabla item 
numberTable += 1 
table = 'item'
values = 'cantidad, estado, tipo_entrega, envio_domicilio, usuario, producto, direccion, pedido'
dataFunction = fakeItem 
minQuantity = minOrderQuantity #Cada item corresponde a un pedido por lo que el numero de items no puede ser menor al de pedidos
maxQuantity = 6000
warning = False 
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

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


