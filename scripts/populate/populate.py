from faker import Faker
from colorama import init, Fore
import psycopg2
import random
import os
from constantes import *
from customProviders import *
from createDataBase import *
from alive_progress import alive_bar
from time import sleep


# Inicializa colorama para sistemas Windows
init(autoreset=True)

# constantes
YES_NO = Fore.GREEN + 's' + Fore.RESET + '/' + Fore.RED + 'n' + Fore.RESET

# obtengo los usuarios
def getUsers() -> list:
    query = "SELECT numero_cliente FROM usuario"
    cursor.execute(query)
    allUsers = cursor.fetchall()
    allUsers = [element[0] for element in allUsers]
    return allUsers 

def clearScreen() -> None:
    os.system('clear')

def askTable(number: int, table: str) -> str:
    print(Fore.MAGENTA + f'({number})' + Fore.RESET + f' ¿Quiere cargar la tabla {table}?')
    fillTable = ''
    while ((fillTable != 's') & (fillTable != 'n')):
        fillTable = input(YES_NO + '\n')
    return fillTable

# Crear una conexión a la base de datos y habilitamos el cursor
connection = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT)
cursor = connection.cursor()

# creamos objetos fake en diferentes regiones
fakeEn = Faker() # ingles
fakeEsAr = Faker('es_AR') # español argentina

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
table = 'usuario'

print(Fore.YELLOW + '⚠ - Si hubo algun problema en la etapa anterior cancele la ejecucion con CTRL+C - ⚠')

fillUsers = askTable(1, table)

clearScreen()
if (fillUsers == 's'):
    index = 0
    count = 0

    while ((count < 100) | (count > 5000)):
        count = input('¿Cuantos usuarios quiere agregar?\n' + Fore.YELLOW + '⚠ - Recomendamos no menos de 100 usuarios y no mas de 5000. - ⚠\n' + Fore.RESET)
        count = int(count)

    clearScreen()
    with alive_bar(count, title='Creando...', bar='filling', spinner='arrows') as bar:
        while (index < count):
            email = fakeEsAr.email()
            phone = fakeEsAr.phone_number()
            password = fakeEn.lexify(text='??????????')
            try:
                cursor.execute(f"INSERT INTO {table} (correo_electronico, telefono, contrasenia) VALUES ('{email}', '{phone}', '{password}')")
            except psycopg2.Error as error:
                print(Fore.YELLOW + f"⚠ Error en {table}:{Fore.RESET}\n{error}")
                connection.rollback()
                sleep(0.02)
            else:
                connection.commit()
                index += 1
                sleep(0.02)
                bar()
    print('\n')


# tabla empresa
table = 'empresa'

fillCorporate = askTable(2, table)

clearScreen()
if (fillCorporate == 's'):
    index = 0
    # count = len(getUsers()) // 3
    count = 100

    clearScreen()
    with alive_bar(count, title='Creando...', bar='filling', spinner='arrows') as bar:
        while (index < count):
            randomUser = random.choice(list(getUsers()))
            cuit = fakeEn.bothify(text = '##-########-#')
            fakeEn.add_provider(arg_pymes_provider)
            fantasyName = fakeEn.pymes_provider()
            creationDate = fakeEn.past_date('-18263d') # Genera una fecha pasada aleatoria en los últimos 50 años
            try:
                cursor.execute(f"INSERT INTO {table} (usuario, cuit, nombre_fantasia, fecha_creacion) VALUES ({randomUser}, '{cuit}', '{fantasyName}', '{creationDate}')")
            except psycopg2.Error as error:
                print(Fore.YELLOW + f"⚠ Error en {table}:{Fore.RESET}\n{error}")
                connection.rollback()
                sleep(0.02)
            else:
                connection.commit()
                index += 1
                sleep(0.02)
                bar()  
    print('\n')    

#tabla particular
table = 'particular'

fillParticular = askTable(3, table)

clearScreen()
if (fillParticular == 's'):
    index = 0

    # obtengo los usuarios que no son empresas
    query = "SELECT usuario FROM empresa"
    cursor.execute(query)
    corporateUser = cursor.fetchall()
    corporateUser = [element[0] for element in corporateUser]
    allUsersAvailable = set(getUsers()) - set(corporateUser)

    count = len(allUsersAvailable)
    with alive_bar(count, title='Creando...', bar='filling', spinner='arrows') as bar:
        while (index < count):
            randomUser = random.choice(list(allUsersAvailable))
            dni = fakeEn.bothify(text = '########')
            dateOfBirth = fakeEn.past_date('-29220d') # Genera una fecha pasada aleatoria en los últimos 80 años
            firstName = fakeEsAr.first_name()
            lastName = fakeEsAr.last_name()
            try:
                cursor.execute(f"INSERT INTO {table} (usuario, DNI, fecha_nacimiento, nombre, apellido) VALUES ({randomUser}, '{dni}', '{dateOfBirth}', '{firstName}', '{lastName}')")
            except psycopg2.Error as error:
                print(Fore.YELLOW + f"⚠ Error en {table}:{Fore.RESET}\n{error}")
                connection.rollback()
                sleep(0.02)
            else:
                connection.commit()
                index += 1
                sleep(0.02)
                bar() 
    print('\n')

connection.commit()
cursor.close()
connection.close()

sleep(2)
clearScreen()
print(Fore.GREEN + "✔ - La base de datos fue poblada exitosamente. - ✔")
sleep(0.10)

