from faker import Faker
from faker.providers import DynamicProvider


arg_province_provider = DynamicProvider(
    provider_name = "province_provider",
    elements = [
        "Buenos Aires", "Catamarca", "Chaco", "Chubut", "Córdoba", "Corrientes", 
        "Entre Ríos", "Formosa", "Jujuy", "La Pampa", "La Rioja", "Mendoza", "Misiones", 
        "Neuquén", "Río Negro", "Salta", "San Juan", "San Luis", "Santa Cruz", "Santa Fe", 
        "Santiago del Estero", "Tierra del Fuego", "Tucumán"
    ],
)

arg_name_provider = DynamicProvider(
    provider_name = "name_provider",
    elements = [
        "Abril", "Agustín", "Ailén", "Alan", "Alejandro", "Alicia", "Ana", "Andrés", 
        "Antonella", "Antonio", "Ariana", "Augusto", "Brenda", "Brian", "Camila", 
        "Carlos", "Carolina", "Catalina", "Ciro", "Clara", "Claudia", "Cristian", 
        "Daniela", "Diego", "Elena", "Emanuel", "Emilia", "Facundo", "Florencia", 
        "Francisco", "Gabriel", "Guillermo", "Iara", "Ignacio", "Isabella", "Isabel", 
        "Joaquín", "José", "Juan", "Juana", "Laura", "Leandro", "Lautaro", "Lía", "Lucas", 
        "Lucía", "Luis", "Manuel", "Mariana", "Martina", "Matías", "Mía", "Miguel", "Nahuel", 
        "Natalia", "Nicolás", "Noelia", "Olivia", "Pablo", "Patricia", "Paula", "Pedro", 
        "Rafael", "Ramiro", "Renata", "Roberto", "Romina", "Santiago", "Sofía", "Tomas", 
        "Valentina", "Valentín", "Victoria", "Violeta","Abram", "Adela", "Alba", "Albano", 
        "Alcira", "Alejandra", "Alfonso", "Alfredo", "Alicia", "Alma", "Alvaro", "Amelia", 
        "Ana", "Anastasia", "Andrea", "Andrés", "Ángela", "Ángeles", "Angélica", "Antonia", 
        "Antonio", "Ariadna", "Armando", "Arturo", "Astrid", "Aurelia", "Aurora", "Axel", 
        "Azul", "Bartolomé", "Belén", "Benjamín", "Bernardo", "Blanca", "Braulio", "Bruno", 
        "Candela", "Carlos", "Carolina", "Casandra", "Catalina", "Cecilia", "Celeste", 
        "Celia", "Cesar", "Clara", "Cristian", "Cristina", "Cristóbal", "Dalia", "David", 
        "Débora", "Delfina", "Diego", "Dolores", "Edmundo", "Eduardo", "Elena", "Elio", 
        "Elisa", "Elsa", "Elvira", "Emilio", "Enrique", "Erick", "Esteban", "Eva", 
        "Ezequiel", "Fabián", "Federico", "Felipe", "Fernanda", "Fernando", "Flavia", 
        "Flavio", "Francisca", "Francisco", "Gabriel", "Gastón", "Gerardo", "Germán", 
        "Gisela", "Gonzalo", "Graciela", "Guadalupe", "Guillermo", "Gustavo", "Héctor", 
        "Helena", "Horacio", "Hugo", "Ignacio", "Inés", "Irene", "Iris", "Isabel", 
        "Isabela", "Iván", "Jacinta", "Javier", "Jeremías", "Jessica", "Joaquín", 
        "Jorge", "José", "Josefina", "Juan", "Juana", "Julia", "Juliana", "Julieta", 
        "Laura", "Lautaro", "Leticia", "Lila", "Liliana", "Lorena", "Lorenzo", 
        "Lourdes", "Lucas", "Lucía", "Luis", "Luisa", "Luna", "Magdalena", "Manuela", 
        "Marcela", "Marcelo", "Marcia", "Marco", "Marcos", "Margarita", "María", 
        "Mariana", "Mariano", "Marina", "Mario", "Marisa", "Martín", "Mauricio", 
        "Maximiliano", "Melanie", "Melina", "Mía", "Micaela", "Miguel", "Miranda", 
        "Mónica", "Nadia", "Nahuel", "Natalia", "Natividad", "Nicolás", "Noelia", 
        "Norma", "Octavio", "Olga", "Olivia", "Omar", "Pablo", "Paola", "Patricia", 
        "Paula", "Pedro", "Pilar", "Rafael", "Ramiro", "Raúl", "Renata", "Ricardo", 
        "Roberto", "Rodrigo", "Rosa", "Roxana", "Rubén", "Ruth", "Sabrina", "Sandra", 
        "Santiago", "Santino", "Sara", "Sebastián", "Selena", "Silvia", "Simón", 
        "Sofía", "Sol", "Sonia", "Soraya", "Tamara", "Tania", "Tatiana", "Tomás", 
        "Valentina", "Valeria", "Vanessa", "Vera", "Verónica", "Vicente", "Victoria", 
        "Violeta", "Viviana", "Walter", "Ximena", "Yolanda", "Zoe"
    ]
)

arg_lastname_provider= DynamicProvider(
    provider_name = "lastname_provider",
    elements = [
        "Rodríguez", "González", "Gómez", "Fernández", "López", "Díaz", "Martínez", 
        "Pérez", "García", "Sánchez", "Romero", "Sosa", "Álvarez", "Torres", "Ruiz", 
        "Ramírez", "Flores", "Benítez", "Acosta", "Alvarez", "Silva", "Morales", 
        "Santos", "Rojas", "Gutiérrez", "Vega", "Molina", "Leiva", "Aguirre", 
        "Medina", "Hernández", "Castro", "Vázquez", "Giménez", "Mendoza", 
        "Suárez", "Cabrera", "Ríos", "Ortiz", "Núñez", "Vidal", "Godoy", 
        "Miranda", "Bravo", "Guzmán", "Escobar", "Gallardo", "Calderón", 
        "Pereyra", "Campos", "Peralta", "Ferreira", "Villalba", "Ponce", 
        "Cáceres", "Córdoba", "Vera", "Nieves", "Roldán", "Duarte", 
        "Camacho", "Vargas", "Barrios", "Arias", "Paz", "Juárez", 
        "Gallego", "Ojeda", "Guevara", "Valdez", "Méndez", "Galván", 
        "Chávez", "Rosales", "Ocampo", "Suarez", "Maldonado", "Moreno", 
        "Ramos", "Acuña", "Soto", "Villanueva", "Villa", "Galeano", 
        "Leguizamo", "Leiva", "Alderete", "Luna", "Quispe", "Lezcano", 
        "Góngora", "Cordoba", "Barreto", "Crespo", "Cuevas", "Zarate", 
        "Gimenez", "Villalobos", "Acuña", "Vallejos", "Ferreyra", 
        "Toledo", "Rivas", "Rivarola", "Valdez", "Cáceres", "Lara", 
        "Ferreyra", "Peralta", "Colman", "Castillo", "Villarreal", 
        "Velázquez", "Luna", "Guerrero", "Pereyra", "Bazán", "Martinez", 
        "Puebla", "Zambrano", "Salinas", "Salcedo", "Guerra", "Bautista", 
        "Maldonado", "Ledesma", "Ferreyra", "Luque", "Benegas", "López", 
        "Ortega", "Peralta", "Aguilera", "Cabrera", "Chavez", "García", 
        "Santos", "Albornoz", "Alonso", "Benítez", "Coronel", "Dominguez", 
        "Gimenez", "Gutierrez", "Martinez", "Paez", "Peréz", "Ramirez", 
        "Santos", "Villalba", "Milei", "Massa", "Bullrich", "Schiaretti", 
        "Bregman", "Boomrich"
    ] 
)

arg_prefixphone_provider = DynamicProvider(
    provider_name = "prefixphone_procider",
    elements=[
        "11","221","223","291","3833","351",
        "3783","3722","2965","343","3717","2954",
        "3822","261","3752","299","2920","387","264",
        "2652","2966","342","341","385","381","2901"
    ]
)

arg_cat_provider = DynamicProvider(
    provider_name = "cat_provider",
    elements = [
        "Electrónica","Ropa y Accesorios","Calzado","Belleza y Cuidado Personal",
        "Hogar","Jardín","Deportes y Actividades al Aire Libre","Juguetes y Juegos",
        "Libros y Material de Oficina","Electrodomésticos","Muebles","Alimentos y Bebidas",
        "Automóviles y Accesorios","Instrumentos Musicales","Arte y Manualidades",
        "Electrónica de Consumo","Salud y Bienestar","Maletas y Equipaje",
        "Productos para Bebés y Niños","Joyas y Relojes","Electrodomésticos de Cocina",
        "Herramientas y Mejoras para el Hogar","Productos para Mascotas","Equipamiento para Negocios",
        "Productos para el Cuidado del Cabello","Cámaras y Fotografía","Equipamiento para Deportes y Fitness",
        "Equipos de Oficina","Juegos de Mesa y Rompecabezas","Suministros para Fiestas y Eventos",
        "Equipamiento para Viajes y Aventuras","Productos para el Cuidado de la Piel",
        "Equipamiento para Acampar y Excursionismo","Equipamiento para Actividades Acuáticas",
        "Electrodomésticos para la Limpieza","Equipamiento para la Playa y Piscina",
        "Equipos de Sonido y Audio","Equipamiento para Ciclismo","Equipamiento para Deportes de Invierno",
        "Productos para el Cuidado de la Salud","Equipamiento para Deportes de Raqueta",
        "Equipamiento para Deportes de Pelota","Equipamiento para Deportes de Combate",
        "Productos para el Cuidado Oral","Equipamiento para Deportes de Equipo",
        "Productos para el Cuidado de los Ojos","Productos de Higiene Personal",
        "Equipamiento para Deportes de Agua","Equipamiento para Deportes de Aventura",
        "Productos para el Cuidado de las Uñas","Equipamiento para Deportes de Montaña",
        "Equipamiento para Deportes de Escalada","Equipamiento para Deportes de Motor",
        "Productos para el Cuidado de la Barba","Equipamiento para Deportes de Vuelo",
        "Equipamiento para Deportes de Tiro","Productos de Aseo Personal",
        "Equipamiento para Deportes de Lucha","Equipamiento para Deportes de Invierno"
    ]
)

arg_pymes_provider = DynamicProvider(
    provider_name = "pymes_provider",
    elements = [
        "TechSolutions","GlobalGourmet","StarElectronics","NaturalLiving","SportMax","DiamondBeauty",
        "CreativeWorks","UrbanHarvest","SkyHighAdventures","GreenPower","EliteEvents","GoldenCoast",
        "InnovaTech","SunriseHomes","FreshMarket","RainbowDesigns","SmartSolutions","UrbanStyle",
        "SwiftFoods","BlueWave","SunsetView","OceanVoyage","IdeaFactory","NatureFresh","HarmonyHomes",
        "ZenithBuilders","EnchantedGardens","SilverLining","OceanBreeze","PacificPearls","GoldenFields",
        "WhisperingWinds","RoyalRidge","DreamBuilders","AmberWaves","CosmicCreations","RadiantRidge",
        "LuxuryLiving","StarrySkies","WhimsicalWaters","DazzlingDunes","SecretSunrise","ParadisePoint",
        "TimelessTreasures","GoldenKey","SkylineInnovations","NatureNest","BlissfulBoutique",
        "StarlightSplendor","MajesticHomes","HarborVista","NovaBuilders","DreamyInteriors",
        "UrbanEscape","RadiantGrove","DiamondView","EcoHarbor","LuxeDesigns","AmbientGlow",
        "UrbanAura","EmeraldEchoes","TechNova","GlobalGenius","EmpireBuilders","OceanVista",
        "MysticMinds","NaturalElegance","SeaBreeze","GreenVibes","EnchantedSpaces","OceanPearls",
        "DreamCove","RadiantHomes","MoonlitMajesty","StarrySkies","WhimsicalWaters","DazzlingDunes",
        "SecretSunrise","ParadisePoint","SparklingShores","WhisperingPines","CrimsonCove","GoldenHarbor",
        "OceanfrontVilla","SeasideEscape","WhimsicalWoods","SunsetVoyage","GoldenSunrise","EmeraldHaven",
        "LuxuryLiving","TranquilHomes","DreamyDwellings","StarView","GoldenFields","StarrySkies",
        "RadiantRidge","RoyalRidge","MoonlitMajesty","WhisperingWinds","OceanBreeze","HarmonyHaven",
        "DazzlingDunes","SecretSunrise","ParadisePoint","TimelessTreasures","GoldenKey","BlueHorizon",
        "GreenSolutions","NaturalLiving","SunriseHomes","SwiftFoods","RainbowDesigns","StarlightSplendor",
        "UrbanHarvest","SkyHighAdventures","GoldenCoast","InnovaTech","FreshMarket","EliteEvents",
        "OceanVoyage","IdeaFactory","SunsetView","SilverLining","UrbanStyle","PacificPearls",
        "HarmonyHomes","ZenithBuilders","NatureFresh","EnchantedGardens","SunriseVista",
        "RoyalRidge","DreamBuilders","AmberWaves","RadiantRidge","StarrySkies","OceanBreeze",
        "PacificPearls","GoldenFields","WhisperingWinds","NovaBuilders","BlissfulBoutique",
        "UrbanEscape","LuxeDesigns","RadiantGrove","SeaBreeze","AmbientGlow","EmeraldEchoes",
        "TechNova","GlobalGenius","EmpireBuilders","NatureNest","UrbanAura","EcoHarbor",
        "DreamyInteriors","TimelessTreasures","UrbanVibe","StarrySkies","RadiantRidge",
        "DreamCove","MoonlitMajesty","WhisperingWinds","HarmonyHaven","SecretSunrise",
        "ParadisePoint","SparklingShores","OceanfrontVilla","SeasideEscape","WhimsicalWoods",
        "SunsetVoyage","GoldenSunrise","EmeraldHaven","LuxuryLiving","TranquilHomes",
        "DreamyDwellings","StarView","GoldenFields","StarrySkies","RadiantRidge",
        "RoyalRidge","MoonlitMajesty","WhisperingWinds","OceanBreeze","HarmonyHaven",
        "DazzlingDunes","SecretSunrise","ParadisePoint","TimelessTreasures","GoldenKey",
        "UrbanNest","BlueHorizon","GreenSolutions","NaturalLiving","SunriseHomes",
        "SwiftFoods","RainbowDesigns","StarlightSplendor","Urban","UrbanMix", "Ardidas", 
        "Mike", "StellaMaris", "Popper", "DC"
    ]
)

arg_products_provider = DynamicProvider(
    provider_name = "products_provider",
    elements = ['iPhone 13 Pro', 'Samsung Galaxy S21', 'Google Pixel 6', 'OnePlus 9 Pro', 'Xiaomi Mi 11', 'Sony Xperia 1 III', 'Huawei P40 Pro', 'OnePlus Nord', 'Google Pixel 5', 'Samsung Galaxy Note 20 Ultra', 'iPhone 12 Mini', 'OnePlus 8T', 'Xiaomi Mi 10T Pro', 'Samsung Galaxy A52', 'Google Pixel 4a', 'OnePlus 9', 'iPhone SE (2020)', 'Xiaomi Poco X3', 'Sony Xperia 5 II', 'Huawei Mate 40 Pro', 'Samsung Galaxy Z Fold 2', 'Google Pixel 4', 'OnePlus 8 Pro', 'iPhone 11', 'Xiaomi Redmi Note 10 Pro', 'Samsung Galaxy S20 FE', 'Google Pixel 3a', 'OnePlus 8', 'Sony Xperia 10 II', 'Huawei P30 Pro', 'Samsung Galaxy A72', 'iPhone XR', 'Xiaomi Mi 10', 'OnePlus 7T Pro', 'Google Pixel 3', 'Samsung Galaxy S20 Ultra', 'Sony Xperia 10 Plus', 'Huawei Nova 7i', 'Xiaomi Mi 9T Pro', 'OnePlus 7 Pro', 'iPhone X', 'Samsung Galaxy S20+', 'Google Pixel 3 XL', 'Sony Xperia 10', 'Huawei P20 Pro', 'Xiaomi Mi Note 10', 'OnePlus 7T', 'iPhone 8', 'Samsung Galaxy S10e', 'Google Pixel 2', 'Sony Xperia XZ3', 'Huawei P40 Lite', 'Xiaomi Mi 9', 'OnePlus 6T', 'iPhone 8 Plus', 'Samsung Galaxy S10+', 'Google Pixel 2 XL', 'Sony Xperia XZ2', 'Huawei P30 Lite', 'Xiaomi Redmi Note 8 Pro', 'OnePlus 6', 'iPhone 7', 'Samsung Galaxy S10', 'Google Pixel', 'Sony Xperia XZ1', 'Huawei P20', 'Xiaomi Redmi Note 9', 'OnePlus 5T', 'iPhone 7 Plus', 'Samsung Galaxy S9', 'Google Pixel XL', 'Sony Xperia XZ', 'Huawei P10', 'Xiaomi Redmi Note 7', 'OnePlus 5', 'iPhone 6s', 'Samsung Galaxy S9+', 'Google Pixel 3a XL', 'Sony Xperia XA2', 'Huawei Mate 20 Pro', 'Xiaomi Redmi Note 9S', 'OnePlus 3T', 'iPhone 6s Plus', 'Samsung Galaxy Note 9', 'Google Pixel 3 XL', 'Sony Xperia XA1', 'Huawei Mate 20 Lite', 'Xiaomi Poco F2 Pro', 'OnePlus 3', 'iPhone 6', 'Samsung Galaxy Note 8', 'Google Pixel 3a', 'Sony Xperia XA1 Ultra', 'Huawei Mate 10 Pro', 'Xiaomi Mi A3', 'OnePlus X', 'iPhone 6 Plus', 'Samsung Galaxy Note 10', 'Google Pixel 2', 'Sony Xperia XA2 Ultra', 'Huawei Nova 5T', 'Xiaomi Mi A2', 'OnePlus 2', 'iPhone 5s', 'Samsung Galaxy A51', 'Google Pixel 4a', 'Sony Xperia L3', 'Huawei P10 Lite', 'Xiaomi Mi 8', 'OnePlus One','Nike Air Max 90', 'Adidas Superstar', 'Converse Chuck Taylor All Star', 'Vans Old Skool', 'Puma Cali', 'Reebok Classic Leather', 'New Balance 990', 'Under Armour HOVR Phantom', 'Saucony Jazz Original', 'Brooks Ghost 13', 'ASICS Gel-Kayano 27', 'Salomon Speedcross 5', 'Hoka One One Clifton 7', 'Mizuno Wave Rider 24', 'Fila Disruptor', 'Sketchers Go Walk 5', 'Merrell Moab 2', 'Columbia Newton Ridge Plus II', 'Timberland Earthkeepers', 'Dr. Martens 1460', 'Birkenstock Arizona', 'Crocs Classic', 'Clarks Desert Boot', 'UGG Classic Short', 'Steve Madden Gills', 'Vionic Tide II', 'Birkenstock Gizeh', 'Keen Targhee II', 'Ecco Soft 7', 'Teva Hurricane XLT2', 'Sanuk Yoga Sling 2', 'Chaco Z/Cloud', 'Toms Alpargata', 'Cole Haan Grand Crosscourt', 'Birkenstock Mayari', 'UGG Neumel', 'Skechers D\'Lites', 'Converse Chuck 70', 'Vans Sk8-Hi', 'Puma RS-X', 'Reebok Club C 85', 'New Balance Fresh Foam 1080v11', 'Under Armour Project Rock 3', 'Saucony Kinvara 12', 'Brooks Adrenaline GTS 21', 'ASICS Gel-Nimbus 23', 'Salomon XA Pro 3D V8', 'Hoka One One Bondi 7', 'Mizuno Wave Inspire 17', 'Fila Ray Tracer', 'Skechers Ultra Flex', 'Merrell Jungle Moc', 'Columbia Redmond V2', 'Timberland PRO Pit Boss', 'Dr. Martens 1461', 'Birkenstock Boston', 'Crocs Classic Clog', 'Clarks Wallabee', 'UGG Ansley', 'Steve Madden Ecentrcq', 'Vionic Walker', 'Birkenstock Milano', 'Keen Newport H2', 'Ecco Biom Fjuel', 'Teva Original Universal', 'Sanuk Beer Cozy 2', 'Chaco Z/Volv', 'Toms Classic', 'Cole Haan Zerogrand', 'Birkenstock Madrid', 'UGG Fluff Yeah', 'Skechers Go Run', 'Converse Chuck Taylor All Star High Top', 'Vans Authentic', 'Puma Calibrate', 'Reebok Nano X1', 'New Balance Fresh Foam Beacon v3', 'Under Armour Charged Assert 8', 'Saucony Guide 14', 'Brooks Launch 8', 'ASICS Gel-Cumulus 23', 'Salomon X Ultra 3', 'Hoka One One Mach 4', 'Mizuno Wave Horizon 5', 'Fila Disruptor II', 'Sketchers D\'Lites 3', 'Merrell Moab 2 Vent', 'Columbia Newton Ridge Plus Waterproof Amped', 'Timberland Earthkeepers Rugged', 'Dr. Martens 2976 Chelsea Boot', 'Birkenstock Zurich', 'Crocs Bistro', 'Clarks Bushacre 2', 'UGG Dakota', 'Steve Madden Irenee', 'Vionic Tide', 'Birkenstock Yao', 'Keen Terradora II', 'Ecco Soft 8', 'Teva Tirra', 'Sanuk Yoga Mat', 'Chaco Z/2 Classic', 'Toms Avalon', 'Cole Haan Original Grand','Samsung QLED Q90T', 'LG OLED C1', 'Sony Bravia XR A90J', 'TCL 6-Series R635', 'Vizio OLED H1', 'Panasonic HZ2000', 'Philips OLED 805', 'Hisense U8G', 'Sony Bravia X90J', 'LG NanoCell 90','Samsung RS27T5200SR', 'Whirlpool WTW5000DW', 'LG WM4000HBA', 'Frigidaire FFID2426TD', 'GE GNE25JMKES', 'Electrolux EFLS627UTT', 'Bosch SHPM78W55N', 'KitchenAid KRFC300ESS', 'Maytag MVWB865GC', 'Amana ABB1924BRM', 'Samsung DV42H5000EW', 'Whirlpool WRS315SNHM', 'LG LFXS28968S', 'Frigidaire FGHD2368TF', 'GE GTW720BPNDG', 'Electrolux EFME627UTT', 'Bosch SHPM98W75N', 'KitchenAid KRMF706ESS', 'Maytag MHW5630HW', 'Amana NED4655EW', 'Samsung DW80R9950US', 'Whirlpool WRF555SDHV', 'LG WT7300CW', 'Frigidaire FFSS2615TS', 'GE GFD85ESPNRS', 'Electrolux EFLS627UIW', 'Bosch SHPM65W55N', 'KitchenAid KRFF507HPS', 'Maytag MRT118FFFH', 'Amana NTW4516FW','Jarrón', 'Paraguas', 'Reloj', 'Guitarra', 'Mesa', 'Silla', 'Bufanda', 'Taza', 'Cepillo', 'Cámara', 'Espejo', 'Bolso', 'Cuadro', 'Laptop', 'Teléfono', 'Cinturón', 'Vela', 'Libro', 'Planta', 'Almohada', 'Cepillo de dientes', 'Tenedor', 'Martillo', 'Llave', 'Toalla', 'Auriculares', 'Pelota', 'Cuchillo', 'Lápiz'
    ]
)
# arg_questions_provider = DynamicProvider(
#     provider_name = "question_provider",
#     elements = ['¿Cuál es el precio del producto?', '¿Cuál es la disponibilidad en stock?', '¿Cuál es el tiempo estimado de entrega?', '¿Cuáles son las opciones de envío disponibles?', '¿Viene con garantía? ¿Cuánto tiempo dura la garantía?', '¿Cuáles son las características y especificaciones del producto?', '¿Hay opciones de color o tamaño?', '¿El producto es nuevo o reacondicionado?', '¿Se pueden realizar devoluciones o cambios?', '¿Cuál es la política de devoluciones?', '¿El producto viene con accesorios incluidos?', '¿Es compatible con otros productos o dispositivos?', '¿Hay descuentos o promociones disponibles?', '¿Cuáles son las formas de pago aceptadas?', '¿El producto tiene alguna limitación o restricción de uso?', '¿Cuál es la marca y modelo del producto?', '¿Se proporciona servicio de instalación o montaje?', '¿El producto tiene certificaciones de calidad o seguridad?', '¿Cómo se realiza el mantenimiento o limpieza del producto?', '¿Hay opiniones o reseñas de otros compradores sobre el producto?']
# ):

# arg_answers_provider = DynamicProvider(
#     provider_name = "answers_providers",
#     elements = []
# ))
