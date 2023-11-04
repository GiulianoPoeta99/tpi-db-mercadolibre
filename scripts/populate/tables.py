import os
from colorama import init, Fore
import psycopg2
from faker import Faker
from alive_progress import alive_bar
from time import sleep
import random

from constants import *
from querys import *
from customProviders import *

# Inicializa colorama para sistemas Windows
init(autoreset=True)

# creamos objetos fake en diferentes regiones
fakeEn = Faker() # ingles
fakeEsAr = Faker('es_AR') # español argentina

def clearScreen() -> None:
    os.system('clear')

def askTable(number: int, table: str) -> str:
    print(Fore.MAGENTA + f'({number})' + Fore.RESET + f' ¿Quiere cargar la tabla {table}?')
    fillTable = ''
    while ((fillTable != 's') & (fillTable != 'n')):
        fillTable = input(YES_NO + '\n')
    return fillTable

def getCount(count: int, lowerLimit: int, upperLimit: int) -> int:
    while ((int(count) < lowerLimit) | (int(count) > upperLimit)):
        count = input('¿Cuantos registros quiere agregar?\n' + Fore.YELLOW + f'⚠ - Recomendamos no menos de {lowerLimit} registros y no mas de {upperLimit}. - ⚠\n' + Fore.RESET)
    return int(count)

def getTitleBar(table: str) -> str:
    return f'Llenando tabla ({table})...'

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


# PLANTILLA
# Solo hay que cambiar los parametro que esta entre [] un ejemplo es [TABLE_NAME]

# def fill([TABLE_NAME])(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
#     table = '[TABLE_NAME]'
#     fillTable = askTable([NUMBER_TABLE], table)
#     clearScreen()
#     if (fillTable == 's'):
#         index = 0
#         count = 0
#         errors = []
#         count = getCount(count, [MIN_TUPLES], [MAX_TUPLES])
#         clearScreen()
#         with alive_bar(count, title = f'Llenando tabla ({table})...', bar = STYLE_BAR, spinner = STYLE_SPINNER) as bar:
#             while (index < count):
#                 # Definir los atributos de la tabla
#                 # la documentacion para hacerlo es la siguiente:
#                 # https://faker.readthedocs.io/en/master/index.html
#
#                 insert = f"INSERT INTO {table} ([ATRIBUTTES])) VALUES ([DEFINED_ATRIBUTTES])"
#
#                 # ¡Esto no se toca!                 
#                 try:
#                     cursor.execute(insert)
#                 except psycopg2.Error as error:
#                     errors.append(Fore.YELLOW + f"⚠ Error en {table}:{Fore.RESET}\n{error}")
#                     connection.rollback()
#                     sleep(0.02)
#                 else:
#                     connection.commit()
#                     index += 1
#                     sleep(0.02)
#                     bar()
#         print('\n')
#         viewErrors(errors)



# tabla usuario
def fillUsers(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
    table = 'usuario'
    print(Fore.YELLOW + '⚠ - Si hubo algun problema en la etapa anterior cancele la ejecucion con CTRL+C - ⚠')
    fillTable = askTable(1, table)
    clearScreen()
    if (fillTable == 's'):
        index = 0
        count = 0
        errors = []
        count = getCount(count, 100, 5000)
        clearScreen()
        with alive_bar(count, title = getTitleBar(table), bar = STYLE_BAR, spinner = STYLE_SPINNER) as bar:
            while (index < count):
                email = fakeEsAr.email()
                phone = fakeEsAr.phone_number()
                password = fakeEn.lexify(text='??????????')
                insert = f"INSERT INTO {table} (correo_electronico, telefono, contrasenia) VALUES ('{email}', '{phone}', '{password}')"
                try:
                    cursor.execute(insert)
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
def fillCorporate(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
    table = 'empresa'
    fillTable = askTable(2, table)
    clearScreen()
    if (fillTable == 's'):
        index = 0
        # count = len(getUsers(cursor)) // 3 #para hacer esto necesitamos muchas mas empresas alrededor de 1700
        count = 100
        errors = []
        clearScreen()
        with alive_bar(count, title = getTitleBar(table), bar = STYLE_BAR, spinner = STYLE_SPINNER) as bar:
            while (index < count):
                randomUser = random.choice(list(getUsers(cursor)))
                cuit = fakeEn.bothify(text = '##-########-#')
                fakeEn.add_provider(arg_pymes_provider)
                fantasyName = fakeEn.pymes_provider()
                creationDate = fakeEn.past_date('-18263d') # Genera una fecha pasada aleatoria en los últimos 50 años
                insert = f"INSERT INTO {table} (usuario, cuit, nombre_fantasia, fecha_creacion) VALUES ({randomUser}, '{cuit}', '{fantasyName}', '{creationDate}')"
                try:
                    cursor.execute(insert)
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
def fillParticular(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
    table = 'particular'
    fillTable = askTable(3, table)
    clearScreen()
    if (fillTable == 's'):
        index = 0
        errors = []
        allUsersAvailable = getUsersNotCorporate(cursor)
        count = len(allUsersAvailable)
        with alive_bar(count, title = getTitleBar(table), bar = STYLE_BAR, spinner = STYLE_SPINNER) as bar:
            while (index < count):
                randomUser = random.choice(list(allUsersAvailable))
                dni = fakeEn.bothify(text = '########')
                dateOfBirth = fakeEn.past_date('-29220d') # Genera una fecha pasada aleatoria en los últimos 80 años
                firstName = fakeEsAr.first_name()
                lastName = fakeEsAr.last_name()
                insert = f"INSERT INTO {table} (usuario, DNI, fecha_nacimiento, nombre, apellido) VALUES ({randomUser}, '{dni}', '{dateOfBirth}', '{firstName}', '{lastName}')"
                try:
                    cursor.execute(insert)
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
def fillAdresses(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
    table = 'direccion'
    fillTable = askTable(4, table)
    clearScreen()
    if (fillTable == 's'):
        index = 0
        count = 0
        errors = []
        count = getCount(count, 100, 500)
        clearScreen()
        with alive_bar(count, title = getTitleBar(table), bar = STYLE_BAR, spinner = STYLE_SPINNER) as bar:
            while (index < count):
                zipCode = random.randint(1001,9431)
                street = fakeEsAr.street_name()
                streetNumber = fakeEn.bothify(text='####')
                insert = f"INSERT INTO {table} (codigo_postal, calle, altura) VALUES ('{zipCode}', '{street}', '{streetNumber}')"
                try:
                    cursor.execute(insert)
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
