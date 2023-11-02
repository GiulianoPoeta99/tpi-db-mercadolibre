

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