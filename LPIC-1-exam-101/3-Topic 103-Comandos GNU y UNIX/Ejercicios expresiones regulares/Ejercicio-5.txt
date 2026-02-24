##En la mv de linux:
cd /lpic1

Averiguar con grep  las veces que me ha visitado gateway.ps.net del archivo acces_log:
Averiguar con grep las veces que me ha visitado pwch3s01 y 204.251.93.247  access_log:
Buscar las ip que nos han visitado en nuestro /var/log/httpd/access_log, excluyendo la ip 192.168.1.14:
Buscar www.thyssen.com en access_log que lo muestra y 5 lineas a continuación del criterio de busqueda:
Buscar en access_log, www.thyssen.com y que muestre la 1 línea anterior al criterio.
Para visualizar el número de línea58  completo del archivo /etc/passwd con sed:
Buscamos la palabra root y queremos que nos muestre en que fichero esta esta palabra en la ruta /var/log/:
Buscamos la palabra root y no queremos que nos muestre en que fichero esta esta palabra var/log/:
Buscar todo lo que comiece root en /etc/passwd y que nos diga el numero de linea:
Buscar todo lo que comiece root en todos los archivos de /var/log y que nos diga el numero de linea:
Para visualizar el número de línea1  completo del archivo /etc/passwd con sed:

##Expresiones Regulares##

Para ver todo lo que comienza por www en el archivo access_log:.
Para mostrar todo lo que sea www. Y finalice con .com.mx en el arhivo access_log
Para mostrar que el 2 carácter sea u 8 en el archivo access_log:
Mostrara los nombres que contengan 3 caracteres del archivo nombres.txt:
Para ver todo lo que comience por w y n del archivo access_log:
Todo lo que comience por el rango ente 1 y 2 en el archivo access_log
Para negar líneas que no comiencen ni con w ni con a en el archivo access_log:
Para buscar todas las líneas que contienen un solo carácter con grep:
Para buscar todas las líneas que solamente tengan un punto con grep:
Con grep seleccionar las lineas que tengan al menos una letra (mayúscula o minúscula)
Expresiones regulares extendidas con grep lo tenemos que habilitar con el comando: 
Dado el fichero números.txt vemos que tenemos números de 1 a 4 dígitos,
si queremos mostrar los números menores de 100, que tengan uno o dos dígitos:

Filtrar solo las ips del archivo access_log:
Buscamos que comience por b conatenga an y obligatorio que la ulima palabra sea una a en el archivo test1:
Buscar números pero que tengan tres digitos, es decir le estamos diciendo una expresión que se tiene que repetir 3 veces en numeros.txt:
Para que se repita entre un rango para que busque números que se repitan entre dos dígitos y 3 dígitos, y esto es un rango, es decir buscara dos y tres dígitos, no dos o tres dígitos.
Buscar números que tengan tres dígitos o mas en el archivo numeros.txt

Que hace esta expresion:
# grep -E "^[0-9] ([0-9] [0-9])?$”  números.txt

Que hace este comando:
# grep -E "^([0-9]|[0-9] {3})$”  números.txt

Que hace este comando:
# egrep  "^([0-9]|[0-9] {3})$”  números.txt







Para cambiar el año de 2014 a 2018 con sed,en el archivo empresa.txt, en todas las ubicaciones:
Para visualizar en el fichero las líneas sin espacios, lineas vacias :
El comando anterior con el  conmando sed: 
Que realiza el siguiente comando:
Con sed realizar una copia de seguridad (empresa.txt.original) sobre el archivo en el que vayamos a realizar modificaciones empresas.txt del comando anterior:
Ordenar el ficheros ips.txt, contar las veces que se repite el acceso de una ip, volver a ordenarlo de forma numérica y  guardarlo en un fichero y muestre el resultado por pantalla.
Con el comando anterior el comando tee que añade el contenido al fichero nuevamente, es decir no lo sobrescribe.














