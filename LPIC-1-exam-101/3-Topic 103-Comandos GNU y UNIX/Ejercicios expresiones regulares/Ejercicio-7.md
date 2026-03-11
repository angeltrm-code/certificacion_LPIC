# Ejercicio 7

Conjunto de ejercicios sobre Ejercicio 7, reorganizado para facilitar la práctica y la revisión.

Conjunto de ejercicios sobre Ejercicio 7, reorganizado para facilitar la práctica y la revisión.

## Desarrollo

## Con el comando sort ordene el fichero1 fichero2 y el resultado se guarde en fichero3:

Obtener un listado de los ficheros del directorio actual, ordenado de mayor a menor por tamaño de archivo con sort:

Ordenar un fichero datos.txt el que los campos están separados por comas, por el campo número 3:

Con el comando join unimos los archivos profesores grupos expecificando el separador de campo:

## Con el comando cut obtener el 1 campo del archivo /etc/passwd

## Con el comando cut obener del archivo /etc/passwd los nombres de los usuarios y su shell:

## Filtramos por direcciones de correo electrónico del archivo trabajadores.txt:

Sacamos la lista de usuarios de correo electrónico  del archivo trabajadores.txt y a continuación selecionamos por nombre de usuario:

Para ver cuantos dominios de las direcciones de correo se repiten del archivo empleados.csv:

obtener la lista de IPs que han visitado nuestro servidor web /var/log/httpd/access.log y ordenar la salida:

## Que realiza el siguiente comando:

## Con el comando egrep buscar las ips  192.168.0.30 192.168.0.40 en el archivo test:

Con el comando egrep queremos sacar únicamente los resultados que contengan 192.168.0.30 y 192.168.0.40 del archivo test:

Buscar toda línea que contenga un carácter en mayúsculas en el archivo /etc/httpd/conf/httpd.conf

## Buscar todo lo que comience por DocumentRoot en el archivo /etc/httpd/conf/httpd.conf

## Con el comando grep eliminamos las líneas que tienen comodines del archivo httpd.conf:

Buscar en  nuestro fichero access_log las maquinas  ts8-1.westwood.ts.ucla.edu   gutter.tepia.nmda.or.jp

Buscar en  nuestro fichero access_log las maquinas  ts8-1.westwood.ts.ucla.edu   gutter.tepia.nmda.or.jp

## y comprobar cuantas veces se repite el accesso a estas dos maquinas:

## Tendremos que averiguar en que línea se repite la búsqueda anterior:

## Ordena el archivo datos.txt por valor numérico:

## Ordena el archivo datos.txt por valor numérico de mayor a menor (invierte el orden):

si tengo un archivo lista.txt desordenada y quiero averiguar cuantas veces se repiten la palabra:

Utilizando tuberías. Muestra por orden numérico el UID, el GID y el shell de la información contenida en /etc/passwd

## Pasar las vocales a mayúsculas de la palabra murcielago

## Mostrar el contenido de /etc/passwd sustituyendo los dos puntos “:” por espacios “ ”

## Para eliminar del fichero ipordenadas2  todas las filas que contengan  198 con sed:

## Para borrar desde la lines 10 hasta la palabra quesada con el comando sed:

## Con el comando sed  insertar texto encima de la 1 linea del arhivo ipodenadas2:

## Muestra los campos del 3 al 5 del fichero /etc/passwd

## Para ver los 10 utlimos usuarios del sistema /etc/passwd:

Para visualizar el numero de línea que quiero en este caso el primer usuario, en este caso una linea /etc/passwd:

## Para el comando tail mostraría el ultimo usuario creado:

## Que realiza el siguiente comando:

Con sed realizar una copia de seguridad (empresa.txt.original) sobre el archivo en el que vayamos a realizar modificaciones empresas.txt del comando anterior:

Ordenar el ficheros ips.txt, contar las veces que se repite el acceso de una ip, volver a ordenarlo de forma numérica y  guardarlo en un fichero y muestre el resultado por pantalla.

Con el comando anterior el comando tee que añade el contenido al fichero nuevamente, es decir no lo sobrescribe.

## Contar todos los ficheros que tenemos vacios dentro del directorio /var/log

## Averiguar cuanto ocupa el home de los ultimos 10 usuarios creados en nuestro sistema

## De nuestro archivo access_log, averiguar cuantas visitas tenemos del dominio berkeley.edu

De nuestro archivo access_log, averiguar cuantas visitas tenemos del dominio berkeley.edu y que sean de vmf45
