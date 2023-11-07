import psycopg2
from colorama import init, Fore

# Inicializa colorama para sistemas Windows
init(autoreset=True)

def createDataBase(connection: psycopg2.extensions.connection, cursor: psycopg2.extensions.cursor) -> None:
    # traigo el contenido del ddl para ejecutarlo
    database = "./scripts/ddl.sql"  
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
    
    arrayCreates = content.split(';')

    count = 0
    for create in arrayCreates:
        if (create != ''):
            splitCreate = create.split(' ')
            try:
                cursor.execute(create)
            except psycopg2.Error as error:
                print(Fore.LIGHTRED_EX + f'✘ - Tabla no creada: {splitCreate[2]}')
                print(f"Error: \n{error}")
            else:
                count += 1
                print(Fore.LIGHTGREEN_EX + f'✔ - Tabla creada: {splitCreate[2]}')

    try:
        connection.commit()
    except psycopg2.Error as error:
        print(f'\n {Fore.RED} ✘ - No se creo la base de datos exitosamente. - ✘')
        print(f"Error: \n{error}")
    else:
        if (count == (len(arrayCreates) - 1)):
            print('\n'+ Fore.GREEN + '✔ - Se creo la base de datos exitosamente. - ✔')
        elif (count == 0):
            print('\n'+ Fore.RED + '✘ - No se creo la base de datos exitosamente. - ✘')
        else:
            print('\n'+ Fore.YELLOW + '⚠ - Se creo la base de datos parcialmente. - ⚠')
    print('\n')
