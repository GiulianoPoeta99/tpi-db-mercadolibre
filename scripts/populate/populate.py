from faker import Faker
from colorama import init, Fore
import psycopg2
import random
import os
from connection import *
from customProviders import *
from createDataBase import *
from alive_progress import alive_bar
from time import sleep


# Inicializa colorama para sistemas Windows
init(autoreset=True)

# constantes
YES_NO = Fore.GREEN + 's' + Fore.RESET + '/' + Fore.RED + 'n' + Fore.RESET

def clearScreen() -> None:
    os.system('clear')

# obtengo los usuarios
def getUsers() -> list:
    query = "SELECT numero_cliente FROM usuario"
    cursor.execute(query)
    allUsers = cursor.fetchall()
    allUsers = [element[0] for element in allUsers]
    return allUsers 

def askTable(number: int, table: str) -> str:
    print(Fore.MAGENTA + f'({number})' + Fore.RESET + f' ¿Quiere cargar la tabla {table}?')
    fillTable = ''
    while ((fillTable != 's') & (fillTable != 'n')):
        fillTable = input(YES_NO + '\n')
    return fillTable

def viewErrors(errors: list) -> None:
    print(Fore.RED + '(!)' + Fore.RESET + ' ¿Desea ver los errores durante la creación de datos?')
    seeErrors = ''
    while ((seeErrors != 's') & (seeErrors != 'n')):
        seeErrors = input(YES_NO + '\n')

    clearScreen()
    if (seeErrors == 's'):
        if (len(errors) != 0):
            for numberError, error in enumerate(errors):
                print(Fore.RED + '(' + str(numberError + 1) + ') ' + Fore.RESET + error)
        else:
            print(Fore.LIGHTGREEN_EX + 'No se produjeron errores durante la ejecucion.')
        print('\n')
        print (Fore.YELLOW + '(*)' + Fore.RESET + ' Hubo un total de ' + Fore.RED + str(len(errors)) + Fore.RESET)
        print('\n')

def getCount(count: int, lowerLimit: int, upperLimit: int) -> int:
    while ((int(count) < lowerLimit) | (int(count) > upperLimit)):
        count = input('¿Cuantos registros quiere agregar?\n' + Fore.YELLOW + f'⚠ - Recomendamos no menos de {lowerLimit} registros y no mas de {upperLimit}. - ⚠\n' + Fore.RESET)
    return int(count)


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
    errors = []

    count = getCount(count, 100, 5000)
    
    clearScreen()
    with alive_bar(count, title = f'Llenando tabla ({table})...', bar = 'filling', spinner = 'arrows') as bar:
        while (index < count):
            email = fakeEsAr.email()
            phone = fakeEsAr.phone_number()
            password = fakeEn.lexify(text='??????????')
            try:
                cursor.execute(f"INSERT INTO {table} (correo_electronico, telefono, contrasenia) VALUES ('{email}', '{phone}', '{password}')")
            except psycopg2.Error as error:
                errors.append(Fore.YELLOW + f"⚠ Error en {table}:{Fore.RESET}\n{error}")
                connection.rollback()
                sleep(0.02)
            else:
                connection.commit()
                index += 1
                sleep(0.02)
                bar()
    print('\n')
    viewErrors(errors)

# tabla empresa
table = 'empresa'

fillCorporate = askTable(2, table)

clearScreen()
if (fillCorporate == 's'):
    index = 0
    # count = len(getUsers()) // 3
    count = 100
    errors = []

    clearScreen()
    with alive_bar(count, title = f'Llenando tabla ({table})...', bar = 'filling', spinner = 'arrows') as bar:
        while (index < count):
            randomUser = random.choice(list(getUsers()))
            cuit = fakeEn.bothify(text = '##-########-#')
            fakeEn.add_provider(arg_pymes_provider)
            fantasyName = fakeEn.pymes_provider()
            creationDate = fakeEn.past_date('-18263d') # Genera una fecha pasada aleatoria en los últimos 50 años
            try:
                cursor.execute(f"INSERT INTO {table} (usuario, cuit, nombre_fantasia, fecha_creacion) VALUES ({randomUser}, '{cuit}', '{fantasyName}', '{creationDate}')")
            except psycopg2.Error as error:
                errors.append(Fore.YELLOW + f"⚠ Error en {table}:{Fore.RESET}\n{error}")
                connection.rollback()
                sleep(0.02)
            else:
                connection.commit()
                index += 1
                sleep(0.02)
                bar()  
    print('\n')
    viewErrors(errors)


# tabla particular
table = 'particular'

fillParticular = askTable(3, table)

clearScreen()
if (fillParticular == 's'):
    index = 0
    errors = []

    # obtengo los usuarios que no son empresas
    query = "SELECT usuario FROM empresa"
    cursor.execute(query)
    corporateUser = cursor.fetchall()
    corporateUser = [element[0] for element in corporateUser]
    allUsersAvailable = set(getUsers()) - set(corporateUser)

    count = len(allUsersAvailable)
    with alive_bar(count, title = f'Llenando tabla ({table})...', bar = 'filling', spinner = 'arrows') as bar:
        while (index < count):
            randomUser = random.choice(list(allUsersAvailable))
            dni = fakeEn.bothify(text = '########')
            dateOfBirth = fakeEn.past_date('-29220d') # Genera una fecha pasada aleatoria en los últimos 80 años
            firstName = fakeEsAr.first_name()
            lastName = fakeEsAr.last_name()
            try:
                cursor.execute(f"INSERT INTO {table} (usuario, DNI, fecha_nacimiento, nombre, apellido) VALUES ({randomUser}, '{dni}', '{dateOfBirth}', '{firstName}', '{lastName}')")
            except psycopg2.Error as error:
                errors.append(Fore.YELLOW + f"⚠ Error en {table}:{Fore.RESET}\n{error}")
                connection.rollback()
                sleep(0.02)
            else:
                connection.commit()
                index += 1
                sleep(0.02)
                bar() 
    print('\n')
    viewErrors(errors)


# tabla direccion
table = 'direccion'

fillAdresses = askTable(4, table)

clearScreen()
if (fillAdresses == 's'):
    index = 0
    count = 0
    errors = []

    count = getCount(count, 100, 500)

    clearScreen()
    with alive_bar(count, title = f'Llenando tabla ({table})...', bar = 'filling', spinner = 'arrows') as bar:
        while (index < count):
            zipCode = random.randint(1001,9431)
            street = fakeEsAr.street_name()
            streetNumber = fakeEn.bothify(text='####')
            try:
                cursor.execute(f"INSERT INTO {table} (codigo_postal, calle, altura) VALUES ('{zipCode}', '{street}', '{streetNumber}')")
            except psycopg2.Error as error:
                errors.append(Fore.YELLOW + f"⚠ Error en {table}:{Fore.RESET}\n{error}")
                connection.rollback()
                sleep(0.02)
            else:
                connection.commit()
                index += 1
                sleep(0.02)
                bar()
    print('\n')
    viewErrors(errors)


sleep(5)
clearScreen()
sleep(1)
print(Fore.GREEN + "✔ - La base de datos fue poblada exitosamente. - ✔")
sleep(0.10)

connection.commit()
cursor.close()
connection.close()


