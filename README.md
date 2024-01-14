# Trabajo Practico integrador Bases de datos 1

## Mercado libre

### Consigna

La consigna se encuentra en la carpeta de [docs/](./docs/) del proyecto.

---

### Dependencias

- Docker
- Docker compose
- pytohn
- pip
- virtualenv

---

### Instalamos Docker

---

#### Docker para Debian/Ubuntu

##### Referencia para Debian/Ubuntu

[Instalación de docker para ubuntu](https://docs.docker.com/engine/install/ubuntu).

```bash
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

---

##### Docker para Arch

```bash
sudo pacman -Syu
sudo pacman -S docker docker-compose
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
```

---

##### Docker para MacOS/Windows

- Descargar de la pagina el instalador de docker desktop
- instalar docker desktop
- ejecutar docker desktop

---

### Instalamos python

#### Referencia python

[Python](https://www.python.org/)

---

#### Python para Debian/Ubuntu

```bash
sudo apt install python3
sudo apt install pip3
sudo apt install python-virtualenv
```

---

#### Python para Arch

```bash
sudo pacman -S python
sudo pacman -S pip
sudo pacman -S python-virtualenv
```

---

##### Python para MacOS/Windows

- Descargar de la pagina el instalador de python
- instalar python

```sh
pip install virtualenv
```

---

### Configuración

---

Copiamos el archivo de ejemplo "**.env.sample**", le cambiamos el nombre a "**.env**" y le agregamos los valores a las variables de entorno que correspondan para la instancia requerida.

```bash
cp .env.sample .env
nano .env
```

---

### Iniciar contenedor

La opción "**-d**" se puede sacar si se quiere ver los logs al crear el contenedor.

```bash
docker compose up -d development
```

---

### Detener contenedor

Si esta corriendo sin la opción "**-d**" simplemente apretar Ctrl+C.

```bash
docker compose down
```

---

### Base de Datos

Toda la base de datos se guardara en "**/database/data**"

Para conectarse a una terminal del contenedor (sólo para debug).
Usar los datos configurados previamente en "**.env**".

**POSTGRES_USER**: está en el archivo "**.env**"

**POSTGRES_DB**: está en el archivo "**.env**"

```bash
docker compose exec -it development bash

# dentro del contenedor (root)
psql -U ${POSTGRES_USER} ${POSTGRES_DB}
```

---

#### Crear y rellenar con datos falsos

Para hacer esto se utilizo la libreria Faker para poder rellenar las tablas con datos falsos y tambien se hizo un pequeño programa para crear la base de datos.

---

##### Proceso

Antes de esto hay que tener iniciado el contenedor de la base de datos.

1. Creamos el entorno virtual
2. Iniciamos el entorno virtual de python
3. Instalamos las dependencias

```bash
# 1) 
python -m venv venv

# 2) para Linux/MacOS
source ./venv/bin/activate

# 3)
pip install -r requirements.txt
```

Luego ejecutamos el archivo [main.py](./scripts/populate/main.py) y se mostrara el programa.

> .[!WARNING].
> Hay una funcion de rellenado de la db que no esta terminada y no se puede ejecutar el dml obligatorio durante la ejecucion de los datos de Faker.
---

#### Backups

Se creó un volumen para guardar los **backups** en "**/backups**".

---

##### Realizar backup

Para hacer el backup tenemos que entrar a una shell del contenedor y generar el archivo de backup en la carpeta donde esta montado el volumen.
Usar los datos configurados previamente en "**.env**"

**POSTGRES_USER**: está en el archivo "**.env**"

**POSTGRES_DB**: está en el archivo "**.env**"

```bash
docker compose exec -it prod bash

# dentro del contenedor
pg_dump -U ${POSTGRES_USER} ${POSTGRES_DB} > backups/${DB_NAME}$(date "+%Y%m%d-%H_%M").sql
exit
```

---

#### Restaurar backup

Para restaurar el backup tenemos que entrar a una shell del contenedor y restaurar el backup que se encuentra en el volumen montado.

- Hay que asegurarse de tener el backup en la carpeta **/backups**.

**POSTGRES_USER**: está en el archivo "**.env**"

**POSTGRES_DB**: está en el archivo "**.env**"

```bash
# Descomprimo el backup
cd backups
sudo gunzip NOMBRE_BACKUP.sql.gz
cd ..

# Elimino la base datos que existe actualmente
docker compose -f dev.compose.yml down
sudo rm -rf database
docker compose -f dev.compose.yml up -d development

# Levanto el backup
docker compose exec -it development bash

# dentro del contenedor
psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f backups/NOMBRE_BACKUP.sql
exit
```
