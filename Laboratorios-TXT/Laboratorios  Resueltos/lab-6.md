Comando para ver la informacion del modulo vfat 
modinfo vfat
Listar los modolulos que tengo en memoria del kernel 
lsmod
Direfrencia entre el comando modprobre y insmod 
insmod no gestiona dependencias a la hora de cargar los modulos
Cagar el modulo vfat y sus dependencias
modprobe    vfat
ver los procesos del usuario apache y oracle 
ps -u oracle,apache
Cambiar la prioridad del proceso 1234 a -5 
renice -5 1234

Lanzar el comando xterm en segundo plano y que no se cuelgue ante el cierre de sesion 
nohup xterm &
Que hace el comando fc --> 
Trabaja con el historial fc -l y fc -s numeros del trabajo

Instalar el archivo mc.rpm 
rpm -i mc.rpm
dpkg -i mc.deb

Eliminar el archivo mc 
rpm -e mc
dpkg -r mc

Que paquete rpm ha instalado el archivo 
rpm -ql
dpkg -l

Que paquetes php tengo instalados en el sistema 
rpm -qa php
dpkg -l php

Informacion sobre el paquete php
rpm -qi php
dpkg -i php 

Forzar a instalar el paquete joomla.rpm sin sus dependencias. 
rpm -i --nodeps joomla.rpm 

Cambiar el juego de caracteres al usuario operador a iso885915
locale
vi /home/operador/.bash_profile
LANG=es_ES.iso88591 
LC_CTYPE="es_ES.iso88591"
export LANG LC_CTYPE

Que hace el comando iconv
Modificar al usuario operador que no tenga shell
usermod -s /sbin/nologin operador