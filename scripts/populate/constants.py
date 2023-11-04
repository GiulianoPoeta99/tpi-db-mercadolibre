from colorama import init, Fore

# Inicializa colorama para sistemas Windows
init(autoreset=True)

# constantes
YES_NO = Fore.GREEN + 's' + Fore.RESET + '/' + Fore.RED + 'n' + Fore.RESET

# si se quiere cambiar el stylo de las barras de carga se puede leer la documentacion de la libreria
# https://pypi.org/project/alive-progress/
STYLE_BAR = 'filling'
STYLE_SPINNER = 'arrows'