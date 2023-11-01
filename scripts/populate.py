from faker import Faker
import psycopg2
import random
from datetime import datetime, timedelta

# Datos de conexión
DB_NAME = "mercadoLibre"
DB_USER = "dbi"
DB_PASS = "123456"
DB_HOST = "localhost"  # Por lo general, localhost si estás trabajando de manera local
DB_PORT = "5435"

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

<<<<<<< HEAD
# CREATE TABLE empresa (
#     usuario INT NOT NULL PRIMARY KEY REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
#     CUIT VARCHAR(15) NOT NULL UNIQUE,
#     nombre_fantasia VARCHAR(255) NOT NULL UNIQUE,
#     fecha_creacion DATE NOT NULL 
# );
for _ in range(500):
    usuarioRandom = random.randint(1, 500)
    cuit = str(random.randint(10000000, 99999999))
    
=======
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

>>>>>>> 22d6c2f5e42383f260329a37c67ab2d12c9103f4
conn.commit()
cur.close()
conn.close()




