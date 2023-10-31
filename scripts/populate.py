from faker import Faker
import psycopg2
import random

# Datos de conexión
DB_NAME = "mercado_libre_db"
DB_USER = "mercado_libre_db"
DB_PASS = "mercado_libre_db"
DB_HOST = "localhost"  # Por lo general, localhost si estás trabajando de manera local
DB_PORT = "6004"

# Crear una conexión a la base de datos
conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT)

# creamos onjeto fake
fakeEn = Faker()
fakeEsEs = Faker()
fakeEsAr = Faker()

cur = conn.cursor()

# rellenamos tabla usuario
for _ in range(500):
    email = fakeEn.email()
    telefono = fakeEn.msisdn()
    contrasenia = fakeEn.lexify(text='??????????')
    cur.execute("INSERT INTO usuario (correo_electronico, telefono, contrasenia) VALUES (%s, %s, %s)", (email, telefono, contrasenia))

# CREATE TABLE empresa (
#     usuario INT NOT NULL PRIMARY KEY REFERENCES usuario(numero_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
#     CUIT VARCHAR(15) NOT NULL UNIQUE,
#     nombre_fantasia VARCHAR(255) NOT NULL UNIQUE,
#     fecha_creacion DATE NOT NULL 
# );
for _ in range(500):
    usuarioRandom = random.randint(1, 500)
    cuit = str(random.randint(10000000, 99999999))
    

conn.commit()
cur.close()
conn.close()




