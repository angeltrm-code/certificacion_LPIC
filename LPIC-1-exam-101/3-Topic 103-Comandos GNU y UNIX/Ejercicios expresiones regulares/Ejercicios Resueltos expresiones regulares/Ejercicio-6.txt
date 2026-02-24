Dado el siguiente archivo:
cat  bienvenidos.txt
BIENVENIDOOS AA ASTURIASy

Convierte los caracteres aeiou en minúsculas con tr:
# cat bienvenidos.txt |tr "[AEIOU]" "[aeiou]"

Con el ejemplo anterior para cambiar todo el alfabeto  de mayus a minus  utilizar rangos:
# cat bienvenidos.txt |tr "[A-Z]" "[a-z]"

Con tr -s ao elimina del texto todas las a y o que encuentre duplicadas.
# cat bienvenidos.txt |tr "[A-Z]" "[a-z]" |tr -s ao

Para elminar un carácter en este caso la y podemos utilizar el comando:
tr -d y 
# cat bienvenidos.txt |tr "[A-Z]" "[a-z]" |tr -s ao |tr -d y

Con el comando xargs cuántas líneas tiene cada fichero: 
# cat ficheros.txt
/etc/passwd
/etc/fstab
#cat ficheros.txt | xargs wc -l

Repita el comando anterior,si le ponemos el comando echo a xargs veremos que comando se esta utilizando:
# cat ficheros.txt |  xargs echo  wc -l

Si queremos que por cada argumento ejecute un comando le pasamos el parámetro -i con  {}, con este comando podre ver que no me da los totales porque lanza los 4 comandos del wc -l por cada fichero.
# cat ficheros.txt |  xargs -i  echo  wc -l {}
# cat ficheros.txt |  xargs -i    wc -l {}

Buscar todos los ficheros .conf del directorio /etc que contengan la palabra root dentro de su contenido…
utilizar el comando find (Para buscar todos los ficheros de /etc que terminen en .conf), y luego con ese resultado utilizamos xarg en conjunto con grep (xarg):

# find /etc -name "*.conf" | xargs grep "root"

Con el comando echo ver el valor de la variable $USER:
# echo "Valor de la variable $USER"

Buscar todas las palabras que comiencen por a en un archivo:
$ grep "^a" archivo

Mostrar por pantalla, las líneas que contienen comentarios en el archivo /boot/grub/menu.lst:
$ grep “#” /boot/grub/menu.lst
 grep  "^#" /boot/grub2/grub.cfg


Enviar al  fichero1 las líneas del archivo /boot/grub/menu.lst que no son comentarios:
$ grep -v “#” /boot/grub/menu.lst > fichero1

Contar el número de interfaces buscamos por iface, que tenemos definidos en el fichero /etc/network/interfaces:
$ grep -c “iface” /etc/network/interfaces

Mostrar las líneas de un fichero que contienen la palabra BADAJOZ o HUELVA:
$ grep -e “BADAJOZ” -e “HUELVA” archivo

Mostrar las líneas de un fichero que contienen la palabra BADAJOZ o HUELVA, numerando las líneas de salida:
$ grep -n -e “BADAJOZ” -e “HUELVA” archivo

Mostrar los ficheros que contienen la palabra TOLEDO en el directorio actual y todos sus subdirectorios:
$ grep -r “TOLEDO” *

####Laboratorio grep con expresiones regulares####:
Obtener la dirección MAC de la interfaz de red eth0 de nuestra máquina:
02:42:ed:e8:50:69

$ ifconfig eth0 | grep -oiE ‘([0-9A-F]{2}:){5}[0-9A-F]{2}’

Extraer la lista de direcciones de correo electrónico de un archivo fichero.txt:
usuario_garcia@dominio.cat
grep -Eio ‘[a-z0-9._-]+@[a-z0-9.-]+[a-z]{2,4}’ fichero.txt

Obtener la dirección IP de la interfaz de red eth0 de nuestra máquina utilizamos ifconfig y grep:
$ ifconfig eth0 | grep -oiE ‘([0-9]{1,3}\.){3}[0-9]{1,3}’ | grep -v 255

Explique  la expresión regular:

192.168.33.1
grep -Eo'([0-9]{1,3}\.){3}[0-9]{1,3}' access_log
  grep -Eo      "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"


([0-9]{1,3}\.){3}: Representa 3 bloques de entre uno y tres dígitos separados por puntos. Observemos que como el punto es un metacaracter, tengo que usar el caracter de escape \ para que no sea interpretado como un metacaracter, sino como un carácter normal.
[0-9]{1,3}: Representa el último bloque de la dirección IP, que está formado por un número de entre 1 y 3 dígitos.

Con expresiones regulares si queremos representar un caracter entre la a y la z,:
 [a-z]
 
Si lo que queremos es representar identificar un número o una letra:
[a-zA-Z0-9]

Representar un número que se compone de cero o más dígitos:
[0-9]*

Representar un número que se compone de uno o más dígitos: 
[0-9]+

Representar cualquier caracter menos los dígitos: 
[^0-9]

Representar un número de 5 dígitos: 
[0-9]{5}

Y si quisiéramos representar una palabra que tiene entre dos y cuatro caracteres:
[a-zA-Z]{2,4}

Comando con grep para nos devuelva  todas las líneas del fichero que comienzan por La
# grep -i ‘^La’ fichero

Camando con grep para que nos devuelve todas las líneas del fichero que comienzan por cualquier número de espacios seguido de La.
# grep ‘^ *La’ fichero

Comando con grep que nos devuelve todas las líneas del fichero que comienzan por punto y tienen cualquier número de caracteres.
# grep ‘^\..*’ fichero

Comando con grep que nos devuelve la lista de ficheros que comienzan por un espacio seguido de un punto y cualquier número de caracteres, es decir, la lista de ficheros ocultos.
# ls -la | grep ‘ \..*’

Comando grep que  nos devuelve la lista de ficheros que comienzan por d, es decir, la lista de directorios
# ls -l | grep ‘^d’
Comparar dos ficheros, ignorando los espacios en blanco, utilizaremos el parámetro -w:
# diff -w fichero1 fichero2

Comparar dos ficheros queremos es que no nos muestre las diferencias, sino que tan sólo nos informe de si son diferentes o no:
diff -q fichero1 fichero2

Comparar dos ficheros, queremos que nos muestre la salida con las diferencias marcadas a dos columnas:
diff -y fichero1 fichero2

Para borrar con sed la linea 1 de fichero.txt
sed ‘1d’ fichero

Para borrar con sed el intervalo de lines del 3 al 5 de fichero:
sed ‘3,5d’ fichero

Para borrar con sed desde la linea 3 en adelante en fichero:
sed ‘3,$d’ fichero

Parar borrar con sed las lineas en blanco de un fichero:
sed ‘/^$/d’ fichero

Para sustituir con sed cadena1 por cadena2 en fichero:
sed ‘s/cadena1/cadena2/’ fichero 

Para sustituir con sed cadena1 por cadena2 en todo el fichero:
sed ‘s/cadena1/cadena2/g’ fichero

Para sustituir con sed en la linea 5 USUARIO por usuario en todo el fichero:
sed ‘5 s/USUARIO/usuario/g’ fichero

Buscar con sed el  patrón cadena en un fichero:
  # sed -e '/cadena/ !d' fichero
  
Buscar con se AAA o BBB o CCC en fichero:
  # sed '/AAA/!d; /BBB/!d; /CCC/!d' fichero

Buscar con sed AAA y BBB y CCC en fichero:
  # sed '/AAA.*BBB.*CCC/!d' fichero

Añadir con sed  una línea antes o despues del final de un fichero ($=última línea):
  # sed -e '$i Prueba' fichero 
  # sed -e '$a Prueba' fichero 
  
Ver las primeras 10 líneas de un fichero con sed:
  # sed 10q fichero
  
Ver las primeras 10 líneas de /etc/passwd con sed y que numeres las lines y lo envie a fichero2:
# sed 10q /etc/passwd | cat -n > ficero2
  
Ver desde las  líneas 2 a la 5 de /etc/passwd con sed y que numeres las lineas:
# cat -n /etc/passwd | sed -n '2,5 p'

Con sed mostrar la 1 linea del archivo /etc/passwd:
sed -n '1p' /etc/passwd

Eliminar con sed  desde una línea 2 hasta el final del fichero:
  # sed '2,$d' fichero 
  
Eliminar con sed la línea que comiencen por borrar:
  sed '/^borrar/d' fichero   
  










 











