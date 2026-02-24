
#Instalamos el siguiente software en la mv:
dnf -y install tar zip unzip gzip bzip2 xz
apt -y install tar zip unzip gzip bzip2 xz-utils

##En resumen
gzip → rápido, menos compresión. Ideal para uso general y logs.
bzip2 → compresión mejor, pero más lento.
xz → compresión máxima, pero el más lento de todos. Ideal para almacenamiento o distribución.

##Creación y extracción de archivos *.tar.
c -->empaqueta
f--> file1
t-->lista dentro del tar
x --> Extraer
-C --> directorio en el que queremos extraer
-k, --keep-old-files
              Don't replace existing files when extracting.
-v, --verbose              verbosely list files processed			  

tar -k opción tar -k solicita una confirmación si el file ya existe.
Puede establecerlo de forma pnetworkingeterminada,
ya sea agregándolo a la variable TAR_OPTIONS ( TAR_OPTIONS="$TAR_OPTIONS -k" ) o creando un alias ( alias tar="tar -k" ).			  


##Comenzamos el laboratorio:

mkdir /viernes22
cp /etc/*.conf /viernes22

cd /root

####tar.gz
z

tar cvfz viernes22.tar.gz /viernes22
ls -lrta
viernes22.tar.gz 

##Visualizamos el contenido	
tar tvfz viernes22.tar.gz

#Extraemos el contenido:
tar xvfz  viernes22.tar.gz  -C /opt

ls -l /opt/viernes22

##tar.bz2
j

tar cvfj viernes22.tar.bz2 /viernes22
ls -lrta
viernes22.tar.bz2

##Visualizamos el contenido	

tar tvfj viernes22.tar.bz2

#Extraemos el contenido:

tar xvfj  viernes22.tar.bz2  -C /opt

ls -l /opt/viernes22


##tar.xz
J

tar cvfJ viernes22.tar.xz /viernes22
ls -lrta
viernes22.tar.xz

##Visualizamos el contenido	
	
tar tvfJ viernes22.tar.xz

#Extraemos el contenido:

tar xvfJ  viernes22.tar.xz  -C /opt

ls -l /opt/viernes22

