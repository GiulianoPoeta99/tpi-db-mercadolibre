import psycopg2

# obtengo los usuarios
def getUsers(cursor: psycopg2.extensions.cursor) -> list:
    query = "SELECT numero_cliente FROM usuario"
    cursor.execute(query)
    allUsers = cursor.fetchall()
    allUsers = [element[0] for element in allUsers]
    return allUsers 

# obtengo los usuarios que no son empresas
def getUsersNotCorporate(cursor: psycopg2.extensions.cursor) -> list:
    searchCorporateUser = "SELECT usuario FROM empresa"
    cursor.execute(searchCorporateUser)
    corporateUser = cursor.fetchall()
    corporateUser = [element[0] for element in corporateUser]
    searchParticularUser = "SELECT usuario FROM particular"
    cursor.execute(searchParticularUser)
    particularUser = cursor.fetchall()
    particularUser = [element[0] for element in particularUser]

    return set(getUsers(cursor)) - set(corporateUser) - set(particularUser)