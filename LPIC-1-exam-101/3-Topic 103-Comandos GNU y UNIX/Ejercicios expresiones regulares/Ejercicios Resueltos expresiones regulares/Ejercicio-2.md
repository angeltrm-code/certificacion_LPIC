## Clonar repositorio formador:
dnf install git unzip -y
cd /
git clone https://github.com/agarciafer/lpic1.git
cd /lpic1
unzip access_log.zip


cd /lpic1

# Utilizando el comando echo para salto de linea:
echo -e "Esto es un \n  ejemplo"

# Utilizando el comando echo para que muestre un tabulador :
echo -e "Esto es un \t  ejemplo"

# Con el comando echo que nos muestre  la variable del sistema $USER con un salto de linea:
echo -e "El usuario: \n $USER "

# Para ver los 10 primeros usuarios del sistema /etc/passwd:
head /etc/passwd

# Para ver los 10 ultimos usuarios del sistema /etc/passwd:
tail /etc/passwd

# Para visualizar el numero de línea que quiero en este caso el primer usuario, en este caso una linea /etc/passwd:
head -n1 /etc/passwd |cat -n


# Para el comando tail mostraría el ultimo usuario creado:
tail –n1 /etc/passwd  

# Para ver las ultimas 7 entradas en el archivo acces_log:
tail -n7 access_log

# Para ver en todos los ficheros logs, las 5 primeras líneas, y me muestra el nombre de los ficheros y las 5 primeras líneas.
head -n5 /var/log/*.log

# Si queremos eliminar el nombre de los ficheros y realizar una búsqueda genérica con head:
head -5  -q /var/log/*.log

# Para ver el 1 carácter de cada línea del archivo access_log:
cut -c1 access_log

# Para ver desde el caracter1 al caracter18 del archivo acces_log:
cut -c1-18 access_log

# Para seleccionar el carácter 1 y el 18 del archivo access_log:
cut -c1,18 access_log

# Para ver logs rangos desde el cararcter1 al 18 el 15 y el 2 del archivo access_log :
cut -c1-18,15,2 access_log

# Buscando por el delimitador espacio en blanco en el archivo acces_log nombre de maquina y fecha:
cut -d" " -f1,4,6,7,8,10 access_log |more
cat access_log |cut -d" " -f1,4 |cut -d: -f1

# Buscar del archivo /etc/passwd que nos muestre el nombre se usuario y el shell del usuario:
cut -d":" -f1,7  /etc/passwd 

# Sacar los 10 primeros caracteres de un fichero access_log:
cut -c1-10 access_log
head -1 access_log |cut -c1-10


# El primer carácter de un fichero acess_log:
cut -c1 access_log

# Obtener  del archivo access_log, que contenga la palabra sckyla 31/Aug 1995:23:46 y nos de el número de línea:

grep -w skylab access_log |grep  -w 31/Aug |grep -n -w 1995:23:46
grep -wn  -e skylab -e 31/Aug -e 1995:23:46 access_log

# En el archivo /etc/passwd obtener lo que no coincidan con el patrón oper
grep -v oper  /etc/passwd 

# De todos los archivos log del directorio /var/log, que se muestren en que ficheros ha encontrado la palabra root
grep -r -w root -l /var/log/*.log

# Para ver la información de las lines que contengan la palabra root del /var/log/*.log, nos daría tanto el nombre del fichero encontrado como la línea del log.
grep root   /var/log/*.log

# Para buscar usuarios o grupos del sistema que tengan el identificacador 100:

grep -w 100 /etc/passwd

# Con grep para que nos muestre el numero de línea donde encuentra el patrón que le pasamos root:
grep -n -w root /etc/passwd

# Con grep , que no diferencia mayúsculas de minúsculas, para buscar root
grep -i root /etc/passwd

# Para que nos muestre la cantidad de líneas encontradas con este patrón A:
grep -i A -c /etc/passwd

# Buscaremos de forma recursiva en un directorio /var/log todos los archivos *.log el patron root:
# Para que solo sea root:
grep -r -w root /var/log/*.log




ls -l |tr -s " " |cut -d" " -f 1,9

        
ls -l | tr -s " " | cut -d" " -f1

	
ls -l /var/tmp/ | awk '{print $1,$9}'

# awk divide cada línea en campos:
$1 = permisos de archivo
$9 = nombre del archivo (solo si el nombre NO tiene espacios)
# Por eso imprime únicamente:
los permisos
el nombre del archivo
