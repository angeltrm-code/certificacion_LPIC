AL USUARIO oracle CAMBIARLE EL JUEGO DE CARACTERES A ISO8859-1
vim /home/oracle/.bash_profile
export LANG=es_ES.ISO8859-1 	--realizo el cambio de codificación
	[oracle@orion ~]$ locale							--compruebo y veo el resultado del cambio.
	LANG=es_ES.ISO8859-1
	LC_CTYPE="es_ES.ISO8859-1"
	LC_NUMERIC="es_ES.ISO8859-1"
	LC_TIME="es_ES.ISO8859-1"
	LC_COLLATE="es_ES.ISO8859-1"
	LC_MONETARY="es_ES.ISO8859-1"
	LC_MESSAGES="es_ES.ISO8859-1"
	LC_PAPER="es_ES.ISO8859-1"
	LC_NAME="es_ES.ISO8859-1"
	LC_ADDRESS="es_ES.ISO8859-1"
	LC_TELEPHONE="es_ES.ISO8859-1"
	LC_MEASUREMENT="es_ES.ISO8859-1"
	LC_IDENTIFICATION="es_ES.ISO8859-1"
	LC_ALL=
Cambiar de targer multi-user con systemclt y chkconfig
systemctl get-default
systemctl set-default multi-user.target
vi /etc/inittab
id:3:

Arquitectura del sistema operativo
arch

Explicar la diferencia entre un servidor de syslog remoto configurado como udp o tcp
Que para la escritura de un cliente linux si es udp @ si es tcp @@

En un servidor Redhat donde se configuran los parametros regionales
/etc/locale.conf
/etc/sysconfig/i18n

El usu4 no tiene shell y tiene la cuanta bloqueada
adduser -s /sbin/nologin usu4
passwd -l usu4
passwd -S usu4

Buscar archivos de mas 200MB
find / -type f -size +200M
 
Permisos de stikibit al directorio /datos
chmod 1777 /datos
ls -ld /tmp

Como forzar un fsck en el proximo reinicio a la particion /
touch /forcefsck

Explicar la siguiente entrada en /etc/fstab
blkid  /dev/sdb1    -- Optenemos el UUID 
UUID=14396714-7a80-43a4-a999-a526dea91090 /pdfs                  ext4     defaults        0 0


