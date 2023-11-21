from components.fillTable import *

# PLANTILLA

# tabla table_name
# numberTable += 1
# table = 'table_name'
# values = 'attr1, attr2, attr2'
# dataFunction = fakeTableNameData # nombre de la funcion hecha en fakerData
# minQuantity = 100
# maxQuantity = minQuantity # si se hace con esto se da a entender que es el mismo numero por lo tanto no hay intervalo
# warning = True/False # se escribe un mensaje de advertencia del paso anterior 
# # ¡No se toca!
# fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

def fillTablesAuto(cursor: psycopg2.extensions.cursor, connection: psycopg2.extensions.connection) -> None:
    # TODO: hacer una funcion para poder ejecutar el contenido del dml obligatorio

    numberTable = 0

    # tabla usuario
    numberTable += 1
    table = 'usuario'
    values = 'correo_electronico, telefono, contrasenia'
    dataFunction = fakeUserData
    minQuantity = 100
    maxQuantity = 5000
    warning = True
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

    # tabla empresa
    numberTable += 1
    table = 'empresa'
    values = 'usuario, cuit, nombre_fantasia, fecha_creacion'
    dataFunction = fakeCorporateData
    minQuantity = 100
    maxQuantity = minQuantity
    warning = False
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

    # tabla particular
    numberTable += 1
    table = 'particular'
    values = 'usuario, DNI, fecha_nacimiento, nombre, apellido'
    dataFunction = fakeParticularData
    minQuantity = len(getUsersNotCorporate(cursor))
    maxQuantity = minQuantity
    warning = False
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

    # tabla direccion
    numberTable += 1
    table = 'direccion'
    values = 'codigo_postal, calle, altura'
    dataFunction = fakeAdressData
    minAdressesQuantity = 100
    maxQuantity = len(getUsers(cursor)) * 2
    warning = False
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minAdressesQuantity, maxQuantity, warning)

    # tabla metodo_de_pago
    numberTable += 1
    table = 'metodo_de_pago'
    values = 'titular, numero_tarjeta, clave_seguridad, fecha_caducidad, empresa_emisora, tipo, usuario'
    dataFunction = fakePaymentMethodData
    minQuantity = 100
    maxQuantity = 10000
    warning = False
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

    # tabla producto
    numberTable += 1
    table = 'producto'
    values = 'es_nuevo, precio_unitario, detalle, descripcion_producto, nombre_producto, stock, calificacion'
    dataFunction = fakeProductData # nombre de la funcion hecha en fakerData
    minProductQuantity = 300
    maxQuantity = 3000 # si se hace con esto se da a entender que es el mismo numero por lo tanto no hay intervalo
    warning = False # se escribe un mensaje de advertencia del paso anterior 
    print("Se agregaran 10 manualmente para la muestra.")
    # ¡No se toca!
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minProductQuantity, maxQuantity, warning)

    # tabla categoria
    numberTable += 1
    table = 'categoria'
    notFillTable(table, numberTable)
    sleep(2)

    # tabla categoria_subcateoria
    numberTable += 1
    table = 'categoria_subcateoria'
    notFillTable(table, numberTable)
    sleep(2)

    # tabla oferta
    numberTable += 1
    table = 'oferta'
    values = 'porcentaje, fecha_desde, fecha_hasta'
    dataFunction = fakeOfertData
    minOfertQuantity = 10
    maxQuantity = 100
    warning = False
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minOfertQuantity, maxQuantity, warning)

    # tabla pregunta
    numberTable += 1
    table = 'pregunta'
    notFillTable(table, numberTable)
    sleep(2)

    # tabla imagen
    numberTable += 1
    table = 'imagen'
    values = 'producto, imagen'
    dataFunction = fakeImage
    minQuantity = minProductQuantity
    maxQuantity = 50000
    warning = False
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

    # tabla envio 
    numberTable += 1
    table = 'envio'
    values = 'tipo_envio'
    dataFunction = fakeShipping # nombre de la funcion hecha en fakerData
    minShippingQuantity = 300
    maxQuantity = 3000 # si se hace con esto se da a entender que es el mismo numero por lo tanto no hay intervalo
    warning = False 
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minShippingQuantity, maxQuantity, warning)

    # tabla resenia 
    numberTable += 1
    table = 'resenia'
    values = 'resenia_producto, calificacion, producto'
    dataFunction = fakeReview # nombre de la funcion hecha en fakerData
    minQuantity = 300
    maxQuantity = 3000 # si se hace con esto se da a entender que es el mismo numero por lo tanto no hay intervalo
    warning = False 
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

    # tabla pedido 
    numberTable += 1 
    table = 'pedido'
    values = 'fecha_pedido, metodo_pago, particular, resenia'
    dataFunction = fakeOrder 
    minOrderQuantity = 1000 
    maxQuantity = 6000
    warning = False 
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minOrderQuantity, maxQuantity, warning)

    # tabla item 
    numberTable += 1 
    table = 'item'
    values = 'cantidad, estado, tipo_entrega, envio_domicilio, usuario, producto, direccion, pedido'
    dataFunction = fakeItem 
    minQuantity = minOrderQuantity #Cada item corresponde a un pedido por lo que el numero de items no puede ser menor al de pedidos
    maxQuantity = 6000
    warning = False 
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

    # tabla usuario_direccion 
    numberTable += 1 
    table = 'usuario_direccion'
    values = 'usuario, direccion'
    dataFunction = fakeUserAdress 
    minQuantity = minAdressesQuantity
    maxQuantity = minQuantity
    warning = False 
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

    # tabla item_envio 
    numberTable += 1 
    table = 'item_envio'
    values = 'item, envio'
    dataFunction = fakeItemShipping
    minQuantity = minShippingQuantity
    maxQuantity = minQuantity
    warning = False 
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

    # TODO: arreglar esta faker para que funcione la tabla
    # # tabla pregunta_producto_usuario
    # numberTable += 1 
    # table = 'pregunta_producto_usuario'
    # values = 'pregunta, producto, usuario'
    # dataFunction = fakeAskProductUser
    # minQuantity = len(getProduct(cursor))
    # maxQuantity = minQuantity
    # warning = False 
    # print("se agregaran mas manualmente para las preguntas.")
    # fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

    # tabla producto_categoria
    numberTable += 1
    table = 'producto_categoria'
    notFillTable(table, numberTable)
    sleep(2)

    # tabla pregunta_respuesta
    numberTable += 1
    table = 'pregunta_respuesta'
    notFillTable(table, numberTable)
    sleep(2)

    # tabla oferta_producto 
    numberTable += 1 
    table = 'oferta_producto'
    values = 'oferta, producto'
    dataFunction = fakeOfertProduct
    minQuantity = minOfertQuantity * 4
    maxQuantity = minQuantity
    warning = False 
    fillTable(connection, cursor, numberTable, table, values, dataFunction, minQuantity, maxQuantity, warning)

    print('''\n
    Las tablas:
    * producto
    * categoria
    * categoria_subcateoria
    * pregunta
    * pregunta_producto_usuario
    * producto_categoria
    * pregunta_respuesta
        
    Se rellenaran manualmente en el archivo "dml.sql".
    ''')