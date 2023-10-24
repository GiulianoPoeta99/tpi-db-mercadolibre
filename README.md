# Postgres

## Instalamos Docker
### Para Debian/Ubuntu
#### Referencia: 
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

### Para Arch

```bash
# PENDIENTE...
```

### Para NixOS

```bash
# PENDIENTE...
```

### Para MacOS

```bash
# PENDIENTE...
```


## Configuración
### Producción/Desarrollo

Copiamos el archivo de ejemplo "**.env.sample**", le cambiamos el nombre a "**.env**" y le agregamos los valores a las variables de entorno que correspondan para la instancia requerida. <br>
En produccion hay que cambiar el nombre de los secretos en el archivo **compose.yml**.

```bash
cp .env.sample .env
nano .env
```

## Iniciar contenedor

La opción "**-d**" se puede sacar si se quiere ver los logs al crear el contenedor.

### Producción/Desarrollo

```bash
docker compose up -d development
```

## Detener contenedor

Si esta corriendo sin la opción "**-d**" simplemente apretar Ctrl+C.

### Producción/Desarrollo

```bash
docker compose down
```

## Base de Datos

Toda la base de datos se guardara en "**/database/data**"

Para conectarse a una terminal del contenedor (sólo para debug).
Usar los datos configurados previamente en "**.env**".

### Producción/Desarrollo

**POSTGRES_USER**: está en el archivo "**.env**" <br>
**POSTGRES_DB**: está en el archivo "**.env**"

```bash
docker compose exec -it development bash

# dentro del contenedor (root)
psql -U ${POSTGRES_USER} ${POSTGRES_DB}
```

## Backups

Se creó un volumen para guardar los **backups** en "**/backups**".

### Realizar backup

Para hacer el backup tenemos que entrar a una shell del contenedor y generar el archivo de backup en la carpeta donde esta montado el volumen.
Usar los datos configurados previamente en "**.env**"

**DB_USER_FILE**: está en el archivo "**.env**" <br>
**DB_NAME**: está en el archivo "**.env**"

```bash
docker compose exec -it prod bash

# dentro del contenedor
pg_dump -U ${DB_USER_FILE} ${DB_NAME} > backups/${DB_NAME}$(date "+%Y%m%d-%H_%M").sql
exit
```

### Restaurar backup

#### Desarrollo

Para restaurar el backup tenemos que entrar a una shell del contenedor y restaurar el backup que se encuentra en el volumen montado.

* Hay que asegurarse de tener el backup en la carpeta **/backups**.

**DB_USER**: está en el archivo "**.env**" <br>
**DB_NAME**: está en el archivo "**.env**"

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
psql -U ${DB_USER} -d ${DB_NAME} -f backups/NOMBRE_BACKUP.sql
exit
```

## Programar backups automáticos (CRON)

### Prerrequisitos

En el servidor de destino tiene que estar configurado ssh para aceptar autenticación con Public Keys.

```bash
$ # En el servidor de destino
$ sudo nano /etc/ssh/sshd_config
$ # Descomentar la linea que tiene: PubkeyAuthentication yes
$ sudo systemctl restart sshd.service
$ #------------------------------------------------------------------------------
$ # En el servidor de origen del backup (USUARIO ROOT)
root$ # Generar las claves del usuario que va a ejecutar el script en este equipo
root$ ssh-keygen
root$ ssh-copy-id USUARIO@SERVIDOR_DESTINO
```

### Programar tarea

```bash
$ # En el servidor de origen del backup
$ cp backup_cron.sh.example backup_cron.sh
$ # Configurar el destino. Editar la linea #DEST=usuaro@host:/path
$ nano backup_cron.sh
$ # Programar la tarea con cron (USUARIO ROOT)
root$ crontab -e
root$ # En cron:
			# Para probar un backup cada 5 minutos
			*/5 * * * * /ruta_al_script/backup_cron.sh

			# Para dejar el backup 1 vez por dia
			0 0 * * * /ruta_al_script/backup_cron.sh
```
