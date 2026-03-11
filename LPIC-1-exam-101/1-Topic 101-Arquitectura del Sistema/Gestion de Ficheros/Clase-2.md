# Clase 2

Apuntes de clase sobre Clase 2, reorganizados para facilitar la consulta rápida y el repaso.

## Permisos linux:

r-->4 w-->2 x-->1

```bash
chmod 640 fichero
chmod -R 640 /directorio
```

## Modificación de permisos, modo simbólico:

➢ u usuario ➢ g grupo ➢ o otros ➢ a todos

➢ + agrega ➢ - quita ➢ = setea

## Quitar el permiso de lectura al grupo:

```bash
chmod g-r mi.archivo
```

## Agregar permiso de ejecución al dueño, y permiso de lectura para el grupo y others:

```bash
chmod u+x,go+r mi.archivo
```

## Setear permiso de lectura y escritura a todos

```bash
chmod a=rw mi.archivo
```

## chown -->Cambiar el usuario o el grupo propietario de un archivo o directorio:

```bash
chown root.informatica archivo1
chown root:informatica archivo1
```

```
chown  :informatica anaconda-ks.cfg
```

```bash
chown -Rf  root.informatica /directorio1
```

### chgrp -->Solo modifica el grupo propietario

chgrp informatica file1 chgrp informatica -R /directorio

## umask--> Modifica los valores de los permisos por defecto:

### umask -S

```conf
u=rwx,g=rx,o=rx
```

umask 0022

## Marcara por defecto

fichero --> -rw-r--r-- directorio --> drwx r-x r-x

umask u=rwx,g=rwx,o= umask -S

## Mascara con permisos para ficheros y directorios:

umask u=rw,g=rw,o= umask 0117

## Parar persistirlo en el home de un usuario:

```bash
 vi /home/usuario1/.bash_profile
```

umask u=rwx,g=rwx,o=

## Para persistirlo a todos los usuarios:

```
vi  /etc/profile
```

umask u=rwx,g=rwx,o=

## Permisos especiales en linux:

## El premiso setuid se da a archivos

El permiso setuid visualiza una "s" en el campo de ejecución del propietario Cuando el permiso de identificación de usuario (setuid) esta asignado sobre un fichero ejecutable, un usuario o proceso que lo ejecuta tiene garantizado el acceso como propietario del fichero (generalmente root) en ver del usuario que arranco el ejecutable

```bash
chmod 4700 ficheroejecutable
chmod u+s ficheroejecutable
find / -type f -perm -4000 -ls
```

```bash
ls -l /usr/bin/passwd
```

-rws r-x r-x. 1 root root 27832 jun 10  2014 /usr/bin/passwd

## El premiso setgid seria para directorios

```bash
chmod g+s /directorio
chmod 2770 /directorio
```

### drwx rws rwx 4 root informatica 102 nov 28 10:01 /sabado28/

```bash
find / -type d -perm -2000
```

## El permiso Sticky Bit se da a directorios, solo root o el propietario pueden borrar el directorio:

```bash
chmod 1777 /directorio
chmod o+t /directorio
```

```bash
ls -ld /tmp/
```

### drwx rwx rwt. 9 root root 261 nov 28 10:05 /tmp/

```bash
find / -type d -perm -1000
```

---

## Creación y extracción de archivos *.tar. c -->empaqueta f--> file1 t-->lista dentro del tar x --> Extraer -C --> directorio en el que queremos extraer -k, --keep-old-files Don't replace existing files when extracting. -v, --verbose              verbosely list files processed

```bash
tar -k opción tar -k solicita una confirmación si el file ya existe.
```

Puede establecerlo de forma pnetworkingeterminada, ya sea agregándolo a la variable TAR_OPTIONS ( TAR_OPTIONS="$TAR_OPTIONS -k" ) o creando un alias ( alias tar="tar -k" ).

## Empaquetamos un directorio:

```bash
 tar cvf datos.tar /miercoles16/*
```

## Visualizo con tar el contenido del archivo datos.tar

```bash
  tar tvf datos.tar
```

## Extraemos el archivo datos.tar el el directorio /opt

```bash
  tar xvf datos.tar
  tar xvf datos.tar -C /opt
```

## tar.gz

### z

### Empaqueto y comprimo con gzip:

```bash
 tar cvfz datos.tar.gz /miercoles16/*
```

## Visualizo con tar el contenido del archivo datos.tar

```bash
  tar tvfz datos.tar.gz
```

## Extraemos el archivo datos.tar el el directorio /opt

```bash
  tar xvfz datos.tar.gz -C /opt
```

## tar.bz2

j

## Empaqueto y comprimo con bz2:

```bash
 tar cvfj datos.tar.bz2 /miercoles16/*
```

## Visualizo con tar el contenido del archivo datos.tar

```bash
  tar tvfj datos.tar.bz2
```

## Extraemos el archivo datos.tar el el directorio /opt

```bash
  tar xvfj datos.tar.bz2 -C /opt
```

## tar.xz

J

## Empaqueto y comprimo con xz:

```bash
 tar cvfJ datos.tar.xz /miercoles16/*
```

## Visualizo con tar el contenido del archivo datos.tar

```bash
  tar tvfJ datos.tar.xz
```

## Extraemos el archivo datos.tar el el directorio /opt

```bash
  tar xvfJ datos.tar.xz -C /opt
```

## Descomprimir zip:

```bash
unzip file.zip
unzip file.zip -d /opt
```

## Enlaces simbólicos (soft / symbolic links)

### ln -s test enlace-a-test

Enlaces duros (hard links) ln test enlace-duro-test

## Diferencias entre soft y hard links

 Los enlaces simbólicos se pueden hacer con ficheros y directorios mientras que los duros solo entre ficheros.  Los enlaces simbólicos se pueden hacer entre distintos sistemas de ficheros, los duros no.  Los enlaces duros comparten el número de inodo, los simbólicos no.  En los enlaces simbólicos si se borra el fichero o directorio original, la información se pierde, en los duros no.  Los enlaces duros son copias exactas del fichero mientras que los simbólicos son meros punteros o “accesos directos”.

## Por convención se colocan las librerías compartidas en directorios llamado lib:

- /lib: librerías de sistema básicas, vitales
- /usr/lib: librerías: de usuario básicas, no necesarias al boot.
- /usr/local/lib: librerías locales para los programas para la maquina
- /usr/X11R6/lib: librerías del entorno X windows
- /opt/kde3/lib: librerías de KDE....

Bajo Linux (y Unix, en general), las librerías compartidas llaman a Shared Objects (so) en el sentido en que se trata de ficheros de objetos sin bloque de instrucción main. Llevan el sufijo .so.

El comando ldd permite determinar cuales son las librerías vinculadas a un programa y también si están persistentes o no

```bash
ldd /usr/sbin/fsck
```

## Configurar la cache del editor de vínculos

El cargador de vínculos ld.so busca las librerías en varios lugares, entre los cuales, se encuentran, por este orden:

- las rutas precisadas en la variable de entorno LD_LIBRARY_PATH. Se

### separan las rutas, como para el PATH, por ":"

- el contenido del fichero /etc/ld.so.cache, que contiene una lista compilada

(formato binario) de las librerías encontradas en las rutas predeterminadas.

```bash
cat /etc/ld.so.conf
```

### include ld.so.conf.d/*.conf

```bash
/etc/ld.so.conf.d/mariadb-x86_64.conf
```

- los directorios /lib y /usr/lib

## Regeneramos la cache con el comando ldconfig

```bash
ldconfig
```

```bash
vi /root/.bash_profile
LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client/lib/:/usr/lib64/mysql
export LD_LIBRARY_PATH
```

El comando wc (word count) permite contar las líneas, las palabras y los caracteres. wc [-l] [-c] [-w] [-w] fic1

- -l: cuenta el número de líneas
- -c: cuenta el número de bytes
- -w: cuenta el número de palabras
- -m: cuenta el número de caracteres

$ wc lista 12 48 234 lista

El archivo lista contiene 12 líneas, 48 palabras y 234 caracteres.

> comando hwclock pagina del manual 391

El comando hwclock permite interrogar directamente al reloj hardware RTC. El parámetro --show(por defecto) visualiza la fecha actual Sincronizar la fecha de la bios con el sistema

```bash
hwclock --systohc
```

Puede sincronizar la hora del sistema y la hora física en los dos sentidos. Para que se sincronice la hora física desde la hora del sistema:

## # hwclock --systohc

Para realizar lo contrario:

## # hwclock --hctosys

```bash
hwclock --systohc  Pone en la BIOS la hora del Sistema
hwclock --hctosys  Pone en El Sistema la hora de la BIOS
```
