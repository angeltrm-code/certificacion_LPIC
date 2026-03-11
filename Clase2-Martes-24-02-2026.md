# Clase 2 Martes 24 02 2026

Apuntes de clase sobre Clase 2 Martes 24 02 2026, reorganizados para facilitar la consulta rápida y el repaso.

Martes 24/02/2026

## Referencias

- https://www.lpi.org/es/our-certifications/lpic-1-overview

## Materiales publicos de LPIC:

- https://learning.lpi.org/es/learning-materials/learning-materials/

Profesor/a Titular: Alberto Garcia agarciaf@outlook.es

---

## En esta clase veremos:

> Material Alumnos LPIC-1-2026\LPIC-1-exam-101\1-Topic 101-Arquitectura del Sistema ResumenTopic101-Arquitectura de Sistemas.txt Laboratorio modulos kernel.txt Tema 101 Arquitectura del Sistema.pdf 2-Recopilación de información de hardware.pdf ResumenTopic101-Arquitectura de Sistemas.txt

Material Alumnos LPIC-1-2026\LPIC-1-exam-101\1-Topic 101-Arquitectura del Sistema\Servicios del sistema Resumen System-V.txt

Material Alumnos LPIC-1-2026\LPIC-1-exam-101\1-Topic 101-Arquitectura del Sistema\Servicios del sistema\SystemD Resumen Clase SystemD.txt

## Comandos basicos:

> \Material Alumnos LPIC-1-2026\LPIC-1-exam-101\3-Topic 103-Comandos GNU y UNIX Comandos-Basicos-linux.pdf Clase-1.txt

Material Alumnos LPIC-1-2023\LPIC-1-exam-101\1-Topic 101-Arquitectura del Sistema\Gestion de Ficheros Clase-2.txt

Puede utilizar chattr para cambiar los atributos de los sistemas de archivos ext2,ext3 y ext4 como xfs. Desde cierto punto de vista, es análogo a chmod, pero con diferente sintaxis y opciones. Utilizado adecuadamente, dificulta las acciones en el sistema de archivos por parte de un intruso que haya logrado suficientes privilegios en un sistema.

chattr i a

+ - =

### chattr [-RV] +-=[AacDdijsSu] [-v versión] archivos

Agregue el atributo inmutable al archivo algo.txt ejecutando lo siguiente: chattr +i algo.txt

Verifique que se ha establecido dicho atributo ejecutando lsattr utilizando algo.txt como argumento:

### lsattr algo.txt

chattr +a fichero ¿Qué hace exactamente? Cuando en un archivo se le aplica +a: Solo puede ser modificado añadiendo datos al final del archivo (modo append). No se puede truncar, sobrescribir, renombrar ni eliminar su contenido. Incluso el usuario root no puede modificar el archivo salvo para agregar líneas

## Atributos comunes:

```
Letra    Nombre    Descripción
a    append-only    Solo permite agregar datos al final. Útil para archivos de log.
i    immutable    Inmutable. No puede ser modificado, renombrado ni eliminado.
d    no dump    Excluye el archivo de respaldos con dump.
u    undeletable    Si se borra, el contenido puede recuperarse (no siempre funciona).
c    compressed    Comprime automáticamente el contenido (en sistemas de archivos que lo soportan).
s    secure deletion    Elimina con sobrescritura (solo si el FS lo implementa).
t    no tail-merging    Desactiva la optimización de bloques compartidos.
e    extent format    Indica que usa el formato extent (solo lectura).
j    data journaling    Todo se escribe primero en el journal (si el FS lo permite).
```

---

## El Shell y los comandos GNU

> Manual LINUX - Preparación a la certificación LPIC-1.pdf -->Pagina 112

## Enlaces simbólicos (soft / symbolic links)

> \Material Alumnos LPIC-1-2023\LPIC-1-exam-101\3-Topic 103-Comandos GNU y UNIX Diferencias entre enlaces simbolicos.pdf

### ln -s test enlace-a-test

Enlaces duros (hard links) ln test enlace-duro-test

## Diferencias entre soft y hard links

 Los enlaces simbólicos se pueden hacer con ficheros y directorios mientras que los duros solo entre ficheros.  Los enlaces simbólicos se pueden hacer entre distintos sistemas de ficheros, los duros no.  Los enlaces duros comparten el número de inodo, los simbólicos no.  En los enlaces simbólicos si se borra el fichero o directorio original, la información se pierde, en los duros no.  Los enlaces duros son copias exactas del fichero mientras que los simbólicos son meros punteros o “accesos directos”.

---

## Comando para ver datos de las tarjetas de red:

```bash
netstat -i
```

## Refrescamos el comanado con watch

watch netstat -i

## Refrescamos el comanado con watch cada 5 segundos

watch -n 5 netstat -i

---

## Averiguar que paquete me instala un comando que no tenga en mi linux:

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

```bash
sudo apt install  -y nombre_paquete
```

## En Redhat y derivados averiguar paquete que instala un comando

```bash
yum provides lspci
dnf provides lspci
```

## El comando anterior da esta salida:

### pciutils-3.5.1-3.el7.x86_64 : PCI bus related utilities

```
Repositorio        : @base
```

Resultado obtenido desde: Nombre del archivo    : /usr/sbin/lspci

## Instalo el programa:

```bash
yum install -y pciutils-3.5.1-3.el7.x86_64
```

dmesg es un comando de Linux que se utiliza para examinar o controlar la información

mas reciente que se genera sobre el sistema. El programa ayuda a los usuarios a imprimir los mensajes de arranque.

```bash
dmesg
```

```bash
cat /var/log/dmesg
```

## El comando lshw muestra el hardware. Obtiene su información de varias fuentes:

- El archivo pci.ids. Es un registro público de todos los ID (identificaciones)

conocidos que son utilizados por los dispositivos PCI. Se ubica en la carpeta /usr/share/hwdata o

```bash
/usr/share/misc según la distribución de Linux.
```

- Los archivos /proc/bus/pci, /proc/ide, /proc/scsi /dev/sg*, /dev/CPU, /proc/device-tree, /proc/bus/usb, /sys/*.

lshw > /tmp/informe-hardware

---

## Conectarme a traves del cliente ssh de Windows abrimos un cmd:

## Maquina rockylinux:

```bash
ssh root@192.168.33.10
```

## Maquina debian12:

```bash
ssh vagrant@192.168.33.11
```

## Para trabajar como root en la mv de debian:

### sudo -i

Qué es sosreport? Es una herramienta de diagnóstico y soporte que recopila información completa de un sistema Linux: Versión del sistema, kernel, módulos. Configuración de red. Configuración de almacenamiento (LVM, RAID, discos, particiones). Servicios (systemd, logs de journald, configuraciones de daemons). Hardware detectado. Archivos de configuración relevantes.

El objetivo principal es generar un paquete comprimido que puede enviarse al soporte técnico (ej. Red Hat, SUSE, Oracle) para analizar problemas.

## Lo desempaquetamos y descomprimimos en /opt

```bash
tar xvfJ /var/tmp/sosreport-rockylinux8-2026-09-23-dgdodcn.tar.xz -C /opt
```
