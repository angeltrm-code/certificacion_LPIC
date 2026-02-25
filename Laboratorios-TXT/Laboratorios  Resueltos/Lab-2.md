### En los ejercicios que pidan trabajar con directorios, asegurarse de que esten creados en la ruta que corresponda y si no existen se crearan de forma practica

## Arquitectura del sistema operativo
arch
uname -a

### Modelo de cdrom del sistema operativo
dmesg |grep cdrom
dmesg |grep sr0

## Cuanta memoria ram tiene nuestro servidor
cat /proc/meminfo
free -h
lsmem

## cuantas cpus tiene mi servidor
lscpu
cat /proc/cpuinfo

## Cuanto tiempo lleva encendido nuestro servidor
uptime

## Modificar la fecha y hora de nustro servidor a 10/01/2016 18:10
date -s "10/01/2016 18:10"
timedatectl 
timedatectl set-time '2016-01-10 18:10:00'
timedatectl set-time  18:10:00

## Informacion de modelo de nuestra tarjeta de red
ip a
ifconfig -a
dmesg |grep eth0
lspci
lspci -s 02:01.0 -v


## Informacion de sistema de ficheros soportados por el servidor
cat /proc/filesystems

## Version del sistema oprativo que tenemos
cat /etc/redhat-release
cat /etc/centos-release
cat /etc/debian_version

yum provides lsb_release
yum install redhat-lsb-core -y

lsb_release -a


## version de nuestro kernel
uname -r

## Averiguar mascara de permisos a directorios y ficheros por defecto
umask -S


# Buscar directorios con permiso Sticky Bit
find / -type d -perm -1000

# Buscar archivos con permiso setuid
find / -type f -perm -4000

## Cambiar el usuario propietario operador al directorio /datos
mkdir /datos
adduser operador
passwd operador
chown operador:root  /datos
chown operador:  /datos



## Dar permisos Sticky Bit /datos
chmod 1777 /datos
chmod o+t /datos
ls -ld /datos

## Dar permisos de setgid a /datos2 de forma alfabetica:
chmod g+s /datos2

# Que hace el permiso setuid
El permiso setuid (Set User ID) es un bit especial en los permisos de archivos en sistemas Unix y Linux que, cuando se establece en un archivo ejecutable, permite que dicho archivo se ejecute con los privilegios del propietario del archivo (root), en lugar de con los privilegios del usuario que lo ejecuta.

# Cambiar la mascara por defecto a rw- rw- ---
umask 0117
umask u=rw,g=rw,o=
umask -S

# Cuantas lineas tiene el archivo passwd, con el comando cat
cat -n /etc/passwd
wc -l  /etc/passwd 
nl /etc/passwd

# Cuanto tiempo lleva encendido nuestro servidor
uptime

# Que hacen los comando:
runlevel -->Permite ver en que runlevel estoy actualmente en system-v
chkconfig --> Quita o pone al inicio servicios en linux, para que arranquen con el servidor en system-v
init 6  --> Reinicia el servidor
telinit 0  --> Para el servidor

systemctl isolate poweroff.target 
systemctl isolate reboot.target 


# Poner al inicio el servicio httpd en systemd y sistemv
chkconfig --level 3 httpd on
systemctl enable httpd

# arranca ahora el servicio httpd  systemd y sistemv
service httpd start
/etc/init.d/httpd start
systemctl start httpd

# Comando para ver en systend el target actual y en systemv
systemctl get-default

cat /etc/inittab
runlevel

# Comando para moverme en caliente entre en target o runlevel 5 en systemd systemv
init 5
telinit 5
systemctl isolate graphical.target
