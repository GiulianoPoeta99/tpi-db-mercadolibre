# extern
from colorama import init, Fore
import psycopg2
from time import sleep

# interm
from connection import *
from createDataBase import *
from querys import *
from tables import *

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
fillUsers(connection, cursor)

# tabla empresa
fillCorporate(connection, cursor)

# tabla particular
fillParticular(connection, cursor)

# tabla direccion
fillAdresses(connection, cursor)

sleep(5)
clearScreen()
sleep(1)
print(Fore.GREEN + "✔ - La base de datos fue poblada exitosamente. - ✔")
sleep(0.10)

connection.commit()
cursor.close()
connection.close()


