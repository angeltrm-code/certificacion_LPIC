## Manual de la certificacion:
Manual LINUX.pdf -->Pagina 161

## 103.5 Crear, supervisar y matar procesos

## Un proceso representa un programa en curso de ejecución y, al mismo tiempo, todo su entorno de ejecución
(memoria, estado, identificación, propietario, padre...).


## El comando ps es el que permite informar sobre el estado de los procesos. 
# ps esta basado en el sistema de archivos /proc, es decir, lee directamente la información de los archivos que se encuentran en este directorio
(-e muestra todos los procesos)

La salida que muestras es el formato típico de la información obtenida a través del comando ps en sistemas Unix o Linux. A continuación, te explico lo que significa cada campo:
ps -ef |more

UID: El ID de usuario que ejecutó el proceso.
PID: El ID del proceso (Process ID).
PPID: El ID del proceso padre (Parent Process ID), que indica qué proceso inició el proceso actual.
C: Porcentaje de utilización del CPU (en un valor relativo).
STIME: Hora en la que se inició el proceso.
TTY: El terminal asociado con el proceso.
TIME: Tiempo total de CPU que el proceso ha consumido.
CMD: El comando que inició el proceso.



ps -efl |more
-e → Muestra todos los procesos en ejecución en el sistema (equivalente a --all).
-f → Activa el formato "full" (detallado), incluyendo información como el UID, PPID, TTY, STIME y CMD.
-l → Muestra el formato "long" (extendido), que añade información adicional sobre el estado del proceso, prioridad, uso de CPU, etc.

Columna	    Descripción
F	         Indicador de bandera del proceso.
S	         Estado del proceso: R (ejecutando), S (dormido), D (espera ininterrumpida), Z (zombie), T (detenido).
UID	         ID del usuario propietario del proceso.
PID	         Identificador único del proceso.
PPID	     Identificador del proceso padre.
C	         Uso del CPU por el proceso.
PRI	         Prioridad del proceso.
NI	         Valor de "niceness" (prioridad ajustada por el usuario).
ADDR	     Dirección de memoria del proceso (casi siempre vacía en sistemas modernos).
SZ	         Tamaño del proceso en páginas de memoria.
WCHAN	     Dirección en la que el proceso está esperando (si está en espera).
STIME	     Hora en que el proceso fue iniciado.
TTY	         Terminal desde donde se ejecutó el proceso (si aplica).
TIME	     Tiempo de CPU utilizado por el proceso.
CMD     	 Comando que ejecutó el proceso.

## Formato BSD, lo que nos da es un resument del %CPU %MEM
ps aux |more

ps -eo user,pid,tty,stat,command |more
ps -u root,apache
ps -u apache
ps -eF (-F muestra opciones completas extra)

pstree -puc
Muestra los procesos en forma de árbol, pstree
pstree -AGu

-p → muestra los PID
-u → muestra el usuario dueño del proceso
-c → muestra el comando completo sin agrupar procesos idénticos

El comando systemd-cgls en sistemas basados en Linux con systemd muestra una lista jerárquica de los grupos de control (cgroups) y los procesos que pertenecen a cada uno de ellos. Este comando es útil para ver cómo se organizan los procesos y los recursos que consumen dentro de los cgroups.

La salida de este comando presenta:

Una estructura en árbol: Muestra de manera jerárquica cómo los procesos están organizados en los cgroups.
Procesos individuales: Muestra los procesos en ejecución y los cgroups en los que están contenidos.
Subárboles de cgroups: Agrupaciones de procesos bajo un mismo cgroup, lo que permite controlar aspectos como el uso de CPU, memoria, E/S, etc.

systemd-cgls


## kill
## El comando kill, que literalmente quiere decir matar, sirve no solo para matar o terminar procesos sino principalmente para enviar señales (signals) a los procesos

kill -l
kill -9 pid
#> kill -9 11428 (termina, mata un proceso completamente)
#> kill -SIGKILL 11428 (Lo mismo que lo anterior)

Las señales más comunes del kill, son la 19 y 20 que detienen momentáneamente la ejecución
de un proceso o programa, 18 la continua.

##Lista de señales en Linux (kill -l):

 1)  SIGHUP       - Hangup, recarga configuración en algunos procesos.
 2)  SIGINT       - Interrupción del usuario (Ctrl + C).
 3)  SIGQUIT      - Termina un proceso y genera un core dump.
 4)  SIGILL       - Instrucción ilegal.
 5)  SIGTRAP      - Punto de interrupción o trampa.
 6)  SIGABRT      - Abortado, generado por abort().
 7)  SIGBUS       - Error de acceso a memoria.
 8)  SIGFPE       - Error de punto flotante (división por cero, etc.).
 9)  SIGKILL      - Mata un proceso inmediatamente (no se puede ignorar o manejar).
10)  SIGUSR1      - Señal de usuario 1, definida por la aplicación.
11)  SIGSEGV      - Error de segmentación (acceso inválido a memoria).
12)  SIGUSR2      - Señal de usuario 2, definida por la aplicación.
13)  SIGPIPE      - Intento de escribir en una tubería sin lector.
14)  SIGALRM      - Señal de alarma, generada por alarm().
15)  SIGTERM      - Terminación de proceso de manera elegante.
16)  SIGSTKFLT    - Falla en la pila, rara vez usada.
17)  SIGCHLD      - Proceso hijo terminó.
18)  SIGCONT      - Continúa un proceso detenido.
19)  SIGSTOP      - Detiene un proceso sin posibilidad de ser ignorado.
20)  SIGTSTP      - Detiene un proceso desde terminal (Ctrl + Z).
21)  SIGTTIN      - Proceso en segundo plano intenta leer de la terminal.
22)  SIGTTOU      - Proceso en segundo plano intenta escribir en la terminal.
23)  SIGURG       - Datos urgentes en un socket.
24)  SIGXCPU      - Límite de tiempo de CPU excedido.
25)  SIGXFSZ      - Límite de tamaño de archivo excedido.
26)  SIGVTALRM    - Alarma de tiempo virtual.
27)  SIGPROF      - Señal de profiling.
28)  SIGWINCH     - Cambio de tamaño de la ventana del terminal.
29)  SIGIO        - Entrada/salida asíncrona disponible.
30)  SIGPWR       - Advertencia de fallo de energía.
31)  SIGSYS       - Llamada de sistema inválida.

Señales en tiempo real (usadas por el kernel y aplicaciones específicas):
34)  SIGRTMIN     - Señal en tiempo real mínima.
35-50) SIGRTMIN+X - Variaciones de SIGRTMIN.
50-64) SIGRTMAX-X - Variaciones de SIGRTMAX.
64)  SIGRTMAX     - Señal en tiempo real máxima.

Notas:
- SIGKILL (9) y SIGSTOP (19) no pueden ser ignoradas ni manejadas.
- SIGTERM (15) es la forma recomendada de terminar procesos, excepto si están bloqueados.



## killall
## El comando killall, que funciona de manera similar a kill, pero con la diferencia de en vez de indicar un PID se indica el nombre del programa, lo que afectará a todos los procesos que tengan ese nombre.
killall -9

killall -l
killall -HUP httpd (manda una señal de "colgar", detenerse
releer sus archivos de configuración y reiniciar)
#> killall -KILL -i squid (manda señal de matar a todos los procesos
squid pero pide confirmación en cada uno)

##Podemos lanzar en una cosola el comando:
yes
##Desde otra consola lo puedo matar con el comando:
killall yes

## Señales disponibles en Linux (killall -l):

HUP   (1)  - Reinicia procesos, útil para recargar configuración sin detener el proceso.
INT   (2)  - Interrumpe un proceso (equivalente a Ctrl + C en la terminal).
QUIT  (3)  - Termina un proceso y genera un core dump.
ILL   (4)  - Instrucción ilegal, el proceso intentó ejecutar código inválido.
TRAP  (5)  - Punto de interrupción, utilizado en debugging.
ABRT  (6)  - Señal de aborto, usada por abort().
BUS   (7)  - Error de bus, problema de acceso a memoria.
FPE   (8)  - Excepción de punto flotante, como división por cero.
KILL  (9)  - Mata un proceso de inmediato (no se puede ignorar o manejar).
USR1  (10) - Señal de usuario 1, definida por la aplicación.
SEGV  (11) - Violación de segmento, acceso a memoria inválida.
USR2  (12) - Señal de usuario 2, definida por la aplicación.
PIPE  (13) - Error en una tubería (pipe) sin lector.
ALRM  (14) - Señal de alarma, generada por alarm().
TERM  (15) - Termina un proceso de manera elegante (por defecto).
STKFLT (16) - Error de falla en la pila (stack fault), rara vez usada.
CHLD  (17) - Notificación cuando un proceso hijo termina.
CONT  (18) - Continúa un proceso detenido.
STOP  (19) - Detiene un proceso sin posibilidad de ser ignorado.
TSTP  (20) - Detiene un proceso (equivalente a Ctrl + Z en la terminal).
TTIN  (21) - Detiene un proceso cuando intenta leer de una terminal sin permiso.
TTOU  (22) - Detiene un proceso cuando intenta escribir en una terminal sin permiso.
URG   (23) - Señal de datos urgentes en sockets.
XCPU  (24) - Límite de tiempo de CPU excedido.
XFSZ  (25) - Límite de tamaño de archivo excedido.
VTALRM (26) - Alarma de tiempo virtual.
PROF  (27) - Señal de profiling.
WINCH (28) - Cambio de tamaño en la ventana de terminal.
POLL  (29) - Evento en una I/O de socket.
PWR   (30) - Señal de fallo de energía.
SYS   (31) - Llamada de sistema inválida.

Nota: `KILL (9)` y `STOP (19)` no pueden ser ignoradas ni manejadas por el proceso.



## nice
## Permite cambiar la prioridad de un proceso. Por defecto, todos los procesos tienen una
## prioridad igual ante el CPU que es de 0. Prioridad -20 a +19 de un proceso.

nice -n -5 comando
nice -n -5 yes

##renice
##Asi como nice establece la prioridad de un proceso cuando se incia su ejecución, renice
##permite alterarla en tiempo real, sin necesidad de detener el proceso

nice -n -5 yes (se ejecuta el programa 'yes' con prioridad -5)
(dejar ejecutando 'yes' y en otra terminal se
analiza con 'ps')
#> ps -el
F S UID PID PPID C PRI NI ADDR SZ WCHAN TTY TIME CMD
4 S 0 12826 12208 4 75 -5 - 708 write_ pts/2 00:00:00 yes
#> renice 7 12826


##Asi se evita que el proceso se "cuelgue" al cerrar la consola

El comando nohup (abreviatura de "no hang up") en sistemas basados en Unix y Linux permite ejecutar un comando o proceso de tal forma que no se detenga, incluso si cierras la sesión o el terminal desde el cual fue iniciado. Es especialmente útil cuando quieres ejecutar tareas de larga duración en segundo plano sin que se interrumpan si pierdes la conexión o cierras la terminal.

El símbolo & en Linux y sistemas Unix se utiliza para ejecutar un comando o proceso en segundo plano. Esto significa que el comando se ejecutará de manera independiente y no bloqueará la terminal o sesión actual, permitiéndote seguir usando la terminal para otras tareas mientras el proceso continúa ejecutándose.

nohup yes > /dev/null &

sh backup.sh &
nohup sh backup.sh &


echo $$ --> pid del shell actual
echo $! --> pid del ultimo proceso ejectuado
echo  $? --> devuelve 0 el comando anterior se ejecuto con exito
echo $0 --> Nos devuelve el shell que estamos utilizando

Shell	Salida de echo $0
Bash	/bin/bash o -bash
Zsh	/bin/zsh o -zsh
Dash	/bin/dash o -dash
Sh	/bin/sh o -sh
Fish	/usr/bin/fish

Los comandos bg y fg permiten actuar en estos jobs tomando como parámetro su número. Se ejecuta el comando bg en un job parado para iniciarlo de nuevo en segundo plano
jobs
fg (foreground) y bg background


fg	Trae un trabajo suspendido/segundo plano al primer plano.
bg	Retoma un trabajo suspendido y lo envía al segundo plano (background).

jobs	Muestra una lista de los trabajos activos en la sesión actual del shell.

[2]   Ejecutando              sleep 600 &
[3]-  Ejecutando              sleep 300 &
[4]+  Ejecutando              sleep 200 &

[2] [3] [4]	Número de trabajo asignado por el shell. Se usa para referenciar el proceso con %N.
Ejecutando	Indica que el proceso está activo en segundo plano.
sleep 600 &, etc.	Comando ejecutado en background.
+	Indica el trabajo más reciente en segundo plano ([4]).
-	Indica el segundo más reciente ([3]).

kill %3

#IMPORTANTE:
El % es obligatorio.
Si usas kill 1 matarías el proceso PID 1 (systemd), lo cual sería peligroso.


which killall
/usr/bin/killall
[root@sercentos7 ~]# rpm -qf /usr/bin/killall
psmisc-22.20-16.el7.x86_64
yum provides /*killall
yum provides killall
yum install psmisc -y


##disown
es una herramienta que te permite quitar todos los procesos de la tabla de procesos activos.
Es decir, estás desacoplando el proceso del terminal desde el que lo lanzaste.
Otra opción es utilizar la opción -h. Si utilizas esta opción, los procesos no se quitan de la tabla de procesos activos sino que se marca para que la señal SIGHUP no se envie al proceso. 
Esto es lo mismo que hacías nohup.

sleep 6000 &
ps -ef | grep -i sleep
jobs
[1]   Ejecutando              sleep 600 &

disown -h %1

#matar el bash o salir del termianl, desde otro terminal veremos que el padre es el pid 1:
ps -efl |grep -w sleep
0 S root     31252     1  0  80   0 - 27014 hrtime 21:06 ?        00:00:00 sleep 6000

Para obtener la traza del proceso de Apache 2 es preciso conocer su PID:
# pidof apache2
4995 4994 4991

pidof
Este comando muestra el o los PID del programa invocado.
Sintaxis
pidof <opción> <nombre_del_programa>

pgrep
El comando pgrep muestra los identificadores de los procesos.
Sintaxis
pgrep <opciones> <nombre_del_programa>

Conocer los PID del programa sshd:
# pgrep -l sshd
3423 sshd
3605 sshd
3610 sshd3

Conocer el PID de los programas cuyo propietario es root:
# pgrep -lu root
1790 systemd
1791 (sd-pam)
1793 sshd
1794 bash

pkill
pkill también envía una señal a los procesos en función de su nombre.
Sintaxis
pkill <opciones> <nombre_del_programa>


El comando time en Linux y sistemas Unix se utiliza para medir el tiempo que tarda en ejecutarse un comando. Proporciona información sobre el tiempo real (tiempo total transcurrido), el tiempo de CPU del usuario (el tiempo que el CPU ha pasado ejecutando código en el espacio del usuario) y el tiempo de CPU del sistema (el tiempo que el CPU ha pasado ejecutando código del kernel).

Campos explicados:
real: El tiempo real total transcurrido desde el inicio hasta el final del comando, incluyendo el tiempo de espera en otros procesos y el tiempo de inactividad. Este es el "reloj de pared" o tiempo cronológico.

user: El tiempo que el CPU ha pasado ejecutando el código en el espacio de usuario (es decir, no en el kernel). Incluye las operaciones realizadas por el usuario, como ejecutar un programa.

sys: El tiempo que el CPU ha pasado ejecutando las funciones del kernel en nombre del programa (por ejemplo, manejo de archivos, E/S).



El comando top en sistemas Linux y Unix muestra en tiempo real los procesos en ejecución en el sistema, ordenados por el uso del procesador (CPU). Es una herramienta interactiva muy útil para monitorizar el rendimiento del sistema, incluyendo el uso de recursos como la CPU, la memoria y el tiempo de ejecución de los procesos.

#Principales secciones de la salida de top:
Cabecera del sistema: Contiene información general del sistema.

uptime: Tiempo que el sistema ha estado en funcionamiento.
load average: La carga promedio del sistema en los últimos 1, 5 y 15 minutos.

tasks: Número total de tareas (procesos) en el sistema y su estado (en ejecución, en espera, etc.).

CPU usage: Porcentaje de uso del CPU dividido en usuarios, sistema, y procesos inactivos.

Memory (Mem y Swap): Información del uso de la memoria RAM y de la memoria de intercambio (swap).


### Lista de procesos: Muestra los procesos actualmente en ejecución, con columnas que incluyen:

PID: Identificador del proceso.
USER: Usuario que ejecuta el proceso.
PR: Prioridad del proceso.
NI: Valor de nice (prioridad ajustada del proceso).
VIRT: Cantidad total de memoria virtual utilizada por el proceso.
RES: Cantidad de memoria física utilizada por el proceso.
SHR: Cantidad de memoria compartida usada.
%CPU: Porcentaje de uso de CPU por el proceso.
%MEM: Porcentaje de uso de la memoria RAM por el proceso.
TIME+: Tiempo total de CPU consumido por el proceso.
COMMAND: El nombre del comando o proceso.


El comando vmstat en Linux y sistemas Unix proporciona información sobre el rendimiento del sistema, mostrando estadísticas relacionadas con la memoria, los procesos, la CPU y el uso de I/O (entrada/salida). Es una herramienta útil para monitorizar el estado del sistema y diagnosticar problemas de rendimiento.

# Campos importantes en la salida de vmstat:
Procesos (procs):
r: Número de procesos en cola de ejecución (running o waiting).
b: Número de procesos bloqueados, esperando recursos de I/O.

# Memoria (memory):
swpd: Cantidad de memoria usada en el espacio de intercambio (swap) en KB.
free: Memoria libre disponible en KB.
buff: Memoria utilizada como buffers (normalmente para escritura en disco).
cache: Memoria utilizada como caché de disco.

# Swap:
si: Cantidad de memoria intercambiada desde el disco (swap-in) en KB/s.
so: Cantidad de memoria intercambiada hacia el disco (swap-out) en KB/s.

# I/O:
bi: Cantidad de bloques de entrada desde dispositivos de bloque (lecturas de disco) en bloques/s.
bo: Cantidad de bloques de salida hacia dispositivos de bloque (escrituras en disco) en bloques/s.

# Sistema (system):
in: Número de interrupciones por segundo, incluyendo las de hardware.
cs: Número de cambios de contexto por segundo (cuando el CPU cambia de un proceso a otro).

# CPU:
us: Porcentaje de tiempo de CPU usado por procesos en espacio de usuario.
sy: Porcentaje de tiempo de CPU usado por el sistema (procesos del kernel).
id: Porcentaje de tiempo que la CPU está inactiva.
wa: Porcentaje de tiempo que la CPU está esperando operaciones de I/O.
st: Porcentaje de tiempo robado a una máquina virtual por el hipervisor.
----------------------------------------------------------------------------------------------------------------------------
## Laboratorio  Matar un programa zombi
yum install  make gcc  -y
apt install make gcc  -y

Un proceso Zombie es aquel que nunca recibió una señal por parte del proceso padre que lo creo,
un proceso hijo es aquel que tiene su origen en un proceso de nivel superior conocido como proceso padre
que es el encargado de enviar las señales a los procesos hijos generados por el mismo para indicarles
que su lapso de vida ha terminado.

Un proceso zombi es un proceso que ha terminado su ejecución, pero su entrada en la tabla de procesos sigue existiendo porque su proceso padre no ha leído su código de salida mediante una llamada a wait() o waitpid().

1. Escriba el siguiente código en un editor de texto. Asigne al archivo el nombre zombi.c:

cd /root
vi zombi.c

// zombi.c
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
int main(void)
{
pid_t child_pid;
child_pid = fork ();
if (child_pid > 0) {
printf("Proceso padre: Esperar 2 minutos.\n");
sleep(120);
}
else {
printf("Proceso hijo: Salida inmediata.\n");
exit(0);
}
return(0);
}

## Compile con gcc:
gcc zombi.c -o zombi

## Ejecute el programa zombi en segundo plano.
./zombi &

## Dispone de dos minutos. Identifique el PID y el PPID del proceso zombi.

ps -eo uname,pid,ppid,stat,args |grep Z
root 1961 1960 Z [zombi] <defunct>
root 1968 1895 S+ grep Z
El PID es 1961 y el PPID es 1960.

##Elimine el zombi.
Hay que matar el proceso padre:
kill -9 1960

## Verifique.
ps -eo uname,pid,ppid,stat,args |grep Z
root 1974 1895 S+ grep Z

----------------------------------------------------------------------------------------------------------------------------
yum install git -y
apt install git -y

cd /
git clone https://github.com/agarciafer/lpic1.git

cd /lpic1
unzip access_log.zip
du -hs access_log


-----------------------------------------------------------------------------------------------------------------------------
## El término lsof es la abreviatura de LiSt Open Files que como lo indica su nombre lista los archivos abiertos
## El comando lsof le ayuda a determinar  qué proceso está utilizando un archivo del punto de montaje en el momento de iniciar el comando

lsof --help
lsof /backup/
lsof /backup/
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
bash    8153 root  cwd    DIR   8,17     4096    2 /backup


## Ver todos los puertos que estan listando:
 lsof -i -P -n
 
Visualizar los puertos TCP y UDP así como las conexiones activas en el sistema, usando el parámetro -i

# lsof -i
lsof -i |grep sshd

Ver los archivos que esta utilizando un determinado usuario

# lsof -u usuario

Buscar procesos que usan un determinado puerto ej, el puerto 22

# lsof -i TCP:22

Ver archivos abiertos por un proceso o programa concreto

# lsof -c httpd

Mostrar procesos que usan IPv4 o IPV6

# lsof -i 4
# lsof -i 6

Ver archivos abiertos por un rango de puertos

# lsof -i TCP:1-1024
Ejemplo 8
Ver archivos en uso por un usuario, en un directorio o path específico

# lsof -u nksistemas -a +D /bin

## Como administrador, puede iniciar fuser para forzar la parada de los procesos que estén accediendo al punto de montaje.
fuser --help
-a,--all              display unused files too
  -i,--interactive      ask before killing (ignored without -k)
  -k,--kill             kill processes accessing the named file
  -l,--list-signals     list available signal names
  -m,--mount            show all processes using the named filesystems or block device

fuser -km /logs
kill -9 8153





