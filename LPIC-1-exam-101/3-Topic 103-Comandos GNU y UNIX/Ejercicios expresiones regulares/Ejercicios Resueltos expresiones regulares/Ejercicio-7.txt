Con el comando sort ordene el fichero1 fichero2 y el resultado se guarde en fichero3:
sort fichero1 fichero2 > fichero3

Obtener un listado de los ficheros del directorio actual, ordenado de mayor a menor por tamaño de archivo con sort:
$ ls -l | sort -r 

Ordenar un fichero datos.txt el que los campos están separados por comas, por el campo número 3:
$ sort -t, -k 3 datos.txt

Con el comando join unimos los archivos profesores grupos expecificando el separador de campo:
join -t”:” profesores.txt grupos.txt

Con el comando cut obtener el 1 campo del archivo /etc/passwd
# cut -d:  -f 1 /etc/passwd

Con el comando cut obener del archivo /etc/passwd los nombres de los usuarios y su shell:

# cut -d:  -f 1,7 /etc/passwd

Filtramos por direcciones de correo electrónico del archivo trabajadores.txt:
# egrep -oi '\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}'   trabajadores.txt

Sacamos la lista de usuarios de correo electrónico  del archivo trabajadores.txt y a continuación selecionamos por nombre de usuario:
# egrep -oi '\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}' empleados.csv  |cut -d@ -f 1 |sort

Para ver cuantos dominios de las direcciones de correo se repiten del archivo empleados.csv:
# egrep -oi '\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}' empleados.csv  |cut -d@ -f 2 |sort |uniq -c |sort -n

obtener la lista de IPs que han visitado nuestro servidor web /var/log/httpd/access.log y ordenar la salida:
$ egrep -o '\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b' access.log | sort -u

Que realiza el siguiente comando:
# egrep -o '\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b' access_log | sort -n |uniq -c |sort -n

Con el comando egrep buscar las ips  192.168.0.30 192.168.0.40 en el archivo test:
$ egrep '(192.168.0.30|192.168.0.40)' test

Con el comando egrep queremos sacar únicamente los resultados que contengan 192.168.0.30 y 192.168.0.40 del archivo test:
$ egrep '(192.168.0.30|192.168.0.40)' test

Buscar toda línea que contenga un carácter en mayúsculas en el archivo /etc/httpd/conf/httpd.conf
$egrep [[:upper:]] /etc/httpd/conf/httpd.conf

Buscar todo lo que comience por DocumentRoot en el archivo /etc/httpd/conf/httpd.conf
egrep ^DocumentRoot /etc/httpd/conf/httpd.conf

Con el comando grep eliminamos las líneas que tienen comodines del archivo httpd.conf:

$ grep -v "#" test

Buscar en  nuestro fichero access_log las maquinas  ts8-1.westwood.ts.ucla.edu   gutter.tepia.nmda.or.jp
# egrep '^ts8-1.westwood.ts.ucla.edu|^gutter.tepia.nmda.or.jp' access_log 

Buscar en  nuestro fichero access_log las maquinas  ts8-1.westwood.ts.ucla.edu   gutter.tepia.nmda.or.jp
y comprobar cuantas veces se repite el accesso a estas dos maquinas:
# egrep '^ts8-1.westwood.ts.ucla.edu|^gutter.tepia.nmda.or.jp' access_log |cut -d" " -f1 |sort -r |uniq -c

Tendremos que averiguar en que línea se repite la búsqueda anterior:
egrep -n '^ts8-1.westwood.ts.ucla.edu|^gutter.tepia.nmda.or.jp' access_log |cut -d" " -f1 |sort –r

Ordena el archivo datos.txt por valor numérico:
sort -n pepe.txt 

Ordena el archivo datos.txt por valor numérico de mayor a menor (invierte el orden):
# sort -nr datos.txt

si tengo un archivo lista.txt desordenada y quiero averiguar cuantas veces se repiten la palabra:

#sort -bdf lista | uniq -ic | sort -nr

Utilizando tuberías. Muestra por orden numérico el UID, el GID y el shell de la información contenida en /etc/passwd

$ cut -d: -f3,4,6 /etc/passwd | sort -n 

Pasar las vocales a mayúsculas de la palabra murcielago

$ echo murcielago | tr aeiou AEIOU

Mostrar el contenido de /etc/passwd sustituyendo los dos puntos “:” por espacios “ ”

$ cat /etc/passwd | tr : " "

Para eliminar del fichero ipordenadas2  todas las filas que contengan  198 con sed:
# sed -e '/198/d' ipordenadas2 |more

Para borrar desde la lines 10 hasta la palabra quesada con el comando sed:
# cat -n quijote.txt |sed -e  '10,/Quesada/d' quijote.txt |more

Con el comando sed  insertar texto encima de la 1 linea del arhivo ipodenadas2:
# sed -e '1i\##Fichero con IP Ordenadas' ipordenadas2 |more

Muestra los campos del 3 al 5 del fichero /etc/passwd
$ cut -d: -f3-5 /etc/passwd

Para ver los 10 utlimos usuarios del sistema /etc/passwd:
tail /etc/passwd

Para visualizar el numero de línea que quiero en este caso el primer usuario, en este caso una linea /etc/passwd:
head –n1 /etc/passwd  

Para el comando tail mostraría el ultimo usuario creado:
tail –n1 /etc/passwd  

Que realiza el siguiente comando:
# sed -i  's/2014/2018/g' empresa.txt

Con sed realizar una copia de seguridad (empresa.txt.original) sobre el archivo en el que vayamos a realizar modificaciones empresas.txt del comando anterior:
# sed -i.original  's/2014/2018/g' empresa.txt

Ordenar el ficheros ips.txt, contar las veces que se repite el acceso de una ip, volver a ordenarlo de forma numérica y  guardarlo en un fichero y muestre el resultado por pantalla.
# sort ips.txt |uniq -c|sort -n| tee ips-accesos-ordenados.txt

Con el comando anterior el comando tee que añade el contenido al fichero nuevamente, es decir no lo sobrescribe.
# sort ips.txt |uniq -c|sort -n| tee -a ips-accesos-ordenados.txt

Contar todos los ficheros que tenemos vacios dentro del directorio /var/log
# du -h /var/log/* |cut -f1 |grep -E ^0 |wc -l

Averiguar cuanto ocupa el home de los ultimos 10 usuarios creados en nuestro sistema
#tail  /etc/passwd | grep ^a |cut -d: -f6 |xargs du -h
tail -n 3 /etc/passwd | cut -d: -f6 |xargs du -hs

De nuestro archivo access_log, averiguar cuantas visitas tenemos del dominio berkeley.edu
# cat access_log |egrep *.*.berkeley.edu |wc -l

De nuestro archivo access_log, averiguar cuantas visitas tenemos del dominio berkeley.edu y que sean de vmf45

#cat access_log |egrep *.*.berkeley.edu |cut -d" " -f1 |sort |grep  ^wmf45 |wc -l




