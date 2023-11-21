from dotenv import load_dotenv
import os

# cargamos el .env
load_dotenv()

# Datos de conexión
DB_NAME = os.getenv("POSTGRES_DB")
DB_USER = os.getenv("POSTGRES_USER")
DB_PASS = os.getenv("POSTGRES_PASSWORD")
DB_HOST = "localhost"  # Por lo general, localhost si estás trabajando de manera local
DB_PORT = os.getenv("DB_PORT")