
#dd

El comando dd (device to device) tiene como misión la copia física, bloque por bloque, de un archivo
periférico hacia un archivo periférico. Al principio se utilizaba para la lectura y escritura
en cinta magnética, pero se puede utilizar también con cualquier archivo.

El comando dd permite realizar copias físicas de discos y sistemas de archivos


##Por lo que si quisiéramos clonar un disco duro:

    dd if=/dev/hda of=/dev/hdb bs=1M con esto clonaríamos el disco hda en hdb. (discos IDE)

O:

    dd if=/dev/sda of=/dev/sdb  bs=1M  #discos SATA
	
	Para crear la imagen .iso de un CD en el directorio /home:

 dd if=/dev/sr0  of=/home/imagendeCD.iso
 
##Crea un fichero vacio de de 2 Gb y dale formato y permisos adecuados para actuar como swap
 
 dd if=/dev/zero of=/swap2gb bs=1M count=2048
---------------------------------------------------------------------------------------------------------------

#Swap

El espacio de memoria de intercambio o Swap, es lo que se conoce como memoria virtual. La diferencia entre la memoria real y la virtual es que está última utiliza espacio en el disco duro en lugar de un módulo de memoria. Cuando la memoria real se agota, el sistema copia parte del contenido de esta directamente en este espacio de memoria de intercambio a fin de poder realizar otras tareas.

En sistemas con gran cantidad de memoria RAM, el uso de swap puede ser innecesario y, en algunos casos, perjudicial para el rendimiento. No hay una regla estricta, pero generalmente se recomienda desactivar swap a partir de los 32/64 GB de RAM en adelante, dependiendo del caso de uso.


#Recomendaciones Generales sobre Swap

Cantidad de RAM	Swap        Recomendada	                                       Notas
0 - 2 GB	                2 veces la RAM	                                   Sistemas con poca memoria requieren swap.
2 - 8 GB	                Igual o 1.5 veces la RAM	                       Uso moderado de swap en cargas ligeras.
8 - 16 GB	                Igual a la RAM	                                   Solo para hibernación o picos de carga.
16 - 32 GB	                4 - 8 GB de swap	                               Útil en servidores de aplicaciones.
64 GB o más	                Desactivada o 4 GB	                               Swap puede ser innecesaria salvo cargas pesadas.

¿Cómo Deshabilitar Swap en Linux?
1. Desactivar Swap Temporalmente
sudo swapoff -a

Desactivar Swap Permanentemente /etc/fstab y comenta (agregando #) la línea que contiene swap

##Casos en los que Swap NO es Recomendado

Servidores con +64GB de RAM: Si la memoria es suficiente, el uso de swap puede ralentizar el sistema.
Bases de Datos (MySQL, PostgreSQL, Oracle, etc.): Estas aplicaciones gestionan su propia memoria y el uso de swap puede afectar su rendimiento.
Clusters Kubernetes o Docker: Swap está deshabilitado por defecto porque afecta la asignación de memoria de los contenedores.
Servidores de Alto Rendimiento: Swap introduce latencia y puede ser contraproducente en aplicaciones críticas.


---------------------------------------------------------------------------------------------------------------

##La particion swap se puede extender a traves de LVM:

lsblk

NAME            MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda               8:0    0  64G  0 disk
├─sda1            8:1    0   1G  0 part /boot
└─sda2            8:2    0  63G  0 part
  ├─centos-root 253:0    0  41G  0 lvm  /
  ├─centos-swap 253:1    0   2G  0 lvm  [SWAP]
  
  

##Ampliar swap a traves de una particion de nuestro disco /dev/sdb con 2GB:

free -h
#Creo la particion /dev/sdb1, la creo  y el tipo 82:
fdisk /de/sdb

#se dará formato como partición de memoria de intercambio
mkswap -c /dev/sdb1

#En el siguiente ejemplo se activa como partición de memoria de intercambio a la partición /dev/sdb1:
swapon /dev/sdb1
free -h

##Desactivo la swap del /dev/sdb1
swapoff /dev/sdb1
free -h

##Persistir la swap en el fstab:
vim /etc/fstab
/dev/sdb1  swap  swap  defaults  0 0

*El comando swapon -s muestra un resumen de todas las áreas de swap activas en el sistema. Es útil para ver qué particiones o archivos de swap están en uso y cuánta memoria de swap está disponible.

swapon -s
---------------------------------------------------------------------------------------------------------------
##Laboratorio Gestionar espacio de memoria de intercambio swap
##En este laboratorio crearemos un archivo llamado swap en el / para extender nuestro swap en 2 GB.

free -h

##Creamos un archivo de 2G
dd if=/dev/zero of=/swap bs=1M count=2048

#dd: Comando para copiar y convertir datos.
if=/dev/zero: Utiliza /dev/zero como archivo de entrada, que es un archivo especial que proporciona bytes de valor cero. 

Básicamente, se están escribiendo ceros en el archivo de destino.
of=/swap: Especifica el archivo de salida donde se va a crear el archivo de swap. En este caso, se llama /swap.
bs=1M: Bloque de escritura de 1 megabyte (MB) por operación.
count=2048: Especifica cuántos bloques de 1 MB se escribirán, lo que da un archivo final de 2048 MB o 2 GB.



##Dar formato al archivo de intercambio:
mkswap /swap
chmod 0600 /swap

##Activar la partición en caliente:
 swapon /swap
 
free -h 
 
##Deactivar la partición en caliente:
 swapoff /swap
 free -h   
 
####NO REALIZAR EN NUESTRO LABORATORIO Añadimos la nueva estrada al archivo /etc/fstab ##NO REALIZAR EN NUESTRO LABORATORIO
 vi /etc/fstab
/swap swap swap defaults 0 0

Comprobamos la memoria swap que tenemos en el sistema:
# free -h |grep -i swap

##Para ver de donde nos viene la swap y la prioridad de las diferenstes dispositivos
swapon -s
cat /proc/swaps

#La salida del comando swapon -s

Filename                                Type            Size    Used    Priority
/dev/sda1                               partition       2151420 0       -2
/swap                                   file            2097148 0       -3

Prioridad: Define la prioridad con la que se usan las áreas de swap. El sistema utiliza áreas de swap con mayor prioridad (números más bajos) primero. En este caso, la partición tiene una prioridad de -2 y el archivo tiene una prioridad de -3, lo que significa que se utilizará la partición /dev/sda1 antes que el archivo /swap.


##Desactivar la partición en caliente:

 swapoff /swap
 free -h 

##Para finalizar el laboratorio eliminamos el archivo /swap para que no nos ocupe espacio
rm -rf /swap


--------------------------------------------------------------------------------------------------------------------------------
##Cambiar con que frecuencia las aplicaciones y programas son movidas de la memoria física hacia la memoria de intercambio

Pueden establecerse valores entre 0 y 100, donde el valor más bajo establece que se utilice menos la memoria de intercambio, lo cual significa que se reclamará en su lugar el caché de la memoria.

cat /proc/sys/vm/swappiness

echo 10 > /proc/sys/vm/swappiness

##Para persistir el valor:
vim /etc/sysctl.conf
vm.swappiness = 10

##Aplicamos los cambios en el fichero /etc/sysctl.conf
sysctl -p


vm.swappiness = 10 – ¿Qué significa y cómo afecta el rendimiento?
El parámetro vm.swappiness en Linux controla cuánto el sistema usa swap en lugar de RAM. Su valor varía entre 0 y 100, donde:

0 → El sistema evita usar swap a menos que sea absolutamente necesario.
10 → Usa swap solo cuando la RAM está casi llena.
30 (valor por defecto en muchas distros) → Usa swap de forma moderada.
100 → El sistema usa swap agresivamente, incluso cuando hay RAM libre.

#¿Qué hace vm.swappiness = 10?

Reduce drásticamente el uso de swap, usándolo solo cuando la memoria RAM está muy baja.
Mejora el rendimiento en servidores al evitar escrituras innecesarias en swap.
Es ideal para sistemas con más de 8 GB de RAM, ya que la RAM puede manejar mejor la carga.
Evita desgaste prematuro en SSDs, ya que minimiza el uso de swap en disco.

-------------------------------------------------------------------------------------------------

##Cambiar la prioridad de escritura de sawp:

cat /etc/fstab 
# /etc/fstab: static file system information.

#/dev/mapper/ubuntu--vg-swap_1 none            swap    sw,pri=90              0       0
#mi_swap
#/swapfile swap swap pri=79 0 0

/dev/mapper/centos-swap swap                    swap    defaults,pri=90        0 0
/swap                     swap                  swap     defaults,pri=60              0 0


#¿Qué significa esto?
/dev/mapper/centos-swap tiene prioridad 90 → Se usará primero para swap.
/swap (archivo de swap) tiene prioridad 60 → Se usará solo cuando la anterior esté llena.

##Para ver de donde nos viene la swap y la prioridad de las diferenstes dispositivos
swapon -s


#Para desactivar la swap en un sistema Linux, puedes usar el siguiente comando:
sudo swapoff -a

-a: Aplica la acción a todas las áreas de swap activas, tanto en particiones como en archivos.
