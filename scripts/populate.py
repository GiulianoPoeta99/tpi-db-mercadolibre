from faker import Faker
import psycopg2
import random
from dynamicProvider import *
from constantes import *
from customProviders import *

# obtengo los usuarios
def getUsers():
    query = "SELECT numero_cliente FROM usuario"
    cursor.execute(query)
    allUsers = cursor.fetchall()
    allUsers = [element[0] for element in allUsers]
    return allUsers 

# Crear una conexión a la base de datos
connection = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT)

# creamos onjetos fake en diferentes regiones
fakeEn = Faker()
fakeEsEs = Faker('es_ES')
fakeEsAr = Faker('es_AR')

cursor = connection.cursor()

print('Quiere crear la base de datos?')
createDatabase = ''
while ((createDatabase != 's') & (createDatabase != 'n')):
    createDatabase = input('s/n\n')

if (createDatabase == 's'):
    # traigo el contenido del ddl para ejecutarlo
    database = "./scripts/ddl.sql"  
    content = ""
    try:
        with open(database, "r", encoding="utf-8") as file:
            content = file.read()
    except FileNotFoundError:
        print(f"El archivo {database} no fue encontrado.")
    except Exception as e:
        print(f"Ocurrió un error al leer el archivo: {str(e)}")

    cursor.execute(content)
    connection.commit()

# tabla usuario
table = 'usuario'

print(f'Quiere cargar la tabla {table}?')
fillUsers = ''
while ((fillUsers != 's') & (fillUsers != 'n')):
    fillUsers = input('s/n\n')

if (fillUsers == 's'):
    index = 0
    count = 500
    while (index < count):
        email = fakeEsAr.email()
        phone = fakeEsAr.phone_number()
        password = fakeEn.lexify(text='??????????')
        try:
            cursor.execute(f"INSERT INTO {table} (correo_electronico, telefono, contrasenia) VALUES ('{email}', '{phone}', '{password}')")
        except psycopg2.Error as error:
            print(f"Error en {table}: \n{error}")
            connection.rollback()
        else:
            connection.commit()
            index += 1
        print(f"Completado: {index}/{count}")

allUsers = getUsers()

# tabla empresa
table = 'empresa'

print(f'Quiere cargar la tabla {table}?')
fillCorporate = ''
while ((fillCorporate != 's') & (fillCorporate != 'n')):
    fillCorporate = input('s/n\n')

if (fillCorporate == 's'):
    index = 0
    count = 100
    while (index < count):
        randomUser = random.choice(list(allUsers))
        cuit = fakeEn.bothify(text = '##-########-#')
        fakeEn.add_provider(arg_pymes_provider)
        fantasyName = fakeEn.pymes_provider()
        creationDate = fakeEn.past_date('-18263d') # Genera una fecha pasada aleatoria en los últimos 50 años
        try:
            cursor.execute(f"INSERT INTO {table} (usuario, cuit, nombre_fantasia, fecha_creacion) VALUES ({randomUser}, '{cuit}', '{fantasyName}', '{creationDate}')")
        except psycopg2.Error as error:
            print(f"Error en {table}: \n{error}")
            connection.rollback()
        else:
            connection.commit()
            index += 1
        print(f"Completado: {index}/{count}")

# obtengo los usuarios que no son empresas
query = "SELECT usuario FROM empresa"
cursor.execute(query)
corporateUser = cursor.fetchall()
corporateUser = [element[0] for element in corporateUser]
allUsersAvailable = set(getUsers()) - set(corporateUser)

#tabla particular
table = 'particular'

print(f'Quiere cargar la tabla {table}?')
fillParticular = ''
while ((fillParticular != 's') & (fillParticular != 'n')):
    fillParticular = input('s/n\n')

if (fillParticular == 's'):
    index = 0
    count = 400
    while (index < count):
        randomUser = random.choice(list(allUsersAvailable))
        dni = fakeEn.bothify(text = '########')
        dateOfBirth = fakeEn.past_date('-29220d') # Genera una fecha pasada aleatoria en los últimos 80 años
        firstName = fakeEsAr.first_name()
        lastName = fakeEsAr.last_name()
        try:
            cursor.execute(f"INSERT INTO {table} (usuario, DNI, fecha_nacimiento, nombre, apellido) VALUES ({randomUser}, '{dni}', '{dateOfBirth}', '{firstName}', '{lastName}')")
        except psycopg2.Error as error:
            print(f"Error en {table}: \n{error}")
            connection.rollback()
        else:
            connection.commit()
            index += 1

        print(f"Completado: {index}/{count}")

connection.commit()
cursor.close()
connection.close()

print("La base de datos fue poblada exitosamente.")


