Con sed elimina las 5 primeras lines del archivo ipordenadas2:
grep -Eo "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" /lpic1/access_log |sort -n |uniq -c |sort -n > /lpic1/ipordenadas2

# sed -e '1,5d' ipordenadas2 |more
# sed -i -e '1,5d' ipordenadas2 |more

Para eliminar del fichero ipordenadas2  todas las filas que contengan  198 con sed:
# sed -e '/198/d' ipordenadas2 |more

Para borrar desde la lines 10 hasta la palabra quesada con el comando sed:
# cat -n quijote.txt |sed -e  '10,/Quesada/d' quijote.txt |more

Con el comando sed  insertar texto encima de la 1 linea del arhivo ipodenadas2:
# sed -e '1i\##Fichero con IP Ordenadas' ipordenadas2 |more

Con sed  anexar en la 1 linea, es decir la pondrá justo debajo la palabra "IP Ordenadas":
# sed -e '1a\##Fichero con IP Ordenadas' ipordenadas2 |more

Para sustituir la linea1 por ##Fichero con IP Ordenadas sobre el fichero ipordenadas2:
# sed -e '1c\##Fichero con IP Ordenadas' ipordenadas2 |more

Con el comando sed mostrar solo la acción realizada del comando anterior:
# sed -n -e '1p' ipordenadas2 |more
# sed -n -e '1c\##Fichero con IP Ordenadas' ipordenadas2 |more

Con el comando sed con el comando anterior que aplique los cambios sobre el archivo ipordenadas2:
# sed -n -i '1c\##Fichero con IP Ordenadas' ipordenadas2 |more

Con sed mostrar solamente las 3 primeras líneas del fichero ipordenadas2:
# sed -ne '1,3p' ipordenadas2

Mostrar todas las línea del texto excepto la 1,2,3 con el comando sed sobre el archivo ipordenadas:
# sed -ne '1,3!p' ipordenadas

Para sustituir con sed  y por la palabra VACIO en el archivo fichero.txt:
# sed -e '/y/c\VACIO' fichero.txt

Para sustituir y por la palabra VACIO, pero cuando encuentra la palabra Frisaba sale y no continua con sed:
# sed  -e '/Frisaba/q'    -e '/y/c\VACIO' fichero.txt

Con sed sustituir 129.55.20.2 por 198.xxx ipodenadas
# sed -e '/129.55.20.2/q' -e '/198/c\xxx' ipordenadas

Con sed sustituir espacioes por  _ ipodenadas:
# sed -e 's/[[:space:]]/_/g' ipordenadas

Con sed sustituir espacioes por LINEA N->  en el archivo ipodenadas:
# sed -e 's/[[:space:]]/LINEA N->/' ipordenadas

Con sed sustituir en un archivo de empleados por ejemplo los dominios de correo .co.uk por .com:
sed -e 's/\.co\.uk/\.com/' empleados.csv

Con sed  eliminamos todos los usuarios del domonio .net del archivo empleados.csv
# sed    -e  '/\.net;/d    -e 's/\.co\.uk/\.com/' empleados.csv

Con sed ustituir el domino de correo vitaeerat.org  por vitaeerat2.es
# sed -e 's/vitaeerat.org/vitaeerat2.es/' empleados.csv

Para ver el numero de veces que se me repite una ip o las veces que ha accedido una ip a nuestro servicio por ejemplo de apache
utilice el comando uniq sobre el archivo ip.txt.
# sort ip.txt  |uniq -c |more

Para saber las ips que no se repiten con sort y uniq y wc, en el archivoe ip.txt
# sort ip.txt  |uniq -u |wc -l

Ordenar por numero  las veces que a accedido una ip con ips_contar.txt:
# sort -n ips_contar.txt |more

Convertir en 1 espacio el archivo tabuldado tabulado:txt
# expand -t 1 tabulado.txt

El comando fmt visualiza el fichero caracteres ancho 40 access_log
# fmt -w 40 access_log |more

# pr access_log |more

Con el comando pr sustituir en la cabecera el nombre del archivo por el mensaje que le queramos poner al archivo access_log.
# pr -h "ACCESSOS A MI SERVIDOR WEB" access_log |more

Con sed sustituir ; por : en el archivo empleados.csv:
# sed -i -e 's/;/:/g' empleados.csv

Del archivo empleados.csv queremos obtener el nombre y direccion de correo:
# cut -d";" -f1,2 empleados.csv

Dado el siguiente archivo jefes.txt:
Paul	Otellini
Larry Page
Rory  Read
Timothy D. Cook

Obtener los nombres de los jefes
# cut  -c 1-8 jefes.txt
Obtener  los apellidos del 9 al 20
# cut  -c 9-20  jefes.txt

Creamos ficheros de 50 líneas  del fichero acces_log con el prefijo Access_ :
# split -l 50 access_log access-

Dividir el archivo access_log en archivos de 5M con el prefijo Access-
# split -b 5M access_log  access-

Del comando anterior unir todos los archivo en un archivo y dejarlo como el original, por ejemplo los divido para enviarlos por correo y luego los unimos:
# cat access-* >  access-log

Cuando utilizaremos el comando paste:
lo utilizaremos cuando sabemos que en los dos ficheros tenemos el mismo número de línea

Cuando utilizaremos el comando  join:
lo utilizaremos cuando tengamos un campo en común entre los dos ficheros.



	 

   







