
#Información detallada de cada archivo.

ls -l
-rw-r--r--. 1 root root 167813783 Jul  8  2018 access_log

#Explicación de cada campo:
-rw-r--r--.: Permisos del archivo y tipo de archivo.

-: Indica que es un archivo regular (si fuera un directorio, sería una d).
rw-: El propietario (en este caso root) tiene permisos de lectura (r) y escritura (w), pero no de ejecución (-).
r--: El grupo (también root) tiene permisos de lectura (r), pero no de escritura ni ejecución (-).
r--: Los otros usuarios (otros) tienen permisos de lectura (r), pero no de escritura ni ejecución (-).
.: Indica el uso de ACLs (Access Control Lists) en algunos sistemas, pero no afecta directamente a los permisos básicos.

1: Número de enlaces (hard links) que apuntan a este archivo. En este caso, solo hay 1 enlace.

root: El propietario del archivo.

root: El grupo al que pertenece el archivo.

167813783: El tamaño del archivo en bytes. En este caso, el archivo tiene un tamaño de 167,813,783 bytes (aproximadamente 167 MB).

Jul 8 2018: La fecha y hora de la última modificación del archivo. En este caso, el archivo fue modificado el 8 de julio de 2018.

access_log: El nombre del archivo. En este caso, se llama access_log.

#Resumen del campo tipo:
-: Archivo regular.
d: Directorio.
l: Enlace simbólico.
b: Dispositivo de bloque.
c: Dispositivo de carácter.
p: Pipe con nombre.
s: Socket.

#Ejemplo de salida del comando ls:
-rw-r--r--  1 user user 4096 Jul 10 14:20 archivo.txt
drwxr-xr-x  2 user user 4096 Jul 10 14:20 carpeta
lrwxrwxrwx  1 user user   12 Jul 10 14:20 enlace -> archivo.txt
brw-rw----  1 root disk 8, 0 Jul 10 14:20 /dev/sda
crw-rw-rw-  1 root tty 4, 0 Jul 10 14:20 /dev/tty0
prw-r--r--  1 user user    0 Jul 10 14:20 pipe
srwxrwxrwx  1 user user    0 Jul 10 14:20 /var/run/docker.sock
                      

#Esta salida tiene varios tipos de archivos:

-rw-r--r--: archivo.txt es un archivo regular.
drwxr-xr-x: carpeta es un directorio.
lrwxrwxrwx: enlace es un enlace simbólico que apunta a archivo.txt.
brw-rw----: /dev/sda es un dispositivo de bloque (probablemente un disco duro).
crw-rw-rw-: /dev/tty0 es un dispositivo de carácter (un terminal).
prw-r--r--: pipe es un pipe con nombre.
srwxrwxrwx: socket es un socket.

##Permisos linux numericos:
r-->4
w-->2
x-->1

chmod 640 fichero
chmod -R 640 /directorio1

#Modificación de permisos, modo simbólico:
➢ u usuario
➢ g grupo
➢ o otros
➢ a todos

➢ + agrega
➢ - quita
➢ = setea

#Quitar el permiso de lectura al grupo:
chmod g-r mi.archivo

#Agregar permiso de ejecución al dueño, y permiso de lectura para el grupo y others:
chmod u+x,go+r mi.archivo

#Setear permiso de lectura y escritura a todos
chmod a=rw mi.archivo

#El comando chown (change owner) se usa para modificar el usuario y/o el grupo propietario de un archivo o directorio.
chown root.informatica archivo1
chown root:informatica archivo1

chown  :informatica anaconda-ks.cfg

chown -Rf  root.informatica /directorio1

#El comando chgrp (change group) sirve para modificar únicamente el grupo propietario de un archivo o directorio.

*Es similar a chown, pero solo cambia el grupo.
chgrp informatica file1
chgrp informatica -R /directorio

#El comando umask define qué permisos NO se asignarán cuando se crea un archivo o directorio nuevo.
#No establece permisos directamente, sino que los resta de los permisos máximos.

umask -S

umask u=rw,g=rw,o=
umask -S

##Para persistirlo en el home de un usuario:
 vi /home/programador1/.bash_profile
umask 0007
umask u=rw,g=rw,o=


 
#Para persistirlo a todos los usuarios, solamente root puede modificar este archivo:
vi  /etc/profile
umask 0007


##El premiso setuid se da a archivos
El permiso setuid hace que cuando un archivo ejecutable se ejecuta, el proceso resultante se ejecute con los permisos del propietario del archivo (root), en lugar de con los permisos del usuario que lo ejecuta.

*El permiso setuid visualiza una "s" en el campo de ejecución del propietario

chmod 4700 ficheroejecutable
chmod u+s ficheroejecutable
find / -type f -perm -4000 -ls

ls -l /usr/bin/passwd
-rws r-x r-x 1 root root 27832 jun 10  2014 /usr/bin/passwd

#El premiso setgid seria para directorios
El permiso setgid (Set Group ID) puede aplicarse tanto a archivos ejecutables como a directorios, pero su comportamiento es diferente según el tipo de objeto

Esto es muy útil en colaboración en grupo, para que todos los archivos pertenezcan al mismo grupo y puedan ser compartidos fácilmente.

chmod g+s /directorio
chmod 2770 /directorio

drwxrwsrwx 2 root informatica 4096 feb 16 10:55 /miercoles16

drwx rws rwx 4 root informatica 102 nov 28 10:01 /sabado28/
find / -type d -perm -2000


##El permiso Sticky Bit se da a directorios, solo root o el propietario pueden borrar el directorio:

chmod 1777 /directorio
chmod o+t /directorio

ls -ld /tmp/
drwx rwx rwt. 9 root root 261 nov 28 10:05 /tmp/

find / -type d -perm -1000



#El comando install en Linux se utiliza para copiar archivos y establecer permisos en el sistema de archivos. Aunque su nombre puede ser confuso, no se utiliza para instalar paquetes, sino para copiar archivos de manera controlada.

install [opciones] origen destino


#Opción	Descripción
-d	Crea directorios, similar a mkdir -p.
-m	Establece los permisos de archivo (por ejemplo, 755).
-o	Especifica el propietario del archivo.
-g	Especifica el grupo del archivo.
-t	Especifica el directorio de destino.
-v	Muestra información detallada del proceso.
-p	Preserva los tiempos de acceso y modificación.

#Copiar un Archivo con Permisos Específicos:
sudo install -m 755 script.sh /usr/local/bin

Copia el archivo script.sh al directorio /usr/local/bin.
Establece permisos 755 (ejecutable para todos, escritura solo para el propietario).

#Crear un Directorio con Permisos:
sudo install -d -m 755 /opt/mi_directorio
Crea el directorio /opt/mi_directorio con permisos 755.

#Copiar un Archivo con Propietario y Grupo Específicos:
sudo install -o root -g root -m 644 archivo.txt /etc/mi_archivo.txt
Copia el archivo archivo.txt a /etc/mi_archivo.txt.
El propietario y grupo serán root, y los permisos serán 644.

#Copiar Múltiples Archivos a un Directorio:
sudo install -v archivo1 archivo2 archivo3 -t /usr/local/bin

#Copia varios archivos al directorio /usr/local/bin.
La opción -v muestra detalles de la copia.

#Usos Comunes:
Instalación Manual de Scripts: Colocar scripts en directorios como /usr/local/bin.
Despliegue de Archivos de Configuración: Copiar archivos de configuración con permisos específicos.
Creación de Estructura de Directorios: Crear rutas completas para aplicaciones.

#Ejemplo Completo: Despliegue de un Script
Imagina que tienes un script llamado mi_script.sh que deseas copiar a /usr/local/bin con permisos ejecutables para todos:
sudo install -m 755 mi_script.sh /usr/local/bin


##Creación y extracción de archivos *.tar:
*El comando tar en Linux se usa para archivar (empaquetar) y extraer archivos y directorios, normalmente para hacer respaldos o mover conjuntos de archivos.

tar --help

c -->empaqueta
f--> file1
t-->lista dentro del tar
x --> Extraer
-C --> directorio en el que queremos extraer
-k, --keep-old-files
              Don't replace existing files when extracting.

tar -k opción tar -k solicita una confirmación si el file ya existe.
Puede establecerlo de forma pnetworkingeterminada,
ya sea agregándolo a la variable TAR_OPTIONS ( TAR_OPTIONS="$TAR_OPTIONS -k" ) o creando un alias ( alias tar="tar -k" ).			  


##tar.gz
z

##tar.bz2
j

##tar.xz
J



#Comando	Compresor	Finalidad
zcat	gzip	Muestra el contenido de un fichero de texto comprimido .gz.
zless	gzip	Pagina el contenido de un fichero de texto comprimido .gz.

bzcat	bzip2	Muestra el contenido de un fichero de texto comprimido .bz2.
bzless	bzip2	Pagina el contenido de un fichero de texto comprimido .bz2.

xzcat	xz	    Muestra el contenido de un fichero de texto comprimido .xz.
xzless	xz	    Pagina el contenido de un fichero de texto comprimido .xz.


##Comprimir en zip:
zip archivo.zip /carpeta/archivos

##Descomprimir zip en linux
Comando para descomprimir un fichero zip en linux:

unzip archivo.zip


##Comprimir y descomprimir .rar (rar)
Para comprimir .rar, debemos utilizar:
rar -a archivo.rar /carpeta/archivos

##Para descomprimir .rar, debemos utilizar:
rar -x archivo.rar


##Enlaces simbólicos (soft / symbolic links)
ln -s test enlace-a-test


#Enlaces duros (hard links)
ln test enlace-duro-test

##Diferencias entre soft y hard links
 Los enlaces simbólicos se pueden hacer con ficheros y directorios mientras que los duros solo entre ficheros.
 Los enlaces simbólicos se pueden hacer entre distintos sistemas de ficheros, los duros no.
 Los enlaces duros comparten el número de inodo, los simbólicos no.
 En los enlaces simbólicos si se borra el fichero o directorio original, la información se pierde, en los duros no.
 Los enlaces duros son copias exactas del fichero mientras que los simbólicos son meros punteros o “accesos directos”.


##Por convención se colocan las librerías compartidas en directorios llamado lib:
• /lib: librerías de sistema básicas, vitales
• /usr/lib: librerías: de usuario básicas, no necesarias al boot.
• /usr/local/lib: librerías locales para los programas para la maquina
• /usr/X11R6/lib: librerías del entorno X windows
• /opt/kde3/lib: librerías de KDE....

Bajo Linux (y Unix, en general), las librerías compartidas llaman a Shared Objects (so)
en el sentido en que se trata de ficheros de objetos sin bloque de instrucción main.
Llevan el sufijo .so.

#El comando ldd permite determinar cuales son las librerías vinculadas a un programa y también si están persistentes o no
ldd /usr/sbin/fsck

##Configurar la cache del editor de vínculos

El cargador de vínculos ld.so busca las librerías en varios lugares, entre los cuales, se
encuentran, por este orden:
• las rutas precisadas en la variable de entorno LD_LIBRARY_PATH. Se
separan las rutas, como para el PATH, por ":"


• el contenido del fichero /etc/ld.so.cache, que contiene una lista compilada
(formato binario) de las librerías encontradas en las rutas predeterminadas.

cat /etc/ld.so.conf
include ld.so.conf.d/*.conf

/etc/ld.so.conf.d/mariadb-x86_64.conf

• los directorios /lib y /usr/lib

##Regeneramos la cache con el comando ldconfig
ldconfig

vi /root/.bash_profile
LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client/lib/:/usr/lib64/mysql
export LD_LIBRARY_PATH

El comando wc (word count) permite contar las líneas, las palabras y los caracteres. wc [-l] [-c] [-w] [-w] fic1
 • -l: cuenta el número de líneas 
 • -c: cuenta el número de bytes 
 • -w: cuenta el número de palabras 
 • -m: cuenta el número de caracteres 

$ wc lista
 12 48 234 lista
 
 El archivo lista contiene 12 líneas, 48 palabras y 234 caracteres.
 
 
#Comando hwclock pagina del manual 391 

El comando hwclock permite interrogar directamente al reloj hardware RTC. El parámetro --show(por defecto) visualiza la fecha actual
Sincronizar la fecha de la bios con el sistema
hwclock --systohc


#Puede sincronizar la hora del sistema y la hora física en los dos sentidos.
Para que se sincronice la hora física desde la hora del sistema: 
 
hwclock --systohc
 
#Para realizar lo contrario:
hwclock --hctosys
 
hwclock --systohc  Pone en la BIOS la hora del Sistema
hwclock --hctosys  Pone en El Sistema la hora de la BIOS


#sha256sum
El comando sha256sum genera una huella digital (hash) de un archivo usando el algoritmo SHA-256.
Se usa para verificar integridad (por ejemplo, al descargar una ISO o un paquete).

En la actualidad se recomienda utilizar el algoritmo SHA-256 para calcular los checksums de los ficheros y así poder verificar su integridad. SHA-256 es el reemplazo lógico del algoritmo MD5, ya que por el momento no se han descubierto vulnerabilidades.

sha256sum -b yourfile.iso

El comando  sha512sum  muestra o verifica las sumas de verificación SHA512 (512 bits).
Sin ARCHIVO, o cuando ARCHIVO es – (un guión), lee el resumen del mensaje de la entrada estándar.

Sintaxis
sha512sum [OPCIÓN] ... [ARCHIVO] ...

MD5SUMS: checksums de MD5.
SHA1SUMS: checksums de SHA-1.
SHA256SUMS: checksums de SHA-256.
SHA512SUMS: checksums de SHA-512.

#EDITOR 
La variable EDITOR define qué editor de texto se usará por defecto cuando un programa necesite abrir uno (por ejemplo crontab, git, visudo, etc.).

vi /root/.bash_profile

EDITOR=/usr/bin/vi
export PATH PS1 HISTIGNORE LD_LIBRARY_PATH EDITOR

#Visualizar el valor:
echo $EDITOR
