# Clase entorno grafico

Apuntes de clase sobre Clase entorno grafico, reorganizados para facilitar la consulta rápida y el repaso.

## Tema 106: Interfaces de usuario y escritorios

> -->Manual de la certificacion pdf  pagina 507

El X Window System (también conocido como X11 o simplemente X) es un sistema de ventanas para sistemas operativos tipo Unix (como Linux y BSD) que proporciona la funcionalidad fundamental para crear y manejar interfaces gráficas de usuario (GUI).

## Características Principales del X Window System

## Arquitectura Cliente-Servidor:

El servidor X maneja la pantalla, el teclado y el mouse. Los clientes X son las aplicaciones que utilizan el servidor para mostrar ventanas y recibir entradas.

## Protocolos de Red:

Permite que las aplicaciones gráficas se ejecuten en un servidor remoto mientras se muestran localmente. Utiliza el protocolo X11 para la comunicación entre cliente y servidor.

## Independencia de Hardware:

Funciona en una amplia variedad de hardware gráfico. No está vinculado a ningún entorno de escritorio en particular (como GNOME o KDE).

## Gestores de Ventanas y Entornos de Escritorio:

El servidor X no gestiona el aspecto o el comportamiento de las ventanas. Los gestores de ventanas (como Metacity, Mutter, i3) y los entornos de escritorio (como GNOME, KDE, XFCE) se encargan de ello.

¿Qué es X.Org?

- Su estructura es cliente-servidor.
- El cliente ejecuta la aplicación X y el servidor gestiona la comunicación con el hardware

(gráfica, monitor, teclado, ratón), y procesa los gráficos.

- Así el servidor gráfico X se ejecuta localmente y las aplicaciones X pueden ejecutarse de forma remota

desde las diferentes máquinas.

## Variable DISPLAY:

DISPLAY es una variable de entorno en sistemas Unix/Linux que define la conexión entre una sesión gráfica cliente (X11) y un servidor X. Se usa para manejar interfaces gráficas en sistemas remotos o locales.

```bash
export DISPLAY=192.168.33.1:0.0
```

### El archivo de configuración de Xorg está en /etc/X11 y se llama xorg.conf:

```bash
/etc/X11/xorg.conf
```

Xorg 7.3 o posterior Si utiliza una versión 7.3 o posterior de Xorg, puede intentar realizar la autoconfiguración iniciando el comando siguiente:

## Xorg --configure

El servidor X más utilizado es el XFree86, desarrollado y distribuido de forma gratuita por el XFree86 Project (miembro del X Consortium)

Arrancar el sistema gráfico Si /usr/bin/X11 está incluído en la variable $PATH podemos arrancar las X ejecutando la orden: $ sudo startx $genome-session $startkde

xming xlaunch system-config-

```bash
yum install system-config* -y
```

```bash
export DISPLAY=192.168.33.1:0.0
```

system-config-user firefox

```bash
ssh -X -p 22 usuario@servidor aplicación
```

-X: Habilita el reenvío de X11, lo que permite que las aplicaciones gráficas remotas se muestren en tu máquina local.

## El comando xhost permite controlar los permisos de acceso al servidor X.

```bash
Su sintaxis básica toma un más ”+” o un menos ”-” para autorizar o no de manera global (todo el mundo) las conexiones
```

al servidor X.

## xhost +

deshabilita todas las restricciones de acceso, permitiendo que cualquier usuario o máquina remota pueda enviar gráficos a tu pantalla.

$ xhost - access control enabled, only authorized clients can connect Se revoca el acceso otorgado anteriormente a cualquier cliente. Nadie más puede conectarse a tu sesión X, incluso si previamente se le había permitido.

### $xhost -maquinaremotaIP

Después de los signos, puede precisar un nombre de anfitrión o de login. En el segundo servidor X, debe autorizar el primero: $ xhost +192.168.1.60

### 192.168.1.60 being added to access control list

xhost + xhost -

xhost +    Abre el acceso a todos los hosts (inseguro) xhost -    Cierra el acceso; solo usuarios autorizados xhost +IP    Permite acceso a un host concreto xhost +SI:localuser:usuario    Permite acceso a un usuario local

El programa xauth se utiliza para editar y mostrar la información de autorización utilizada para conectarse al servidor X

Este programa se usa generalmente para extraer registros de autorización de una máquina y combinarlos en otra (como es el caso cuando se usan inicios de sesión remotos o se otorga acceso a otros usuarios).

```bash
yum install xterm -y
```

xterm genome-session startkde

## Lanzar el entorno grafico:

startx

## Desktop Environment : GNOME Desktop centos8

```bash
dnf -y group install "Server with GUI"
systemctl set-default graphical.target
systemctl get-default
yum provides xeyes
```

xeyes xterm firefox

---

## RDP

## Referencias

- https://www.e2enetworks.com/help/knowledge-base/how-to-install-xrdp-on-centos-and-redhat-linux-8-7/

RDP (Remote Desktop Protocol) es un protocolo desarrollado por Microsoft que permite conectarse de forma remota a otro equipo y controlarlo como si estuvieras delante de él.

## Para conectarnos desde windows con el cliente de escritorio remoto a traves de:

### mstsc

Xrdp es una implementación de código abierto de RDP (Remote Desktop Protocol, el protocolo utilizado por los Servidores de Terminal de Windows, para la conectividad nativa del escritorio de Windows. El paquete RDP, junto con un servicio capaz de aceptar conexiones de rdesktop y de clientes del Servidor de Terminal de Windows

```bash
yum install epel-release   -y
yum -y install xrdp tigervnc-server rdesktop
```

```bash
systemctl enable xrdp
systemctl start xrdp
systemctl status xrdp
```

```
netstat -antup | grep xrdp
tcp        0      0 0.0.0.0:3389            0.0.0.0:*               LISTEN      8185/xrdp
```

```bash
rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
```

Conectarme desde linux a windows por RDP### rdesktop –u administrador ipdewindows

---

## Apache guacamole html5

Apache Guacamole es una herramienta de acceso remoto basada en web que te permite controlar escritorios y servidores de forma gráfica sin necesidad de instalar cliente — todo se hace desde el navegador.

- https://guacamole.apache.org/

## ¿Qué es Apache Guacamole? Es un gateway RDP, VNC y SSH sin cliente ("clientless remote desktop gateway"). Características principales: Acceso remoto a escritorios usando RDP, VNC y SSH. Todo a través de un navegador web, sin plugins ni Java. Interfaz moderna y segura. Multiusuario (puede integrarse con LDAP o bases de datos). Soporte para copiar/pegar, redirección de archivos y más.

## Componentes principales:

guacd – El demonio que traduce los protocolos (RDP, VNC, SSH). guacamole.war – Aplicación web (Java) desplegada en Tomcat. base de datos (opcional) – Para gestionar usuarios y conexiones (MySQL, PostgreSQL, etc.).

---

## Spice

SPICE es un protocolo de escritorio remoto diseñado para entornos virtuales que reemplaza a VNC en máquinas virtuales KVM/QEMU. SPICE entrega un mejor rendimiento a bajo consumo de CPU, soporta video de alta calidad, sonido e interacción con el host (copiar/pegar).

## VNC (Virtual Network Computing) es un protocolo que permite ver y controlar de forma remota el entorno gráfico (escritorio) de otro equipo, similar a una sesión física, pero a través de la red.

¿Para qué sirve VNC? Acceder al escritorio de una máquina Linux (como Rocky Linux) desde otro equipo. Administrar servidores de forma gráfica. Ejecutar aplicaciones gráficas remotamente.

## Componentes de VNC:

Servidor VNC → se instala en el equipo que se quiere controlar (ej: Rocky Linux). Cliente VNC (viewer) → se instala en el equipo desde el que se accede.

## Servidores VNC comunes en Linux:

tigervnc-server → recomendado en Rocky Linux. x11vnc → comparte la sesión gráfica actual. vncserver → crea sesiones virtuales independientes.

## Cliente VNC:

En otro equipo (Linux, Windows o Mac), puedes usar: TigerVNC Viewer RealVNC Viewer Remmina (en Linux)

---

## Cockpit

Cockpit es una consola web para administrar servidores Linux desde el navegador. Permite gestionar servicios, usuarios, almacenamiento, red y contenedores sin usar solo la terminal.

## Es muy común en distribuciones como:

Red Hat Enterprise Linux Rocky Linux Ubuntu Debian

- https://cockpit-project.org/

```bash
dnf install cockpit -y
yum install cockpit* -y
apt install  cockpit* -y
```

```bash
systemctl start cockpit.socket
systemctl status cockpit.socket
```

```
netstat -putan |grep 9090
tcp        0      0 0.0.0.0:9090            0.0.0.0:*               LISTEN      1/systemd
```

## Entramos en nuestra ip del servidor con las credenciales del usuario root:

- https://192.168.33.150:9090/

---

## #####Laboratorio Instalacion de Entorno Grafico en Rocky Liunux 8.x

- https://www.shernet.com/kde/kde-on-rocky-linux-9/

- https://linux.how2shout.com/how-to-install-kde-plasma-desktop-on-rocky-linux-8/

KDE es un entorno de escritorio libre y altamente configurable para sistemas Linux y Unix. Hoy en día, cuando hablamos de KDE normalmente nos referimos a KDE Plasma, que es su entorno gráfico moderno.

## Procedimiento para Rocky Linux release 8.8

## Comenzamos con el update del sistema, la instalacion de repositorios y la instalacion del software:

```bash
sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf --enablerepo=epel,powertools group -y install "KDE Plasma Workspaces" "base-x" -y
```

## Set Default System Target Graphical

## El comando , echo "exec /usr/bin/startkde" >> ~/.xinitrc, agrega la línea exec /usr/bin/startkde al archivo de configuración ~/.xinitrc. Este archivo se ##utiliza para definir qué entorno de escritorio o gestor de ventanas debe iniciarse cuando ejecutas startx.

```bash
echo "exec /usr/bin/startkde" >> ~/.xinitrc
sudo systemctl set-default graphical.target
```

## Reboot and log in to get KDE GUI

shutdown -r now

---

## Laboratorio variable DISPLAY

La variable de entorno DISPLAY indica dónde debe mostrarse una aplicación gráfica (X11). Es fundamental en entornos gráficos basados en X Window System.

¿Qué hace exactamente? Cuando ejecutas un programa gráfico (por ejemplo xclock, firefox, etc.), el sistema necesita saber: ¿En qué pantalla (y servidor gráfico) lo dibujo? Esa información la proporciona la variable DISPLAY

```bash
yum install xeyes firefox -y
```

xeyes

## Download xming para Windows

- https://sourceforge.net/projects/xming/

## Tras instalar ximing, lo lanzamos con el comando xlaunch

## IMPORTANTE selecionar NO ACCESS CONTROL

### xlaunch

## Estando conectados a traves de ssh con nuestra mv de linux, exportamos la variable DISPLAY A NUESTRO WINDOWS (192.168.33.1)

## Cualquier comando grafico que ejecutemos en nuestro linux, tiene que irnos a nuestro servidor X que tenemos instalado en nuestro Windows a traves xming:

```bash
export DISPLAY=192.168.33.1:0.0
```

xeyes firefox

---

### Install Xrdp Server to connect to Rocky Linux Server from the Windows Remote Desktop feature

- https://www.server-world.info/en/note?os=Rocky_Linux_8&p=desktop&f=3

Xrdp es una implementación de código abierto de RDP (Remote Desktop Protocol, el protocolo utilizado por los Servidores de Terminal de Windows, para la conectividad nativa del escritorio de Windows. El paquete RDP, junto con un servicio capaz de aceptar conexiones de rdesktop y de clientes del Servidor de Terminal de Windows.

## Install from EPEL y instalamos el software xrdp:

```bash
dnf install epel-release -y
dnf --enablerepo=epel -y install xrdp
```

## Iniciamos el service xrdp y lo ponemos al inicio del sistema:

```bash
systemctl enable xrdp --now
```

```
netstat -antup | grep xrdp
tcp        0      0 0.0.0.0:3389            0.0.0.0:*               LISTEN      8185/xrdp
```

## Para conectarnos desde nuestro windows con el cliente de escritorio remoto a traves de:

### mstsc

a la ip de nuestro servidor de linux y nos conectamos con las credenciales del usuario root. 192.168.33.10

## Nota:

En la version de Rocky linux9 la instalacion del software xrdp no permite la conexion con root, tendremos que utilizar un usario nominal. Comprobarlo.

---

- https://cockpit-project.org/

## Herramienta via Web:

## Cockpit is a web-based graphical interface for servers, intended for everyone, especially those who are:

```bash
dnf install cockpit* -y
yum install cockpit* -y
apt install  cockpit* -y
```

```bash
systemctl start cockpit.socket
systemctl status cockpit.socket
```

```
netstat -putan |grep 9090
tcp        0      0 0.0.0.0:9090            0.0.0.0:*               LISTEN      1/systemd
```

## Entramos en nuestra ip del servidor con las credenciales del usuario root:

- https://192.168.33.150:9090/

Xfce es un entorno de escritorio libre para sistemas tipo Unix como GNU/Linux, BSD, Solaris y derivados. Su objetivo es ser rápido y ligero, sin dejar de ser visualmente atractivo y fácil de usar.

---

## Procedimiento para Rocky Linux release 10.

## Instalación KDE Plasma rocky 10

```bash
sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf config-manager --set-enabled crb -y
sudo dnf groupinstall "KDE Plasma Workspaces" "base-x" -y
sudo systemctl set-default graphical.target
```

```bash
echo "exec /usr/bin/startkde" >> ~/.xinitrc
sudo systemctl set-default graphical.target
```

reboot

## NO REALIZAR SOLO SI EN EL PROCEDIMIENTO YA TENIA INSTALADO gnome:

### Habilitamos ssdm de plasma y deshabilitamos gdm de gnome

```bash
sudo systemctl enable sddm; sudo systemctl disable gdm; sudo systemctl stop gdm;sudo systemctl start ssdm
```
