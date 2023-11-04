from faker import Faker
import psycopg2
import random
from customProviders import *
from scripts.populate.connection import *

# Crear una conexión a la base de datos
conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT)


cur = conn.cursor()

# rellenamos tabla usuario

fakeUsuario = Faker()
fakeUsuario.add_provider(arg_prefixphone_provider)

def telefonoFaker(fakeUsuario): 
    telefono = fakeUsuario.random_number(digits=6)
    prefijo = fakeUsuario.prefixphone_provider()
    phoneConcat = str(prefijo) + str(telefono)
    return int(phoneConcat)
    
count = 1
error = False 
while count < 500 and not(error):
    email = fakeUsuario.email()
    telefono = telefonoFaker(fakeUsuario)
    contrasenia = fakeUsuario.lexify(text='??????????')
    try:     
        cur.execute("INSERT INTO usuario (correo_electronico, telefono, contrasenia) VALUES (%s, %s, %s)", (email, telefono, contrasenia))
        conn.commit()
        count += 1
    except psycopg2.Error as e:
        print("Error en usuarios:", e)
        conn.rollback()

# empresa
fakeEmpresa = Faker()
fakeEmpresa.add_provider(arg_pymes_provider)
count = 0
while count <= 250 and not(error):
    usuarioRandom = 0
    usuarioRandom = usuarioRandom + 1
    cuit = fakeEmpresa.bothify(text='##-########-#')
    nombreFantasia = fakeEmpresa.pymes_provider()
    fecha_creacion = fakeEmpresa.past_date('-18263d') # Genera una fecha pasada aleatoria en los últimos 50 años
    try:
        cur.execute("INSERT INTO empresa (usuario, cuit, nombre_fantasia, fecha_creacion) VALUES (%s, %s, %s, %s)", (usuarioRandom, cuit, nombreFantasia, fecha_creacion))
        conn.commit()
        count += 1
    except psycopg2.Error as e:
        print("Error en Empresa:", e)
        conn.rollback()
        error = True

# particular 
fakeParticular = Faker()
fakeParticular.add_provider(arg_name_provider)
fakeParticular.add_provider(arg_lastname_provider)
while count <= 500 and not(error):
    usuarioRandom = usuarioRandom + 1
    dni = fakeParticular.random(digits=8)
    fechaNacimiento = fakeParticular.past_date() 
    nombre = fakeParticular.name_provider()
    apellido = fakeParticular.lastname_provider()

    try: 
        cur.execute("INSERT INTO particular (usuario, DNI, fecha_nacimiento, nombre, apellido) VALUES (%s, %s, %s, %s, %s)", (usuarioRandom, dni, fechaNacimiento, nombre, apellido))
        conn.commit()
        count += 1
    except psycopg2.Error as e:
        print("Error en Particular:", e)
        conn.rollback()
        error = True

conn.commit()
cur.close()
conn.close()

print("Insert Completado!!")


