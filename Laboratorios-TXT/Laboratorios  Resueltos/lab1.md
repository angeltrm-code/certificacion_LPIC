##Version de sistema operativo
cat /etc/redhat-release
cat /etc/debian_version
lsb_release -a
cat /etc/os-release

#Arquitectura del sistema operativo
arch

#Informacion de memoria del sistema operativo
cat /proc/meminfo
free -h

#Cuantas cpus tengo en el sistema operativo
cat /proc/cpuinfo
lscpu
inxi -C
 
#Averiguar si tenemos soporte de ntfs
cat /proc/filesystems
install ntfs-3g
dnf install  ntfs-3g
apt install  ntfs-3g

#Comando para borrar un archivo de forma que no pregunte y recursiva
mkdir /lunes5
touch /lunes5/file1
rm -rf /lunes5/file1

#Permisos en el directorio /etc
ls -ld /etc

#Usuario propietario del archivo /etc/passwd
ls -l /etc/passwd 

#Copiar del directorio /etc los archivos con extension conf /datos
mkdir /datos
cp /etc/*.conf  /datos


#Copiar del directorio /etc/ los archivos segundo caracter una h en /numeros
mkdir /numeros
cp /etc/?h* /numeros

#Eliminar el directorio /numeros y todo su contenido
rm -rf /numeros


#Fecha de modificacion del archivo /etc/passwd
stat /etc/passwd
ls -l   /etc/passwd

#Que hace el comando tac
Muestra el archivo en orden inverso, desde la última línea hasta la primera

#Crear el directorio /datos y los archivo1 a archivo2, archivo3 archivo4 archivo5

mkdir /datos
cd /datos
touch archivo1
touch archivo2
...

También puedes crear varios archivos separandolos por un espacio

touch archivo1 archivo2  archivo3 archivo4 archivo5

Mejor aún, si necesitas un patron puedes usar el siguiente comando

touch archivo{1..5}

            Los archivos que tienen 1 o 2
			ls *[12]

            Todos los ficheros que no terminen en 3 
			 ls *[!3$]
			 
             Lista de los archivos del 1 al 3
			  ls *[1-3]
			  
			  Muestra el archivo1 y el archivo3
			 
			  ls *[1,3] 
			  
Los caracteres de patrón especiales tienen los siguientes significados:

* Concuerda con cualquier cadena de caracteres, incluida la cadena vacía.
? Concuerda con un solo carácter cualquiera.
[...] Concuerda con uno de los caracteres entre corchetes. Un par de
caracteres separados por un signo menos denota un rango
[!...] La concordancia es con cualquier carácter de los que no estén entre los corchetes.

##Expansión de llaves { }
La expansión de llaves es un mecanismo por el cual pueden generarse cadenas arbitrarias. Los
patrones a ser expandidos con la expansión de llaves toman la forma de un preámbulo opcional
seguido por una serie de cadenas separadas por comas entre un par de llaves, seguido por un post
scriptum opcional. El preámbulo sirve de prefijo a cada cadena de entre las llaves, y el post
scriptum se añade luego a cada cadena resultante, expandiendo de izquierda a derecha.

Ejemplo:
touch archivo{1..5}
mkdir dir{1..5}