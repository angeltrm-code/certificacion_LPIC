#Lista parcial de archivos, términos y utilidades:

for
while
test
if
read
seq
exec
||
&&


mkdir /lpic1/scripts
cd /lpic1/scripts

#El usuo de las comillas:
Sin embargo, cuando utilizas ` lo que haces es ejecutar un comando en otro comando,
por ejemplo si quieres utilizar el comando «pwd» en otro comando, deberías hacerlo de esta manera:

echo `pwd`/prueba

###Resumiendo
##Dobles comillas
Usar dobles comillas cuando se encierran variables o se utilizan comandos envueltos en «
Todos los carácteres se intrepetan tal y como son, excepto $ y ` que serán expandidos en el shell

echo "Hola $USER"
#Resultado:
Hola root


##Simples comillas
Todos los caracteres son interpretados como una tal y como son
echo 'Hola $USER'
#Resultado:
Hola $USER
-------------------------------------------------------------------------------------------------------------

La línea #!/bin/bash al inicio de un script es llamada shebang (o "hashbang"), y su propósito es
Y entiende que debe usar el programa ubicado en /bin/bash (el Bourne Again Shell) para interpretar y ejecutar el contenido del archivo.

#! → es una secuencia especial que activa el shebang.

/bin/bash → es la ruta absoluta al intérprete que ejecutará el script (en este caso, el shell Bash).


vi  1.sh
#!/bin/bash
echo "Hola Mundo"

chmod u+x 1.sh
sh 1.sh
./1.sh
--------------------------------------------------------------------------

#Parámetros
Los párametros en bash
Un script Bash puede recibir parámetros y estos pueden ser procesados dentro de él.
Los parámetros que se pueden usar dentro de un script bash son:

vi script2.sh

#!/bin/bash
echo Primer parametro es $1
echo Numeros de parametros es $#
echo todos los parametros son: $*
echo pid del shell actual:  $$
echo el comando ha tenido exito: $?

./script2.sh uno dos tres
sh script2.sh uno dos tres

##Variables de nuesto shell que puedo recuperar: 
echo $!--> PID del ultimo proceso ejecutado
echo $$ PID del shell actual
echo $?--> Devuelve 0 si el ultimo comando tine exito, si no devuelve 1 o otro valor diferente.

##Listas de Parametros:
$# Nº de parametros recibidos
$0 Nombre y ruta del propio script
$1 ... $9 Parámetros del 1 al 9 recibidos
${N} Parámetro de la posicion N recibido
$* Todos los parámetros recibidos (excepto $0) 1
$@ Array de parámetros recibidos (excepto $0) 2
$$ El PID (numero de proceso) del script
$? El código de error del ultimo comando ejecutado
-----------------------------------------------------------------------------------------------------------

Que muestre el directorio actual
en que fecha estoy actualmente y hora
Cual es el nombre del servidor:

vi script3.sh

#!/bin/bash
fecha=`date +%F\ %r`
FECHA=$(date +%Y%m%d)
servidor=`hostname`
directorio=`pwd`
v1="Hola"
echo $PWD
echo "Directorio: $directorio"
echo "Fecha: $fecha"
echo "Servidor: $servidor"
echo $HOSTNAME 
echo El contenido de la v1 es $v1
echo "Usuario actual: ${USER}"


sh script3.sh
--------------------------------------------------------------------------------------------------
#read
read lee de la terminal el input del usuario

vi 4.sh

#!/bin/bash
#Fecha: 24.12.2014
#Autor: Autor
#Proposito: Script leyendo el input de usuarios
#CODIGO
clear
echo "Cual es su nombre?"
read nombre
clear
echo Hola $nombre
sleep 5
echo "Cual es su apellido?"
read apellido
echo Su nombre completo es $nombre $apellido
#FIN
-----------------------------------------------------------------------------------
##Comando test

El comando test permite efectuar una serie de pruebas sobre los archivos, las cadenas de caracteres,
los valores aritméticos y el entorno de usuario.

Este comando tiene un código de retorno igual a cero cuando el test es positivo, y diferente de cero en caso contrario, esto permite utilizarlo en encadenamientos de comandos con ejecución condicional (&& y ||) o en las estructuras de control  que veremos más adelante.

El comando test posee dos sintaxis: test expresión y [ expresión ], donde "expresión" representa el test que se debe efectuar.
1. Test de archivos
-f archivo

Devuelve verdadero (código de retorno igual a cero) si el archivo es de tipo estándar (file):

$ test -f /etc/passwd 
$ echo $? 
0 
$ [ -f /etc ] || echo "/etc no es un archivo estándar" 
/etc no es un archivo estándar 

-d directorio

Devuelve verdadero si el archivo es de tipo directorio...

test -e $HOME/berto || touch $HOME/berto
test -e berto || touch berto
test -d berto2 || mkdir berto2
test -e berto || touch berto
test -f berto && rm -rf berto


#Comparación de archivos
-e archivo: Verifica si el archivo existe.
-f archivo: Verifica si el archivo existe y es un archivo regular.
-d archivo: Verifica si el archivo es un directorio.
-r archivo: Verifica si el archivo tiene permisos de lectura.
-w archivo: Verifica si el archivo tiene permisos de escritura.
-x archivo: Verifica si el archivo es ejecutable.

##Comparación de números
n1 -eq n2: Verifica si n1 es igual a n2.
n1 -ne n2: Verifica si n1 no es igual a n2.
n1 -gt n2: Verifica si n1 es mayor que n2.
n1 -lt n2: Verifica si n1 es menor que n2.
n1 -ge n2: Verifica si n1 es mayor o igual a n2.
n1 -le n2: Verifica si n1 es menor o igual a n2.

#Comparación de cadenas
-z cadena: Verifica si la cadena está vacía.
-n cadena: Verifica si la cadena no está vacía.
cadena1 = cadena2: Verifica si las cadenas son iguales.
cadena1 != cadena2: Verifica si las cadenas son diferentes.

#Condiciones lógicas
cond1 -a cond2: AND lógico; verdadero si ambas condiciones son verdaderas.
cond1 -o cond2: OR lógico; verdadero si al menos una de las condiciones es verdadera.



#!/bin/bash

# Definimos variables
archivo="mi_archivo.txt"
directorio="mi_directorio"
num1=10
num2=20

# Verificar si un archivo existe
if test -f "$archivo"; then
    echo "El archivo '$archivo' existe."
else
    echo "El archivo '$archivo' NO existe."
fi

# Verificar si un directorio existe
if test -d "$directorio"; then
    echo "El directorio '$directorio' existe."
else
    echo "El directorio '$directorio' NO existe."
fi

# Comparar dos números
if test $num1 -lt $num2; then
    echo "$num1 es menor que $num2."
else
    echo "$num1 NO es menor que $num2."
fi

# Verificar si una cadena no está vacía
cadena="Hola Mundo"
if test -n "$cadena"; then
    echo "La cadena no está vacía y contiene: '$cadena'."
else
    echo "La cadena está vacía."
fi

# Verificar si una variable está vacía
var_vacia=""
if test -z "$var_vacia"; then
    echo "La variable está vacía."
else
    echo "La variable contiene algo."
fi
-------------------------------------------------------------------------------------
/lpic1/access_log
/tmp/access_log

Introducir la ruta del fichero

grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' 
--------------------------------------------------------------------------------------------
vi 5.sh

#!/bin/bash
clear
echo "Introduce la ruta del fichero para filtrar por IPs:"
sleep 5
read ruta
clear
echo "Espere unos segundos a que se muestre el filtro de Ips":
grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $ruta |sort -n |uniq -c |sort -n
#fin


##Comprobar si la ruta existe:


#!/bin/bash

clear
echo "Introduce la ruta del fichero para filtrar por IPs:"
read ruta

# Verificar si la ruta existe y es un archivo regular
if [ -f "$ruta" ]; then  ##Comprueba que el archivo existe y es un archivo regular.
    clear
    echo "Espere unos segundos mientras se filtran las direcciones IP..."
    sleep 2
    # Buscar, filtrar, contar y ordenar las IPs
    grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' "$ruta" | sort -n | uniq -c | sort -n
else
    clear
    echo "Error: El archivo '$ruta' no existe o no es un archivo válido."
    exit 1
fi #cierra todo el bloque, indicando que el script puede continuar con otras instrucciones

# Fin del script


if [ condición ]; then
    # Bloque de comandos si la condición es verdadera
else
    # Bloque de comandos si la condición es falsa (opcional)
fi

En esta estructura:

El if abre el bloque.
El then define las acciones a realizar si la condición es verdadera.
El else (opcional) define las acciones a realizar si la condición es falsa.
El fi cierra todo el bloque del if.

-------------------------------------------------------------------------------------

#!/bin/bash
clear
echo "Dime el directorio, para darte el permisos-propietario-nombre fichero"
read directorio
clear
ls -l  $directorio | tr -s " " | cut -d" " -f1,3,9 



-----------------------------------------------------------------------------------------
##Comparación de enteros (números)
-eq Equal (es igual a) if [ "$a" -eq "$b" ]
-neNot Equal (no es igual a / es distinto a)

if [ "$a" -ne "$b" ]
-gt Greater Than (es mayor que) if [ "$a" -gt "$b" ]
-ge Greater Equal (es mayor que o igual a)

if [ "$a" -ge "$b" ]
-lt Lower Than (es menor que)
 if [ "$a" -lt "$b" ]
 
-le Lower Equal (es menor que o igual a)

if [ "$a" -le "$b" ]
< Menor que (usar con doble paréntesis)
(("$a" < "$b"))

<= Menor que o igual a (usar con doble paréntesis)
(("$a" <= "$b"))

> Mayor que (usar con doble paréntesis)
(("$a" > "$b"))

>= Mayor que o igual a (usar con doble paréntesis)
(("$a" >= "$b"))




#!/bin/bash
read -p "Primer valor:"  v1
read -p "Segundo valor:" v2
if [ $v1 -gt $v2 ] ; then
echo "V1 ($v1) es mayor que V2($v2)"
else
echo "El primer valor no es mayor que el segundo valor"
fi



#!/bin/bash
read -p "Primer valor:"  v1
read -p "Segundo valor:" v2
if [ $v1 -gt $v2 ] ; then
echo "V1 ($v1) es mayor que V2($v2)"
else
echo "El valaro de V2($v2) es mayor)"
fi


-------------------------------------------------------------------------------------------------
##Para el lab ponemos esta ruta del fichero: /lpic1/access_log

vi 9.sh

#!/bin/bash

read -p "Introduzca una ruta para ficheros filtrar por IP: " ruta

if [ ! -e $ruta ]; then
        echo "Esta ruta no existe"
        exit 1
fi

if [ -d $ruta ]; then
        echo "Y es un directorio."
        exit
fi


if [ -f $ruta -a -w $ruta ]; then
        grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $ruta |sort -n |uniq -c |sort -n
fi

-a si es un archivo regular
-w Comprueba si el archivo es escribible, si tenemos permisos de escritura en el archivo.
--------------------------------------------------------------------------------------
read -p "Introduzca una ruta para ficheros: " fichero

if [ $size -gt 1000 ]; then
echo El fichero es grande
echo Tiene un tamaño de du -h $fichero
else
echo El fichero es pequeño
fi
--------------------------------------------------------------------------------
read -p "Introduzca una ruta para ficheros: " fichero
size=$(du   $fichero |cut -f1)
if [ $size -gt 1000 ] ; then
echo El fichero es grande
echo Tiene un tamaño de  $size
else
echo El fichero es pequeño
fi

------------------------------------------------------------------------------
#!/bin/bash
#Fecha: 30.12.2014
#Autor: Autor
#Proposito: Evaluando IF THEN ELSE con INPUT de usuario
#CODIGO
read -p "Introduce un numero del 1 al 9: " NUMERO
if [ $NUMERO -gt 5 ]
then
echo "El numero introducido es MAYOR que 5"
else
echo "El numero introducido es MENOR que 5"
fi
-------------------------------------------------------------------------------
Lo que hacemos con ELIF es contar con la salida del IF anterior y utilizarla para ahorrarnos
una nueva condicional IF
Creando un script con ELIF
a. Creamos el siguiente script
----------Script----------
#!/bin/bash
#Fecha: 31.12.2014
#Autor: Autor
#Proposito: Evaluando IF THEN ELIF
#CODIGO
read -p "Introduce un numero del 1 al 9: " NUMERO
if [ $NUMERO -eq 5 ]
then
echo "El numero introducido es IGUAL que 5"
elif [ $NUMERO -lt 5 ]
then
echo "El numero introducido es MENOR que 5"
else
echo "El numero introducido es MAYOR que 5"
fi
#FIN
-------------------------------------------------------------
Lo que hacemos con ELIF es contar con la salida del IF anterior y utilizarla para ahorrarnos
una nueva condicional IF

#!/bin/bash
read -p "Introduce una nota numerica:" nota
if [ $nota -ge 9 ]; then
        echo "Tienes un sobresaliente";
elif [ $nota -ge 7 ]; then
        echo "Tienes un notable"
elif [ $nota -ge 6 ]; then
        echo "Tienes un bien"
elif [ $nota -ge 5 ]; then
        echo "Tienes un aprobado"
else
        echo "Has suspendido"
fi



Mejorar el script y asegurarnos de que la nota solo pueda estar en el rango de 0 a 10, podemos agregar una validación que verifique que el valor ingresado esté dentro de ese rango.

vi notas.sh

#!/bin/bash

# Solicitar la nota hasta que sea un número entre 0 y 10
while true; do
    read -p "Introduce una nota numérica (de 0 a 10): " nota

    # Verificar si la entrada es un número entre 0 y 10
    if [[ "$nota" =~ ^[0-9]+$ ]] && [ "$nota" -ge 0 ] && [ "$nota" -le 10 ]; then
        break  # Salir del bucle si la nota es válida
    else
        echo "Entrada no válida. Por favor, introduce un número entre 0 y 10."
    fi
done

# Evaluar la calificación
if [ "$nota" -ge 9 ]; then
    echo "Tienes un sobresaliente"
elif [ "$nota" -ge 7 ]; then
    echo "Tienes un notable"
elif [ "$nota" -ge 6 ]; then
    echo "Tienes un bien"
elif [ "$nota" -ge 5 ]; then
    echo "Tienes un aprobado"
else
    echo "Has suspendido"
fi


#Explicación de los cambios
Bucle while true:

Mantiene un bucle hasta que el usuario introduzca una nota válida.
Validación de la nota:

[[ "$nota" =~ ^[0-9]+$ ]]: Comprueba si la entrada es un número entero.
[ "$nota" -ge 0 ] && [ "$nota" -le 10 ]: Asegura que el número está entre 0 y 10.

Si la nota cumple ambas condiciones, el bucle se interrumpe con break; de lo contrario, muestra un mensaje de error y vuelve a solicitar la nota.

Evaluación de la nota:

Una vez validada, se evalúa la nota como antes, clasificándola en sobresaliente, notable, bien, aprobado o suspendido.

-------------------------------------------------------------------------------------
#!/bin/bash
#Evaluando bucle for pasandole un fichero para filtrar las ips

read -p "Introduce la ruta del fichero de log:" FICHERO
for fichero in $(grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $FICHERO)
do
echo $fichero
done
-------------------------------------------------
#El comando seq
El comando seq es una herramienta capaz de imprimir una secuencia de números naturales,
que pueden ser transmitidos a otros scripts o aplicaciones.

seq --help

vi reloj.sh

#!/bin/bash

for i in `seq 1 900`
do 
  date +%H:%M:%S
  sleep 1
done

--------------------------
#!/bin/bash
for i in `seq 1 10`;
do
  echo $i
  sleep 1
done  

#Incrementamete numeros del 1 al 10
seq 1 10

##decrecer la secuencia
seq 15 -1 0

##Aumentar la secuencia de dos en dos del 1 al 15:
seq 1 2 15

##Añadir un separador con -s
seq -s, 1 9


#El comando while
El comando while en bash crea un bucle que se ejecuta mientras una condición especificada sea verdadera. Se us para repetir un bloque de código hasta que la condición de salida se cumpla. La estructura básica de while es:

while [ condición ]; do
    # Código a ejecutar mientras la condición sea verdadera
done


##Lanzar un numero y decrecerlo
#!/bin/bash
echo "Inserte un numero"
read numero

while [ $numero != 0 ]; do
echo "La cuenta atras es: $numero"
numero=$[$numero - 1]
sleep 1

done
-----------------------------------------------------------------------------------------------------------------------
#¿Qué es exec en un shell script (Linux)?
exec es un built-in del shell (bash, sh, zsh, etc.) con dos usos principales:

Reemplazar el proceso del shell por otro programa
Cuando llamas exec comando ... el shell no crea un proceso hijo: el proceso actual se reemplaza por comando. Al terminar comando, no vuelves al script: el proceso terminó. Es útil para ahorrar un fork o para sustituir el shell por el programa final.

Redirigir/describir descriptores de fichero del propio shell

Si usas exec con redirecciones pero sin comando, aplicas esas redirecciones al shell actual (y por tanto a todolo que ejecute después). Muy usado para logs, errores, o para abrir/cerrar ficheros.

##Ejemplos prácticos

1) Reemplazar el proceso del script (no vuelve luego)
#!/bin/bash
echo "Antes de exec (PID $$)"
# Reemplaza este proceso por `sleep 10`
exec sleep 10
# Las siguientes líneas NO se ejecutarán porque el shell fue reemplazado
echo "Esto no se verá"

En este ejemplo el PID ($$) corresponde al sleep tras exec. No hay retorno al script al terminar sleep.


##Ejecutar un comando sin exec (para comparar)
#!/bin/bash
echo "Antes (PID $$)"
sleep 2 &
echo "Después (sigue el script)"

Aquí el shell crea un proceso hijo para sleep (se sigue ejecutando el script).

3) Redirigir stdout/stderr para todo el script
#!/bin/bash
# A partir de aquí, todo stdout y stderr irá a script.log
exec > script.log 2>&1

echo "Esto irá a script.log"
ls inexistente   # el error también irá a script.log
Esto es muy común para que un script deje todo su log en un archivo sin añadir >> archivo en cada comando.

##Precauciones y notas
exec reemplaza el shell: si lo usas con un comando, el resto del script no se ejecutará. Úsalo al final cuando quieras que el proceso del script sea el comando.

Redirecciones con exec (sin comando) afectan al shell actual y a todos los comandos posteriores del script.

exec no crea proceso hijo cuando ejecuta un programa; esto puede afectar al manejo de señales y al entorno (por ejemplo, variables de entorno siguen, pero el PID cambia a la nueva imagen).

Si quieres lanzar un programa y seguir en el script, no uses exec; usa command & o command normal


------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
----------Script----------
#!/bin/bash
#Fecha: 31.12.2014
#Autor: Autor
#Proposito: Evaluando el bucle FOR con los dias de la semana
#CODIGO
for dias in Lunes Martes Miercoles Jueves Viernes Sabado Domingo
do
echo $dias
done
------------------------------------------------------------------------------------------

##La sintaxis de SELECT es la siguiente:
SELECT variable IN opción1 opción2 ... opciónN
DO
Comando
BREAK
DONE
----------Script----------
#!/bin/bash
#Fecha: 05.01.2015
#Autor: Autor
#Proposito: Script usando SELECT para ver logs
PS3='Elegir una opcion: '
#VARIABLE
LISTA="Sistema Salir"
#CODIGO
select i in $LISTA
do
if [ $i = "Sistema" ]
then
tail /var/log/messages
elif [ $i = "Salir" ]
then
exit
fi
done
#FIN
---------------------------------------------------------------------------------
CASE $variable IN
patron1 )
(Se ejecuta el comando 1)
;;
patron2 )
(Se ejecuta el comando 2)
;;
patron3 )
(Se ejecuta el comando 3)
;;
ESAC
-----------------------------------------------------------------
vi  /opt/scripts/supervisamem
#!/bin/bash
while true
  do
  ahora=$(date "+%H:%M:%S - ")
  echo -n $ahora >> /var/log/supervisamem.log
  grep Dirty /proc/meminfo >> /var/log/supervisamem.log
  sleep 30
done


#El comando case
En Bash permite realizar evaluaciones de múltiples condiciones de una manera más estructurada que una cadena de if-elif-else. Es útil cuando tienes varios casos específicos que quieres manejar según el valor de una variable. La estructura básica de case es:

case variable in
    patrón1)
        # Código a ejecutar si variable coincide con patrón1
        ;;
    patrón2)
        # Código a ejecutar si variable coincide con patrón2
        ;;
    *)
        # Código para el caso "por defecto" si no coincide con ningún patrón
        ;;
esac



/etc/init.d/iniciar-supervisamem.sh
chmod 700 /etc/init.d/iniciar-supervisamem.sh
vi /etc/init.d/iniciar-supervisamem.sh

/opt/scripts/supervisamem

##iniciar-supervisamem.sh

#!/bin/bash
case $1 in
start)
  /opt/scripts/supervisamem &
  ;;
stop)
  killall supervisamem
 ;;
*)
echo "No es una opcion para pasarle al script solo start y stop" 
break
;;
esac  


iniciar-supervisamem.sh start
-----------------------------------------------------------------------------------------

#!/bin/bash
case $1 in
ips)
  grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /lpic1/access_log
;;
usuarios)  
  tail -d: -f1,7 /etc/passwd
  ;;
*)
echo "No reconozco el parametro" ;;
 esac
---------------------------------------------------------------------------------
#!/bin/bash
#Fecha: 05.01.2015
#Autor: Autor
#Proposito: Usando CASE
#CODIGO
echo "Que distribucion de Linux utilizas:"
read DISTRO
case $DISTRO in
debian )
echo "Debian es muy popular" ;;

centos )
echo "Distribucion basada en Red Hat" ;;

ubuntu )
echo "Distribucion bastante popular basada en Debian" ;; 

windows )
echo "Muy gracioso" ;;

* )
echo "No reconozco esa distribucion" ;;
esac
-------------------------------------------------------------------------------------
iniciar-supervisamem.sh
#!/bin/bash
# chkconfig: - 99 10
case $1 in
start)
  /opt/scripts/supervisamem &
  ;;
stop)
  killall supervisamem
  ;;
*)
echo "No es una opcion para pasarle a script solo start y stop" 
;;
esac  
-----------------------------------------------------------------------------
Program Calls Within Scripts exec

#! /bin/bash

while true
do
   echo "1. Disk Stats "
   echo "2. Send Evening Report "
   read Input
   case "$Input" in
      1) exec df -kh ;;
      2) exec /home/SendReport.sh  ;;
   esac
done

Usage With the Find Command
The exec option can be used to perform operations like grep, cat, mv, cp, rm, and many more on the files found by the find command. Let’s use an example from our article on the find command to find all .java files containing the word “interface” in the “src” directory:

find src -name "*.java" -type f -exec grep -l interface {} \;


##Crear un servicio para system-v para trabajar con nginx instado /usr/local/nginx :


vi /etc/init.d/nginx

#!/bin/bash
# chkconfig: - 99 10
case $1 in
start)
  /usr/local/nginx/sbin/nginx &
  ;;
stop)
  killall nginx
  ;;
*)
echo "No es una opcion para pasarle a script solo start y stop" 
;;
esac


vi /etc/init.d/tomcat.sh

#!/bin/bash
# chkconfig: - 99 10
case $1 in
start)
  /tomcat-9/bin/startup.sh &
  ;;
stop)
  /tomcat-9/bin/shutdown.sh
  ;;
*)
echo "No es una opcion para pasarle a script solo start y stop"
;;
esac


##Ejemplo de while contador:

#!/bin/bash 
CONTADOR=0
while [  $CONTADOR -lt 10 ]; do
echo El contador es $CONTADOR
let CONTADOR=CONTADOR+1 
done


------------------------------------------------------------------------------------------------------------------------------------------

###Laboratorio script en Bash:

Crear un script en bash linux para realizar un backup de un directorio, que el usuario entre por consola, salvarlo en el directorio /opt que lo comprima y ponga la fecha en el archivo de backup, a la fecha actual.

vi backup.sh

#!/bin/bash

# Solicitar al usuario la ruta del directorio a respaldar
read -p "Ingresa la ruta absoluta del directorio a respaldar:" DIRECTORIO_ORIGEN

# Directorio de destino (donde se guardará el respaldo)
DIRECTORIO_DESTINO="/opt"

# Nombre del archivo de respaldo (con la fecha actual)
FECHA=$(date +%Y%m%d)
NOMBRE_ARCHIVO="backup_${FECHA}.tar.bz2"

# Crear el respaldo en formato .tar.bz2
tar -cvjf "${DIRECTORIO_DESTINO}/${NOMBRE_ARCHIVO}" "${DIRECTORIO_ORIGEN}"

# Verificar si la creación del respaldo fue exitosa
if [ $? -eq 0 ]; then
echo "Respaldo creado exitosamente en ${DIRECTORIO_DESTINO}/${NOMBRE_ARCHIVO}"
else
    echo "Error al crear el respaldo en ${DIRECTORIO_DESTINO}/${NOMBRE_ARCHIVO}"
fi

--------------------------------------------------------------------------------------------------------------------------------------
###Programar una tarea  que se ejecute de forma aleatoria una sola vez entre las 9:00 y las 17:00 horas

#!/bin/bash

# Verifica si el usuario es root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse como root. Saliendo..."
    exit 1
fi

# Genera una hora aleatoria entre 9 y 17 (ambos inclusive)
hora_aleatoria=$((RANDOM % 9 + 9))

# Crea la línea cron con la hora aleatoria
linea_cron="0 $hora_aleatoria * * * /ruta/a/tu/comando_o_script"

# Agrega la línea al archivo cron
echo "$linea_cron" >> /etc/crontab

echo "Trabajo programado para ejecutarse a las $hora_aleatoria horas."


0 9-17 * * * /ruta/a/mi_script.sh
