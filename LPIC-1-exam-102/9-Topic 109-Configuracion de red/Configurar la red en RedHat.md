**Tema 109: Fundamentos de redes

# Manual LINUX - Preparación a la certificación LPIC-1.pdf -->Pagina 401

eth0
eth1

ens33
ens37

enp0s3-->NAT
enp0s8 --> 192.168.30.10

ip en Linux, que se utilizan para gestionar interfaces de red, direcciones IP, rutas y mas configuraciones:

ifconfig -a
ip address

ip a show 
ip a show eth0
ip a show eth1

*Resumen comandos ip:

# Mostrar interfaces de red:
ip link show

# Mostrar direcciones IP asignadas:
ip addr show

# Asignar una dirección IP a una interfaz:
sudo ip addr add 192.168.1.10/24 dev eth0

# Eliminar una dirección IP de una interfaz:
sudo ip addr del 192.168.1.10/24 dev eth0

# Activar una interfaz de red:
sudo ip link set dev eth0 up

# Desactivar una interfaz de red:
sudo ip link set dev eth0 down

# Mostrar las rutas (tabla de enrutamiento):
ip route show

# Agregar una ruta estática:
sudo ip route add 192.168.2.0/24 via 192.168.1.1 dev eth0

# Eliminar una ruta:
sudo ip route del 192.168.2.0/24

# Agregar una puerta de enlace predeterminada (default gateway):
sudo ip route add default via 192.168.1.1 dev eth0

# Mostrar estadísticas de la interfaz de red:
ip -s link show

# Ver las reglas de enrutamiento IP (policy routing):
ip rule show

# Agregar una nueva regla de enrutamiento:
sudo ip rule add from 192.168.1.10/32 table 100

# Eliminar una regla de enrutamiento:
sudo ip rule del from 192.168.1.10/32 table 100

# La configuracion de red en Redhat hasta la version 9 se persisten el ficheros ifcfg-nombreinterface:

vi /etc/sysconfig/network-scripts/ifcfg-eth0
vi /etc/sysconfig/network-scripts/ifcfg-eth1
  
cat  /etc/sysconfig/network-scripts/ifcfg-eth0
HWADDR=00:0C:29:2D:F8:77
TYPE=Ethernet
BOOTPROTO=none
DNS1=80.33.20.10
DNS2=80.33.20.11
PEERDNS=no
DEFROUTE=yes
NAME=eth0
UUID=0c180136-ef33-4544-8ca8-3faea3e0b7b1
ONBOOT=yes
IPADDR=192.168.1.5
# PREFIX=24
NETMASK=255.255.255.0
GATEWAY=192.168.1.1

#  cat  /etc/sysconfig/network-scripts/ifcfg-eth1
HWADDR=00:0C:29:2D:F8:81
TYPE=Ethernet
BOOTPROTO=dhcp
# DEFROUTE=yes
PEERDNS=no
NAME=eth1
ONBOOT=yes

# NetworkManager
NetworkManager es una herramienta utilizada en sistemas Linux para simplificar la configuración y gestión de conexiones de red. Su objetivo principal es facilitar el manejo de redes, tanto cableadas como inalámbricas, permitiendo a los usuarios y administradores gestionar fácilmente interfaces de red, VPNs, conexiones Wi-Fi, y más, sin necesidad de editar manualmente archivos de configuración.

systemctl restart NetworkManager

El servicio de red network (DEPRECADO)  era responsable de controlar las interfaces de red y aplicar configuraciones definidas en los archivos de configuración, en versiones de redhat antiguas, sustituido por NetworkManager a partir de Redhat 7x:

systemctl restart network

# Para activar o desactivar interfaces de red:
ip link set eth1 up
ip link set eth1 down

ifdown eth1
ifup eth1

ip link set eth1 down;ip link set eth1 up

# NetworkManager-tui

NetworkManager-tui es una herramienta de interfaz de usuario basada en texto (TUI) para gestionar las conexiones de red en sistemas Linux utilizando NetworkManager. La utilidad se llama nmtui y ofrece una forma simple y amigable de configurar redes desde la terminal sin necesidad de editar archivos de configuración manualmente. Es ideal para aquellos que prefieren o necesitan trabajar en un entorno sin interfaz gráfica (GUI) pero que aún quieren una herramienta visual dentro de la terminal.

yum install NetworkManager-tui
yum provides nmtui
nmtui --> configura la red de forma grafica


# nmcli
nmcli es una herramienta de línea de comandos que forma parte de NetworkManager en Linux, utilizada para gestionar conexiones de red. Con nmcli, puedes realizar una amplia variedad de tareas relacionadas con la configuración de interfaces de red, administración de conexiones Wi-Fi, creación de conexiones VPN, y más, sin necesidad de utilizar una interfaz gráfica, normalmete para realizar scripts.

# Funcionalidades principales de nmcli:
Gestionar interfaces de red: Puedes activar, desactivar, y ver el estado de las interfaces de red.
Configurar conexiones: Permite crear, editar y eliminar conexiones de red (Ethernet, Wi-Fi, VPN, etc.).
Escanear redes Wi-Fi: Puedes listar y conectarte a redes inalámbricas disponibles.
Configurar redes con IP estática o dinámica (DHCP).
Gestionar DNS, puertas de enlace y rutas.

nmcli --> configura la red desde cero sin entorno grafico.

# Configuro un interface de red eth2 con la ip y mascara de red 192.168.33.200/24:

El comando nmcli connection show en Linux se usa para listar todas las conexiones administradas por NetworkManager, mostrando detalles como el nombre, tipo de conexión y UUID.

nmcli connection show
NAME         UUID                                  TYPE      DEVICE
eth0         5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03  ethernet  eth0
System eth1  9c92fad9-6ecb-3e6c-eb4d-8a47c6f50c04  ethernet  eth1
virbr0       0508b58f-8197-496e-a4bf-4f00ab0b217b  bridge    virbr0
eth2         f96baed1-ddd9-42e9-8702-28e96c48afa8  ethernet  eth2

nmcli connection add type ethernet ifname eth2 con-name eth2  ipv4.addresses 192.168.33.250/24 ipv4.gateway 192.168.33.1 ipv4.dns 8.8.8.8 ipv4.never-default yes connection.autoconnect yes ipv4.method manual
 
# Ahora ejecutamos el comado ip ya tendriamos la IP
 
ip a

El comando anterior de nmcli crear el archivo de configuracion ifcfg-eth2:

cat /etc/sysconfig/network-scripts/ifcfg-eth2
TYPE=Ethernet
BOOTPROTO=none
DNS1=80.33.20.10
NAME=eth2
ONBOOT=yes
IPADDR=192.168.33.150
NETMASK=255.255.255.0
GATEWAY=192.168.33.1

systemctl restart NetworkManager


# Configuracion a traves de DHCP, con nmcli:

nmcli connection add \
  type ethernet \
  ifname eth2 \
  con-name eth2 \
  connection.autoconnect yes \
  ipv4.method auto \
  ipv4.never-default yes
  
ipv4.never-default yes es una opción de NetworkManager que indica que esa conexión NO debe instalar una ruta por defecto en la tabla de rutas, aunque obtenga la IP por DHCP  

#  cat  /etc/sysconfig/network-scripts/ifcfg-eth2
TYPE=Ethernet
BOOTPROTO=dhcp
# DEFROUTE=yes
PEERDNS=no
NAME=eth2
ONBOOT=yes


# hostnamectl
El comando hostnamectl es una herramienta en sistemas Linux que permite gestionar el nombre del host (hostname) y la información relacionada con el sistema. Es parte de systemd y facilita la configuración del hostname, así como la visualización de detalles del sistema, como el sistema operativo, la arquitectura del hardware y más.

cat /etc/hostname

hostnamectl
#  hostnamectl set-hostname service.curso.local
systemctl restart systemd-hostnamed

# Configurar el cliente de dns
vi  /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
domain curso.local
search localdomain curso.local barcelona.curso.local langreo.curso.local


# Explicación del contenido:
nameserver 8.8.8.8 y nameserver 8.8.4.4: Estos son los servidores DNS que se utilizan para resolver nombres de dominio. En este caso, los servidores configurados son los DNS públicos de Google:

8.8.8.8: Primer servidor DNS de Google.
8.8.4.4: Segundo servidor DNS de Google (servidor de respaldo).
Cada vez que tu sistema necesita resolver un nombre de dominio (como www.google.com), consultará primero el servidor DNS 8.8.8.8. Si ese servidor no responde, entonces utilizará 8.8.4.4 como alternativa.

domain curso.local: Define el dominio predeterminado para tu red local. Esto es útil cuando se resuelven nombres de host locales sin el uso de un FQDN (Fully Qualified Domain Name). Si haces una consulta a un host llamado servidor, el sistema intentará resolverlo como servidor.curso.local.

search localdomain curso.local barcelona.curso.local langreo.curso.local: La directiva search especifica una lista de dominios de búsqueda que se aplican cuando intentas resolver un nombre de host sin un FQDN. Esto significa que si haces una consulta para el host servidor, el sistema intentará resolverlo en el siguiente orden:

servidor.localdomain
servidor.curso.local
servidor.barcelona.curso.local
servidor.langreo.curso.local

# /etc/nsswitch.conf
El archivo /etc/nsswitch.conf en sistemas Linux define el orden y los servicios que se utilizan para la resolución de varios tipos de información de red, como nombres de host, contraseñas, grupos, entre otros. Este archivo es fundamental para que el sistema sepa en qué fuentes buscar para resolver nombres de dominio, usuarios, grupos, etc., y en qué orden hacerlo.

El término NSS se refiere a Name Service Switch, que es el mecanismo que permite que el sistema utilice diferentes servicios para resolver consultas de bases de datos como hosts (nombres de host), passwd (contraseñas), y más.
 
#  cat /etc/nsswitch.conf
hosts:      files dns myhostname


# nslookup
nslookup es una herramienta de línea de comandos utilizada para consultar servidores de nombres de dominio (DNS) y obtener información sobre la resolución de nombres. Te permite realizar consultas a los servidores DNS para convertir nombres de dominio en direcciones IP o viceversa. Es útil para diagnosticar problemas de red relacionados con el DNS, como verificar si un dominio se está resolviendo correctamente.

# Consultas nslookup modo interactivo:

set type=A	Consulta registros A (IPv4).
set type=AAAA	Consulta registros AAAA (IPv6).
set type=MX	Consulta registros MX (correo).
set type=NS	Consulta los servidores de nombres.
set type=SOA	Consulta el registro SOA (Start of Authority).
set type=PTR	Realiza una búsqueda inversa (IP → dominio).
set timeout=N	Cambia el tiempo de espera (segundos).
set retry=N	Número de reintentos en caso de fallo.
set debug	Muestra información detallada de la consulta.
set norecurse	Evita que el servidor DNS haga consultas recursivas.
set domain=ejemplo.com	Define un dominio predeterminado para las consultas.



# Para resolver desde nuestro linux:
 nslookup www.google.com
 nslookup 8.8.8.8
 
yum provides /*nslookup
yum install -y bind-utils
nslookup www.marca.es

[root@sercentos7 ~]#  nslookup 142.250.184.3
3.184.250.142.in-addr.arpa      name = mad41s10-in-f3.1e100.net.


# Equivalente provides de los redhat para debian:
sudo apt install apt-file
sudo apt-file update
sudo apt-file search nslookup

El archivo /etc/NetworkManager/NetworkManager.conf es el archivo de configuración principal de NetworkManager, una herramienta utilizada en sistemas Linux para gestionar conexiones de red (tanto cableadas como inalámbricas). Este archivo controla el comportamiento y las opciones generales de NetworkManager, como qué plugins utilizar para gestionar las interfaces, cómo manejar los archivos de configuración de red, y si debe interactuar con ciertos servicios o no. 
 
#  vi /etc/NetworkManager/NetworkManager.conf
[main]
# plugins=ifcfg-rh,ibft
dns=none

# Explicacion:
plugins=ifcfg-rh,ibft
Esta línea (comentada con # ) indica que NetworkManager debería usar los plugins:
ifcfg-rh: Permite que NetworkManager administre archivos de configuración heredados de RHEL y derivados.
ibft: Permite el soporte de iSCSI Boot Firmware Table.
Al estar comentada, NetworkManager no utilizará estos plugins.

dns=none
El valor dns=none indica que NetworkManager no gestionará la configuración de DNS.
Esto significa que NetworkManager no cambiará el archivo /etc/resolv.conf.
Esto es útil si deseas administrar manualmente el archivo de configuración de DNS o si lo gestionas mediante otra herramienta.

#  vi /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.33.10    sercentos7.curso.local   sercentos7



---------------------------------------------------------------------------
# En el siguiente ejemplo se definirá la ruta estática hacia la red 192.168.3.0 con máscara de 25 bit
 (255.255.255.128),  puerta de enlace a través de la dirección IP 172.16.1.36
# y a través del dispositivo de red eth1:

ip route add  192.168.3.0/25 via 172.16.1.36 dev eth1

/etc/profile.d/rutas.sh
ip route add 192.168.3.0/25 via 172.16.1.36 dev eth1
ip route add 192.168.4.0/25 via 172.16.1.38 dev eth2


chmod 700 /etc/profile.d/rutas.sh
------------------------------------------------------------------------------

# Agregue una ruta que persista tras el reinicio del sistema con el comando route.
route -p add -net network-address -gateway gateway-address

-p
Crea una ruta que debe persistir tras el reinicio del sistema.
 Si desea que la ruta sea válida sólo para la sesión actual, no utilice la opción -p.
 
Para agregar una segunda ruta a la red 10.0.5.0, que tiene su portal como enrutador de límite, debe configurar lo siguiente:


#  route -p add -net 10.0.5.0/24 -gateway 10.0.5.150/24
add net 10.0.5.0: gateway 10.0.5.150

El comando netstat -rn se utiliza en sistemas Linux para mostrar la tabla de enrutamiento del kernel, lo que significa que proporciona información sobre cómo se enrutan los paquetes de red en tu sistema. En concreto, la opción -r muestra la tabla de rutas, y -n muestra las direcciones numéricas sin tratar de resolver los nombres de host o red.

netstat -rn
route -n
 
-----------------------------------------------------------------------------
# Eliminar ruta por defecto:
route del default gw 192.168.1.1

# Add  Default Gateway:
route add default gw 192.168.1.1

# Para ver el Default Gateway
route -n
route -F

netstat -r
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.0.2.2        0.0.0.0         UG    100    0        0 eth0

-------------------------------------------------------

# Para poner como gw al eth1:
#  vi  /etc/sysconfig/network-scripts/ifcfg-eth0

# GATEWAY=192.168.1.1
# DEFROUTE=yes

systemctl restart network
systemctl restart NetworkManager

# Para ver el Default Gateway

#  route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.92.2    0.0.0.0         UG    100    0        0 eth1

-----------------------------------------------------------------------------------------------------------
# Crear alias de ip, esta maquina contestara a las ip 192.168.2.5 192.168.2.55 por el interfaz eth1

cat  /etc/sysconfig/network-scripts/ifcfg-eth1
NM_CONTROLLED=yes
BOOTPROTO=none
ONBOOT=yes
IPADDR0=192.168.2.5
NETMASK0=255.255.255.0
IPADDR1=192.168.2.55
NETMASK1=255.255.255.0
IPADDR2=192.168.2.150
NETMASK2=255.255.255.0
DEVICE=eth1
DOMAIN=dominio 
DNS1=8.8.8.8
DNS2=8.8.4.4
PEERDNS=no
# VAGRANT-END

# Reinicar el servicio para aplicar
systemctl restart NetworkManager
--------------------------------------------------------------------------------------------------------
# Otra forma de hacer alias de IPs:
cp /etc/sysconfig/network-scripts/ifcfg-eth1 /etc/sysconfig/network-scripts/ifcfg-eth1:0

vi  /etc/sysconfig/network-scripts/ifcfg-eth1:0

NM_CONTROLLED=yes
BOOTPROTO=none
ONBOOT=yes
IPADDR=192.168.2.55
NETMASK=255.255.255.0
DEVICE=eth1:0
DOMAIN=dominio 
DNS1=8.8.8.8
DNS2=8.8.4.4
PEERDNS=no

# Reinicar el servicio para aplicar
systemctl restart NetworkManager

ip a 
eth1
eth1:0
----------------------------------------------
El archivo /etc/sysctl.conf en Linux se utiliza para configurar parámetros del kernel en tiempo de ejecución. Es una forma de ajustar el comportamiento del kernel sin necesidad de recompilarlo. Estos parámetros afectan la red, la memoria, el manejo de procesos y otros aspectos del sistema.

# Función de Reenvío de paquetes para IP versión 4, funcion de router
vi /etc/sysctl.conf
net.ipv4.ip_forward = 1
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1


# Para aplicar la configuracion
sysctl -p

# icmp echo ignore all
echo "1" > /proc/sys/net/ipv4/icmp_echo_ignore_all

echo "0" > /proc/sys/net/ipv4/icmp_echo_ignore_all

vi /etc/sysctl.conf
net.ipv4.icmp_echo_ignore_all = 1

# Para aplicar la configuracion
sysctl -p

--------------------------------------------------------------------------------------------------
# Maquinas Redhat5/6

Parámetros generales El archivo /etc/sysconfig/network contiene los parámetros generales de la red.
 NETWORKING=yes
 HOSTNAME=puesto1.mired.org #  nombre completo 
 GATEWAY=0.0.0.0 #  pasarela por defecto 
 NISDOMAIN= #  nombre del dominio NIS NETWORKING_IPV6=yes 
 • NETWORKING: activación o no de la red.
 • HOSTNAME: nombre de dominio completo FQDN. 
 • GATEWAY: dirección IP de la pasarela. 
 • GATEWAYDEV: interfaz de red que permite acceder a la pasarela. 
 • NISDOMAIN: en caso de un dominio NIS. • NETWORKING_IPV6: activación o no del soporte de IPv6



# Para desactivar esta nueva nomenclatura interfaces de red añadimos net.ifnames=0 biosdevname=0:

vi /etc/default/grub

GRUB_CMDLINE_LINUX="vconsole.font=latarcyrheb-sun16 crashkernel=auto rhgb quiet net.ifnames=0 biosdevname=0"

# Ejecute lo siguiente para aplicar el cambio en la configuración de Grub2: 
Se utiliza para generar un nuevo archivo de configuración de GRUB 2 en sistemas basados en Red Hat, como Rocky Linux 8 o CentOS 8. El archivo resultante /boot/grub2/grub.cfg contiene la configuración que GRUB utilizará para arrancar el sistema operativo.

grub2-mkconfig -o /boot/grub2/grub.cfg

reboot



Chapter 10. Adjusting Network Settings
https://access.redhat.com/documentation/es-es/red_hat_enterprise_linux/9/html-single/configuring_and_managing_networking/index
https://access.redhat.com/documentation/es-es/red_hat_enterprise_linux/6/html/deployment_guide/s1-ethtool


10.1. Changing Network Adapter Settings

ethtool es una herramienta de línea de comandos en Linux que se utiliza para consultar y modificar la configuración de las interfaces de red Ethernet. Proporciona información detallada sobre las capacidades de la interfaz de red y permite ajustar parámetros como la velocidad, el modo dúplex, la activación o desactivación del autonegociado, y otros aspectos importantes de la conexión de red.

To check the speed and settings of network adapters, use the ethtool command which works now for most network interface cards. To check the adapter settings of eth0 run:
#  ethtool eth0

To force a speed change to 1000Mbps, full duplex mode, run:
#  ethtool -s eth0 speed 1000 duplex full autoneg off

To make a speed change permanent for eth0, set or add the ETHTOOL_OPT environment variable in /etc/sysconfig/network-scripts/ifcfg-eth0:
ETHTOOL_OPTS="speed 1000 duplex full autoneg off"

nmcli connection modify Example-connection 802-3-ethernet.auto-negotiate no 802-3-ethernet.speed 10000 802-3-ethernet.duplex full

nmcli connection show Example-connection
---------------------------------------------------------------------------------------------------------------


# Configurarion de Red en Redhat 9  y superior
https://www.redhat.com/en/blog/rhel-9-networking-say-goodbye-ifcfg-files-and-hello-keyfiles

En Red Hat Enterprise Linux 9 (RHEL 9), la configuración de red se gestiona principalmente a través de NetworkManager y los archivos de configuración en el directorio /etc/sysconfig/network-scripts/ ya no están disponibles como en versiones anteriores. En su lugar, los archivos de configuración de red se encuentran en /etc/NetworkManager/system-connections/.

# Persistencia en versiones anteriores:
/etc/sysconfig/network-scripts/ifcfg-enp0s8


nmcli connection add con-name test type ethernet ifname enp0s8 ipv4.addresses 192.168.0.100/24 ipv4.gateway 192.168.0.1 ipv4.never-default yes ipv4.method manual

nmcli connection up test

systemctl restart NetworkManager


# En la version de Redhat9 la configuracion de red viene a  /etc/NetworkManager/system-connections y crear el archivo test.nmconnection donde test es el nombre de la conexion de red creada anteriormente con nmcli:

cat /etc/NetworkManager/system-connections/test.nmconnection

#  Configuración de la conexión Ethernet
[connection]
id=test                #  Nombre de la conexión dentro de NetworkManager
type=ethernet          #  Tipo de conexión (en este caso, Ethernet)
interface-name=enp0s8  #  Nombre de la interfaz de red
autoconnect=true       #  Inicia automáticamente al arrancar el sistema

#  Parámetros específicos de Ethernet
[ethernet]
mac-address=00:1a:2b:3c:4d:5e  #  Dirección MAC del dispositivo (opcional)

#  Configuración de la red IPv4
[ipv4]
method=manual               #  Método de asignación de IP (manual para estática)
addresses=192.168.0.100/24  #  Dirección IP y máscara de red
gateway=192.168.0.1         #  Dirección IP de la puerta de enlace predeterminada
dns=8.8.8.8;8.8.4.4         #  Servidores DNS separados por punto y coma
never-default=true          #  Permitir que esta conexión sea la ruta predeterminada

#  Configuración de la red IPv6
[ipv6]
method=ignore               #  IPv6 está deshabilitado para esta conexión

#  Configuración de proxy (vacío por defecto)
[proxy]
