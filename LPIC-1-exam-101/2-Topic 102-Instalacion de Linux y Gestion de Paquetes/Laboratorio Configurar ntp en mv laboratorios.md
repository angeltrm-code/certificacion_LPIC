###En las maquinas virutales rockylinux y debian12 deberiamos de utilizar chrony:

#NTP
NTP (Network Time Protocol) es un protocolo que permite sincronizar los relojes de los ordenadores mediante la red y, en particular, TCP/IP, o sea Internet. Como nuestros ordenadores utilizan relojes de cuarzo, a veces éstos se pueden adelantar o atrasar mucho dependiendo de la calidad de los componentes.
NTP utiliza UDP como su capa de transporte, usando el puerto 123



###En las maquinas virutales rockylinux y debian10 deberiamos de utilizar chrony:

##Configuring NTP using chrony
yum install chrony -y
apt install chrony

# systemctl start chronyd
# systemctl enable chronyd

# vi  /etc/chrony.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst


# systemctl start chronyd
# systemctl enable chronyd
--------------------------------------------------------------------------------------------------------------
##En la mv rockylinux/rocky Linux

yum install chrony -y

timedatectl set-timezone "Europe/Madrid"
timedatectl

##un comando para listar y modificar la configuración de localización/mapa del teclado.
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
localectl

El paquete chrony, un binario que nos ofrece la posibilidad de mantener la hora sincronizada con servidores NTP y a la vez él mismo ofrecerse como servidor NTP para otros clientes.

##Fichero principal de configuracion de nuestro cliente chrony:

# vi  /etc/chrony.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst

# systemctl restart chronyd
# systemctl enable chronyd

Mostrar la información sobre NTP
# chronyc sources -v



La opción iburst está recomendada, ya que envía una serie («burst») de paquetes solo si no se puede obtener una conexión  con el primer intento. Por otro lado, la opción burst siempre está presente, incluso en el primer intento, pero nunca debe utilizarse sin permiso explícito, dado que puede incluirse en blacklist.)
------------------------------------------------------------------------------------------------------------------

##En centos6 (DEPRECADO)
yum install ntp -y

cp /etc/localtime /root
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Madrid  /etc/localtime


vi /etc/ntp.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst


service ntpd start
chkconfig --level 3 ntpd on

Mostrar la información sobre NTP
# ntpq -p

--------------------------------------------------------------------------------------------------------
##En debian10/12
apt-get update
apt-get install chronyd -y
timedatectl set-timezone "Europe/Madrid"

localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es


# vi  /etc/chrony/chrony.conf

server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst

systemctl status chrony
# systemctl start chrony
# systemctl enable chrony

Mostrar la información sobre NTP
# chronyc sources -v