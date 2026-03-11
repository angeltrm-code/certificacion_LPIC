# lab 4

Documento práctico sobre lab 4. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Modificar al usuario operador que no tenga shell

```bash
usermod -s /sbin/nologin operador
```

### con journal ver los logs de los ultimos 5 minutos del servicio sshd

```bash
 journalctl --since '5 min ago' -u sshd
```

Ejecutando ls en cualquier directorio tendremos que obtener el archivo, propietario permiso

```bash
ls -l | tr -s " " |cut -d " " -f1,3,9
```

## Bloquear al usuario operador con el comando passwd y comprobarlo

```bash
passwd --help
passwd -l usuario
passwd -S usuario
```

## con logger visualizar mail.err

logger -p mail.err "Esto es una prueba"

### tail -f /var/log/maillog

> # Sincronizar la hora del servidor de forma manual contra 0.europe.pool.ntp.org

```bash
ntpdate 0.europe.pool.ntp.org
```

## Buscar archivos en el sistema con permisos setuid

```bash
find / -type f -perm -4000
```

## Buscar archivos desde el / creados hace menos de 1 minustos

```bash
find / -type f -mmin -1
```

## comando para averiguar el ultimo acceso al archivo /etc/passwd

```bash
stat /etc/passwd
```

## Istalar el paquete webmin.rpm con el comando rpm

```bash
rpm -ivh webmin.rpm
```

## Verificar la version de php que tenemos en nuestro servidor con rmp

```bash
rpm -qi php
```

## Eliminar el paquete traceroute con rpm

```bash
rpm -e traceroute
```

## Instalar el paquete traceroute con dpkg

```bash
dpkg -i traceroute
```

## Eliminar el paqiuete traceroute y todas sus dependencias con dpkg

```bash
dpkg -P traceroute
```

## Buscar informacion del paquete httpd con yum

```bash
yum info httpd
```

## Instalar el paquete joomla.rpm que esta en local con yum

```bash
yum -y localinstall /root/joomla.rpm
```

## Como excluir el paquete php del yum

```bash
yum --exclude php* update
```

## Buscar archivos con un tama�o superior a 100M

```bash
find / -type f -size +100M
```

## Buscar archivos modificados en los ultimos 3 dias

```bash
find / -type f -mtime -3
```

### Comando locale

### locale

Tarea programada con cron para lanzar el /scripts/backup.sh de lunes a viernes a las 3 de la ma�ana

```cron
0 3 * * 1-5 /scripts/backup.sh
```

## Tarea programada con at para lanzar /scripts/backup.sh a las 22 h

at 22 -f /scripts/backup.sh

## Comando para ver las colas programadas de at

### atq

### atrm numero del job

### Configurar nuestro servidor con la siguiente configuracion:

```bash
ip-- 192.168.1.25
```

### mascara 255.255.225.0

### gw 192.168.1.1

### dns 8.8.8.8

### dns 8.8.4.4

### dominio miempresa.com

```bash
hostname servidor1
```
