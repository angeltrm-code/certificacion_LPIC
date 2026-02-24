#Para mostrar sólo las variables de entorno, hay varios comandos que proporcionan casi el mismo resultado:
Las variables de entorno en Linux son valores dinámicos que el sistema operativo y los programas utilizan para saber cómo deben comportarse.

Piensa en ellas como “ajustes globales” que influyen en el funcionamiento de la sesión del usuario, la terminal o las aplicaciones.

#¿Para qué sirven?
*Algunas funciones típicas:
Definir rutas donde buscar ejecutables (PATH)
Indicar el usuario actual (USER)
Especificar el directorio personal (HOME)
Configurar idioma (LANG)
Personalizar el prompt (PS1)

El comando env se utiliza para mostrar todas las variables de entorno y sus valores en la sesión actual. También puede utilizarse para ejecutar comandos con un entorno modificado.

El comando declare -x se utiliza para declarar variables de entorno dentro de un script o sesión de Bash. Es equivalente a export

El comando typeset -x es similar a declare -x, pero se utiliza principalmente en versiones más antiguas de Bash o en otros shells como ksh (KornShell). En Bash moderno, declare -x y typeset -x son funcionalmente equivalentes.

El comando export -p muestra una lista de todas las variables de entorno exportadas. Es útil para ver qué variables se han marcado para ser exportadas a procesos hijos.

env
declare -x
typeset -x 
export -p

##Mostrar el valor de una variable:

echo $PATH
echo ${PATH}


#¿Por qué Usar ${} en Lugar de $?
El uso de ${} proporciona mayor claridad y seguridad en algunos casos, especialmente cuando necesitas concatenar texto o agregar sufijos/prefijos

#¿Cuándo Usar $VAR o ${VAR}?
Situación	Preferencia
Uso simple y directo	$VAR
Concatenación de texto o manipulación	${VAR}
Evitar ambigüedad en expresiones complejas	${VAR}



Los comandos internos en Linux son aquellos que están integrados en el shell (como Bash) y no requieren un programa o archivo externo para ejecutarse. Estos comandos se ejecutan directamente en el proceso del shell, lo que los hace más rápidos y útiles para tareas básicas de administración y control del entorno de la sesión.

#Gestión de directorios:
cd: Cambia el directorio actual.
pwd: Muestra el directorio de trabajo actual.
pushd y popd: Administran la pila de directorios para navegar fácilmente entre ellos.

#Gestión de variables:
export: Define o hace disponibles variables de entorno para los procesos hijos.
unset: Elimina una variable de entorno o de shell.
set: Configura o muestra opciones y variables del shell.

#Comandos de control de flujo:
if, then, else, fi: Condiciones de control de flujo en scripts.
for, while, until: Estructuras de bucle para iteración en scripts.
case: Estructura de control para comparar patrones en scripts.

#Gestión de procesos:
jobs: Muestra trabajos en segundo plano en la sesión actual.
bg: Envía un proceso al segundo plano.
fg: Trae un proceso en segundo plano al primer plano.
kill: Envia una señal para finalizar un proceso (usualmente con un PID).

#Redirección y control de salida:
echo: Imprime texto o variables en la pantalla.
read: Lee la entrada del usuario y la asigna a una variable.
wait: Espera a que uno o varios procesos finalicen.
exec: Reemplaza el shell actual con un comando o programa especificado, sin crear un nuevo proceso.

#Comandos de información y ayuda:
help: Muestra ayuda para comandos internos del shell.
type: Indica si un comando es interno, externo, o un alias.
alias y unalias: Crea o elimina alias para comandos.

#Control de sesión:
exit: Finaliza la sesión del shell.
logout: Cierra la sesión en sistemas multiusuario.
history: Muestra el historial de comandos usados en la sesión.


##Declarar variables locales
ENVIRONMENT_A=1
export ENVIRONMENT_A
 
export ENVIRONMENT_B=2
declare -x ENVIRONMENT_C=3
typeset -x ENVIRONMENT_D=3
env | grep ENVIRONMENT

##Eliminar variables locales declaradas:
El comando unset se utiliza para eliminar variables del entorno o variables del shell. También puede eliminar funciones definidas en la sesión actual.

unset ENVIRONMENT_B
unset ENVIRONMENT_c
unset ENVIRONMENT_C
unset ENVIRONMENT_A
unset ENVIRONMENT_D
env | grep ENVIRONMENT

~/.bash_profile




#La variable PATH
PATH es una variable de entorno fundamental que indica al sistema dónde buscar los ejecutables cuando escribes un comando en la terminal.

#Ver el contenido actual
echo $PATH
#Salida ejemplo del comando anterior:
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#Modificar la variable PATH para añadir el directorio /lpic1, donde tengo mis scripts de shell:
vi ~/.bash_profile

export PATH=$PATH:$HOME/bin:/lpic1

#Explicacion:
Esta instrucción modifica la variable PATH añadiendo el  nuevo directorio (/lpic1) al final:

$HOME/bin → Directorio personal del usuario para scripts.
/lpic1 → Directorio absoluto llamado lpic1.

**El uso de $PATH al inicio permite conservar las rutas que ya existían.
El símbolo ":" separa los distintos directorios dentro de la variable PATH.

Si no se incluye $PATH, se eliminarían todas las rutas anteriores.
Para que el cambio se herede a procesos hijos, debe usarse:

export PATH=$PATH:$HOME/bin:/scripts:/lpic1


#La variable PS1
PS1 es una variable de entorno en Linux y otros sistemas Unix que define el formato del prompt (símbolo) de la línea de comandos que ves en el shell (normalmente Bash). El prompt es el texto que aparece cada vez que el shell está esperando una entrada del usuario y se puede personalizar para mostrar información útil, como el nombre de usuario, el directorio actual, la hora, etc.

#Ver su configuracion y dentro de audo podmos buscar PS1
man bash

#Códigos comunes para personalizar PS1
\u: Nombre del usuario actual.
\h: Nombre del host hasta el primer punto.
\H: Nombre completo del host.
\w: Directorio de trabajo actual (ruta completa).
\W: Solo el nombre del directorio actual.
\d: Fecha en formato día_semana mes día.
\t: Hora actual en formato de 24 horas (HH:MM
).
\T: Hora en formato de 12 horas (HH:MM
).
\@: Hora en formato de 12 horas con AM/PM.
\$: Muestra # si eres root y $ si eres un usuario normal.
\n: Salto de línea.

cat /root/.bash_profile
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin:/lpic1
PS1="\[\e[31m\][\[\e[m\]\[\e[38;5;172m\]\u\[\e[m\]@\[\e[38;5;153m\]\h\[\e[m\] \[\e[38;5;214m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "
#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\]'
HISTIGNORE='ls*:cd*:history*:exit'
LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client/lib/:/usr/lib64/mysql/lib
EDITOR=/usr/bin/vi
export PATH PS1 HISTIGNORE LD_LIBRARY_PATH EDITOR
export JAVA_HOME=/usr/local/jdk1.8


##Funciones
Las funciones son un poco más avanzadas que los alias y normalmente se utilizan en los scripts de shell de Bash. 

#Ejemplo de creacion de una funcion:
report () { 
cd /usr/share/doc
echo "Document directory usage report" > /tmp/report 
date >> /tmp/report 
pwd >> /tmp/report 
du -sh . >> /tmp/report 
cd ~ 
}



report2 () { 
cd $1
echo "Document directory usage report" > /tmp/report2 
date >> /tmp/report2 
pwd >> /tmp/report2
du -sh . >> /tmp/report2 
cd ~ 
}


#!/bin/bash

# Función para generar un informe de uso de espacio en un directorio
report2 () {
    if [ -d "$1" ]; then  # Comprueba si el directorio existe
        cd "$1" || exit  # Cambia al directorio especificado o sal si falla
        echo "Document directory usage report" > /tmp/report2
        date >> /tmp/report2
        pwd >> /tmp/report2
        du -sh . >> /tmp/report2
        cd ~  # Vuelve al directorio inicial
        echo "El informe se ha generado en /tmp/report2"
    else
        echo "El directorio $1 no existe. Por favor, proporciona un directorio válido."
    fi
}

# Ejemplo de uso
# Llama a la función report2 con un directorio específico
report2 /path/to/your/directory

#Explicación de cd $1
cd: Cambia el directorio de trabajo actual.
$1: Hace referencia al primer argumento pasado al script de shell.

##Ahora la llamamos:
report
report2  /root


##Veremos el resultado
 cat /tmp/report
 
##Para ver las funciones delcaradas en nuestro shell: 
typeset -f 
declare -f
declare -f | grep report2
------------------------------------------------------------------------------------------

###Archivos de inicialización BASH

El archivo /etc/bashrc (o /etc/bash.bashrc en algunas distribuciones) es un archivo de configuración global utilizado por el shell Bash en sistemas tipo UNIX (Linux). Es ejecutado por todos los usuarios cada vez que abren una nueva sesión de shell interactiva, ya sea en terminal o mediante SSH.

#¿Qué es el archivo /etc/bashrc?
Es un archivo de configuración global para Bash.
Se ejecuta cada vez que se inicia una sesión interactiva.
Contiene configuraciones y alias aplicables a todos los usuarios.
Normalmente incluye la configuración de colores del prompt, alias, y funciones globales.

#La ubicación puede variar según la distribución de Linux:
CentOS/RHEL	/etc/bashrc
Ubuntu/Debian	/etc/bash.bashrc
Arch Linux	/etc/bash.bashrc

/etc/profile Este archivo solo puede ser modificado por el administrador y lo ejecutarán todos los usuarios que inicien sesión. Los administradores utilizan este archivo para crear variables de entorno clave, mostrar mensajes a los usuarios cuando inician sesión y establecer valores clave del sistema.


La variable de entorno TMOUT en Linux define el tiempo de inactividad en segundos después del cual una sesión de shell se cerrará automáticamente. 

El comando readonly TMOUT hace que la variable TMOUT sea solo de lectura, lo que significa que no se podrá modificar ni eliminar durante la sesión. Esto es útil en entornos donde se desea forzar un límite de tiempo de inactividad sin permitir que los usuarios lo cambien.

##Forzar variables a todos los usuarios ponemos la variable como readonly:
El comando readonly en bash marca esas variables como inmutables:
**no se pueden modificar ni eliminar durante la sesión.

vi /etc/profile

TMOUT=15
readonly TMOUT
export TMOUT

##Si el usuario intenta modificarla no puede, como se ve en el ejemplo:

[berto@sercentos7 ~]$ export TMOUT=5000
echo $TMOUT

[berto@sercentos7 ~]$ export TMOUT=5000

-bash: TMOUT: readonly variable

#Ficheros .bash_profile .bashrc

1. .bash_profile
#Ubicación:
~/.bash_profile (o a veces ~/.profile o ~/.bash_login)

#Cuándo se ejecuta:
Se ejecuta una sola vez al iniciar sesión (login shell).
Es decir, cuando entras al sistema por consola, por SSH, o desde un gestor de login gráfico que abre una sesión ompleta.

#Funciones principales:
Configurar variables de entorno globales del usuario, por ejemplo:
export PATH=$PATH:$HOME/bin
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export LANG=es_ES.UTF-8

Ejecutar comandos que solo deben correr una vez por sesión (no cada vez que abras una nueva terminal).

Normalmente, invoca a .bashrc para que las configuraciones interactivas también estén disponibles en sesiones de login:
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

#En resumen:
.bash_profile prepara el entorno general de trabajo cuando inicias sesión en bash.


2. .bashrc

#Ubicación:
~/.bashrc

#Cuándo se ejecuta:
Se ejecuta cada vez que abres una nueva terminal interactiva (por ejemplo, una nueva pestaña en el terminal o una nueva consola dentro del entorno gráfico).
No se ejecuta al iniciar sesión por SSH si ya hay .bash_profile (a menos que éste lo invoque manualmente, como suele hacerse).

#Funciones principales:
Definir alias, funciones, y ajustes interactivos.
alias ll='ls -l --color=auto'
alias grep='grep --color=auto'

PS1='\u@\h:\w\$ '  # Cambiar el prompt

Configurar cosas que afectan solo al uso interactivo del shell (no a procesos de fondo ni scripts).
En resumen:
.bashrc configura el comportamiento interactivo del shell cada vez que abres una nueva terminal.

##Diferencia clave
Archivo	            Cuándo se ejecuta	                                Uso principal
.bash_profile	    Al iniciar sesión (login shell)	                    Configurar entorno y variables globales
.bashrc	            Al abrir una terminal interactiva	                Alias, funciones, y ajustes del shell


su - usuario (login shell completo)
Cuando usas el guion (-), estás indicando que quieres iniciar una sesión de login completa como si ese usuario hubiera iniciado sesión directamente (por consola o SSH).

Entonces se ejecuta:
/etc/profile (configuración global del sistema)

~usuario/.bash_profile (o si no existe, .bash_login o .profile)
y dentro de ese archivo, normalmente se ejecuta también ~usuario/.bashrc

#Resumen:
su - usuario  → login shell
               → carga /etc/profile
               → carga ~/.bash_profile (o ~/.bash_login / ~/.profile)
               → éste a su vez suele invocar ~/.bashrc


#El comando readonly en bash marca esas variables como inmutables:
#no se pueden modificar ni eliminar durante la sesión.

readonly HISTFILE PATH USER LOGNAME MAIL HOSTNAME HISTSIZE HISTCONTROL TMOUT


#El comando history

El comando history en Linux muestra el historial de comandos ejecutados en la sesión del shell. Es útil para revisar comandos anteriores, reutilizarlos y gestionar el historial.

##Ejemplos con el comando history:

history #muestra todo el historial
history 10 #muestra las últimas 10
history –c #limpia el historial

##Repetir un comando del historial
!775

#Apagar o prender el historial
set +o history #Apaga el historial
set -o history #Prende el historial

#Desactivar el Historial Permanente
export HISTFILESIZE=0

##Variables del sistema involucradas con el historial
echo $HISTFILE Contiene el nombre del archivo. Normalmente es: ~/.bash_history
echo $HISTFILESIZE Esta variable contiene el tamaño máximo del archivo
echo $HISTSIZE Esta variable contiene el tamaño máximo de comandos
echo $HISTIGNORE=ls*:cd*:history*:exit:passwd*:

#Los comandos que comiencen con un espacio en blanco no se guardarán en el historial.
export HISTCONTROL=ignorespace

#Ejemplo dejo el espacio en blanco y no queda registrado en el historial:
 echo 000000 |passwd --stdin operador


#¿Por qué usarlo?
Para evitar que comandos sensibles o privados queden registrados (por ejemplo, contraseñas o configuraciones).
Para ejecutar comandos temporales sin llenar el historial innecesariamente.

#Otras Opciones de HISTCONTROL
Valor	     Descripción
ignorespace	 No guarda comandos que comiencen con un espacio en el historial.
ignoredups	 No guarda comandos duplicados consecutivos en el historial.
ignoreboth	 Combina ignorespace e ignoredups, evitando comandos con espacio y duplicados consecutivos.
erasedups	 Elimina todas las entradas duplicadas anteriores, manteniendo solo la última ocurrencia.
none	     No ignora ningún comando.

#HISTTIMEFORMAT 
HISTTIMEFORMAT permite mostrar la fecha y hora de cada comando en el historial.

Para habilitar el registro de la hora en el historial, puedes configurar HISTTIMEFORMAT de la siguiente manera:
export HISTTIMEFORMAT="%F %T "

#Explicación:
%F - Muestra la fecha en formato YYYY-MM-DD.
%T - Muestra la hora en formato HH:MM:SS.
El espacio al final mejora la legibilidad.


Salida:
1  2025-03-27 14:23:45 ls
2  2025-03-27 14:23:46 pwd
3  2025-03-27 14:23:47 echo "Hola"

#Hacerlo Permanente
echo 'export HISTTIMEFORMAT="%F %T "' >> ~/.bashrc
source ~/.bashrc

#Formatos Comunes para HISTTIMEFORMAT
*Formato	                                       Descripción	                        Ejemplo de Salida
%F %T	                                       Fecha completa y hora	            2025-03-27 14:23:45
%d-%m-%Y %T	                                   Día-Mes-Año y Hora	                27-03-2025 14:23:45
%Y/%m/%d %H:%M	                               Año/Mes/Día y Hora:Minuto	        2025/03/27 14:23
%c	                                 Fecha y hora local en formato completo	Thu Mar 27 14:23:45 2025
%x %X	                            Fecha y hora según la configuración regional	    03/27/2025 14:23:45

El símbolo ~ en Linux y otros sistemas tipo Unix es un atajo para el directorio de inicio del usuario actual. Este símbolo simplifica la navegación hacia el directorio principal del usuario sin tener que escribir la ruta completa.

cat /~/.bash_profile

PATH=$PATH:$HOME/bin:/lpic1
PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\]'
HISTIGNORE='ls*:cd*:history*:exit'
EDITOR=/usr/bin/vi
HISTFILE=/root/.historial
export PATH PS1 HISTIGNORE EDITOR HISTFILE

#Ejecutamos el comando source para aplicar los cambios de nuestro .bash_profile
source /root/.bash_profile

El comando source en Bash (y otros shells similares) se utiliza para ejecutar comandos desde un archivo en el contexto del shell actual. Esto significa que las variables de entorno, funciones y configuraciones definidas en el archivo permanecen accesibles después de su ejecución.
------------------------------------------------------------------------------------------
##Persistirlo para todo el sistema operativo, todos los usuarios:

vi  /etc/profile
JAVA_HOME=/usr/local/jdk1.9
export JAVA_HOME


--------------------------------
##JDK para el usuario tomcat8 que lanza el servidor con la jdk1.8
vi   /home/tomcat8/.bash_profile

JAVA_HOME=/usr/local/jdk1.8
export JAVA_HOME

##JDK para el usuario tomcat

vi   /home/tomcat7/.bash_profile

JAVA_HOME=/usr/local/jdk1.7
export JAVA_HOME


#alias
Un alias es esencialmente un apodo para un comando o una serie de comandos. Algunos alias pueden crearse automáticamente como resultado de comandos ejecutados en shells de inicialización. Para ver los alias actuales del shell, use el comando alias sin argumentos:

alias


El comando type en Linux y Unix se usa para mostrar cómo un comando específico es interpretado por el shell, de esta forma podemos comprobar si el alias existe, si es un script o un comando interno o externo del shell.

##Para crar nuestros alias en nuestro shell:

vi /root/.bashrc
alias ips='grep -Eo "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" /lpic1/access_log |sort -n |uniq -c |sort -n'

alias listar='ls -l | tr -s " " |cut -d " " -f1,3,9'

##Para eliminar un alias del shell actual, use el comando unalias:
alias borrar2='rm -ri'
unalias borrar

##Borrar un alias:
El comando unalias se utiliza para eliminar un alias definido en el shell

unalias listar
unalias ips


##Para persistir los ALIAS para cada usuario en su .bashrc:

vi  /root/.bashrc
# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ips='grep -Eo "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" /lpic1/access_log |sort -n |uniq -c |sort -n'
alias listar='ls -l | tr -s " " |cut -d " " -f1,3,9'



##Declaramos la variable y vemos su funcionamiento:
La variable de entorno EDITOR define qué editor de texto se usará por defecto en ciertos comandos.

vi   /root/.bash_profile

export EDITOR=/usr/bin/vi

#Si ejecutamos un comando que abre un editor del sistema, pues abrira en este caso vi:
systemctl edit --full sendmail.service

visudo


##Si lanzamos este comando sin tener definido un valor en la varibale EDITOR, nos lo edita con el nano:
systemctl edit --full sendmail.service

##PS1
https://wiki.archlinux.org/title/Bash_(Espa%C3%B1ol)/Prompt_customization_(Espa%C3%B1ol)




##Listas En el contexto del shell Bash, una lista es una secuencia de comandos que están separados por uno de los siguientes operadores:

; Los comandos dentro de la lista se ejecutan secuencialmente, donde el shell ejecutará el primer comando y esperará a que termine antes de ejecutar el siguiente comando. El estado de salida de la lista se basa en el estado de salida del último comando que se ejecuta.

& Cada comando dentro de la lista se ejecuta de forma asíncrona dentro de una subcapa o en segundo plano. El shell no espera a que terminen los comandos y devuelve un estado de salida de cero.

&& Esta es una lista AND, por lo que si el comando del lado izquierdo se &&ejecuta correctamente, se ejecutará el comando del lado derecho &&. El estado de salida de la lista se basa en el estado de salida del último comando que se ejecuta.

|| Esta es una lista OR, por lo que si el comando del lado izquierdo de ||NO se ejecuta correctamente, se ejecuta el comando del lado derecho de ||. El estado de salida de la lista se basa en el estado de salida del último comando que se ejecuta.


##Scripts de salida de BASH

Así como Bash ejecuta uno o más archivos al iniciarse, también puede ejecutar uno o más archivos al salir. Cuando Bash salga, ejecutará los s archivos ~/.bash_logout y /etc/bash_logout, si existen




vi /etc/bash_logout
clear


~/.bash_logout
clear
cat /etc/adios
sleep 3

vi /etc/adios
.----------------. .----------------. .----------------. .----------------. .----------------.
| .--------------. | .--------------. | .--------------. | .--------------. | .--------------. |
| |      __      | | |  ________    | | |     _____    | | |     ____     | | |    _______   | |
| |     /  \     | | | |_   ___ `.  | | |    |_   _|   | | |   .'    `.   | | |   /  ___  |  | |
| |    / /\ \    | | |   | |   `. \ | | |      | |     | | |  /  .--.  \  | | |  |  (__ \_|  | |
| |   / ____ \   | | |   | |    | | | | |      | |     | | |  | |    | |  | | |   '.___`-.   | |
| | _/ /    \ \_ | | |  _| |___.' / | | |     _| |_    | | |  \  `--'  /  | | |  |`\____) |  | |
| ||____|  |____|| | | |________.'  | | |    |_____|   | | |   `.____.'   | | |  |_______.'  | |
| |              | | |              | | |              | | |              | | |              | |
| '--------------' | '--------------' | '--------------' | '--------------' | '--------------' |
 '----------------' '----------------' '----------------' '----------------' '----------------'
