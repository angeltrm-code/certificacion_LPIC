## Clonar repositorio formador:
dnf install git unzip -y
cd /
git clone https://github.com/agarciafer/lpic1.git
cd /lpic1
unzip access_log.zip


## El Shell y los comandos GNU pagina 112 pdf del manual curso


### Resumen Expresión regular###
Shell Bash de Linux Comandos Manejo de Texto.pdf pagina 90
pagina 48 Cuantificadores
 
 La página http://www.regular-expressions.info
 https://regex101.com/

[ ] Uno cualquiera de los caracteres entre los corchetes. Ej: [A-Z] (desde A hasta Z). 
[^ ] Cualquier caracter distinto de los que figuran entre corchetes: Ej: [^A-Z]. * 
{ } Nos permiten indicar el número de repeticiones del patrón anterior que deben darse
( ) De forma similar que los corchetes, los paréntesis sirven para agrupar caracteres

192.168.2.10


grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' access_log

## Agrupar la expresion regular con ( )

grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" access_log


www.marca.com
pc1-servidor.curso.local
va.alterdial.alter.net
servidor1.sanidad.barcelona.miempresa.com

grep -Eio '[a-z0-9]{1,}\.[a-z]{1,}\.[a-z]{1,}\.[a-z]{1,}' access_log


grep -Eio '[a-z0-9]{1,}\.[a-z0-9]{1,}\.[a-z0-9]{1,}\.[a-z0-9]{1,}' access_log |sort |uniq -c |sort -rn

## Controlar dominos de maquina con 3 o mas 3 0 4 octetos

grep -Eio '([a-z]{1,}\.){2,3}[a-z]{1,}' access_log


grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}|([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})" access_log

Explicación:
([0-9]{1,3}\.){3}[0-9]{1,3}: Esta parte de la expresión regular busca direcciones IP, que están formadas por 4 grupos de 1 a 3 dígitos (0-255), separados por puntos (.). Cada grupo debe tener entre 1 y 3 dígitos.
|: Es un operador OR, que indica que queremos capturar líneas que contengan cualquiera de las dos expresiones: una IP o un FQDN.
([a-zA-Z0-9.-]+\.[a-zA-Z]{2,}): Esta parte de la expresión regular busca nombres de dominio completos (FQDN). Los dominios pueden contener letras, números, guiones y puntos, y deben terminar con un TLD de al menos 2 caracteres (por ejemplo, .com, .org, .net .es).



grep -Ei "([0-9]{1,3}\.){3}[0-9]{1,3}|([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})" access_log | sort -t. -k1,1n -k2,2n -k3,3n -k4,4n

Explicación:
grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}|([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})": Filtra todas las líneas que contienen direcciones IP o nombres de dominio.

sort -t. -k1,1n -k2,2n -k3,3n -k4,4n:
-t.: Usa el punto (.) como delimitador.
-k1,1n -k2,2n -k3,3n -k4,4n: Ordena numéricamente cada parte de la dirección IP. Para las FQDN, sort manejará los dominios como cadenas de texto.


## Laboratorio grep con expresiones regulares:
– Obtener la dirección MAC de la interfaz de red eth0 de nuestra máquina:

08:00:27:c2:05:d3

ip a
ifconfig eth0 | grep -oiE '([0-9A-F]{2}:){5}[0-9A-F]{2}'

ifconfig eth0 | grep -oE '([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}'


### Explicación:

Sacamos la dirección MAC de la interfaz eth0 de nuestra máquina haciendo un: ifconfig eth0
Y aplicando el filtro grep: grep -oiE ‘([0-9A-F]{2}:){5}[0-9A-F]{2}’
Las opciones que he usado en grep son:
-o Indica que la salida del comando debe contener sólo el texto que coincide con el patrón,
en lugar de toda la línea, como es lo habitual.

-i Lo he usado para que ignore la distinción entre mayúsculas y minúsculas.
-E Indica que vamos a usar una expresión regular extendida.

En cuanto a la expresión regular, podemos dividirla en dos partes:
([0-9A-F]{2}:){5} Buscamos 5 conjuntos de 2 caracteres 
seguidos de dos puntos [0-9A-F]{2} seguido por un conjunto de dos caracteres.
Como las direcciones MAC se representan en hexadecimal,
 los caracteres que buscamos son los números del 0 al 9 y las letras desde la A a la F.
-----------------------------------------------------------------------------------------

+
El signo más indica que el carácter que le precede debe aparecer al menos una vez. Por ejemplo, "ho+la" describe el conjunto infinito hola, hoola, hooola, hoooola, etc....


non.magna2@curso.cat
Curabitur.sed@elitpellentesque.co.uk
agarcia_fer@dominio.es

## Extraer la lista de direcciones de correo electrónico de un archivo:
grep -Eio '[a-z0-9._-]+@[a-z0-9.-]+[a-z]{2,4}' empleados.csv

grep -Eio  '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}' empleados.csv


grep -Eio '[a-z0-9._-]{1,}+@[a-z0-9.-]+[a-z]{2,4}' empleados.csv

Parte de la RegEx	     Explicación
[a-z0-9._-]{1,}+	     Busca el usuario del email (letras, números, ., _, -).
@	                     Obliga a que haya un @.
[a-z0-9.-]+	             Dominio (ej. gmail, empresa, example.com).
[a-z]{2,4}	             Extensión de dominio de 2 a 4 letras (.com, .net, .org, etc.).


# Posibles mejoras
# 1. Permitir mayúsculas en el usuario y dominio
La -i ya ignora mayúsculas, pero podemos hacer explícito el patrón:
grep -Eio '[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' empleados.csv
✔️ Esto permite dominios más largos (.museum, .technology) al cambiar {2,4} por {2,}.


# 2. Usar \b para evitar falsos positivos
Si el archivo contiene caracteres que pueden afectar la detección, es recomendable usar \b para delimitar el email:
grep -Eio '\b[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b' empleados.csv
✔️ Evita capturar emails parciales dentro de palabras más largas.



grep -Eio  '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z0-9]{2,}' empleados.csv
non.magna2@miempresa.infoa1

# Explicación:
Utilizo las mismas opciones que en el caso anterior:
-o Indica que la salida del comando debe contener sólo el texto que coincide con el patrón, en lugar de toda la línea, como es lo habitual. -i Lo he usado para que ignore la distinción entre mayúsculas y minúsculas. -E Indica que vamos a usar una expresión regular extendida.

## Analicemos ahora la expresión regular:
[a-z0-9._-]+@[a-z0-9.-]+[a-z]{2,4}

Al igual que antes, la vamos dividiendo en partes:
[a-z0-9._-]+ Una combinación de letras, números, y/o los símbolos . _ y – de uno o más caracteres
@ seguido de una arroba
[a-z0-9.-]+ seguido de una cadena de letras, números y/o los símbolos . y –
[a-z]{2,4} seguido de una cadena de entre dos y cuatro caracteres. 
 
--------------------------------------------------------------------------------------------
## Pagina 144 Manual de certificacion LPIC1  Los canales estándares
crontab -e
0 3 * * 1-5 /scripts/backup.sh 2>&1 |mail -s "Backup servidorA"  usuario@correo.es usuario

Puede redireccionar los dos canales de salida a un único archivo poniéndolos en relación.
 Para ello, se utiliza el >&.
 
 du -sh / >& /tmp/salida2 

# 5. Los canales estándares Se puede considerar un canal como un archivo que posee su propio descriptor por defecto,  y en el cual se puede leer o escribir.
 • El canal de entrada estándar se llama stdin y lleva el descriptor 0. 
 • El canal de salida estándar se llama stdout y lleva el descriptor 1. 
 • El canal de error estándar se llama stderr y lleva el descriptor 2.

 Se puede redireccionar el canal de error hacia otro archivo.
 
 Puede redireccionar los dos canales de salida a un único archivo poniéndolos en relación.
 Para ello, se utiliza el >&. 
 
 También es importante saber en qué sentido el shell interpreta las
 redirecciones. El shell busca primero los caracteres <, >, >> al final de la línea, ya que las redirecciones suelen estar  al final de comando.
 Por lo tanto, si quiere agrupar los dos canales de salida y de error en un mismo archivo,
 hay que proceder como a continuación. 
 
 du -sh /    
 $ ls -l > resultado.txt 2>&1
  du -sh / 2>   /tmp/errores
  
du -sh / 2>&1 |mail -s "Salida del comando du jueves8" berto
  
>	Salida estándar (overwrite)	Sobrescribe archivo
>>	Salida estándar (append)	Agrega al final del archivo

<	Entrada estándar	Usa un archivo como entrada 
sort < nombres.txt
El contenido de nombres.txt se envía como entrada al comando sort.

mysql < cargabd.sql

  
## Ejecute un comando que enumere todos los procesos, pero use un comando que permita expresiones regulares extendidas para mostrar todos los procesos en ejecución que contengan dos caracteres "s" consecutivos:
 
 ps -aux |egrep "^ss+"  


grep -E "^root|^dbus" /etc/passwd


## Para eliminar el grep del final:
ps -ef |grep -w apache |grep -v grep


# sed
sed se usa para buscar, reemplazar, eliminar o modificar texto directamente desde la línea de comandos, sin abrir un editor interactivo

## Para insertar texto encima de la 1 linea:
-i (in-place) → Modifica el archivo directamente, en lugar de imprimir la salida en la terminal.
Si no se usa -i, sed solo mostrará el resultado en pantalla sin modificar el archivo.
-e (script de edición) → Permite especificar un script de sed como argumento.

# Se puede usar -i.bak para crear un backup antes de hacer los cambios, por ejemplo
sed -i.bak 's/hola/bar2/g' archivo.txt


sed -i  -e  '1i\##Empleados Cliente1-2025' empleados.csv  |more
sed -i.bak '1i\##Empleados Cliente1-2025-Abril' empleados.csv 



# Primera coindicencia por linia en el fichero
 sed  -e 's/es/ES/' empleados.csv |grep -i es
 sed  -e 's/ES/es/' empleados.csv |grep -i ES
sed  -i -e   's/org/gal/g' empleados.csv |grep -i gal


# En todo el fichero:
sed  -e 's/es/ES/g' empleados.csv |grep -i es
sed  -e 's/edu/ES/g' empleados.csv 

 
# En todo el fichero:
sed  -i -e 's/edu/es/g' empleados.csv |grep -i es
sed  -i -e 's/ES/edu/g' empleados.csv |grep -i edu

 
 # Para sustituir en un archivo de empleados por ejemplo los dominios de correo .co.uk por .com:
 sed -i -e 's/\.co\.es/\.gal/g' empleados.csv

 
 
# Para aplicar cambios:
 
 sed -i  -e 's/es/ES/g' empleados.csv |grep -i es


sed -i -e 's/miempresa.infoa1/miempresa.net/g' empleados.csv 



### Resumen de sed -i -e en Linux

# 1. Opción -i (in-place):

# Modifica el archivo directamente.
Se puede usar -i.bak para crear un backup antes de modificar el archivo.

# Ejemplo:

sed -i 's/foo/bar/' archivo.txt
sed -i.bak 's/foo/bar/' archivo.txt  # Crea una copia archivo.txt.bak

# 2. Opción -e (script de edición):
Permite especificar múltiples comandos de sed.

Puede ser omitido si se usa solo un comando.
Ejemplo:
sed -i -e 's/foo/bar/' -e 's/baz/qux/' archivo.txt

# 3. Reemplazo de texto (s/expresión/reemplazo/):

Sustituye un texto en todas las líneas del archivo.
Ejemplo:
sed -i 's/Apache/Nginx/' config.txt

# 4. Borrar líneas que coincidan con un patrón:
d elimina líneas que contengan el patrón especificado.

Ejemplo:
sed -i -e '/DEBUG/d' logs.txt

# 5. Modificar solo una línea específica:
N s/expresión/reemplazo/ permite modificar solo la línea N.

Ejemplo:
sed -i -e '2s/error/warning/' logs.txt  # Solo en la línea 2

# 6. Resumen de comandos comunes:
Opción
Descripción
-i

# Edita el archivo en su lugar (modifica directamente).
-e

# Permite especificar múltiples comandos de edición.
s/exp/res/

# Reemplazo de expresiones.
/patrón/d

# Elimina líneas que coinciden con el patrón.
Recomendación: Siempre hacer un backup antes de modificar archivos importantes:
cp archivo.txt archivo.txt.bak
sed -i -e 's/foo/bar/' archivo.txt



----------------------------------------------------------------------------------------------------------------------------------

# xargs

xargs es un comando muy útil en Linux/Unix que toma elementos de la entrada estándar y los pasa como argumentos a otro comando. Se usa mucho en combinación con find, echo, cat, etc.

## En este ejemplo, xargs ayuda a encontrar todos los archivos que contienen la palabra “Factura”. Para ello, además de find se usa también el comando grep.

find -name "*.txt" | xargs grep "Factura"

find /var/log -name "*.log" | xargs grep -win "error"


El comando xargs en Linux y sistemas Unix se utiliza para construir y ejecutar comandos utilizando los argumentos proporcionados desde la entrada estándar o desde la salida de otro comando. Es muy útil cuando deseas pasar un conjunto de argumentos a un comando que no puede manejar entradas estándar de forma directa.

Eliminar archivos: ls /var/log/*.log | xargs rm -rf
Eliminar archivos: find /  -type f -name "*.tmp" | xargs rm -rf


Buscar y eliminar archivos: find . -name "*.txt" | xargs rm

Mover archivos listados en un archivo: cat lista.txt | xargs mv -t /ruta/destino/

Contar líneas de archivos .txt: find . -name "*.txt" | xargs wc -l

Ejecutar con límite de argumentos (2 por vez): ls | xargs -n 2 echo

Usar marcador de posición: echo archivo1 archivo2 | xargs -I {} mv {} /ruta/destino/

Confirmación antes de ejecutar: echo archivo1 archivo2 | xargs -p rm

Eliminar archivos con nombres que contienen espacios: find . -name "*.txt" -print0 | xargs

## Busca archivos con extesion log y que los cuente:
find / -type f  -name "*.log" | xargs -I {} echo {} |wc -l

| xargs -I {} echo {}: Usa xargs para procesar cada archivo encontrado, pasando su nombre a echo, lo cual permite generar una lista de nombres de archivo.



# Ejemplo 1: Listar archivos .log mayores de 10 MB
find /var/log -type f -name "*.log" -size +10M | xargs -I {} ls -lh {}

# Desglose paso a paso:

find /var/log
→ Busca dentro del directorio /var/log y sus subdirectorios.

-type f
→ Solo selecciona archivos normales (no directorios).

-name "*.log"
→ Filtra solo los archivos que terminen con la extensión .log.

-size +10M
→ Filtra los que tengan más de 10 megabytes.

| xargs -I {} ls -lh {}
→ Por cada archivo encontrado:

Reemplaza {} por el nombre del archivo.

Ejecuta ls -lh {} para mostrar su tamaño en formato legible.



# Ejemplo 3: Borrar los .log antiguos (más de 30 días)
find /var/log -type f -name "*.log" -mtime +30 | xargs -I {} rm -f {}

# Desglose paso a paso:
find /var/log
→ Explora /var/log y subdirectorios.

-type f
→ Busca solo archivos.

-name "*.log"
→ Limita la búsqueda a archivos que terminen en .log.

-mtime +30
→ Selecciona archivos modificados hace más de 30 días.
(+30 significa “más de 30 días” y -30 sería “menos de 30 días”).

| xargs -I {} rm -f {}
→ Pasa cada archivo encontrado a rm -f para borrarlo sin pedir confirmación.


-I {}
sirve para definir un marcador de posición (placeholder) que será reemplazado por cada elemento que xargs recibe de la entrada estánda
-I {} → define {} como el marcador.
Cada vez que xargs lee una línea, sustituye {} por esa línea dentro del comando.