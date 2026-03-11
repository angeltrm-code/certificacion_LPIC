# ResumenTopic 101 Arquitectura de Sistemas

Resumen de estudio sobre ResumenTopic 101 Arquitectura de Sistemas con jerarquía Markdown consistente y bloques técnicos normalizados.

> Resumen del pdf Tema 101 Arquitectura del Sistema.pdf

## Comparación y resumen:

/sys/ es el sistema de archivos donde se expone la configuración y el estado de los dispositivos y el kernel.

/proc/ es el sistema de archivos que proporciona acceso a información del kernel y de los procesos, en tiempo real y permite ajuste de parametros.

```bash
/dev/ contiene archivos de dispositivo que permiten la interacción con el hardware y los dispositivos del sistema.
```

Estos directorios son cruciales para la administración de sistemas y proporcionan interfaces muy poderosas para la gestión de procesos, hardware, y recursos del sistema.

```bash
/dev/fd0 --> disquetera en linux
/dev/hda --> Controladoras de disco IDE
/dev/sda -->disco controladoras scsi
/dev/sr0 -->dvd scsci
```

### eth0 --> interfaz de red

El comando dmesg en Linux muestra los mensajes del buffer del kernel, incluyendo información sobre hardware, dispositivos, errores y eventos del sistema. Para ejecutarlo en una terminal:

```bash
dmesg
dmesg --level=err
dmesg -T
```

### -T → convierte las marcas de tiempo (timestamps) a formato legible

```bash
cat /var/log/dmesg
su -
```

### id

```conf
uid=0(root) gid=0(root) groups=0(root)
```

El comando lspci muestra más detalles sobre un dispositivo específico si su dirección se proporciona con la opción -s, acompañada de la opción -v:

```bash
yum install -y pciutils
```

```bash
lspci --help
```

```bash
lspci
```

00:03.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 02)

```bash
lspci -s 00:03.0 -v
```

La opción -k, disponible en versiones más recientes de lspci, proporciona otra forma de verificar qué módulo del núcleo del sistema operativo está en uso para el dispositivo especificado

```bash
lspci -s 00:03.0 -k
```

00:03.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 02) Subsystem: Intel Corporation PRO/1000 MT Desktop Adapter Kernel driver in use: e1000 Kernel modules: e1000

## lsusb

El comando lsusb muestra los canales USB disponibles y los dispositivos conectados a ellos. Al igual que con lspci, la opción -v muestra una salida más detallada.

Se puede seleccionar un dispositivo específico para inspección proporcionando su ID a la opción -d:

```bash
lsusb -v -d 1781:0c9f
```

Con la opción -t, el comando lsusb muestra las asignaciones actuales de los dispositivos USB en forma de árbol jerárquico

```bash
lsusb -t
```

Para verificar qué dispositivo está utilizando el módulo lsusb, presente en la lista anterior, los números Bus y Dev deben asignarse a la opción -s del comando lsusb:

## lsusb -s 01:20

## Si no tenemos los comandos lo consultamos en nuestos linux que paquete instala el comando:

### Redhat/derivados

```bash
yum provides /*lsusb
yum install usbutils -y
```

Para verificar qué dispositivo está utilizando el módulo btusb, presente en la lista anterior, los números Bus y Dev deben asignarse a la opción -s del comando lsusb

## Para consultar comando que paquete nos lo instala.... en debian/derivados

```bash
sudo apt-get update
sudo apt install apt-file
sudo apt-file search lspci
sudo apt-file update
sudo apt-file search lspci
sudo apt-get install nombre-paquete
```

Los comandos lspci,lsusb y lsmod actúan como interfaz para leer la información del dispositivo almacenada por el sistema operativo. Este tipo de información se guarda en archivos especiales en los directorios /proc y /sys. Estos directorios son puntos de montaje para sistemas de archivos que no están presentes en una partición de dispositivo, sino solo en el espacio RAM utilizado por el núcleo del sistema operativo para almacenar la configuración en tiempo de ejecución y la información sobre los procesos en ejecución.

Dichos sistemas de archivos no están destinados al almacenamiento convencional de archivos, por lo que se denominan pseudo-sistemas de archivos y solo existen mientras el sistema se está ejecutando

## Los Modulos del kernel

Los módulos tienen un papel primordial ya que muchas de las funcionas básicas se gestionan en forma de módulos. Si un kernel no dispone de los módulos necesarios para el funcionamiento del sistema, las funciones simplemente no estarán disponibles.

Los módulos son archivos con extensión .ko que se cargan en memoria en función de las necesidades. Existen a nuestra disposición una serie de comandos que permiten listar los módulos cargados, retirarlos de memoria o cargar otros nuevos.

Los kernels de la versiones antiguas (2.4), usan archivos de módulos con la extensión ".o".

```bash
uname -r
```

### 3.10.0-1160.15.2.el7.x86_64

Los módulos están presentes en /lib/modules/$(uname -r)

## Trabajar con modulos del kernel:

### Visualización de módulos cargados en memoria:

```bash
lsmod
```

## modinfo

## El comando modinfo provee toda la información necesaria sobre un modulo:

- El nombre del fichero correspondiente
- una descripción del modulo
- su autor
- su licencia
- sus dependencias
- sus parámetros
- sus alias

```bash
modinfo vfat
modinfo fat
```

## El comando insmod carga un modulo dado sin gestionar las dependencias

```bash
insmod /lib/modules/2.6.18-8.el5/kernel/fs/fat/fat.ko
insmod  /lib/modules/2.6.18-8.el5/kernel/fs/vfat/vfat.ko
```

## El comando rmmod descarga el modulo dado quitarlo de la memoria. Se trata del contrario de insmod y, al ## igual que este rmmod no gestiona las dependencias.

```bash
rmmod /lib/modules/2.6.18-8.el5/kernel/fs/vfat/vfat.ko
rmmod /lib/modules/2.6.18-8.el5/kernel/fs/fat/fat.ko
```

## lsmod |grep -i vfat

## El comando modprobe carga el modulo dado, así como todas sus dependencias

-r permite descargar un modulo y los que dependen de el (si no están en uso).

## modprobe vfat

## modprobe -r  vfat

## lsmod |grep -i vfat

Los comandos lspci,lsusb y lsmod actúan como interfaz para leer la información del dispositivo almacenada por el sistema operativo.

Este tipo de información se guarda en archivos especiales en los directorios /proc y /sys. Estos directorios son puntos de montaje para sistemas de archivos que no están presentes en una partición de dispositivo,sino solo en el espacio RAM utilizado por el núcleo del sistema operativo para almacenar la configuración en tiempo de ejecución y la información sobre los procesos en ejecución.

Dichos sistemas de archivos no están destinados al almacenamiento convencional de archivos, por lo que se denominan pseudo-sistemas de archivos y solo existen mientras el sistema se está ejecutando.

El directorio /proc contiene archivos con información sobre procesos en ejecución y recursos de hardware. Algunos de los archivos importantes en /proc para inspeccionar el hardware son:

```bash
/proc/cpuinfo
```

Enumera información detallada sobre las CPU encontradas por el sistema operativo.

```bash
/proc/interrupts
```

Una lista de números de las interrupciones por dispositivo de entrada/salida para cada CPU.

Los archivos dentro del directorio /sys tienen roles similares a los de /proc. Sin embargo, el directorio /sys tiene el propósito específico de almacenar información del dispositivo y datos del núcleo del sistema operativo relacionados con el dispositivo, mientras que /proc también contiene información sobre varias estructuras de datos  del núcleo del sistema operativo, incluidos los procesos en ejecución y la configuración.

Otro directorio directamente relacionado con dispositivos en un sistema Linux estándar es /dev. Cada archivo dentro de /dev está asociado con un dispositivo del sistema, particularmente dispositivos de almacenamiento.

Un disco duro IDE heredado, por ejemplo, cuando está conectado al primer canal IDE de la placa base, está representado  por el archivo /dev/hda. Cada partición en este disco será identificada por /dev/hda1,/dev/hda2 hasta la última partición encontrada.

```bash
/dev/fd0 --> disquetera
/dev/sda --> discos scsi
/dev/sr0  -->nomenclatura para dispositivos scsi para cd dvd...
```

```bash
cat /proc/sys/net/ipv4/icmp_echo_ignore_all
```

Reemplace 0 por 1 con echo:

## echo "1" > icmp_echo_ignore_all

## echo "0" > icmp_echo_ignore_all

```bash
echo "0" > /proc/sys/net/ipv4/icmp_echo_ignore_all
echo "1" > /proc/sys/net/ipv4/icmp_echo_ignore_all
```

La configuración net.ipv4.ip_forward = 1 es un parámetro del sistema en Linux que habilita el reenvío de paquetes IP entre interfaces de red. Esto convierte al sistema en un router o gateway, permitiendo que los paquetes IP sean reenviados entre diferentes interfaces de red (como entre una red local y una red externa).

## Habilitar el forward de los paquetes de red (habilar un router en linux)

```bash
vi  /etc/sysctl.conf
net.ipv4.ip_forward = 1
icmp_echo_ignore_all = 1
```

## Para aplicar los cambios en el sistema:

Al ejecutar sysctl -p, el sistema lee el archivo /etc/sysctl.conf y establece los valores de los parámetros especificados. sysctl -p

### El comando lshw muestra el hardware. Obtiene su información de varias fuentes:

- El archivo pci.ids. Es un registro público de todos los ID (identificaciones) conocidos que son utilizados por los dispositivos PCI. Se ubica en la carpeta /usr/share/hwdata o /usr/share/misc según la distribución de Linux.
- Los archivos /proc/bus/pci, /proc/ide, /proc/scsi /dev/sg*, /dev/CPU, /proc/device-tree, /proc/bus/usb, /sys/*.

## lshw –versión

Para conocer la lista de clases, escribimos en un terminal:

## lshw -businfo

La clase system de lshw recopilará la información del equipo en el que estamos trabajando:

## lshw -c system

Con la clase processor de lshw obtendremos también algunos datos:

## lshw -c processor

También contamos con la clase memory de lshw, que muestra las características de la memoria caché y los bancos de memoria:

## lshw -c memory

Para identificar la tarjeta gráfica, utilizamos lshw con la clase video:

## lshw -c video

La clase storage del comando lshw muestra información sobre los controladores de disco:

## lshw -c storage

La clase disk del comando lshw muestra información de los discos duros y lectores de CD o DVD:

## lshw -c disk

La clase volume del comando lshw muestra información de los volúmenes y de los sistemas de archivo utilizados:

## lshw -c volume

La clase network del comando lshw muestra información sobre las interfaces de red:

## lshw -c network
