#  **Tema 109: Fundamentos de redes

# Administración de la Red Local
Manual LINUX - Preparación a la certificación LPIC-1.pdf -->Pagina 407


eth0
eth1

ifconfig -a
ip a

# Configuración de Red en Debian
• El fichero /etc/resolv.conf también es común para ambos sistemas.
• Se utiliza para indicar al sistema cual será el servidor de nombres (DNS) a consultar para la
resolución de nombres.

vi  /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
domain curso.local
search curso.local asturias.curso.local barcelona.curso.local


# Interfaces Red Debian → /etc/network/interfaces

# Definimos en este fichero los dispositivos de red del sistema
- auto → dispositivos que levantan automaticamente al inicio
- allow-hotplug → similar a auto pero detecta eventos
- iface → definición de interface
- inet static → dispositivo con ip fija
- inet dhcp → dispositivo que obtiene dirección por dhcp

# Interfaces Red Debian → /etc/network/interfaces
- address → dirección
- netmask → máscara de subred
- gateway → puerta de enlace
- broadcast → dirección de boradcast de la subred
- dns-nameservers → servidores DNS para ese interface
-----------
eth0:0 → interface virtual

# Interfaces Red Debian → /etc/network/interfaces
- up, down → comando para levantar o tumbar el interface
- pre-up → cosas a ejecutar antes de levantar el interface
- post-up → cosas a ejecutar tras levantar el interface
- pre-down → cosas a ejecutar antes de tumbar el interface
- post-down → cosas a ejecutar tras tumbar el interface

# Interfaces Red Debian → /etc/network/interfaces
Ejemplo de configuración de eth0 en debian:

source /etc/network/interfaces.d/*
#  The loopback network interface
auto lo eth0 eth1
iface lo inet loopback
auto eth0
iface eth0 inet static
address 192.168.48.130
netmask 255.255.255.0
gateway 192.168.48.2

iface eth1 inet dhcp


ifdown eth0
ifup eth0

ip link set eth1 down
ip link set eth1 up

# System V init
/etc/init.d/networking restart
service networking  restart

El comando systemctl restart networking en sistemas Linux (debian), se utiliza para reiniciar el servicio de red. Dependiendo de la distribución de Linux que estés utilizando, este comando puede tener un comportamiento ligeramente diferente.

# systemd
systemctl restart networking
systemctl status networking.service


--------------------------------------------------------------------------------


# El archivo de configuración de las interfaces de redes en Debian (y Ubuntu) se sitúa en /etc/network/interfaces.
# No tiene el mismo formato que en Red Hat. 

#  cat /etc/network/interfaces
 auto lo eth0 eth1 
 iface lo inet loopback 
 
 iface eth0 inet static 
 address 192.168.1.60 
 netmask 255.255.255.0 
 broadcast 192.168.1.255 
 gateway 192.168.1.1 
 
 iface eth1 inet dhcp
 
 # Con una configuración estática, especifique los diferentes parámetros con las palabras claves siguientes:
 • address: la dirección IP.
 • netmask: la máscara de subred.
 • broadcast: la dirección de broadcast.
 • gateway: la pasarela por defecto.

# La línea auto indica las interfaces que se activarán automáticamente en el arranque.

# iface lo inet loopback configura la interfaz loopback (lo) en sistemas Debian/Ubuntu, permitiendo la comunicación interna del sistema.

 
 
ifconfig -a
ip a show 
ip a show eth0

# Comandos para trabajar con la red en linux:
ip addr show
ip addr show eth1
ip link show
ip link show eth0

ip addr add 192.168.70.61/25 dev eth0
ip addr del 192.168.70.61/25 dev eth0

ip link set eth1 up
ip link set eth1 down

ifdown eth1
ifup eth1

---------------------------------------------------------------------------------------------------------



# Archivo /etc/network/interfaces

auto enp0s3
iface enp0s3 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 8.8.8.8 8.8.4.4



# auto enp0s3	Indica que la interfaz enp0s3 debe activarse automáticamente al arrancar el sistema.
# iface enp0s3 inet static	Define una interfaz llamada enp0s3, usando el protocolo IPv4 (inet) y con IP estática (static).
address 192.168.1.100	IP estática que se asignará a la interfaz.
netmask 255.255.255.0	Máscara de subred que define el rango de IPs de la red local.
gateway 192.168.1.1	Dirección IP del router o puerta de enlace predeterminada.
dns-nameservers 8.8.8.8 8.8.4.4	Lista de servidores DNS para resolver nombres (aunque en sistemas modernos, esta línea puede ser ignorada por resolvconf o systemd-resolved si están activos).




# Múltiples direcciones IP en una Interfaz Debian# 


cat  /etc/network/interfaces


#  This file describes the network interfaces available on your system
#  and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

#  The loopback network interface
auto lo
iface lo inet loopback

#  The primary network interface
allow-hotplug eth0
iface eth0 inet dhcp
pre-up sleep 2
# VAGRANT-BEGIN
#  The contents below are automatically generated by Vagrant. Do not modify.
auto eth1
iface eth1 inet static
      address 192.168.33.11
      netmask 255.255.255.0

auto eth1:0
allow-hotplug eth1:0
iface eth1:0 inet static
    address 192.168.33.43
    netmask 255.255.255.0


systemctl restart networking.service	


# Comentarios y detalles:

auto eth1:0: Indica que la interfaz debe activarse automáticamente en el arranque.
allow-hotplug eth1:0: Permite que la interfaz se active automáticamente cuando se detecta.
iface eth1:0 inet static: Especifica que la configuración de la subinterfaz eth1:0 es estática.
	
# Nombre del servidor en debian:	
cat /etc/hostname

hostnamectl
#  hostnamectl set-hostname service.curso.lab
systemctl restart systemd-hostnamed

# Para resolver como cliente de dns:
vi  /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
domain curso.local
search localdomain curso.local telefonica.com 	
	
 # Equivalente provides de los centos para debian:
sudo apt install apt-file
sudo apt-file update
sudo apt-file search nslookup
-----------------------------------------------------------------------------------------------------------
ubuntu 17.10 ya es yaml  o netplan (NO ES OBJETIVO DE NUESTRA CERTIFICACION LPIC-1).

# Netplan
Netplan es una herramienta de configuración de red que se utiliza en distribuciones modernas de Linux como Ubuntu (a partir de la versión 17.10) para gestionar las configuraciones de red. Netplan permite definir de forma sencilla la configuración de red, incluyendo interfaces Ethernet, Wi-Fi, VLANs, y más, a través de archivos en formato YAML. Luego, Netplan traduce esas configuraciones para ser aplicadas por NetworkManager o systemd-networkd, según lo que esté configurado en tu sistema.

https://mytcpip.com/netplan-ubuntu/


cat /etc/hostname
hostnamectl
#  hostnamectl set-hostname service.curso.lab
systemctl restart systemd-hostnamed

vi  /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
domain curso.local
search localdomain curso.local telefonica.com 

cat /etc/hosts
# 127.0.0.1      localhost
# 127.0.1.1      debian10        debian10
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
192.168.2.10 debian10.curso.esp  debian10

 
#  cat /etc/nsswitch.conf
hosts:      files dns myhostname

# Para resolver desde nuestro linux:
 nslookup www.google.com
 
---------------------------------------------------------------------------------------------------------------
109.3 Resolución de problemas básicos de red

ip
hostname
ss
ping
ping6
traceroute
traceroute6
tracepath
tracepath6
netcat
ifconfig
netstat
route

# ip: Gestiona interfaces de red, direcciones IP y rutas.
Ver interfaces: ip link show
Ver direcciones IP: ip addr show
Mostrar rutas: ip route show

# hostname: Muestra o cambia el nombre del host.
Ver hostname: hostname
Cambiar hostname: sudo hostnamectl set-hostname nuevo-nombre

# ss: Muestra información sobre conexiones de red (más rápido que netstat).
Ver conexiones TCP: ss -t
Todas las conexiones: ss -a
ss -putan  |grep -i listen
ss -putan |tr -s " " |grep -i listen

# ping: Verifica la conectividad con un host mediante paquetes ICMP.
Usar: ping google.com
Tres parámetros deben llamarle la atención: 
-c permite especificar el número de ecos que se deben emitir.
-b permite emitir un eco en una dirección de broadcast.
-I permite especificar la interfaz de red

ping -c 1 10.9.238.170
ping -b 192.168.1.255
ping -I eth0 192.168.1.60

# ping6: Igual que ping, pero para redes IPv6.
Usar: ping6 ipv6.google.com

# traceroute: Rastrea la ruta que siguen los paquetes hacia un host.
Usar: traceroute google.com

# traceroute6: Igual que traceroute, pero para IPv6.
Usar: traceroute6 ipv6.google.com

# tracepath: Similar a traceroute, pero sin privilegios y ajusta la MTU.
Usar: tracepath google.com

# tracepath6: Igual que tracepath, pero para IPv6.
Usar: tracepath6 ipv6.google.com

# netcat (nc): Herramienta versátil para redes (escaneo, transferencia de datos).
Escanear puertos: nc -zv google.com 80-90
Iniciar servidor: nc -l 12345

# ifconfig: Configura interfaces de red (antiguo, reemplazado por ip).
Ver interfaces: ifconfig

# netstat: Muestra estadísticas de red y conexiones (reemplazado por ss).
Ver conexiones: netstat -a

# route: Muestra y configura la tabla de rutas (reemplazado por ip).
Ver tabla de rutas: route -n



**Resumen de comandos:

# netstat
El comando netstat permite obtener gran cantidad de información sobre la red y los protocolos.
El parámetro -i permite obtener el estado de las tarjetas de redes para determinar una posible
avería o un problema de cable:

#  netstat -i 

El comando watch en Linux se utiliza para ejecutar repetidamente un comando a intervalos regulares y mostrar su salida en tiempo real. Es muy útil cuando necesitas monitorear cambios en un comando o un archivo, como el estado de una red, la carga del sistema, o los procesos en ejecución.

watch netstat -i  # Por defecto el tiempo refresco es de dos segundos
watch -n 5 netstat -i


 
Kernel Interface table
Iface             MTU    RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR Flg
docker0          1500        0      0      0 0             0      0      0      0 BMU
eth0             1500    18835      0      0 0          2231      0      0      0 BMRU
eth1             1500     4354      0      0 0          4209      0      0      0 BMRU
lo              65536        0      0      0 0             0      0      0      0 LRU


# ss
ss (Socket Statistics) es una herramienta de línea de comandos en Linux utilizada para mostrar estadísticas y detalles sobre las conexiones de red y los sockets. Se considera más eficiente y rápido que el antiguo netstat, ya que accede directamente a la información desde el kernel en lugar de depender de archivos /proc o /dev.

ss <opciones>
Opciones útiles:
Ejemplo

Muestra el puerto de escucha del programa Apache 2:

#  ss -tulpn |grep apache2
tcp LISTEN 0 0 :::80 :::* users:
(("apache2",pid=4995,fd=4),("apache2",pid=4994,fd=4),
("apache2",pid=4991,fd=4))


ss -tulpn |grep rsyslog
udp    UNCONN     0      0         *:514                   *:*                   users:(("rsyslogd",pid=1208,fd=3))

ss -putan  |grep rsyslog
udp    UNCONN     0      0         *:514                   *:*                   users:(("rsyslogd",pid=1208,fd=3))

ss --help
-t
--tcp
Muestra el protocolo TCP.

-u
--udp
Muestra el protocolo UDP.

-l
--listening
Muestra los sockets del servidor en escucha.

-p
--processes
Muestra el nombre y el PID de los procesos propietarios.

-n
--numeric
Muestra las direcciones en formato numérico



# Consulta DNS como cliente con  dig y host -->Pagina 439 Pdf de la certifiacion:

# dig
El programa dig es una herramienta de consulta avanzada de servidor de nombres capaz de restituir
todos los datos de las zonas de un servidor de DNS. 

dig tele2.es

# host
La herramienta host devuelve el mismo resultado, pero quizá de manera más sencilla.
    host tele2.es

# getent
El comando getent en Linux se utiliza para obtener entradas de las bases de datos del sistema, como usuarios, grupos, hosts, servicios y más. Es una herramienta útil para consultar la información que se gestiona mediante Name Service Switch (NSS), que puede provenir de diferentes fuentes como archivos locales, LDAP, NIS, DNS, etc.

Consultar usuarios (passwd): Muestra una lista de todos los usuarios en el sistema, similar al contenido de /etc/passwd:
getent passwd

getent passwd operador
getent group operadoresldap
getent group wheel


getent hosts google.com


# Bases de datos más comunes que puedes consultar con getent:

passwd: Muestra la información de los usuarios, como si leyeras /etc/passwd.
group: Muestra información sobre los grupos, equivalente a /etc/group.
hosts: Resuelve nombres de host, como si estuvieras consultando /etc/hosts o haciendo una consulta DNS.
services: Muestra los servicios de red y sus puertos, como los definidos en /etc/services.
protocols: Muestra los protocolos de red, definido en /etc/protocols.
networks: Muestra las redes conocidas.
shadow: Muestra las contraseñas encriptadas de los usuarios (requiere permisos de superusuario).

# Resumen:
getent es una herramienta muy versátil para consultar diversas bases de datos del sistema.
Permite extraer información sobre usuarios, grupos, hosts, servicios, protocolos y más.
Es útil en entornos donde se utiliza LDAP o NIS para la gestión de cuentas de usuario y otros recursos de red, ya que consulta todas las fuentes configuradas en /etc/nsswitch.conf.

 