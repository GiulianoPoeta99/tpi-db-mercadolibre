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
    randomUser = random.choice(list(getUsersNotCorporate(cursor)))
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