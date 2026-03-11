# Clase 4 Jueves 26 02 2026

Apuntes de clase sobre Clase 4 Jueves 26 02 2026, reorganizados para facilitar la consulta rápida y el repaso.

Jueves 26/02/2026

## Referencias

- https://www.lpi.org/es/our-certifications/lpic-1-overview

## Materiales publicos de LPIC:

- https://learning.lpi.org/es/learning-materials/learning-materials/

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

sudo -i

---

## En esta clase veremos:

## Tema 103: Comandos GNU y Unix

> Material Alumnos LPIC-1-2025\LPIC-1-exam-101\3-Topic 103-Comandos GNU y UNIX -->Shell Bash de Linux Comandos Manejo de Texto.pdf

Material Alumnos LPIC-1-2025\LPIC-1-exam-101\3-Topic 103-Comandos GNU y UNIX\Gestion de Procesos

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

## El D-Bus Machine ID

El D-Bus Machine ID es un identificador único que usa D-Bus (y otros servicios del sistema) para distinguir una instalación específica de Linux, sobre todo útil en sistemas clonados, contenedores y entornos virtualizados.

¿Para qué sirve? Identificación única del sistema: usada por D-Bus, systemd, journalctl, etc. Evitar conflictos en entornos clonados: si clonas un sistema y no cambias el machine-id, podrías tener problemas con servicios que esperan unicidad. Contenedores: en contenedores, a veces es necesario regenerar este ID para evitar choques.

```bash
cat /etc/machine-id
```

El siguiente comando se puede usar para validar que existe una ID de máquina D-Bus para el sistema en ejecución: $ dbus-uuidgen --ensure

Si no se muestran mensajes de error, existe una ID para el sistema. Para ver la ID actual de la máquina D-Bus, ejecute lo siguiente: $ dbus-uuidgen --get 17f2e0698e844e31b12ccd3f9aa4d94a

Elimina el archivo actual de machine-id (por ejemplo, si fue clonado y está duplicado en varias máquinas).

```bash
sudo rm -f /etc/machine-id
```

Genera un nuevo UUID válido y lo escribe en /etc/machine-id solo si el archivo no existe. Esto asegura que D-Bus tenga un identificador único. sudo dbus-uuidgen --ensure=/etc/machine-id

---

> Laboratorio Instalar tomcat 9.0.100 de forma manual y trabajar con system-v y system-d

## SystemV

System V init (SysVinit) es uno de los sistemas de inicialización más antiguos y tradicionales en Unix y Linux. Se encarga de iniciar y detener los servicios del sistema durante el arranque y el apagado, usando scripts de shell organizados por runlevels (niveles de ejecución).

## He descagado la version de tomcat desde la web:

Un servidor Tomcat, oficialmente llamado Apache Tomcat, es un servidor web y contenedor de servlets desarrollado por la Fundación Apache. Su función principal es ejecutar aplicaciones web desarrolladas en Java siguiendo las especificaciones de Java EE (ahora Jakarta EE), como: Servlets JSP (JavaServer Pages) WebSockets JSTL (JavaServer Pages Standard Tag Library)

## ###COMENZAMOS EL LABORATORIO EN SystemV

```bash
cd /root
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.100/bin/apache-tomcat-9.0.100.tar.gz
```

```bash
tar xvfz  /root/apache-tomcat-9.0.100.tar.gz -C /
ls -l /apache-tomcat-9.0.100
mv /apache-tomcat-9.0.100 /tomcat-9
```

## Lo he descomprimido en el / de la maquina de linux con este nombre:

```bash
/tomcat-9
```

## Damos permisos de ejecucion:

```bash
chmod 700 /tomcat-9/bin/*.sh
```

## Tenemos que tener java (jdk)  openjdk instalado en el servidor, en este ejemplo:

java -version openjdk version "1.8.0_292"

```bash
dnf list available | grep openjdk
sudo dnf install -y java-1.8.0-openjdk
```

## Buscar versiones disponibles de OpenJDK en debian y instalarla:

```bash
apt search openjdk
sudo apt install openjdk-17-jdk
```

> Iniciarlo de forma manual el servidor de tomcat:

```bash
/tomcat-9/bin/startup.sh
```

## Compromabos que esta iniciado:

```
netstat -putan |grep 8080
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      1170/java
```

netstat – Muestra estadísticas de red.

-p – Muestra el PID/programa que utiliza el socket. -u – Muestra conexiones UDP. -t – Muestra conexiones TCP. -a – Muestra todos los sockets (escuchando y conectados). -n – Muestra direcciones y puertos en formato numérico. | grep 8080 – Filtra para mostrar solo líneas que contengan 8080.

## La ip del interfaz eth1

```bash
ip a
```

- http://192.168.33.150:8080

> Lo paro de forma manual el servidor de tomcat:

```bash
/tomcat-9/bin/shutdown.sh
```

## Compromabos que no esta iniciado, no tiene que aparecer el puerto 8080:

```
netstat -putan |grep 8080
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      1170/java
```

## Crear un script para system-v:

```
vi  /etc/init.d/tomcat
```

## !/bin/bash

## ← Esta línea indica que el script se ejecutará con el intérprete de Bash

## chkconfig: - 99 10

← Esta línea es usada por 'chkconfig' para registrar el script como un servicio. # El guion '-' indica que no se asigna a ningún runlevel por defecto. # 99 es la prioridad al iniciar (más alto = más tarde). # 10 es la prioridad al detener (más bajo = se detiene antes que otros).

case $1 in # ← Se usa una estructura 'case' para evaluar el primer parámetro pasado al script.

## Por ejemplo, si ejecutas: ./tomcat start → entonces $1 es "start"

start)

## # ← Si el primer parámetro es 'start', se ejecuta lo siguiente:

```bash
  /tomcat-9/bin/startup.sh &
```

← Se ejecuta el script de arranque de Tomcat. # El símbolo '&' lo ejecuta en segundo plano (aunque no es necesario, porque startup.sh ya lo hace).

;;

## # ← Fin del bloque de la opción 'start'

stop)

## # ← Si el primer parámetro es 'stop', se ejecuta lo siguiente:

```bash
  /tomcat-9/bin/shutdown.sh &
```

← Se ejecuta el script de apagado de Tomcat. # También con '&' para ponerlo en segundo plano (pero no es necesario).

;;

## # ← Fin del bloque de la opción 'stop'

*) # ← Si el parámetro no es 'start' ni 'stop', se entra en esta opción por defecto.

echo "No es una opcion para pasarle a script solo start y stop"

← Muestra un mensaje de error explicando que solo se permiten los parámetros 'start' y 'stop'

;;

## # ← Fin del bloque por defecto

esac

## ← Fin de la estructura 'case'

## Arrancarlo con el script y pararlo:

```bash
chmod 700 /etc/init.d/tomcat
/etc/init.d/tomcat start
/etc/init.d/tomcat stop
```

```bash
service tomcat start
service tomcat stop
```

## Compromabos que esta iniciado:

```
netstat -putan |grep 8080
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      1170/java
```

- http://ipmv:8080

## Ponerlo al inicio en system-v en el runlevel 3, dos formas de realizarlo:

## Con el comando chkconfig solo redhat y derivados:

```bash
chkconfig --level 35 tomcat on
```

## Esto crearar el siguiente enlace:

```bash
ls -l /etc/rc3.d/
```

total 0 lrwxrwxrwx 1 root root 16 oct  3 19:31 S99tomcat -> ../init.d/tomcat

> Realizarlo de forma manual sin el comando chkconfig: ln -s /etc/init.d/tomcat    /etc/rc3.d/S98tomcat

---

## CREATING AND MODIFYING SYSTEMD UNIT FILES

> Material Alumnos LPIC-1-2025\LPIC-1-exam-101\1-Topic 101-Arquitectura del Sistema\Servicios del sistema Red_Hat_Enterprise_Linux-7-System_Administrators_Guide-en-US.pdf --Pagina 159

## SystemD

## Lo he descomprimido en el / de la maquina de linux con este nombre, realizado en el paso anterior:

```bash
/tomcat-9
```

```bash
vi /etc/systemd/system/tomcat.service
```

```conf
[Unit]  # Sección que define información general y dependencias del servicio.
Description=Apache Tomcat Web Application Container  # Descripción del servicio que aparece con systemctl status.
After=network.target  # Indica que Tomcat debe iniciarse después de que la red esté activa.
Conflicts=httpd.service apache2.service  # Evita que Tomcat se ejecute al mismo tiempo que httpd o apache2 (por posible conflicto de puertos).
```

```
[Service]  # Sección que define cómo se ejecuta y gestiona el servicio.
Type=forking  # Indica que el script de arranque hace fork (se va a segundo plano), como lo hace startup.sh.
ExecStart=/tomcat-9/bin/startup.sh  # Ruta al script que inicia Tomcat.
ExecStop=/tomcat-9/bin/shutdown.sh  # Ruta al script que detiene Tomcat.
```

```
[Install]  # Sección usada al habilitar el servicio con systemctl enable.
WantedBy=multi-user.target  # Indica que el servicio debe arrancar automáticamente en el runlevel multiusuario (modo texto con red, sin GUI).
```

## Le decimos a systemd que tenemos una nueva unit de tipo service:

```bash
systemctl daemon-reload
systemctl start tomcat.service
```

## Compromabos que esta iniciado:

```
netstat -putan |grep 8080
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      1170/java
```

- http://ipmv:8080

## Paro el tomcat

```bash
systemctl stop tomcat.service
```

## Comprobamos que tomcat no esta iniciado:

```bash
netstat -putan |grep 8080
```

- http://ipmv:8080

## Lo ponemos al inicio, para cuando arranque mi servidor:

```bash
systemctl enable tomcat.service
systemctl disable tomcat.service
```

Created symlink /etc/systemd/system/multi-user.target.wants/tomcat.service → /usr/lib/systemd/system/tomcat.service.

¿Qué significa esta salida? Se creó un enlace simbólico (symlink) en /etc/systemd/system/multi-user.target.wants/ que apunta al archivo de unidad principal /usr/lib/systemd/system/tomcat.service.

Esto significa que el servicio tomcat se iniciará automáticamente cuando el sistema entre en el estado multi-user.target (modo multiusuario, equivalente a runlevel 3 en SysV).

---

## Averiguar que paquete me instala un comando que no tenga en mi linux:

## En debian y derivados averiguar paquete que instala un comando

```bash
apt-cache search nslookup
```

```bash
sudo apt-get update
sudo apt-get install apt-file
sudo apt-file update
sudo apt-file search nslookup
sudo apt-file list nombre_paquete
```

```bash
sudo apt install  -y nombre_paquete
```

## En Redhat y derivados averiguar paquete que instala un comando

```bash
yum provides lspci
dnf provides lspci
```

## El comando anterior da esta salida:

### pciutils-3.5.1-3.el7.x86_64 : PCI bus related utilities

```
Repositorio        : @base
```

Resultado obtenido desde: Nombre del archivo    : /usr/sbin/lspci

## Instalo el programa:

```bash
yum install -y pciutils-3.5.1-3.el7.x86_64
```
