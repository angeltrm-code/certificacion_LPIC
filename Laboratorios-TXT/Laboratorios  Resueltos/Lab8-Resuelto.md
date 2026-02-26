2-Comando para poner en el inicio del servicio de httpd (apache), en systemd y systemV
systemctl enable httpd
chkconfig --level 35 httpd on

3.- PROGAMAR TAREA TANTO EN AT COMO EN CRON PARA EJECUTAR EL SCRIPT SUPERVISAMEN TODOS LOS DÍAS A LAS 14h
0 14 * * * /script/supervisamen 

at -f /script/supervisamen  14:00

4.- COMANDO PARA COMPROBAR LA COLA DE AT Y CÓMO ELIMINAR UNA TAREA PROGRAMADA TMB EN AT.
atq
atrm 1

5.- ¿PARA QUÉ SIRVE EL DIRECTORIO /etc/skel, y que modificaciones podemos realizan en dicho directorio? 

De modo predefinido las cuentas de usuario del sistema utilizarán como molde al directorio 
		/etc/skel para crear el directorio de inicio de todos los usuarios del sistema. Regularmente, 
		y como mínimo, /etc/skel incluye lo siguiente:
.bash_logout
 .bash_profilels 
 .bashrc

		
			
6.- DADO EL DIRECTORIO /usr/local/Java/jdk-1.7/bin PARA EL USUARIO MARTES11 PONERLE LAS VARIABLES DE ENTORNO
JAVA_HOME PARA QUE UTILICE ESA VERSIÓN DE JAVA, y que tenga disponibles los binarios.

vi /home/martes11/.bash_profile
export JAVA_HOME=/usr/local/java/jdk-1.7
PATH=$PATH:$HOME/bin:/usr/local/java/jdk-1.7/bin
export PATH
	
7.- AL USUARIO oracle CAMBIARLE EL JUEGO DE CARACTERES A ISO8859-1 
vi /home/oracle/.bash_profile
LANG=es_ISO8859-1
export LANG
Para ver si esto es correcto entramos con el usuario y ejecutaremo el comando locale
localectl

8.- SINCRONIZAR HORA DEL SIST. CON LA HORA DEL HARDWARE	
hwclock --help
-s, --hctosys        set the system time from the hardware clock
-w, --systohc        set the hardware clock from the current system time
hwclock --hctosys

9.- COMO CONVIERTO UN FICHERO QUE ESTÁ EN FORMATO WINDOWS A UNIX PARA PODER SER EJECUTADO en un linux.
dos2unix fichero

10.- COMO SINCRONIZO MI SERVIDOR DE FORMA MANUAL CON EL SERVIDOR NTP
ntpdate  servidorntp

11.- EXPLICAR CON EL AT COMO FUNCIONA EL PERMITIR O DENEGAR SU USO A LOS USUARIOS
Por defecto todos lo pueden utilizar si queremos denegar en /etc/at.deny
Si creamos el /etc/at.allow solo los que esten en este archivo pueden utilizar at.
	
12.- EXPLICAR CON EL CRON COMO FUNCIONA EL PERMITIR O DENEGAR SU USO A LOS USUARIOS
Por defecto todos lo pueden utilizar si queremos denegar en /etc/cron.deny
Si creamos el /etc/cron.allow solo los que esten en este archivo pueden utilizar cron.

13  A traves de los tcp_wrappers el servicio dovecot y httpd no se permite a nadie excepto a la red 192.168.0.

/etc/hosts.allow
  dovecot :  192.168.0.
  

 # /etc/hosts.deny 
 dovecot :  ALL

El servicio httpd no se puede controlar con tcp_wrappers

14-Que cadena tiene que tener un script, para que pueda ser tratado con el comando chkconfig
#! /bin/bash
# chkconfig: - 90 10

chkconfig --level 3 iniciar-supervisamen on

/etc/init.d/iniciar-supervisamen
# chkconfig: - 98 10

##El comando anterior crea un enlace simbolico contra /etc/init.d/iniciar-supervisamen

/etc/rc3.d/S98iniciar-supervisamen ---> /etc/init.d/iniciar-supervisamen
