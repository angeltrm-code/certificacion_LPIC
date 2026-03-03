# Borrar los usuarios de usu1 a usu5
# Eliminar los usuarios usu1 a usu5 (incluyendo sus directorios home):
sudo userdel -r usu1
sudo userdel -r usu2
sudo userdel -r usu3
sudo userdel -r usu4
sudo userdel -r usu5

# También se puede hacer en una sola línea:

sudo userdel -r usu{1..5}


# Crear el usuario usuario1 que no tenga shell y su grupo primario sea informatica
useradd -g informatica -s /sbin/nologin usuario1
sudo passwd usuario1
chage -l usuario1

# El usuario1 la cuenta le caduca el jueves 05/03/2026
chage -E 2026-03-05 usuario1
chage -l usuario1

# A nuestro usuario nominal que tenga todos los privilegios con sudo.
usermod -aG wheel nombre_usuario

===================================================================================================================================================

# Como repito el comando del historial 99

!99

# Cuanto ocupa el archivo smb.conf

du -h /etc/samba/smb.conf

# Cuanto ocupa el directorio /etc

du -sh /etc

# Cuanto espacio tengo libre en el /

df -h /

# Version de mi sistema operativo

cat /etc/os-release
uname -r
hostnamectl

# Bucar archivos con permisos de setuid

find / -type f -perm -4000 2>/dev/null

# Que libreria tengo vinculada al comando smbpasswd

ldd /usr/bin/smbpasswd

# Permiso de Sticky Bit al directorio /nominas

chmod +t /nominas
ls -ld /nominas

# Buscar directorios con permiso setguid en el sistema

find / -type d -perm -2000 2>/dev/null

# Averiguar mascara por defecto

umask
umask -S

# Que hace la variable de entorno LD_LIBRARY_PATH

man ld.so
echo $LD_LIBRARY_PATH

# instalar webmin con rpm como dpkg

rpm -ivh webmin-*.rpm
dpkg -i webmin_*.deb

# Eliminar un paquete con rpm y dpkg

rpm -e nombre_paquete
dpkg -r nombre_paquete

# Listar si tengo instalado php con rpm y dpkg

rpm -qa | grep php
dpkg -l | grep php

# Listar los fiecheros que instala php con rmp y dpkg

rpm -ql php
dpkg -L php

# Comando para averiguar los procesos del usuario apache

ps -u apache
pgrep -u apache -a

# Comando para eliminar el proceso del comando yes

pkill yes
killall yes

# Como añado el usuario usuario1 al grupo informatica con gpasswd

gpasswd -a usuario1 informatica

# Averiguar los accessos al sistema

last

# Averiguar los accesos fallidos del usuario root

lastb root

# Ver la ultima vez que se han conectado todos los usuarios

lastlog

# Ver los inicios de session de los ultimos 15 dias.

last -s -15days

# Ver los usuarios conectados actualmente al sistema.

who
w
users

# Bloquear al ususario becario

passwd -l becario
usermod -L becario

