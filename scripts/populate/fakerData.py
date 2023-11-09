from faker import Faker
import random
from components.constants import *

from components.querys import *
from components.customProviders import *

# creamos objetos fake en diferentes regiones
fakeEn = Faker() # ingles
fakeEsAr = Faker('es_AR') # español argentina

def getRandomUser(cursor: psycopg2.extensions.cursor):
    return random.choice(list(getUsers(cursor)))

# PLANTILLA
# si los atributos son strings hay que ponerlo entre ''
# def fakeTableNameData(cursor) -> str:
#     attribute1 = fakeNumber
#     attribute2 = fakeString
#     attribute3 = fakeNumber
#     return f"{attribute1}, '{attribute2}', {attribute3}"

def fakeUserData(cursor: psycopg2.extensions.cursor) -> str:
    email = fakeEsAr.email()
    phone = fakeEsAr.phone_number()
    password = fakeEn.lexify(text='??????????')
    return f"'{email}', '{phone}', '{password}'"

def fakeCorporateData(cursor: psycopg2.extensions.cursor) -> str:
    randomUser = getRandomUser(cursor)
    cuit = fakeEn.bothify(text = '##-########-#')
    fakeEn.add_provider(arg_pymes_provider)
    fantasyName = fakeEn.pymes_provider()
    creationDate = fakeEn.past_date('-18263d') # Genera una fecha pasada aleatoria en los últimos 50 años
    return f"{randomUser}, '{cuit}', '{fantasyName}', '{creationDate}'"

def fakeParticularData(cursor: psycopg2.extensions.cursor) -> str:
    randomUser = random.choice(list(getUsersNotCorporateAvaible(cursor)))
    dni = fakeEn.bothify(text = '########')
    dateOfBirth = fakeEn.past_date('-29220d') # Genera una fecha pasada aleatoria en los últimos 80 años
    firstName = fakeEsAr.first_name()
    lastName = fakeEsAr.last_name()
    return f"{randomUser}, '{dni}', '{dateOfBirth}', '{firstName}', '{lastName}'"

def fakeAdressData(cursor: psycopg2.extensions.cursor):
    zipCode = random.randint(1001,9431)
    street = fakeEsAr.street_name()
    streetNumber = fakeEn.bothify(text = '####')
    return f"'{zipCode}', '{street}', '{streetNumber}'"

def fakePaymentMethodData(cursor: psycopg2.extensions.cursor) -> str:
    cardHolder = fakeEsAr.name()
    cardNumber = fakeEn.bothify(text = '################')
    securityKey = fakeEn.bothify(text = '###')
    expirationDate = fakeEn.future_date('+2555d')
    partsExpirationDate = str(expirationDate).split('-')
    expirationDate = partsExpirationDate[0] + '-' + partsExpirationDate[1] + '-01'
    issuerCompany = random.choice(list(ISSUER_COMPANY))
    cardType = random.choice(list(CARD_TYPES))
    user = getRandomUser(cursor)
    return f"'{cardHolder}', '{cardNumber}', '{securityKey}', '{expirationDate}', '{issuerCompany}', '{cardType}', {user}"

def fakeOfertData(cursor: psycopg2.extensions.cursor) -> str:
    percentage = random.randint(5, 80)
    date_from = fakeEn.date_between('-100d','+1d')
    date_to = fakeEn.date_between('+2d','+100d')
    return f"'{percentage}', '{date_from}', '{date_to}'"

def fakeProductData(cursor) -> str:
    isNew = bool(random.choice(list([0,1])))
    unityPrice = fakeEn.bothify(text= "####.##" )
    detail = fakeEn.paragraph(nb_sentences = 2)
    description = fakeEn.paragraph(nb_sentences= 5)
    fakeEn.add_provider(arg_products_provider)
    productName =  fakeEn.products_provider()
    if (not(isNew)): 
        stock = 1
    else:
        stock = fakeEn.bothify(text= "##")
    calification = random.randint(1,5)
    randomUser = getRandomUser(cursor)
    return f"{isNew}, '{unityPrice}','{detail}', '{description}' , '{productName}', '{stock}', {calification}, {randomUser}"

def fakeShipping(cursor) -> str:
    shippingType = random.choice(list(SHIPPING_TYPE))
    return f" '{shippingType}'"

def fakeReview(cursor) -> str: 
    reviewContent = fakeEn.paragraph(nb_sentences= 5)
    calification = random.randint(1, 5)
    product = random.choice(list(getProduct(cursor)))
    return f" '{reviewContent}', {calification}, {product}"

def fakeOrder(cursor) -> str: 
    orderDate = fakeEn.date_between('-100d','+1d')
    particular = random.choice(list(getUsersNotCorporate(cursor))) 
    paymentMethodList = list(getPaymentMethod(cursor, particular))
    while not(paymentMethodList): 
        particular = random.choice(list(getUsersNotCorporate(cursor)))
        paymentMethodList = list(getPaymentMethod(cursor, particular))
    paymentMethod = random.choice(paymentMethodList) 
    review = getReview(cursor)
    return f"'{orderDate}', {paymentMethod}, {particular}, {review} "

def fakeItem(cursor) -> str: #queda un error en esta funcion pendiente de resolver
    quantity = fakeEn.bothify(text="#")
    state = random.choice(list(SHIPPING_STATE))
    shippingType = random.choice(list(SHIPPING_TYPE))
    user = random.choice(list(getUsersNotCorporate(cursor)))
    product = random.choice(list(getProduct(cursor)))
    address = random.choice(list(getAddress(cursor)))
    orderNumber = random.choice(list(getOrder(cursor)))
    orderType = getShippingTypeOrder(cursor, orderNumber)   
    if orderType in ['envio rapido','envio normal a domicilio']: 
        homeShip = True 
    else: 
        homeShip = False 
    
    return f" {quantity}, '{state}','{shippingType}', {homeShip}, {user}, {product}, '{address}', {orderNumber}"
