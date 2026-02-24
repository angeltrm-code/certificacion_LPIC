cd /lpic1

##Entorno formador ficheros labs:
dnf install git unzip wget -y
cd /
git clone https://github.com/agarciafer/lpic1.git

cd /lpic1
unzip access_log.zip
access_log

192.168.50.2

#Utilizando grep con expresiones regulares filtrar por ip en  access_log la búsqueda en 4 bloques que son los que contiene una dirección ip.
grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' access_log
egrep

#Con grep buscar el primer octeto del archivo access_log ,números que tengan tres dígitos 
grep -Eo "^[0-9]{1,3}\." access_log

#Ordenar  en orden albabetico tomando como referencia el 1 carácter:
sort /etc/passwd

#Ordenar con sort que la resolución sea inversa en el archivo /etc/passwd:
 sort -r /etc/passwd

#Con el comando sort no interprete letras, sino que sepa interpretar números o magnitudes:
Dado estos comandos:
du / > size_bytes
du -h  / > size_megas

sort -n size_bytes

#Si guardamos la información en magnitudes como megas, k, que orden utilizaremos con sort: 
 sort -h  size_megas

#Ordena el archivo datos.txt usando el primer campo como clave de ordenación. 
#El comando sort -k 1 datos.txt por defecto usa espacios y tabulaciones como delimitadores entre columnas.
 sort -k 1 datos.txt
 sort -t: -k 1 datos.txt

Ordena el archivo datos.txt usando el segundo campo como clave de ordenación:
# sort -k 2 datos.txt

Ordena el archivo datos.txt por valor numérico:
sort -n pepe.txt 

Ordena el archivo datos.txt por valor numérico de mayor a menor (invierte el orden):
# sort -nr datos.txt

si tengo un archivo lista.txt desordenada y quiero averiguar cuantas veces se repiten la palabra:
sort -b no elimina físicamente los espacios del fichero, pero los ignora al ordenar, lo que es justo lo que necesitas cuando vas a usar sort | uniq.
sort -bdf fichero1 | uniq -ic | sort -nr

sed -i 's/^[ \t]*//' fichero1 |cat fichero1 |sort   | uniq -ic

#Significado:
s/: inicio de sustitución.
^: inicio de la línea.
[ \t]*: cualquier cantidad (*) de espacios ( ) o tabuladores (\t).
//: sustitúyelo por nada (es decir, elimínalo).


Con el comando uniq  que diferencia de mayúsculas y minúsculas sobre el nombres.txt:
# uniq   -i nombres.txt

Muestra solamente el número de palabras contenidos en el archivo passwd:
#wc -w /etc/passwd

Muesra solamente el número de líneas contenidas en el archivo procesado passwd:
#wc -l /etc/passwd 

Para ver los usuarios que comienzan por a del archivo /etc/passwd:
# grep ^a /etc/passwd |cut -d":" -f1 |wc -l

Para saber el directorio que mas ocupa en mi sistema:
# du -sh /* 2> /dev/null |sort -h |tail -n1

Con el  comando tr que  sustituir la a por la e :
# tr a e

Creo el fichero.txt con el contenido casa
# echo casa >  fichero.txt

Ahora con el comando tr que nos remplace la a por la e y la c por la n, :
# tr ac en >  fichero.txt

Para borrar todas las a de u texto con tr:
# tr -d a > fichero.txt

Para eliminar un carácter l que este repetido con tr:
# tr -s l > fichero.txt

##Para eliminar todas las vocales de un fichero.txt con tr:
tr -d aeiou > fichero.txt

Pasar un fichero de minúsculas a mayúsculas y guardarlo en fichero.log con el comando tr utilizando CLASES:

# tr [:lower:] [:upper:] < access_log > fichero.log

Para eliminar un carácter que este repetido con el comando tr sobre el fichero.txt
# tr -s [:alpha:]  < fichero.txt

[:alpha:] es una clase de caracteres POSIX que representa todas las letras alfabéticas (A-Z y a-z).












