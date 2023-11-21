from colorama import init, Fore
from components.fillTable import *

# Inicializa colorama para sistemas Windows
init(autoreset=True)

def fillTablesFromSample(cursor: psycopg2.extensions.cursor, connection: psycopg2.extensions.connection) -> None:
     # traigo el contenido del dml para ejecutarlo
    database = "./scripts/dml.sql"  
    content = ""
    try:
        with open(database, "r", encoding="utf-8") as file:
            content = file.read()
    except FileNotFoundError:
        print(Fore.RED + f"El archivo {database} no fue encontrado.")
    except Exception as error:
        print(Fore.RED + f"Ocurrió un error al leer el archivo: \n{str(error)}")
    else:
        print(Fore.GREEN + '✔ - El archivo se leyo correctamente. - ✔ \n')
        # print('\n')

    arrayInserts = content.split(';')

    count = 0
    for insert in arrayInserts:
        if (insert != ''):
            splitCreate = insert.split(' ')
            try:
                cursor.execute(insert)
            except psycopg2.Error as error:
                print(Fore.LIGHTRED_EX + f'✘ - Fallo insert {count} en tabla {splitCreate[2]}')
                print(f"Error: \n{error}")
            else:
                count += 1
                print(Fore.LIGHTGREEN_EX + f'✔ - Insert {count} en tabla {splitCreate[2]}')

    try:
        connection.commit()
    except psycopg2.Error as error:
        print(f'\n {Fore.RED} ✘ - No se poblo la base de datos exitosamente. - ✘')
        print(f"Error: \n{error}")
    else:
        if (count == (len(arrayInserts) - 1)):
            print('\n'+ Fore.GREEN + '✔ - Se poblo la base de datos exitosamente. - ✔')
        elif (count == 0):
            print('\n'+ Fore.RED + '✘ - No se poblo la base de datos exitosamente. - ✘')
        else:
            print('\n'+ Fore.YELLOW + '⚠ - Se poblo la base de datos parcialmente. - ⚠')
    print('\n')