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
# numberTable = 1
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

# tabla usuario
numberTable = 1
table = 'usuario'
values = 'correo_electronico, telefono, contrasenia'
dataFunction = fakeUserData
minQuantity = 100
maxQuantity = 5000
warning = True
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla empresa
numberTable = 2
table = 'empresa'
values = 'usuario, cuit, nombre_fantasia, fecha_creacion'
dataFunction = fakeCorporateData
minQuantity = 100
maxQuantity = minQuantity
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla particular
numberTable = 3
table = 'particular'
values = 'usuario, DNI, fecha_nacimiento, nombre, apellido'
dataFunction = fakeParticularData
minQuantity = len(getUsersNotCorporate(cursor))
maxQuantity = minQuantity
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla direccion
numberTable = 4
table = 'direccion'
values = 'codigo_postal, calle, altura'
dataFunction = fakeAdressData
minQuantity = 100
maxQuantity = 500
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla metodo_de_pago
numberTable = 5
table = 'metodo_de_pago'
values = 'titular, numero_tarjeta, clave_seguridad, fecha_caducidad, empresa_emisora, tipo, usuario'
dataFunction = fakePaymentMethodData
minQuantity = 100
maxQuantity = 500
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

# tabla categoria
print('La tabla categoria para hacer la muestra se carga manualmente.\n\n')
sleep(2)

# tabla categoria_subcateoria
print('La tabla categoria_subcategoria para hacer la muestra se carga manualmente.\n\n')
sleep(2)

# tabla oferta
numberTable = 5
table = 'oferta'
values = 'porcentaje, fecha_desde, fecha_hasta'
dataFunction = fakeOfertData
minQuantity = 100
maxQuantity = 500
warning = False
fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

sleep(3)
clearScreen()
sleep(1)
print(Fore.GREEN + "✔ - La base de datos fue poblada exitosamente. - ✔")
sleep(0.10)

connection.commit()
cursor.close()
connection.close()


