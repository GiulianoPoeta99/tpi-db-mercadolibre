from faker import Faker
import psycopg2
import random
from constantes import *
from customProviders import *

# Crear una conexión a la base de datos
conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT)

# creamos onjetos fake en diferentes regiones
fakeEn = Faker()
fakeEsEs = Faker('es_ES')
fakeEsAr = Faker('es_AR')

cur = conn.cursor()

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

cur.execute(content)
conn.commit()

# tabla usuario
table = 'usuario'
index = 0
count = 500
while (index < count):
    email = fakeEsAr.email()
    phone = fakeEsAr.phone_number()
    password = fakeEn.lexify(text='??????????')
    try:
        cur.execute(f"INSERT INTO {table} (correo_electronico, telefono, contrasenia) VALUES ('{email}', '{phone}', '{password}')")
    except psycopg2.Error as error:
        print(f"Error en {table}: \n{error}")
        conn.rollback()
    else:
        conn.commit()
        index += 1

    print(f"Completado: {index}/{count}")

# tabla empresa
table = 'empresa'
index = 0
count = 100
while (index < count):
    randomUser = random.randint(1, 500)
    cuit = fakeEn.bothify(text = '##-########-#')
    fakeEn.add_provider(arg_pymes_provider)
    fantasyName = fakeEn.pymes_provider()
    creationDate = fakeEn.past_date('-18263d') # Genera una fecha pasada aleatoria en los últimos 50 años
    try:
        cur.execute(f"INSERT INTO {table} (usuario, cuit, nombre_fantasia, fecha_creacion) VALUES ({randomUser}, '{cuit}', '{fantasyName}', '{creationDate}')")
    except psycopg2.Error as error:
        print(f"Error en {table}: \n{error}")
        conn.rollback()
    else:
        conn.commit()
        index += 1

    print(f"Completado: {index}/{count}")

# obtengo los usuarios que no son empresas
query = "SELECT usuario FROM empresa"
cur.execute(query)
corporateUser = cur.fetchall()
corporateUser = [elemento[0] for elemento in corporateUser]
allUsers = set(range(1, 501))
allUsersAvailable = allUsers - set(corporateUser)

#tabla particular
table = 'particular'
index = 0
count = 400
while (index < count):
    randomUser = random.choice(list(allUsersAvailable))
    dni = fakeEn.bothify(text = '########')
    dateOfBirth = fakeEn.past_date('-29220d') # Genera una fecha pasada aleatoria en los últimos 80 años
    firstName = fakeEsAr.first_name()
    lastName = fakeEsAr.last_name()
    try:
        cur.execute(f"INSERT INTO {table} (usuario, DNI, fecha_nacimiento, nombre, apellido) VALUES ({randomUser}, '{dni}', '{dateOfBirth}', '{firstName}', '{lastName}')")
    except psycopg2.Error as error:
        print(f"Error en {table}: \n{error}")
        conn.rollback()
    else:
        conn.commit()
        index += 1

    print(f"Completado: {index}/{count}")

conn.commit()
cur.close()
conn.close()




