Como forzar el fsck al proximo reinicio del sistema /
touch /forcefsck
reboot

Buscar directorios con permisos de stickibit
find / -type d -perm 1000

Cuantas palabras tiene el archivo /etc/shadow
wc --help
wc  -w /etc/shadow

Crear 3 interacion con el comando top y enviarlo a un fichero llamado uso_sistema
top -bn 3 > uso_sistema.csv

Comando para instalar el archivo mc.rpm con yum
yum install mc
apt install mc

Desistalar con yum el archivo php
yum remove php
apt remove php

Diretorio donde se encuentran los respositorios de yum
/etc/yum.repos.d

Dado el archivo smb.conf, que paquete lo ha instalado
find / -name smb.conf
rpm -qf /etc/samba/smb.conf
dpkg -S /etc/samba/smb.conf

Comando para cambiar la prioridad de un proceso
renice

Diferencias entre yum y rpm
rpm no gestiona dependencias

Lanzar el comando xterm en segundo plano y que no se cuelgue cuando cierro el terminal
nohup xterm &

Que hace el comando kill -15 PID
Para de forma ordenada el proceso

Como puedo updatear el sistema con el comando yum
yum update

Explicacion de la siguiente estructura del archivo /etc/fstab
/dev/sdb1       /logs   ext4    defaults        0 0

particion       puntode mo sisficheros opciones al punto de montaje coredump fsck

Que tipo de particiones es 83 82 8e fd
83 standar de linux
82 tipo swap
8e LVM
fd linux raid

Parametro del mount para pasar opciones de ro a un punto de montaje
 mount -o ro,remount   /logs
 mount -o rw,remount   /logs

 
Comando para poner a un proceso en segundo plano y primer plano
jobs
bg
fg

Que fichero me dice que particones tengo en el sistema
cat /proc/partitions

Cambiar el juego de caracteres al usuario operador a iso885915
locale
localectl

vi /home/operador/.bash_profile
LANG=es_ES.iso885915 
LC_CTYPE="es_ES.iso885915"
export LANG LC_CTYPE


Que hace el comando iconv
Es posible convertir un archivo codificado en una tabla dada hacia otra tabla

que hace el comando logger y su equivalente en systemd
Prueba la configuracion de los logs que tengamos en las rules del nuestro syslog (/etc/rsyslog.conf)

echo 'hello' | systemd-cat
logger -p mail.info "Esto es una prueba"


Como podemos forzar el rotado de los logs ahora mismo
logrotate -f /etc/logrotate.conf

Que puerto se utiliza para un syslog remoto
514 puede ser UDP o TPC

Tarea programada con cron backup.sh todos los dias laborables  a las 15 horas
* 15 * * 1-5  root /backup.sh 2>&1 log.txt

Tarea con at backup.sh para hoy a las 23horas
at -f /root/backup.sh 23:00

Ver las tareas de at
atq

Lanzar comando dias impares
#Minutos-Hora-Dia del mes-Mes-Dia de la semana  
* * 1-31/2  * * comando


# Ejecutar mi_script.sh de forma aleatoria entre las 9:00 y las 17:00 cada día
* 9-17 * * * /ruta/a/mi_script.sh

En esta línea:

*/10 indica que la tarea se ejecutará cada 10 minutos.
9-17 especifica que la tarea se ejecutará entre las 9:00 y las 17:00.
/ruta/a/mi_script.sh es la ruta absoluta de tu script que deseas ejecut


Para programar una tarea en Cron que se ejecute de forma aleatoria una sola vez entre las 9:00 y las 17:00 horas, puedes utilizar la siguiente línea en tu archivo crontab:

1 9-17 * * * /ruta/a/mi_script.sh

En esta línea:

0 indica que la tarea se ejecutará al inicio de la hora.
9-17 especifica que la tarea se ejecutará entre las 9:00 y las 17:00.
/ruta/a/mi_script.sh es la ruta absoluta de tu script que deseas ejecutar