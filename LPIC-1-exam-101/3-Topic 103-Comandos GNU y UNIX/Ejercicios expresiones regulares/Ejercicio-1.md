##Clonar repositorio formador:
dnf install git unzip -y
cd /
git clone https://github.com/agarciafer/lpic1.git
cd /lpic1
unzip access_log.zip



Mostrar la hora actual, solamente la hora:
date

Con el comando TR cambiar las minus a mayus de la palabra Hola:
Mostrar el contenido de /etc/passwd sustituyendo los dos puntos “:” por espacios “ ” 
Líneas que contiene la cadena de caracteres vagrant en el fichero /etc/passwd
 Líneas que terminan por bash en el fichero /etc/passwd
Muestra los campos 1, 3 y 7 del fichero /etc/passwd
Muestra los campos del 3 al 5 del fichero /etc/passwd

Muestra a partir del tercer campo del fichero /etc/passwd

##Uso de tuberías. Muestra del archivo /etc/passwd el nombre de usuario, el UID y el shell del usuario operador
Sustituye en la salida del comando anterior, el delimitador “:” por un espacio.


Número de líneas y de palabras del fichero /etc/passwd
Utilizando tuberías. Número de usuarios del sistema que utilizan /bin/bash como shell:
Muestra el fichero /etc/passwd en orden inverso con el comando sort
Utilizando tuberías. Muestra por orden numérico el UID, el GID y el shell de la información contenida en /etc/passwd
Pasar las vocales a mayúsculas de la palabra murcielago
Mostrar el contenido de /etc/passwd sustituyendo los dos puntos “:” por espacios “ ”
##Mostrar el contenido de la carpeta actual en formato largo eliminando los espacios duplicados







Buscar todas las palabras que comiencen por a en  archivo:
Mostrar por pantalla, las líneas que contienen comentarios en el archivo /boot/grub/menu.lst:
Enviar a un fichero las líneas del archivo  /boot/grub2/grub.cfg que no son comentarios:
Mostrar las líneas de un fichero que contienen la palabra BADAJOZ o HUELVA:
Mostrar las líneas de un fichero que contienen la palabra BADAJOZ o HUELVA, numerando las líneas de salida:
Mostrar los ficheros que contienen la palabra TOLEDO en el directorio actual y todos sus subdirectorios:
Obtener la dirección MAC de la interfaz de red eth0 de nuestra máquina:
Averiguar lo que ocupa los directorios personales de todos los usuarios que comiencen por una o que tengamos en el sistema:

Buscar en el directorio /etc/httpd/conf/ todos los ficheros que tengan la palabra listen
tendremos que difernciar mayu y minus, no nos tienen que aparecer las lineas que tengan comentarios:




alias ips='grep -Eo "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" /lpic1/access_log'

