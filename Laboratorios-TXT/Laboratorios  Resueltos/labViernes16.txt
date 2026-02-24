1.- ELIMINAR USUARIOS Y SU HOME CREADOS  en laboratorios anterioresAYER
2.- Como configuro un servidor syslog y rsyslog para que puedan recibir losg remotos
514 @@ipdelservidor @ipservidor 

3.- PROGAMAR TAREA TANTO EN AT COMO EN CRON PARA EJECUTAR EL SCRIPT SUPERVISAMEN TODOS LOS DÍAS A LAS 
11 DE LA NOCHE.

Para hacerlo con el comando 'at'
	1º.- hay que levantar el servicio atd y hacer que se ejecute desde el inicio.
		service atd start 				--para iniciarlo ahora mismo.
		chkconfig --level 35 atd on 	--para que se inicie automáticamente en el inicio.
	
	2º.- Fijar la tarea con 'at'
		at 23:00 
		at> ./opt/scripts/supervisamen &		--indico que quiero que se ejecute este script
		at> <EOT>								--con Ctrl+d para finalizar
		job 5 at 2015-10-13 23:00

		Otra forma de hacer lo mismo:
		
		at 23:00 -f /opt/scripts/supervisamen 
		
	Para hacerlo con el comando 'cron'
		crontab -e 						--me habre el editor vi para añadir tareas en /etc/crontab
		
		Una de las líneas de este archivo tiene que se como la siguiente:
		
		0 23 * * * root /opt/scripts/supervisamen
		
		Para que el escrip se ejecute con las características del usuario "oracle", por ejemplo, habria
		que escribir la línea así:
		
		0 23 * * * su -c "oracle" /opt/scripts/supervisamen
		
		Si no se especifica el usuario se ejecutará como el usuario que soy en el momento de editar 
		el fichero.
		

4.- COMANDO PARA COMPROBAR LA COLA DE AT Y CÓMO ELIMINAR UNA TAREA PROGRAMADA TMB EN AT.
atq 			--para el comando at
		atrm 1			--para eliminar la tarea 1 programada con 'at'
		crontab -l 		--para el comando cron 


5.- ¿PARA QUÉ SIRVE EL DIRECTORIO /etc/skel, y que modificaciones podemos realizan en dicho directorio? 
De modo predefinido las cuentas de usuario del sistema utilizarán como molde al directorio 
		/etc/skel para crear el directorio de inicio de todos los usuarios del sistema. Regularmente, 
		y como mínimo, /etc/skel incluye lo siguiente:
			
			.bash_logout .bash_profile .bashrc .gtkrc 



6.- DADO EL DIRECTORIO /usr/local/Java/jdk-1.7/bin PARA EL USUARIO MARTES11 PONERLE LAS VARIABLES DE ENTORNO
JAVA_HOME PARA QUE UTILICE ESA VERSIÓN DE JAVA, y que tenga disponibles los binarios.
vim /home/martes11/.bash_profile

	Tienemos que añadir las siguientes líneas:
	
		JAVA_HOME=/usr/local/java/jdk-1.7/bin
		export JAVA_HOME

		Para que estén disponibles los binarios de java en la consola sin tener que escribir toda la
		ruta hasta ellos habría que añadirlo a la variable PATH:
			
			PATH=$PATH:$HOME/bin:/opt/scripts/:$JAVA_HOME



7.- AL USUARIO MARTES11 CAMBIARLE EL JUEGO DE CARACTERES A ISO8859-1 
vim /home/martes11/.bash_profile
[martes11@orion ~]$ export LANG=es_ES.ISO8859-1 	--realizo el cambio de codificación
	[martes11@orion ~]$ locale							--compruebo y veo el resultado del cambio.
	LANG=es_ES.ISO8859-1
	LC_CTYPE="es_ES.ISO8859-1"
	LC_NUMERIC="es_ES.ISO8859-1"
	LC_TIME="es_ES.ISO8859-1"
	LC_COLLATE="es_ES.ISO8859-1"
	LC_MONETARY="es_ES.ISO8859-1"
	LC_MESSAGES="es_ES.ISO8859-1"
	LC_PAPER="es_ES.ISO8859-1"
	LC_NAME="es_ES.ISO8859-1"
	LC_ADDRESS="es_ES.ISO8859-1"
	LC_TELEPHONE="es_ES.ISO8859-1"
	LC_MEASUREMENT="es_ES.ISO8859-1"
	LC_IDENTIFICATION="es_ES.ISO8859-1"
	LC_ALL=

8.- SINCRONIZAR HORA DEL SIST. CON LA HORA DEL HARDWARE	
hwclock --hctosys

9.- COMO CONVIERTO UN FICHERO QUE ESTÁ EN FORMATO WINDOWS A UNIX PARA PODER SER EJECUTADO.
dos2unix fichero.sh 

10.- COMO SINCRONIZO MI SERVIDOR DE FORMA MANUAL CON EL SERVIDOR NTP
ntpdate 1.es.pool.ntp.org

11.- EXPLICAR CON EL AT COMO FUNCIONA EL PERMITIR O DENEGAR SU USO A LOS USUARIOS
El archivo /etc/at.deny se utiliza para definir una lista de usuarios a los cuales se les denegará el 
	uso del mandato at. Cuando este archivo está vacío, implica que todos los usuarios del sistema pueden 
	hacer uso del mandato at.

	El archivo /etc/at.allow es inexistente de modo predeterminado. Cuando éste existe, sólo los usuarios 
	listados en su interior pueden hacer uso del mandato at.
	
	
12.- EXPLICAR CON EL CRON COMO FUNCIONA EL PERMITIR O DENEGAR SU USO A LOS USUARIOS
13- Sincronizar la hora ente el servidor a y el servidor b a la hora actual, con el comando date.
date --set "2015-10-16 18:45"

14-Explicar la diferencia entre un servidor de syslog remoto configurado como udp o tcp

15- En un servidor Redhat donde se configuran los parametros regionales.
/etc/sysconfig/i18n

16-DIFERENCIAS ENTRE MODPROBE Y INSMOD
Que el modprobe gestiona las dependencias de los modulos a cargar 
17-Explique los siguientes comandos de impresion de System V
  lp imprime un archivo
  lpstat estado de la impresora
  cancel cancela trabajos
  lpadmin -x cola suprime una cola
  lpadmin -d cola define la cola por defecto
  
  BSD
    lpr imprime un archivo
  lprm elimina trabajos de la cola.
	