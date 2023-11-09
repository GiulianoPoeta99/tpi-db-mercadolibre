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

    return set(getUsers(cursor)) - set(corporateUser)

# obtengo los usuarios que no son empresas
def getUsersNotCorporateAvaible(cursor: psycopg2.extensions.cursor) -> list:
    searchCorporateUser = "SELECT usuario FROM empresa"
    cursor.execute(searchCorporateUser)
    corporateUser = cursor.fetchall()
    corporateUser = [element[0] for element in corporateUser]
    searchParticularUser = "SELECT usuario FROM particular"
    cursor.execute(searchParticularUser)
    particularUser = cursor.fetchall()
    particularUser = [element[0] for element in particularUser]

    return set(getUsers(cursor)) - set(corporateUser) - set(particularUser)

# obtengo productos publicados
def getProduct(cursor: psycopg2.extensions.cursor) -> list:
    query = "SELECT numero_articulo FROM producto"
    cursor.execute(query)
    allProducts = cursor.fetchall()
    allProducts = [element[0] for element in allProducts]
    return allProducts 

# obtengo direcciones de usuarios existentes
def getAddress(cursor: psycopg2.extensions.cursor) -> list:
    query = "SELECT direccion FROM usuario_direccion"
    cursor.execute(query)
    allAddress = cursor.fetchall()
    allAddress = [element[0] for element in allAddress]
    return allAddress 

# obtengo todos los pedidos 
def getOrder(cursor: psycopg2.extensions.cursor) -> list:
    query = "SELECT numero_de_pedido FROM pedido"
    cursor.execute(query)
    allOrders = cursor.fetchall()
    allOrders = [element[0] for element in allOrders]
    return allOrders 

#obtengo un metodo de pago del usuario solicitado
def getPaymentMethod(cursor: psycopg2.extensions.cursor, userNumber) -> int:
    query = "SELECT id_tarjeta FROM metodo_de_pago WHERE usuario = %s"
    cursor.execute(query, (userNumber,))
    result = cursor.fetchone()
    return result[0] #problema: si tiene multiples metodos de pago siempre va a usar el mismo
    
    
#obtengo tipo de envio del pedido 
def getShippingTypeOrder(cursor: psycopg2.extensions.cursor, orderNumber) -> str:
    query = "SELECT tipo_envio FROM envio WHERE id_envio = %s" 
    cursor.execute(query, (orderNumber,))
    result = cursor.fetchone()
    return result[0]

def getReview(cursor: psycopg2.extensions.cursor) -> int:
    query = "SELECT id_resenia FROM resenia"
    cursor.execute(query)
    result = cursor.fetchone()
    return result[0]
    