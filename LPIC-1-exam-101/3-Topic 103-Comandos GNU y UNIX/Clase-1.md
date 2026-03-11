# Clase 1

Apuntes de clase sobre Clase 1, reorganizados para facilitar la consulta rápida y el repaso.

> El Shell y los comandos GNU pagina 112 pdf del manual curso

## Documentacion para el curso LPIC-1 101 y 102

## Referencias

- https://learning.lpi.org/es/

**Comandos internos y externos del shell

## En Linux, los comandos que ejecutas pueden ser de dos tipos:

- Internos (built-ins)
- Externos

La diferencia principal es dónde se ejecutan y cómo están implementados.

1. Comandos internos (built-ins) Son comandos que están integrados dentro del propio shell (por ejemplo, Bash). No son programas independientes en el sistema de archivos. Se ejecutan directamente por el intérprete de comandos.

## Características

No tienen archivo ejecutable en /bin o /usr/bin. Se ejecutan más rápido. Pueden modificar el entorno del shell actual.

## Ejemplos comunes

```bash
cd
echo
pwd
alias
export
```

history exit set unset type

2. Comandos externos Son programas ejecutables que están almacenados en el sistema de archivos. El shell los busca en las rutas definidas en la variable PATH.

## Ejemplo de rutas típicas:

```bash
/bin
/usr/bin
/usr/sbin
```

## Comandos tipicos

```bash
ls
cp
mv
rm
cat
grep
awk
nano
```

## Cómo saber si un comando es interno o externo

type nombre_comando

## Diferencias clave

| Característica          | Interno          | Externo               |
| ----------------------- | ---------------- | --------------------- |
| Ubicación               | Dentro del shell | Archivo en el sistema |
| Modifica entorno actual | Sí               | No directamente       |
| Depende de PATH         | No               | Sí                    |
| Ejemplo                 | cd               | ls                    |

## Comandos de usuario y ubicación:

id: Muestra el ID del usuario y grupos a los que pertenece el usuario actual.

pwd: Muestra el directorio de trabajo actual (ruta completa).

## Comandos de salida de texto:

```bash
echo -n "texto": Imprime el texto sin añadir un salto de línea al final.
echo -e "texto": Activa la interpretación de caracteres especiales (como \n, \t, etc.).
echo -e "salida \n de \t comando": Imprime el texto con un salto de línea (\n) y tabulador (\t).
```

> # Comandos de ayuda y manual: man ls: Muestra la página de manual del comando ls.

ls --help: Muestra una lista breve de opciones y ayuda sobre el uso del comando ls.

```bash
yum install man man-pages mandoc -y
apt install man man-pages mandoc   -y
```

> El comando makewhatis se utiliza en sistemas Linux para generar o actualizar la base de datos que usan los comandos whatis y man -f, permitiendo buscar descripciones rápidas de páginas de manual.

```bash
/usr/share/man -->Paginas de man
```

manpath --> donde se encuentran las paginas del comando man man -f  passwd --> vemos las secciones asociadas

man -f  passwd sslpasswd (1ssl)     - compute password hashes

```bash
passwd (5)           - password file
passwd (1)           - update user's authentication tokens
```

> man -f  passwd - De scripción: Muestra una breve descripción de las secciones del manual donde se menciona el comando passwd

> man -s 5 passwd - Descripción: Muestra la página del manual para passwd en la sección 5, que trata sobre los archivos de configuración relacionados con el comando, en este caso el archivo

> man -s 1 passwd -Descripción: Muestra la página del manual para passwd en la sección 1, que trata sobre los comandos de usuario. Aquí se explica cómo usar el comando passwd para cambiar las contraseñas de usuarios.

## Explicación de las secciones en man:

Sección 1: Comandos ejecutables por el usuario. Sección 5: Archivos de configuración o formato.

ls --help: Muestra la ayuda breve del comando ls con las opciones disponibles.

clear: Limpia la terminal, eliminando el contenido de la pantalla actual.

## Comandos para mostrar usuarios conectados en el sistema:

w: Muestra quién está conectado, qué están haciendo y estadísticas del sistema. who: Muestra quién está conectado al sistema. who am i: Muestra información sobre el usuario actual (quién eres y desde dónde te has conectado). users: Muestra los nombres de los usuarios conectados al sistema. loginctl: Muestra información sobre las sesiones de usuario activas (útil en sistemas con systemd).

## Tener instalado en nuestro linux el paquete bash-completion

```bash
rpm -qa bash-completion
yum install bash-completion
apt install bash-completion
```

tty nos dice en que consola esta un usario tty

El comando echo en Linux se utiliza para imprimir texto o variables en la terminal.

```bash
echo "hola desde la consola1" > /dev/pts/2
```

## wall

El comando wall en Linux se utiliza para enviar un mensaje a todos los usuarios que están conectados al sistema. Es una forma sencilla de difundir un mensaje, generalmente utilizado por los administradores del sistema para advertencias, notificaciones o mensajes importantes.

```bash
echo "Reinicio del servidor en  50 minutos" | wall
```

write root pts/1  --> inicia un chat

## cal

### cal muestra el calendario

cal 2024 --> Calendario todo el año cal 10 2024 -->Muestra el mes de octure del 2024

## Resumen de comandos:

cal: Muestra el calendario del mes actual. cal [año]: Muestra el calendario del año especificado. cal [mes] [año]: Muestra el calendario de un mes y año específicos. cal -y: Muestra el calendario del año actual. cal -3: Muestra el mes actual y los meses anterior y posterior.

El comando date sin argumentos, despliega la fecha en la salida estándar del sistema. El formato de salida se puede especificar precedido por un +. La opción -u es para utilizar la hora universal (Greenwich). El único usuario que puede cambiar la fecha del sistema es root.

```bash
date
date --set "2014-11-13 9:30:01"
date -s "2014-11-13 9:30:01"
date +%D
```

A continuación, se muestra una lista completa de los especificadores de formato que puedes utilizar con el comando date para personalizar la salida:

%a: Nombre abreviado del día de la semana (ej.: "lun"). %A: Nombre completo del día de la semana (ej.: "lunes"). %b: Nombre abreviado del mes (ej.: "ene"). %B: Nombre completo del mes (ej.: "enero"). %c: Fecha y hora completas según la configuración regional. %C: Siglo (los dos primeros dígitos del año, ej.: "20" para 2025). %d: Día del mes con dos dígitos (01-31). %D: Fecha en formato mm/dd/aa (equivalente a %m/%d/%y). %e: Día del mes sin cero a la izquierda (espacio en lugar de cero). %F: Fecha en formato ISO 8601: aaaa-mm-dd (equivalente a %Y-%m-%d). %g: Últimos dos dígitos del año correspondiente a la semana ISO. %G: Año correspondiente a la semana ISO. %h: Equivalente a %b. %H: Hora en formato 24 horas (00-23). %I: Hora en formato 12 horas (01-12). %j: Día del año (001-366). %k: Hora en formato 24 horas sin cero a la izquierda (espacio en lugar de cero). %l: Hora en formato 12 horas sin cero a la izquierda. %m: Mes (01-12). %M: Minutos (00-59). %n: Salto de línea. %N: Nanosegundos (000000000-999999999). %p: Indicador AM/PM en mayúsculas. %P: Indicador am/pm en minúsculas. %r: Hora en formato de 12 horas (equivalente a %I:%M:%S %p). %R: Hora en formato 24 horas con minutos (equivalente a %H:%M). %s: Segundos transcurridos desde 1970-01-01 00:00:00 UTC (Epoch). %S: Segundos (00-60, incluyendo segundos intercalados). %t: Carácter de tabulación. %T: Hora en formato 24 horas con segundos (equivalente a %H:%M:%S). %u: Día de la semana (1-7), donde 1 es lunes. %U: Número de semana del año (00-53), considerando el domingo como primer día de la semana. %V: Número de semana ISO (01-53). %w: Día de la semana (0-6), donde 0 es domingo. %W: Número de semana del año (00-53), considerando el lunes como primer día de la semana. %x: Fecha en formato local. %X: Hora en formato local. %y: Año sin siglo (00-99). %Y: Año completo con siglo (ej.: 2025). %z: Desplazamiento respecto a UTC en formato +hhmm (ej.: -0500). %Z: Zona horaria (ej.: CET, EST). %%: Carácter de porcentaje literal (%).

timedatectl: Muestra y gestiona la fecha, hora y zona horaria del sistema.

```bash
uname --help: Muestra las opciones disponibles para el comando uname.
uname -a: Muestra información completa del kernel, sistema operativo y arquitectura.
uname -r: Muestra la versión del kernel en ejecución.
```

```bash
cat /etc/redhat-release: Muestra la versión de Red Hat si el sistema está basado en Red Hat.
cat /etc/centos-release: Muestra la versión de CentOS.
cat /etc/debian_version: Muestra la versión de Debian si el sistema está basado en Debian.
lsb_release -a: Muestra información detallada sobre la distribución Linux, si el paquete lsb-release está instalado.
cat /etc/*release: Muestra información sobre la distribución Linux (funciona en la mayoría de distribuciones).
```

arch: Muestra la arquitectura del sistema operativo (por ejemplo, x86_64).

history: Muestra el historial de comandos ejecutados en la terminal. history 10: Muestra los últimos 10 comandos ejecutados en la terminal. history -c ##limpia el historial

## Apagar o prender el historial

set +o history #Apaga el historial set -o history #Prende el historial

```bash
/root/.bash_history
/home/usuario1/.bash_history
echo $HISTSIZE ##esta variable contiene el tamaño del historial
```

fc ##Comando asociado al historial que lista, busca, ejecuta fc -l fc -s 120

### history

```
  996  cat mariadb-x86_64.conf
  997  cd /
  998  env
  999  nl /etc/passwd
```

En el shell de Linux se refiere a un comando específico del historial. En este caso, ejecutará el comando número 999 que fue previamente ejecutado en la terminal. !999 !n: Ejecuta el comando número n en el historial de la sesión actual. !!: Repite el último comando ejecutado. !<palabra>: Ejecuta el último comando que empieza con <palabra>. Por ejemplo, !ls ejecutará el último comando que empieza con ls.

## Forma sencilla de averigur que shell actual que se esta ejecutando

```bash
echo $0
```

man ls manpath

man -f passwd man -s 5 passwd

> *El comando apropos en sistemas tipo Unix o Linux se utiliza para buscar páginas de manual (man pages) relacionadas con una palabra clave o un tema. Es especialmente útil cuando no se sabe exactamente el nombre de un comando pero sí se tiene una idea de lo que hace o de la funcionalidad que se busca.

apropos clock man -s 8  hwclock

### info ls

```bash
ls --help
```

El comando mkdir (make directory) se usa para crear carpetas desde la terminal.

```bash
mkdir /directorio
mkdir -p /numeros/pares/dos/cuatro
cd /nombre-directorio
cd ..
cd /
```

## rmdir: Elimina un directorio vacío. rmdir /directorio

rm: Elimina archivos/directorios.

```bash
rm -rf /numeros
rm -ri /numeros
```

## Me cargo todo el sistema, toda la particion / si estoy como root en el sistema:

```bash
rm -rf /  --no-preserve-root
```

ls: Lista archivos/directorios.

```bash
ls -la
ls -lrta
ls -li
ls -ld /directorio
```

```
ls -lrta
Opción    Significado
-l    Formato largo: muestra permisos, propietario, tamaño, fecha, etc.
-r    Reversa el orden de listado (por fecha, nombre, etc.).
-t    Ordena por fecha de modificación, el más reciente primero.
-a    Muestra todos los archivos, incluidos los ocultos (. y .., .bashrc)
```

El comando tree en Linux muestra la estructura de directorios y archivos en forma de un árbol tree -f /directorio

## Comando touch

Crea un archivo vacío, también permite modificar la fecha de acceso y modificación utilizamos touch -a Cambia la fecha de acceso del archivo -m Cambia la fecha de modificación -r archivo Toma la fecha del archivo como referencia -t time Valor de la fecha en decimal. Formato: aaaaMMddHHmm.ss

```bash
touch archivo
touch -m -t 200801112130 fichero
```

El comando stat muestra metadatos completos de un archivo o directorio: tamaño, permisos, propietario, inodos y fechas importantes.stat fichero

```bash
stat archivo.txt
```

Tiempo: Access: cuando se accedió al archivo por ejemplo con el comando cat. Modify: cuando se modifico su contenido. Change: cuando se modifico su contenido o sus permisos, su información.

```
Birth    Fecha y hora de creación del archivo.
```

El comando cp (copy) se usa para copiar archivos y carpetas.

```bash
cp /origen /destino
```

* ?

nombre nombre.ext

```bash
cp --help
cp /etc/*.conf  /datos
cp /etc/?h* /datos
```

## Opciones comunes:

-r: Copia directorios recursivamente. -p: Preserva permisos, tiempos y propietarios. -v: Muestra los archivos que se están copiando. -f: Fuerza la sobrescritura de archivos de destino. -i: Pide confirmación antes de sobrescribir archivos.

El comando stat en Linux se utiliza para mostrar información detallada sobre archivos o directorios, como permisos, tamaño, fechas de modificación y más. Es útil para obtener información de bajo nivel sobre un archivo o directorio.

```bash
stat /etc/passwd
```

## Salida típica de stat:

## La salida incluye información como:

File: Nombre del archivo. Size: Tamaño del archivo en bytes. Blocks: Cantidad de bloques asignados. IO Block: Tamaño de bloque del sistema de archivos. Device: Número del dispositivo. Inode: Número del inode. Links: Número de enlaces al archivo. Access: Permisos del archivo (en formato octal y simbólico). Uid y Gid: Usuario y grupo propietarios del archivo. Access: Fecha y hora del último acceso. Modify: Fecha y hora de la última modificación. Change: Fecha y hora del último cambio en los metadatos del archivo. Birth: Fecha de creación (si está disponible en el sistema de archivos).

## mv  ##mover archivos o cambiar nombre a directorios

## Visualizar el contenido de un archivo:

cat: Muestra el archivo completo.

more: Muestra el archivo por páginas, solo hacia adelante. less: Muestra el archivo por páginas, permite moverse hacia adelante y atrás.

tac: Muestra el archivo en orden inverso, desde la última línea hasta la primera.

El comando file sirve para determinar el tipo de archivo, independientemente de su extensión. Analiza el contenido interno (magic numbers), no solo el nombre. file /etc/passwd

| Opción | Función                           |
| ------ | --------------------------------- |
| `-b`   | Mostrar solo el tipo (sin nombre) |
| `-i`   | Mostrar tipo MIME                 |
| `-z`   | Analizar archivos comprimidos     |

*El tipo MIME (Multipurpose Internet Mail Extensions) es una forma estándar de identificar el tipo de contenido de un archivo

---

> Pagina 130 del manual

El comando find permite buscar archivos dentro de la estructura del sistema de archivos con la ayuda de criterios, y da la posibilidad de actuar sobre los resultados devueltos.

```bash
find
```

```bash
find / -name passwd
 find  / -type f  -name passwd
 find  / -type d  -name passwd
find / -type f -size +100M
```

```bash
find / -type f -size -100M
du -h /lpic1/access_log
```

| Comando  | Muestra            | Qué mide realmente                  |
| -------- | ------------------ | ----------------------------------- |
| `ls -lh` | Tamaño del archivo | Tamaño lógico (bytes del contenido) |
| `du -h`  | Uso en disco       | Bloques ocupados físicamente        |

## Vaciar el archivo, sin borrarlo:

```bash
cat /dev/null >  /lpic1/access_log
```

-atime: busca en la fecha del último acceso (access time). Un acceso puede ser la lectura del archivo, pero también el simple hecho de listarlo de manera específica.

-mtime: busca en la fecha de la última modificación (modification time). Se trata de la modificación del contenido. -ctime: busca en la fecha de modificación (change time, en realidad la fecha de última modificación del número de inodo).

Estos tres criterios sólo trabajan con días (periodos de 24 horas). 0 es el mismo día; 1, ayer; 2, antes de ayer, etc. El valor n colocado después del criterio corresponde, por lo tanto, a n*24 horas. Este rango no es fijo, ya que "ayer" significa entre 24 y 48 horas...

### Los signos + o - permiten precisar los términos "de más" y "de menos":

```bash
find / -type f -mtime 1: archivos modificados ayer  (entre 24 y 48 horas).
```

-mtime -3: archivos modificados hace menos de tres días (72 horas). -atime +4: archivos accedidos hace más de cuatro días (más de 96 horas).

## Para minutos:

-amin -mmin -cmin

```bash
find /etc -type f -mmin -5 ##hace menos de 5 minutos
find / -type f -mmin +60 -mmin -180 #mas de 1 hora y menos de 3
```

adduser martes15

## find /etc -mmin -1 -ls

```bash
find /datos -type f -name "*.mp3" -exec rm -ri {} \;
find /logs -type f -name "logs-2022*" -exec rm -rf {} \;
rm -rf /logs/logs-2022*
```

El criterio -exec va a ejecutar el comando colocado justo después con cada coincidencia encontrada. Es necesario hacer algunas observaciones:

- -exec debe ser obligatoriamente la última opción del comando find.

El comando ejecutado por -exec debe terminarse con un ";" Este carácter especial debe escribirse con \; para que el shell no lo interprete.

- Con el fin de pasar como parámetro para el comando el archivo encontrado por find, hay que escribir {} (sustitución del archivo).

## El criterio -ok es idéntico a la opción -exec, pero, para cada coincidencia, se le requiere una confirmación al usuario.

```bash
find / -type f -name "*.mp3" -ok rm -rf {} \;
```

-ls El criterio muestra información detallada en los archivos encontrados que corresponden al criterio, en lugar del simple nombre de archivo.

```bash
find /var -type f -name *.log  -ls
```

---

## Comandos informacion del sistema operativo

## Comandos de disco y uso de espacio:

```bash
df -hT: Muestra el uso del disco en formato legible por humanos, incluyendo el tipo de sistema de archivos.
du -h fichero: Muestra el tamaño de un archivo en formato legible por humanos.
du -hs /directorio: Muestra el tamaño total de un directorio (de forma resumida) en formato legible por humanos.
du -hs /etc: Muestra el tamaño total del directorio /etc.
```

## Comandos para localizar comandos o archivos:

> whereis halt: Muestra la ubicación de los archivos binarios, de origen y de manual relacionados con el comando halt. which comando: Muestra la ruta completa al ejecutable de un comando, si está en el PATH.

## El comando locate

busca un archivo según el modelo dado en una base de datos de archivos construida por el comando updatedb.

locate archivo.txt locate *.log

## Forzar la actualización de la base de datos:

### sudo updatedb

El comando updatedb recorre una serie de rutas en las que ejecuta un find y almacena todos los resultados en una base indexada. Esto evita, por lo tanto, efectuar de nuevo un find para las búsquedas clásicas. En la práctica, basta con pasarle a updatedb la lista de las rutas o no incluir los archivos en la base indexada

## Comandos de hardware y sistema:

```bash
lspci: Lista todos los dispositivos PCI en el sistema.
lsusb: Lista todos los dispositivos USB conectados.
free -h: Muestra la memoria libre y usada en formato legible por humanos (GB/MB).
free -m: Muestra la memoria libre y usada en megabytes.
```

uptime: Muestra el tiempo que el sistema ha estado encendido, el número de usuarios conectados y la carga del sistema.

## Comandos para obtener información del sistema:

```bash
cat /proc/meminfo: Muestra detalles sobre el uso de la memoria del sistema.
cat /proc/cpuinfo: Muestra información sobre el procesador.
cat /proc/partitions: Lista las particiones de discos.
cat /proc/mounts: Muestra los sistemas de archivos montados actualmente.
cat /proc/swaps: Muestra información sobre las áreas de intercambio (swap) activas.
```

## Comandos para apagar y reiniciar el sistema:

shutdown -h now: Apaga el sistema inmediatamente. shutdown -r: Reinicia el sistema. reboot: Reinicia el sistema (similar a shutdown -r). halt: Detiene el sistema (puede o no apagar el equipo). poweroff: Apaga el sistema (equivalente a shutdown -h now).

shutdown -r +10 "Reinicio para mantenimiento en 10 minutos"

## Cancelar el shutdown

shutdown -c shutdown --help

## En debian y derivados averiguar paquete que instala un comando

```bash
apt-cache search nslookup
```

```bash
sudo apt-get update
sudo apt-get install apt-file
sudo apt-file update
sudo apt-file search nslookup
sudo apt-file list nombre_paquete
```

## Ejemplo:

```bash
apt-file search bin/locate
```

dpkg -S: Se usa para buscar a qué paquete pertenece un archivo ya instalado en el sistema.

## El resultado será algo como:

mlocate: /usr/bin/locate Esto te dice que el comando locate es proporcionado por el paquete mlocate.

## En Redhat y derivados averiguar paquete que instala un comando

```bash
yum provides lspci
dnf provides lspci
```

## Salida del comando anterior

### pciutils-3.5.1-3.el7.x86_64 : PCI bus related utilities

```
Repositorio        : base
```

Resultado obtenido desde: Nombre del archivo    : /usr/sbin/lspci

## Instalo el paquete:

```bash
yum install pciutils -y
```
