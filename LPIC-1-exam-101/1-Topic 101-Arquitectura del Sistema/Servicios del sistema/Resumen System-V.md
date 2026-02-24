##System-V##

**Pagina 280 --> Manual LINUX - Preparación a la certificación LPIC-1.pdf

* SystemV Init (abreviado como SysVinit) es un sistema de inicialización tradicional utilizado en distribuciones de Linux antes de la adopción masiva de SystemD. Es el encargado de gestionar el arranque del sistema, los niveles de ejecución (runlevels) y la inicialización de servicios.

#Principales características de SysVinit:
Simplicidad:
Es un sistema secuencial: los scripts se ejecutan en un orden predefinido según los niveles de ejecución.

#Niveles de ejecución (Runlevels):
Define diferentes estados del sistema, como arranque, apagado, modo de usuario único, etc.
Los runlevels más comunes son:
0: Apagar el sistema.
1: Modo usuario único (rescate).
3: Modo multiusuario sin interfaz gráfica.
5: Modo multiusuario con interfaz gráfica.
6: Reinicio del sistema.

#Scripts de inicio:
Los servicios y tareas se gestionan mediante scripts de shell almacenados en directorios como /etc/rc.d/ o /etc/init.d/.

#Secuencia de arranque:
Durante el arranque, SysVinit ejecuta scripts específicos basándose en el nivel de ejecución configurado en /etc/inittab.


ps -ef  |more
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 11:32 ?        00:00:00 /sbin/init

SVR4.Fue la versión más popular de SVR asi como la fuente de varias características comunes del sistema
operativo Unix, como el script /etc/init.d

# cat /proc/1/stat

Los niveles de ejecucion en SystemV describen ciertos estados del equipo los cuales se caracterizan por
ejecutar ciertos procesos. En general existen 8 niveles de ejecucion los cuales van del 0 al 6 y S o s, que son alias del mismo nivel de ejecucion, de estos ochos niveles, tres son considerados reservados, estos son:
Para ver el modo de arranque (runlevel) normalmente 3 multiusuario sin grafico o 5 multi usuario con graficos

cat /etc/inittab

 Default runlevel. The runlevels used are:
#   0 - halt (Do NOT set initdefault to this)
#   1 - Single user mode
#   2 - Multiuser, without NFS (The same as 3, if you do not have networking)
#   3 - Full multiuser mode
#   4 - unused
#   5 - X11
#   6 - reboot (Do NOT set initdefault to this)
#

id:3:initdefault:



runlevel
##Para arrancar un servicio que se instalen a traves de rpm o deb siempre estaran en /etc/init.d

/etc/init.d/httpd start
apache2
httpd
smb
mysqld

##Para cambiar de runlevel en caliente podemos utilizar el comando init o telinit:
telinit 6 
init 0 
init 1
init 3
init 6

En resumen, init es el proceso central que administra el sistema, mientras que telinit es el medio mediante el cual se le indica a init que realice cambios (como pasar a otro runlevel).

##Para arrancar un servicio que se instalen a traves de rpm o deb siempre estaran en /etc/init.d
/etc/init.d/httpd start
service httpd start
service mysqld stop

##Para poner un servicio en system-v, al inicio, es decir que arranque el servicio con el arranque del servidor:
##Los archivos con S y un numero del 0 al 99 son lo que van a iniciar y los que tienen la K y un numero del 0 al 99 no se inician

rc0.d/ rc1.d/ rc2.d/ rc3.d/ rc4.d/ rc5.d/ rc6.d/ rc.d/

/etc/rc.d/rc3.d

/etc/rc3.d/
S99supervisamen
S86httpd
K15httpd
/etc/rc5.d/

#El comando chkconfig es una herramienta utilizada en sistemas Linux basados en SysVinit (como algunas distribuciones antiguas de Red Hat) para gestionar la configuración de los servicios (daemons) en los diferentes niveles de ejecución (runlevels).

chkconfig --list  network

chkconfig --level 3 httpd on
/etc/rc3/S85httpd --> /etc/init.d/httpd


chkconfig --level 35 httpd on
/etc/rc5/S85httpd
/etc/rc3/S85httpd


chkconfig --level 3 httpd off
/etc/rc3/k15httpd

##Para debian:
sudo apt-get install sysv-rc-conf
sudo sysv-rc-conf

##En redhat y derivados para poner al inicio servicios:
yum install setuptool
setup

##El comando ntsysv permite selecionar los service que queremos poner al inicio con system-v y system-d

ntsysv
yum  install ntsysv -y


##El comando chkconfig del ejemplo anterior (http), cuando le pasamos un on o un off, viene al /etc/init.d/httpd
##y evalua la entrada chkconfig del script:
chkconfig --level 3 httpd on

cat /etc/init.d/httpd
# chkconfig: - 85 15
# description: Supervisamem


##Crear el enlance de forma manual por ejemplo en debian:
cd /etc/rc3.d
ln -s /etc/init.d/iniciar-supervisamem /etc/rc3.d/S99iniciar-supervisamem

##Borrar el enlance de forma manual por ejemplo en debian:
rm -rf  /etc/rc3.d/S99iniciar-supervisamem


chkconfig --level 35 httpd on
/etc/rc3.d/S85httpd --> /etc/init.d/httpd
/etc/rc5.d/S85httpd --> /etc/init.d/httpd

/etc/init.d/httpd start

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##Laboratorio Instalar tomcat 9.0.112 de forma manual y trabajar con system-v y system-d

###SystemV
##He descagado:
cd /root
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.115/bin/apache-tomcat-9.0.115.tar.gz

tar xvfz  /root/apache-tomcat-9.0.115.tar.gz -C /
ls -l /apache-tomcat-9.0.115
mv /apache-tomcat-9.0.115 /tomcat-9


##Lo he descomprimido en el / de la maquina de linux con este nombre:
/tomcat-9

##Damos permisos de ejecucion:
chmod 700 /tomcat-9/bin/*.sh

##Tenemos que tener java (jdk)  openjdk instalado en el servidor, en este ejemplo:
java -version
openjdk version "1.8.0_292"

dnf list available | grep openjdk
sudo dnf install -y java-1.8.0-openjdk

#Buscar versiones disponibles de OpenJDK en debian:
apt search openjdk
sudo apt install openjdk-17-jdk


##Iniciarlo y pararlo de forma manual:
/tomcat-9/bin/startup.sh
/tomcat-9/bin/shutdown.sh

##Compromabos que esta iniciado:
netstat -putan |grep 8080
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      1170/java

netstat – Muestra estadísticas de red.
-p – Muestra el PID/programa que utiliza el socket.
-u – Muestra conexiones UDP.
-t – Muestra conexiones TCP.
-a – Muestra todos los sockets (escuchando y conectados).
-n – Muestra direcciones y puertos en formato numérico.
| grep 8080 – Filtra para mostrar solo líneas que contengan 8080.

##La ip del interfaz eth1
ip a

http://192.168.33.10:8080



##Crear un script para system-v:

vi  /etc/init.d/tomcat

#!/bin/bash
# chkconfig: - 99 10
case $1 in
start)
  /tomcat-9/bin/startup.sh &
  ;;
stop)
  /tomcat-9/bin/shutdown.sh &
  ;;
*)
echo "No es una opcion para pasarle a script solo start y stop"
;;
esac

##Arrancarlo con el script y pararlo:
chmod 700 /etc/init.d/tomcat
/etc/init.d/tomcat start
/etc/init.d/tomcat stop

service tomcat start
service tomcat stop


##Compromabos que esta iniciado:
netstat -putan |grep 8080
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      1170/java

http://ipmv:8080

##Ponerlo al inicio en system-v en el runlevel 3, dos formas de realizarlo:
##Con el comando chkconfig solo redhat y derivados:
chkconfig --level 3 tomcat on

##Esto crearar el siguiente enlace:
ls -l /etc/rc3.d/
total 0
lrwxrwxrwx 1 root root 16 oct  3 19:31 S99tomcat -> ../init.d/tomcat

##Realizarlo de forma manual sin el comando chkconfig:
ln -s /etc/init.d/tomcat    /etc/rc3.d/S98tomcat
-----------------------------------------------------------------------------------------------------------------------
##CREATING AND MODIFYING SYSTEMD UNIT FILES

Material Alumnos LPIC-1-2025\LPIC-1-exam-101\1-Topic 101-Arquitectura del Sistema\Servicios del sistema
Red_Hat_Enterprise_Linux-7-System_Administrators_Guide-en-US.pdf --Pagina 159

###SystemD

##Lo he descomprimido en el / de la maquina de linux con este nombre:
/tomcat-9


vi /etc/systemd/system/tomcat.service

[Unit]
Description=Apache Tomcat Web Application Container
After=network.target
Conflicts=httpd.service apache2.service

[Service]
Type=forking
ExecStart=/tomcat-9/bin/startup.sh
ExecStop=/tomcat-9/bin/shutdown.sh
# Límite duro de memoria: si se supera, el kernel puede matar el proceso
MemoryMax=512M

[Install]
WantedBy=multi-user.target


##Le decimos a systemd que tenemos una nueva unit de tipo service:
systemctl daemon-reload
systemctl start tomcat.service

systemctl show tomcat.service |grep -i MemoryMax

##Compromabos que esta iniciado:
netstat -putan |grep 8080
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      1170/java

http://ipmv:8080

##Paro el tomcat 
systemctl stop tomcat.service

netstat -putan |grep 8080
http://ipmv:8080



##Lo ponemos al inicio, para cuando arranque mi servidor:
systemctl enable tomcat.service
systemctl disable tomcat.service


Created symlink /etc/systemd/system/multi-user.target.wants/tomcat.service → /usr/lib/systemd/system/tomcat.service.

#¿Qué significa esta salida?
Se creó un enlace simbólico (symlink) en /etc/systemd/system/multi-user.target.wants/ que apunta al archivo de unidad principal /usr/lib/systemd/system/tomcat.service.

Esto significa que el servicio tomcat se iniciará automáticamente cuando el sistema entre en el estado multi-user.target (modo multiusuario, equivalente a runlevel 3 en SysV).
