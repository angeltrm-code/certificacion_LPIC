# lab 4

Documento práctico sobre lab 4. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Permiso setuid al archivo /oracle/apachectl

```bash
mkdir /oracle
touch /oracle/apachectl
chmod 4700 /oracle/apachectl
chmod u+s /oracle/apachectl
```

## Permiso de stickibit al directorio /datos

```bash
chmod 1777 /datos
chmod o+t /datos
```

## Comando para averiguar la mascara por defecto

umask -S

## Buscar archivos de mas de 200Mb

```bash
find / -type f -size +200M -ls
```

## Cuantas lineas tiene el archivo /etc/passwd

wc -l /etc/passwd

## Excluir del yum los paquete de php del sistema

```bash
vi /etc/yum.conf
exclude=php*
```

```bash
yum update --exclude php* kernel*
```

## Instalar el paquete mc.rpm

```bash
rpm -ivh mc.rpm
dpkg -i
```

## Buscar informacion del paquete mc.rpm

```bash
rpm -qi mc
dpkg -i
```

## Que archivos instalar el paquete mc.rpm

```bash
rpm -ql mc
dpkg -L
```

## Que paquete instala el archivo /etc/shadow

```bash
rpm -qf /etc/shadow
dpkg -L
```

## Comando para eliminar el paquete mc.rpm

```bash
rpm -evh mc
dpkg -r -P
```

## Exportar el Display de mi servidor linux a nuestro windows

```bash
export DISPLAY=192.168.1.2:0.0
```

## Detener el proceso 1000 de forma ordenada

### kill -15  1000

```
kill   1000
```

## Cambiar la prioridad a -5 con el usuaro operador al proceso 102

NO SE PUEDE solo root prioridades negativas

## Lanzar el servicio de apache con prioridad 5

nice -n 5 systemctl start  httpd

## Ver el contenido de un log en calitente /var/log/yum.log

tail -f /var/log/yum.log

## Lanzar top en modo bach

top -bn 5 > /fichero.csv

## Instalar el archivo weebmin.deb

```bash
dpkg -i webmin.deb
```

## Desisntalar el archivo webmin.deb

```bash
dpkg -P weebmin
```

## Visualizar los procesos del usuario apache y mysql con el comando ps

ps -u apache,mysql

## Redireccionar y numerar el archivo /etc/shadow a /tmp/password

```bash
cat -n /etc/shadow > /tmp/password
```

## Cabiar la prioridar como usuario root al proceso 1234 a -18

renice -18 1234

## Diferencias entre el comando fg y bg

El comando fg se usa para traer un proceso en segundo plano a primer plano, permitiendo que interactúes directamente con él en la terminal.

El comando bg se usa para reanudar un proceso suspendido (detenido con Ctrl + Z) y ejecutarlo en segundo plano

## crear un enlace simbolico al fichero /etc/datos.txt

ln -s /etc/datos.txt enlace-a-datos

## Ver el inodo /etc/datos.txt

```bash
ls -li /etc/datos.txt
stat /etc/datos.txt
```

## Que diferencia tenemos entre mtime y ctime

mtime se refiere a la hora de la última modificación del contenido del archivo. Esto significa que cambia cuando el contenido real del archivo es modificado, como al escribir o editar datos en el archivo

ctime se refiere a la hora del último cambio en los metadatos del archivo. Esto incluye cambios en los permisos, propiedad o enlaces simbólicos del archivo. También se actualiza cuando el contenido del archivo cambia, pero el propósito principal es rastrear cambios en los metadatos.

## Que hace nohup

El comando nohup en Unix y Linux se utiliza para ejecutar otro comando o proceso de manera que no se interrumpa cuando se cierre la sesión o la terminal desde la que se inició. "Nohup" significa "no hang up" (no colgar).

```bash
echo $$
```

## Como desactivo el selinux

```bash
vi /etc/sysconfig/selinux
```

This file controls the state of SELinux on the system.

## SELINUX= can take one of these three values:

enforcing - SELinux security policy is enforced.

permissive - SELinux prints warnings instead of enforcing.

disabled - No SELinux policy is loaded.

```conf
SELINUX=disabled
```

Programar con at hoy y cron los dias laborable  que a las 22 horas se lance /opt/supervisamem.sh

```bash
crontab -e
```

```cron
0 22 * * 1-5 /opt/supervisamem.sh 2>&1 |mail -s "Supervisamem" usuario@gmail.com
```

### at 22:00 -f  /opt/supervisamem.sh

### atq

### atrm numerojob

Tarea programada en cron a las 3 de la mañana los dias laborable del scritp /scripts/backup.sh

```bash
crontab -e
0 3 * * 1-5 /scripts/backup.sh
```

## Averiguar la ultima conexion del usario root y vagrant

### lastlog -u root

### lastlog -u vagrant

## Averiguar los logs fallidos en el sistema

utmpdump /var/log/btmp
