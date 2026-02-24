#El comando timedatectl en Linux se utiliza para consultar y configurar la fecha, la hora y la zona horaria del sistema, especialmente en distribuciones que usan systemd (como Ubuntu, Debian, Rocky, RHEL, etc.).

timedatectl list-timezones
timedatectl set-timezone   Europe/Madrid
timedatectl set-ntp false
timedatectl set-ntp true



#El comando localectl se utiliza en sistemas Linux con systemd para consultar y configurar el idioma (locale) y el teclado del sistema

localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
 
##Para centos8: 
dnf install langpacks-es 



cat /etc/locale.conf
LANG="es_ES.UTF-8"



##Instalacion cliente NTP

#Chrony es un conjunto de herramientas para sincronizar la hora del sistema mediante NTP. Es más preciso y rápido que el antiguo ntpd, especialmente en máquinas virtuales y servidores con cambios de red frecuentes.

#Los comandos principales son:
chronyd → servicio (daemon)
chronyc → cliente para consultar y administrar

#En muchas distribuciones modernas (Rocky, RHEL, Ubuntu Server), es el servicio NTP por defecto.

dnf install chrony -y


vi /etc/chrony.conf

server 3.es.pool.ntp.org iburst
server 1.europe.pool.ntp.org iburst
server 3.europe.pool.ntp.org iburst


systemctl enable chronyd
systemctl start chronyd
systemctl status chronyd

Mostrar la información sobre NTP Chronyd
# chronyc sources -v

################################################################
*La opción iburst está recomendada, ya que envía una serie («burst») de paquetes solo si no se puede obtener una conexión con el primer intento.

Por otro lado, la opción burst siempre está presente, incluso en el primer intento, pero nunca debe utilizarse sin permiso explícito,  dado que puede incluirse en blacklist.)
 
netstat -putan 
udp        0      0 127.0.0.1:323           0.0.0.0:*                           692/chronyd 