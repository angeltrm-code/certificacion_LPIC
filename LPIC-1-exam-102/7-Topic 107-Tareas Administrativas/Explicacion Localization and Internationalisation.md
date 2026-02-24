**107.3 Localización e internacionalización

#Resumen del manual de certificacion LPIC-1 pagina 393
#El reloj del manual de certificacion LPIC-1 pagina 390


NTP (Network Time Protocol) es un protocolo utilizado para sincronizar la hora de los sistemas en una red con precisión. Permite que servidores y clientes mantengan una hora exacta, lo que es esencial para registros de auditoría, transacciones financieras, autenticación y coordinación de eventos en sistemas distribuidos.

El paquete chrony remplaza al ntpd, un binario que nos ofrece la posibilidad de mantener la hora sincronizada con servidores NTP

El comando hwclock permite interrogar directamente al reloj hardware RTC. El parámetro --show (por defecto) visualiza la fecha actual. Es diferente del tiempo del sistema que proviene de ntp o fecha.
Puede sincronizar la hora del sistema y la hora física en los dos sentidos.

#Para que se sincronice la hora física desde la hora del sistema: 
hwclock --systohc 
 
#Para realizar lo contrario:

hwclock --hctosys


#ntpdate
Es posible forzar una sincronización manual con el comando ntpdate. 
Este comando utiliza como parámetro un nombre de servidor ntp. 
Si no desea utilizar el servicio ntpd, puede colocar este comando en crontab todos los días o todas las horas.

ntpdate es.pool.ntp.org 

##Tarea cada 1 hora
* */1 * * *  /usr/sbin/ntpdate es.pool.ntp.org 

#timedatectl
El comando timedatectl en Linux se utiliza para consultar y cambiar la configuración relacionada con la fecha y hora del sistema, así como para gestionar la sincronización con servidores de tiempo mediante NTP (Network Time Protocol). Es parte de systemd y reemplaza herramientas más antiguas como date y ntpdate.

timedatectl list-timezones
timedatectl set-timezone   Europe/Madrid
timedatectl set-ntp false
timedatectl set-ntp true

##Sincronizar la hora manualmente con el comando timedatectl, si tenemos el valor  NTP enabled: yes
no permite el cambio de hora manualmente:

timedatectl set-time 18:00
timedatectl set-ntp no
timedatectl
timedatectl set-time 18:00
timedatectl

##Para que tengamos la hora a traves de nuetro cliente de ntp:
timedatectl set-ntp yes


#localectl
El comando localectl en Linux se utiliza para gestionar la configuración de localización del sistema, como la distribución del teclado, el idioma del sistema, y otros parámetros relacionados con la configuración regional. Es parte de systemd y reemplaza la necesidad de editar manualmente archivos como /etc/locale.conf o /etc/vconsole.conf.

localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
localectl

cat /etc/locale.conf
LANG="es_ES.UTF-8"


#locale
##El comando locale permite recuperar información sobre los elementos de regionalización soportados por su sistema para un usuario:
locale

Se puede modificar y adaptar cada una de las variables LC. Veamos su significado:
• LC_CTYPE: clase de caracteres y conversión.
• LC_NUMERIC: formato numérico por defecto, diferente del de la moneda.
• LC_TIME: formato por defecto de la fecha y la hora. 
• LC_COLLATE: reglas de comparación y de ordenación (por ejemplo, los caracteres acentuados).
• LC_MONETARY: formato monetario. 
• LC_MESSAGES: formato de los mensajes informativos, interactivos y de diagnóstico.
• LC_PAPER: formato de papel por defecto (por ejemplo, A4).
• LC_NAME: formato del nombre de una persona. 
• LC_ADDRESS: igual para una dirección.
• LC_TELEPHONE: igual para el teléfono. 
• LC_ALL: reglas para todas las demás variables LC.




##Para debian sin systemd, reconfigurar los “locales” del sistema en distribuciones basadas en Debian/Ubuntu:
dpkg-reconfigure locales


##Ejemplo usuario oracle donde trabaja con una base de datos de oracle codificada a iso88591, los sistemas de linux por defecto trabajar en utf8

vi /home/oracle/.bash_profile
LANG=es_ES.iso88591 
LC_CTYPE="es_ES.iso88591"
export LANG LC_CTYPE

#iconv
iconv es un comando que sirve para convertir archivos entre diferentes codificaciones de caracteres.
#Es muy útil cuando trabajas con:
Archivos en UTF-8
ISO-8859-1 (Latin1)
ASCII
Windows-1252

Es posible convertir un archivo codificado en una tabla dada hacia otra tabla con el programa iconv.
El parámetro -l le da todas las tablas soportadas

iconv -l

Para convertir un archivo, utilice la sintaxis siguiente:
iconv -f WINDOWS-1252 -t UTF8 nombre_archivo

#dos2unix
dos2unix es un comando que convierte archivos de texto con formato Windows (CRLF) a formato Unix/Linux (LF) y viceversa.

| Sistema      | Final de línea  |
| ------------ | --------------- |
| Windows      | `CRLF` → `\r\n` |
| Linux / Unix | `LF` → `\n`     |


dnf install dos2unix -y

#De Windows → Linux (CRLF → LF)
dos2unix archivo.txt 
✔ Elimina \r
✔ Convierte formato Windows a formato Linux

#De Linux → Windows (LF → CRLF)
unix2dos archivo.txt
✔ Añade \r
✔ Convierte formato Linux a formato Windows
---------------------------------------------------------------------------------------------------------------

###Husos horarios en servidores que no tienen system-D###

 El huso horario determina el desplazamiento temporal en comparación con la hora universal UTC,
 permite también gestionar el cambio de hora en primavera y otoño, de forma automática. 
 
 Para reconfigurar el huso horario, o timezone, emplee los siguientes comandos:
 • Ubuntu y Debian: dpkg-reconfigure tzdata
 • Fedora, CentOS y RHEL: system-config-date o para las anteriores versiones redhat-config-date 
 • Para los otros: tzselect Los comandos tzselect y tzconfig están descontinuados en las distribuciones recientes.

 En este caso emplee el método manual explicado a continuación, o bien los comandos propios de su distribución. 
 El huso horario se determina bajo la forma Continente/ciudad. Esta información se ubica en el archivo /etc/timezone.
 
 El archivo /etc/timezone, en formato binario, contiene la información vinculada al huso horario,
 como el desfase horario con respecto a la hora UTC y las reglas para el cambio de hora en verano o en invierno.
 
##En centos7 con System-D###
timedatectl set-timezone "Europe/Madrid"

vi /etc/ntp.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst

systemctl start ntpd
systemctl enable ntpd
timedatectl set-ntp true


##En centos6 con system-v###

rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Madrid  /etc/localtime


vi /etc/ntp.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst


service ntpd start
chkconfig --level 3 ntpd on





##Cree un comando que ejecutará un script llamado prueba.sh, que está en /opt, a las 5:55 a.m.

systemd-run --unit=laboratorio1 --on-calendar '*-*-* 5:55:00' /bin/bash /opt/prueba.sh
systemctl list-timers

---------------------------------------------------------------------------------------------------------------

#chronyd
Chrony es un servicio para sincronizar la hora del sistema usando NTP (Network Time Protocol).
Es más moderno y eficiente que el antiguo ntpd, y hoy es el predeterminado en muchas distribuciones.

#¿Para qué sirve?
Mantiene el reloj del sistema sincronizado con servidores NTP externos o internos.

#Esto es crítico para:
Logs correctos 
Certificados SSL 
Kubernetes y clusters
Bases de datos
Autenticación (Kerberos, LDAP)

# systemctl enable chronyd

# vi  /etc/chrony.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst


# systemctl start chronyd
# systemctl enable chronyd
--------------------------------------------------------------------------------------------------------------
##En la mv RockyLinux RedHat y derivados

dnf install chrony -y

timedatectl set-timezone "Europe/Madrid"
timedatectl

##un comando para listar y modificar la configuración de localización/mapa del teclado.
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
localectl

cat /etc/locale.conf
LANG=es_ES.utf8


El paquete chrony, un binario que nos ofrece la posibilidad de mantener la hora sincronizada con servidores NTP y a la vez él mismo ofrecerse como servidor NTP para otros clientes.

##Fichero principal de configuracion de nuestro cliente chrony:

# vi  /etc/chrony.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst

# systemctl start chronyd
# systemctl enable chronyd

Mostrar la información sobre NTP
# chronyc sources -v



La opción iburst está recomendada, ya que envía una serie («burst») de paquetes solo si no se puede obtener una conexión con el primer intento. Por otro lado, la opción burst siempre está presente, incluso en el primer intento, pero nunca debe utilizarse sin permiso explícito, dado que puede incluirse en blacklist.)
------------------------------------------------------------------------------------------------------------------
##Configuracion mv laboratorios LPIC-1

##En centos6
yum install ntp -y

cp /etc/localtime /root
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Madrid  /etc/localtime


vi /etc/ntp.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst


service ntpd start
chkconfig --level 3 ntpd on

cat /etc/sysconfig/i18n
LANG=es_ES.utf8
--------------------------------------------------------------------------------------------------------
##En debian10/12 Ubuntu
apt-get update
apt-get install chronyd -y
timedatectl set-timezone "Europe/Madrid"

localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es

localectl
   System Locale: LANG=es_ES.utf8
       VC Keymap: es
      X11 Layout: es
       X11 Model: pc105


# vi  /etc/chrony/chrony.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst

# systemctl start chronyd
# systemctl enable chronyd

#Mostrar la información sobre NTP
chronyc sources -v

##un comando para listar y modificar la configuración de localización/mapa del teclado.
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
localectl

cat /etc/locale.conf
LANG=es_ES.utf8


##En debian si nos da el siguinete error:

localectl set-locale LANG=es_ES.utf8

Failed to issue method call: Specified locale is not installed and non-UTF-8 locale will not be auto-generated: es_ES.utf8

#Ejecutamos:
sudo dpkg-reconfigure locales






