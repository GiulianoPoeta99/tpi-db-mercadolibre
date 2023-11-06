from faker import Faker
import random
from constants import *

from querys import *
from customProviders import *

# creamos objetos fake en diferentes regiones
fakeEn = Faker() # ingles
fakeEsAr = Faker('es_AR') # español argentina

def getRandomUser(cursor):
    return random.choice(list(getUsers(cursor)))

# PLANTILLA
# si los atributos son strings hay que ponerlo entre ''
# def fakeTableNameData() -> str:
#     attribute1 = fakeNumber
#     attribute2 = fakeString
#     attribute3 = fakeNumber
#     return f"{attribute1}, '{attribute2}', {attribute3}"

def fakeUserData() -> str:
    email = fakeEsAr.email()
    phone = fakeEsAr.phone_number()
    password = fakeEn.lexify(text='??????????')
    return f"'{email}', '{phone}', '{password}'"

def fakeCorporateData(cursor) -> str:
    randomUser = getRandomUser(cursor)
    cuit = fakeEn.bothify(text = '##-########-#')
    fakeEn.add_provider(arg_pymes_provider)
    fantasyName = fakeEn.pymes_provider()
    creationDate = fakeEn.past_date('-18263d') # Genera una fecha pasada aleatoria en los últimos 50 años
    return f"{randomUser}, '{cuit}', '{fantasyName}', '{creationDate}'"

def fakeParticularData(allUsersAvailable: list) -> str:
    randomUser = random.choice(list(allUsersAvailable))
    dni = fakeEn.bothify(text = '########')
    dateOfBirth = fakeEn.past_date('-29220d') # Genera una fecha pasada aleatoria en los últimos 80 años
    firstName = fakeEsAr.first_name()
    lastName = fakeEsAr.last_name()
    return f"{randomUser}, '{dni}', '{dateOfBirth}', '{firstName}', '{lastName}'"

def fakeAdressData():
    zipCode = random.randint(1001,9431)
    street = fakeEsAr.street_name()
    streetNumber = fakeEn.bothify(text = '####')
    return f"'{zipCode}', '{street}', '{streetNumber}'"

def fakePaymentMethodData(cursor) -> str:
    cardHolder = fakeEsAr.name()
    cardNumber = fakeEn.bothify(text = '################')
    securityKey = fakeEn.bothify(text = '###')
    expirationDate = fakeEn.past_date('2555d')
    partsExpirationDate = expirationDate.split('-')
    expirationDate = partsExpirationDate[0] + '-' + partsExpirationDate[1] + '-01'
    issuerCompany = random.choice(list(CARD_TYPES))
    cardType = random.choice(list(ISSUER_COMPANY))
    user = getRandomUser(cursor)
    return f"'{cardHolder}', '{cardNumber}', '{securityKey}', '{expirationDate}', '{issuerCompany}', '{cardType}', {user}"