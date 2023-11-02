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
        "11","221","223","291","3833","351"
        ,"3783","3722","2965","343","3717","2954"
        ,"3822","261","3752","299","2920","387","264"
        ,"2652","2966","342","341","385","381","2901"
    ]
)

arg_cat_provider = DynamicProvider(
    provider_name = "cat_provider",
    elements = [
        "Electrónica","Ropa y Accesorios","Calzado","Belleza y Cuidado Personal"
        ,"Hogar","Jardín","Deportes y Actividades al Aire Libre","Juguetes y Juegos"
        ,"Libros y Material de Oficina","Electrodomésticos","Muebles","Alimentos y Bebidas"
        ,"Automóviles y Accesorios","Instrumentos Musicales","Arte y Manualidades",
        "Electrónica de Consumo","Salud y Bienestar","Maletas y Equipaje",
        "Productos para Bebés y Niños","Joyas y Relojes","Electrodomésticos de Cocina",
        "Herramientas y Mejoras para el Hogar","Productos para Mascotas","Equipamiento para Negocios"
        ,"Productos para el Cuidado del Cabello","Cámaras y Fotografía","Equipamiento para Deportes y Fitness"
        ,"Equipos de Oficina","Juegos de Mesa y Rompecabezas","Suministros para Fiestas y Eventos",
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
        "RoyalRidge","DreamBuilders","AmberWaves","RadiantRidge","StarrySkies","OceanBreeze"
        ,"PacificPearls","GoldenFields","WhisperingWinds","NovaBuilders","BlissfulBoutique",
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
