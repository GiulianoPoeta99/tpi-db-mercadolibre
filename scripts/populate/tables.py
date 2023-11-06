import os
from colorama import init, Fore
import psycopg2
from alive_progress import alive_bar
from time import sleep
import random

from constants import *
from fakerData import *
from querys import *
from customProviders import *

# Inicializa colorama para sistemas Windows
init(autoreset=True)

def clearScreen() -> None:
    os.system('clear')

def printWarning() -> str:
    return Fore.YELLOW + '⚠ - Si hubo algun problema en la etapa anterior cancele la ejecucion con CTRL+C - ⚠'

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

def getInsert(table, values, data) -> str:
    return f"INSERT INTO {table} ({values}) VALUES ({data})"

def printError(table, error) -> str:
    return Fore.YELLOW + f"⚠ Error en {table}:{Fore.RESET}\n{error}"

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

def executeInsert(
    connection: psycopg2.extensions.connection, 
    cursor: psycopg2.extensions.cursor ,
    table: str, 
    values: str, 
    index: int, 
    count: int, 
    errors: list, 
    dataFunction: any
):
    with alive_bar(count, title = getTitleBar(table), bar = STYLE_BAR, spinner = STYLE_SPINNER) as bar:
        while (index < count):

            data = dataFunction()

            try:
                cursor.execute(getInsert(table, values, data))
            except psycopg2.Error as error:
                errors.append(printError(table, error))
                connection.rollback()
                sleep(0.02)
            else:
                connection.commit()
                index += 1
                sleep(0.02)
                bar()
    print('\n')
    viewErrors(errors)


# PLANTILLA
# def fillTableName(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
#     table = 'table name'
#     values = 'attribute separeted with comas'
#     dataFunction = fakeTableNameData

#     printWarning()
#     fillTable = askTable(numberTable, table)
#     clearScreen()

#     if (fillTable == 's'):
#         index = 0
#         count = 0
#         errors = []

#         # esto puede cabiar dependiento de lo que se tenga que hacer
#         count = getCount(count, 100, 5000)
#         clearScreen()

#         executeInsert(connection, cursor, table, values, index, count, errors, dataFunction)


# tabla usuario
def fillUsers(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
    table = 'usuario'
    values = 'correo_electronico, telefono, contrasenia'
    dataFunction = fakeUserData

    printWarning()
    fillTable = askTable(1, table)
    clearScreen()

    if (fillTable == 's'):
        index = 0
        count = 0
        errors = []

        count = getCount(count, 100, 5000)
        clearScreen()

        executeInsert(connection, cursor, table, values, index, count, errors, dataFunction)

# tabla empresa
def fillCorporate(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
    table = 'empresa'
    values = 'usuario, cuit, nombre_fantasia, fecha_creacion'
    dataFunction = fakeCorporateData

    fillTable = askTable(2, table)
    clearScreen()

    if (fillTable == 's'):
        index = 0
        # count = len(getUsers(cursor)) // 3 #para hacer esto necesitamos muchas mas empresas alrededor de 1700
        count = 100
        errors = []
        clearScreen()

        executeInsert(connection, cursor, table, values, index, count, errors, dataFunction)

# tabla particular
def fillParticular(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
    table = 'particular'
    values = 'usuario, DNI, fecha_nacimiento, nombre, apellido'
    dataFunction = fakeParticularData

    fillTable = askTable(3, table)
    clearScreen()

    if (fillTable == 's'):
        index = 0
        errors = []

        allUsersAvailable = getUsersNotCorporate(cursor)
        count = len(allUsersAvailable)

        executeInsert(connection, cursor, table, values, index, count, errors, dataFunction)

# tabla direccion
def fillAdresses(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
    table = 'direccion'
    values = 'codigo_postal, calle, altura'
    dataFunction = fakeAdressData

    fillTable = askTable(4, table)
    clearScreen()

    if (fillTable == 's'):
        index = 0
        count = 0
        errors = []

        count = getCount(count, 100, 500)
        clearScreen()

        executeInsert(connection, cursor, table, values, index, count, errors, dataFunction)

# tabla metodo_de_pago 
def fillPaymentMethod(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
    table = 'metodo_de_pago'
    values = 'titular, numero_tarjeta, clave_seguridad, fecha_caducidad, empresa_emisora, tipo, usuario'
    dataFunction = fakePaymentMethodData
    
    fillTable = askTable(5, table)
    clearScreen()

    if (fillTable == 's'):
        index = 0
        count = 0
        errors = []

        count = getCount(count, 100, 500)
        clearScreen()

        executeInsert(connection, cursor, table, values, index, count, errors, dataFunction)