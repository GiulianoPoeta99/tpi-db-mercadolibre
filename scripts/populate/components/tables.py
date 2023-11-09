import os
from colorama import init, Fore
import psycopg2
from alive_progress import alive_bar
from time import sleep

from components.constants import *
from fakerData import *
from components.querys import *
from components.customProviders import *

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

def getCount(lowerLimit: int, upperLimit: int) -> int:
    count = 0
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
    cursor: psycopg2.extensions.cursor,
    table: str, 
    values: str, 
    count: int,  
    dataFunction: any
):
    with alive_bar(count, title = getTitleBar(table), bar = STYLE_BAR, spinner = STYLE_SPINNER) as bar:
        index = 0
        errors = []
        while (index < count):
            data = dataFunction(cursor)
            try:
                cursor.execute(getInsert(table, values, data))
            except psycopg2.Error as error:
                errors.append(printError(table, error))
                # print(printError(table, error))
                connection.rollback()
                sleep(0.02)
            else:
                connection.commit()
                index += 1
                sleep(0.02)
                bar()
    print('\n')
    viewErrors(errors)

def fillTable(
    connection: psycopg2.extensions.connection, 
    cursor: psycopg2.extensions.cursor,
    numberTable: int,
    table: str,
    values: str,
    dataFunction: any,
    minQuantity: int,
    maxQuantity: int,
    warning: bool
) -> None:
    if (warning):
        printWarning()
    fillTable = askTable(numberTable, table)
    clearScreen()

    if (fillTable == 's'):
        if (minQuantity != maxQuantity):
            count = getCount(minQuantity, maxQuantity)
        else:
            count = minQuantity
        clearScreen()
        executeInsert(connection, cursor, table, values, count, dataFunction)

def notFillTable(table: str, numberTable: int) -> None:
    print(Fore.MAGENTA + f'({numberTable})' + Fore.RESET + f' ¿Quiere cargar la tabla {table}?')
    print(Fore.YELLOW + f'La tabla {table} para hacer la muestra se carga manualmente.\n\n' + Fore.RESET)