#Modificar al usuario operador que no tenga shell
usermod -s /sbin/nologin operador
con journal ver los logs de los ultimos 5 minutos del servicio sshd
 journalctl --since '5 min ago' -u sshd

#Ejecutando ls en cualquier directorio tendremos que obtener el archivo, propietario permiso
ls -l | tr -s " " |cut -d " " -f1,3,9

#Bloquear al usuario operador con el comando passwd y comprobarlo
passwd --help
passwd -l usuario
passwd -S usuario

#con logger visualizar mail.err
logger -p mail.err "Esto es una prueba"
tail -f /var/log/maillog

#Sincronizar la hora del servidor de forma manual contra 0.europe.pool.ntp.org
ntpdate 0.europe.pool.ntp.org

#Buscar archivos en el sistema con permisos setuid
find / -type f -perm -4000

#Buscar archivos desde el / creados hace menos de 1 minustos
find / -type f -mmin -1

#comando para averiguar el ultimo acceso al archivo /etc/passwd
stat /etc/passwd

#Istalar el paquete webmin.rpm con el comando rpm
rpm -ivh webmin.rpm

#Verificar la version de php que tenemos en nuestro servidor con rmp
rpm -qi php

#Eliminar el paquete traceroute con rpm
rpm -e traceroute


#Instalar el paquete traceroute con dpkg
dpkg -i traceroute

#Eliminar el paqiuete traceroute y todas sus dependencias con dpkg
dpkg -P traceroute

#Buscar informacion del paquete httpd con yum
yum info httpd

#Instalar el paquete joomla.rpm que esta en local con yum
yum -y localinstall /root/joomla.rpm

#Como excluir el paquete php del yum
yum --exclude php* update

#Buscar archivos con un tamaño superior a 100M
find / -type f -size +100M

#Buscar archivos modificados en los ultimos 3 dias
find / -type f -mtime -3
Comando locale
locale

#Tarea programada con cron para lanzar el /scripts/backup.sh de lunes a viernes a las 3 de la mañana
0 3 * * 1-5 /scripts/backup.sh

#Tarea programada con at para lanzar /scripts/backup.sh a las 22 h
at 22 -f /scripts/backup.sh

#Comando para ver las colas programadas de at
atq
atrm numero del job






Configurar nuestro servidor con la siguiente configuracion:
ip-- 192.168.1.25
mascara 255.255.225.0
gw 192.168.1.1
dns 8.8.8.8
dns 8.8.4.4
dominio miempresa.com
hostname servidor1



