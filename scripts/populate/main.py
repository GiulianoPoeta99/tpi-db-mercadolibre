# extern
from colorama import init, Fore
import psycopg2
from time import sleep

# interm
from components.connection import *
from components.createDataBase import *
from components.tablesAuto import *
from components.tablesSample import *

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

print('¿Quiere usar datos generados previamente?')
useSample = ''
while ((useSample != 's') & (useSample != 'n')):
    useSample = input(YES_NO + '\n')

clearScreen()
if (useSample == 's'):
    fillTablesFromSample(cursor, connection)
else:
    fillTablesAuto(cursor, connection)

sleep(3)
clearScreen()
sleep(1)
print(Fore.GREEN + "✔ - La base de datos fue poblada exitosamente. - ✔")
sleep(0.10)

connection.commit()
cursor.close()
connection.close()


