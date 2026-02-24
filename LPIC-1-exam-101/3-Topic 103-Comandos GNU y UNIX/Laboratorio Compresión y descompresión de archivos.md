##Maquina redhat o rocky linux o derivados
dnf -y install tar zip unzip gzip bzip2 xz

##Para maquina con sistema debian o derivados
sudo apt -y install tar zip unzip gzip bzip2 xz-utils



Sin guion (-): estilo tradicional (modo antiguo)

Con guion (-): estilo moderno (POSIX/generico)
Este estilo es más explícito y claro, y suele ser preferido en scripts portables o modernos, ya que sigue la convención POSIX de que las opciones de comandos van con guion.

¿Cuál usar?
Usa con guion (-) si quieres ser más explícito y compatible con otras herramientas POSIX.

Usa sin guion si te gusta el estilo clásico o estás escribiendo comandos rápidos.

Ambos funcionarán en GNU tar (Linux moderno), pero si trabajas con sistemas muy antiguos o no GNU, conviene verificar cuál formato soporta.

##Creación y extracción de archivos *.tar.
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


#Comenzamos el laboratorio:
mkdir /viernes22
ls -ld /viernes22

cp /etc/*.conf /viernes22

cd /root
pwd

#### Para trabajar con tar.gz
z

tar cvfz viernes22.tar.gz /viernes22

#l comando ls -lrta en Linux muestra una lista de archivos y directorios con detalles, ordenados por fecha de modificación, de los más antiguos a los más recientes. Aquí está el desglose de las opciones:
l: Usa formato largo (muestra permisos, propietario, tamaño, fecha, etc.)
r: Invierte el orden de la salida
t: Ordena por fecha de modificación (más reciente primero, pero con r, es de más antiguo a más reciente)

ls -lrta
viernes22.tar.gz 

##Visualizamos el contenido	
tar tvfz viernes22.tar.gz

#Extraemos el contenido:
tar xvfz  viernes22.tar.gz  

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

