from faker import Faker
import psycopg2
import random
from constantes import *

# Crear una conexión a la base de datos
conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT)

# creamos onjeto fake

fakeEn = Faker()
fakeEsEs = Faker('es_ES')
fakeEsAr = Faker('es_AR')

cur = conn.cursor()

# rellenamos tabla usuario
count = 0
while count < 500:
    try:
        email = fakeEsAr.email()
        telefono = fakeEsAr.phone_number()
        contrasenia = fakeEn.lexify(text='??????????')
        cur.execute("INSERT INTO usuario (correo_electronico, telefono, contrasenia) VALUES (%s, %s, %s)", (email, telefono, contrasenia))
        conn.commit()
        count += 1
    except psycopg2.Error as e:
        print("Error en usuarios:", e)
        conn.rollback()

# empresa
count = 0
while count < 100:
    try:
        usuarioRandom = random.randint(1, 500)
        cuit = fakeEn.bothify(text='##-########-#')
        nombreFantasia = fakeEsEs.company()
        fecha_creacion = fakeEn.past_date('-18263d') # Genera una fecha pasada aleatoria en los últimos 50 años

        cur.execute("INSERT INTO empresa (usuario, cuit, nombre_fantasia, fecha_creacion) VALUES (%s, %s, %s, %s)", (usuarioRandom, cuit, nombreFantasia, fecha_creacion))
        conn.commit()
        count += 1
    except psycopg2.Error as e:
        print("Error en Empresa:", e)
        conn.rollback()

conn.commit()
cur.close()
conn.close()




