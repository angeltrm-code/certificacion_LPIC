# Explicacion Resumen discos Linux

Documento de referencia sobre Explicacion Resumen discos Linux con formato Markdown homogéneo y navegación más clara.

> Pagina 208 Manual del curso PDF

## IDE Los discos con controladores IDE (también llamados PATA, Parallel Ata o ATAPI)

### se llaman hdX:

- hda: IDE0, Master
- hdb: IDE0, Slave
- hdc: IDE1, Master
- hdd: IDE1, Slave

### SCSI, SATA, USB, FIREWIRE, etc.

- sda: primer disco SCSI
- sdb: segundo disco SCSI
- sdc: tercer disco SCSI
- etc. La norma SCSI marca una diferencia entre los diversos soportes. Así, los

lectores de CD-Rom, DVD, HD-DVD, BlueRay y los grabadores asociados no llevan el mismo nombre. Los lectores y grabadores están en srX (sr0, sr1, etc.).

## La mv esta en un hipervisor KVM:

```bash
/dev/vda
/dev/vdb
```

...

## La mv esta en un hipervisor XEM Linux:

```bash
/dev/xvda
/dev/xvdb
```

...

## Averiguar los discos que tiene nuestro servidor:

```bash
cat /proc/partitions
fdisk -l
fdisk -l /dev/sda
```

```bash
lsscsi
```

## lsblk

El comando lsblk (list block devices) en Linux se usa para mostrar una lista de dispositivos de bloques, como discos duros, SSDs, particiones, y unidades USB, en forma de árbol.

```
lsblk -fp
-f    Muestra información del sistema de archivos, como el tipo (xfs, ext4), el UUID, y la etiqueta (LABEL).
-p    Muestra la ruta completa del dispositivo, como /dev/sda1 en lugar de solo sda1.
```

## Visualizar puntos de montaje:

```bash
mount
```

El comando mount se usa para asociar un dispositivo o sistema de archivos a un directorio (punto de montaje) para poder acceder a su contenido.

## findmnt

El comando findmnt en Linux se utiliza para buscar, mostrar o verificar información sobre los sistemas de archivos montados. Es una herramienta poderosa para mostrar la jerarquía de sistemas de archivos y puntos de montaje de una forma clara y organizada. findmnt puede buscar en diferentes orígenes, como el contenido de /etc/fstab, /etc/mtab y /proc/self/mountinfo.

```bash
findmnt
```

## Tipo de particiones para GPT ---> UEFI --> con gdisk

- 8300 : partición de tipo Linux (datos)
- 8200 : partición de tipo swap
- fd00 : partición de tipo RAID
- 8e00 : partición de tipo LVM

## Tipo de particiones MBR --> BIOS-->fdisk

- 83 : partición de tipo Linux (datos)
- 82 : partición de tipo swap
- fd : partición de tipo RAID
- 8e : partición de tipo LVM

## Tabla Comparativa: MBR vs GPT

```
Característica                   MBR (Master Boot Record)                            GPT (GUID Partition Table)
Compatibilidad                  Compatible con BIOS antiguo                        Compatible con UEFI
```

Número máximo de particiones  4 particiones primarias (o 3 primarias + 1 extendida)    Hasta 128 particiones en Windows (más en otros SOs) Tamaño máximo de disco          2 TB                                                     9.4 ZB (Zettabytes) Método de almacenamiento de particiones    Tabla de particiones almacenada en el sector de arranque (512 bytes)    Múltiples copias de la tabla de particiones a lo largo del disco Seguridad y redundancia    No tiene redundancia                           Almacena copias de seguridad de la tabla de particiones Corrección de errores    Sin detección de errores                      Incluye CRC32 para verificar y corregir errores Compatibilidad con sistemas operativos    Windows XP, Vista, 7 (modo BIOS) y Linux    Windows 10/11, macOS, Linux (modo UEFI)

## Explicación Detallada

a) MBR (Master Boot Record) MBR es el esquema de particionado más antiguo, utilizado desde los años 80. Se almacena en el primer sector del disco y contiene información sobre la tabla de particiones y el código de arranque. Limitaciones: Solo soporta 4 particiones primarias. Si se requieren más, se debe usar una partición extendida con particiones lógicas dentro. No permite gestionar discos mayores a 2 TB. No tiene mecanismos de redundancia, por lo que si el MBR se corrompe, el disco puede volverse inservible.

📌 Ejemplo de uso: Discos antiguos, sistemas BIOS heredados.

## GPT (GUID Partition Table)

GPT es la tecnología más moderna, diseñada para reemplazar MBR. Utiliza UEFI en lugar de BIOS para gestionar el arranque. Ventajas principales: Soporta hasta 128 particiones sin necesidad de particiones extendidas. Permite gestionar discos de más de 2 TB. Almacena copias de seguridad de la tabla de particiones en diferentes ubicaciones del disco. Usa sumas de verificación CRC32 para detectar y corregir errores en la tabla de particiones.

📌 Ejemplo de uso: Discos modernos, servidores, almacenamiento masivo, sistemas con UEFI.

¿Cuál elegir? ✅ Usar MBR si: Tienes un sistema antiguo con BIOS. El disco tiene menos de 2 TB. Necesitas compatibilidad con Windows XP o versiones antiguas de Linux.

✅ Usar GPT si: Usas UEFI en lugar de BIOS. El disco tiene más de 2 TB. Necesitas más de 4 particiones primarias.

Quieres mayor seguridad y redundancia en la tabla de particiones.

---

```bash
fdisk -l /dev/sda
```

```
Disk /dev/sda: 68.7 GB, 68719476736 bytes, 134217728 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Identificador del disco: 0x000b294d
```

```
Disposit. Inicio    Comienzo      Fin      Bloques  Id  Sistema
/dev/sda1   *        2048     2099199     1048576   83  Linux
/dev/sda2         2099200   134217727    66059264   8e  Linux LVM
```

## lsblk

El comando lsblk muestra información sobre los dispositivos de bloque en el sistema, como discos duros, particiones, SSDs y dispositivos extraíbles

```bash
lsblk
```

```
NAME            MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda               8:0    0  64G  0 disk
├─sda1            8:1    0   1G  0 part /boot
└─sda2            8:2    0  63G  0 partl
  ├─centos-root 253:0    0  41G  0 lvm  /
  ├─centos-swap 253:1    0   2G  0 lvm  [SWAP]
  └─centos-home 253:2    0  20G  0 lvm  /home
```

NAME: Nombre del dispositivo. MAJ:MIN: Número mayor y menor del dispositivo.

RM: 1 si es extraíble, 0 si no lo es.

SIZE: Tamaño del dispositivo. RO: 1 si es de solo lectura. TYPE: Tipo de dispositivo (disk, part, rom, lvm, etc.). MOUNTPOINT: Punto de montaje del dispositivo.

## parted

parted es una herramienta en Linux utilizada para crear, modificar y administrar particiones de disco. Es compatible con sistemas de particiones GPT y MS-DOS (MBR), permitiendo la creación de particiones sin necesidad de reiniciar el sistema.

## Comandos básicos de parted

```bash
Comando                            Descripción
parted -l                        Lista todos los discos y sus particiones.
parted /dev/sdX print            Muestra la tabla de particiones de un disco específico.
```

mklabel gpt                        Crea una nueva tabla de particiones GPT en el disco. (Borra todos los datos) mklabel msdos                    Crea una tabla de particiones MBR (para BIOS legacy).

```
mkpart                            Crea una nueva partición en el disco.
rm                                Elimina una partición.
resizepart                        Redimensiona una partición existente.
set                                Cambia atributos de la partición (arranque, LVM, swap, etc.).
```

---

## Escanear controladora scsi para detectar disco en caliente:

*Estamos forzando al kernel a reescanear los buses SCSI para detectar nuevos discos sin reiniciar el sistema.

## Se usa cuando:

Añades un disco nuevo en VMware / Proxmox / KVM Expandes un disco virtual Añades almacenamiento SAN Conectas LUNs nuevas ## Los tres valores representan canal, ID de destino SCSI y LUN. ## Los guiones actúan como comodines que significan "volver a escanear todo".

```bash
echo - - - > /sys/class/scsi_host/host0/scan
```

```bash
echo "- - -" | sudo tee /sys/class/scsi_host/host*/scan
```

## Para averiguar en que controladora tengo los discos:

```bash
cat /proc/scsi/scsi
```

## o Utilizar el script para rescanear:

El script rescan-scsi-bus.sh es una herramienta utilizada en sistemas Linux para redetectar discos conectados a un bus SCSI, como SAN, iSCSI, Fibre Channel y discos virtuales en VMware/KVM sin necesidad de reiniciar el sistema.

¿Para qué se usa? Detectar nuevos discos agregados dinámicamente. Redetectar cambios en el tamaño de un disco ya presente. Eliminar dispositivos desconectados. Útil en entornos VMware, KVM, SAN, iSCSI y Fibre Channel.

### rescan-scsi-bus.sh

```bash
dnf provides rescan-scsi-bus.sh
dnf install -y sg3_utils
```

```bash
sudo apt update -y
sudo apt install -y sg3-utils
```

---

```bash
fdisk -l   /dev/sdb
```

## partprobe

El comando partprobe en Linux se utiliza para informar al sistema operativo de los cambios realizados en las tablas de particiones de los discos sin necesidad de reiniciar o desmontar las unidades. Este comando actualiza la información del kernel sobre las particiones de los dispositivos que han sido modificadas, para que el sistema reconozca las nuevas particiones o cambios en las existentes.

### partprobe

¿Qué es un Superbloque en Linux? El superbloque es una estructura clave dentro de un sistema de archivos en Linux y otros sistemas Unix. Contiene metadatos críticos que describen la organización del sistema de archivos en un disco o partición.

## Función del Superbloque

## El superbloque almacena información fundamental sobre el sistema de archivos, como:

Tipo de sistema de archivos (ext2, ext3, ext4, xfs, etc.). Tamaño del sistema de archivos. Cantidad total y disponible de inodos y bloques. Estado del sistema de archivos (montado, desmontado, dañado). Fecha y hora del último montaje y modificación. Ubicación del primer inodo y la estructura de bloques. Opciones de montaje y configuración. Si el superbloque se corrompe, el sistema de archivos puede volverse inaccesible.

## Borrar el superbloque de un disco:

Eliminar Firmas y Superbloques en Linux

## wipefs

El comando wipefs en Linux se usa para eliminar firmas de sistemas de archivos, tablas de particiones y superbloques en discos o particiones. No sobrescribe los datos del disco, pero hace que el sistema no reconozca el formato del disco.

### wipefs -a /dev/sdb

```bash
fdisk -l /dev/sdb
```

```bash
fdisk /dev/sdb
```

## Dar formato a la particion en linux podemo utilizar ext4 o xfs:

```bash
mkfs -t xfs /dev/sdb1
mkfs.xfs /dev/sdb1
```

```bash
mkdir /informes
mount -vvv /dev/sdb1 /informes
df -hT
mount -a
```

```bash
umount /informes
```

```
vi /etc/fstab
/dev/sdb1                       /informes                  xfs     defaults       0 0
/dev/sdc1                       /viernes9                ext4    defaults       0 0
```

```bash
mount /informes
mount /viernes9
mount -a
```

## Montaje por dispositivo a traves del fstab:

```
<dispositivo>   <punto_de_montaje>  <tipo_fs>  <opciones>  <dump>  <fsck>
```

```
vi /etc/fstab
/dev/sdb1               /informes     xfs          defaults  0        0
```

## Explicacion:

```
Campo    Descripción
<dispositivo>    Puede ser /dev/sdX, UUID o LABEL.
<punto_de_montaje>    Ruta donde se montará (ej: /mnt/datos).
<tipo_fs>    Tipo de sistema de archivos (ext4, xfs, vfat, ntfs).
<opciones>    Parámetros de montaje (defaults, noatime, ro, etc.).
<dump>    Si 1, se incluirá en copias con dump; si 0, se ignora.
<fsck>    Orden de chequeo de disco en el arranque (0 = no, 1 = raíz, 2 = otros).
```

## Para comprobar que la linea que creamos en el fstab es correcto:

```bash
mount -a
```

## Explicacion de opciones comunes en /etc/fstab:

```
defaults    Parámetros por defecto (rw, suid, dev, exec, auto, nouser, async).
```

ro / rw    ro (solo lectura), rw (lectura y escritura).

```
noatime    No actualizar el acceso a archivos (mejora rendimiento en SSDs).
nodiratime    Similar a noatime, pero solo en directorios.
async/sync    async (lectura/escritura asíncrona), sync (sincroniza operaciones).
nouser/user    user permite que usuarios monten el sistema.
```

> exec / noexec    exec permite ejecutar archivos binarios, noexec los bloquea. auto / noauto    auto monta automáticamente al inicio, noauto requiere mount manual.

## Ejemplo:

```
/dev/sdb1  /home  ext4  defaults,noexec  0  0
```

## La opcion defaults: Usa opciones predeterminadas de Linux:

rw → Lectura y escritura. suid → Permite ejecutar archivos con setuid/setgid. dev → Permite acceso a dispositivos. exec → Permite ejecución de binarios. auto → Se monta automáticamente en el arranque. nouser → Solo root puede montar. async → Operaciones de lectura/escritura asíncronas.

```bash
mount -o remount,ro /informes
mount -o remount,rw /informes
```

**mount --bind #  Hace que el contenido de /origen aparezca también en /destino. Ambos apuntarán al mismo contenido físico, aunque tengan rutas diferentes.

```bash
mount --bind /origen /destino
```

¿Qué hace exactamente mount --bind? Crea una segunda entrada (alias) al mismo contenido de un directorio (o archivo), sin copiar datos. Ambos caminos (el original y el destino) apuntan a los mismos datos físicos. Los cambios hechos en uno se reflejan en el otro automáticamente.

¿Qué hace exactamente? No copia archivos, solo crea una nueva vista del mismo contenido. Es útil para hacer accesible un directorio desde otro lugar, sin duplicar datos. Cualquier cambio en uno se refleja en el otro.

## Nota:

Este montaje no es persistente tras reiniciar. Para hacerlo persistente, añade esta línea en /etc/fstab:

```bash
/data /backup none bind 0 0
```

## Para desmontarlo:

```bash
umount /destino
```

Solo necesitas desmontar el punto de destino (/backup en este caso), no el origen.

```bash
mount
```

## Usos comunes de --bind:

Dar acceso limitado a un directorio en otro lugar (por ejemplo, dentro de un chroot o contenedor). Montar un subdirectorio como si fuera un punto de montaje independiente. Reorganizar la estructura de directorios sin mover archivos.

---

## Montaje por UUID Cada sistema de archivos dispone de un identificador único llamado UUID que es un sinónimo de GUID en Linux: UUID es un número aleatorio codificado en bits lo suficientemente complejo como para que todos sean diferentes  en uno o varios sistemas dados.

**Averiguar el UUID de una particion podemos utilizar los comandos:

## blkid /dev/sdb1

```bash
/dev/sdb1: UUID="be1671ac-e150-4a1b-84aa-da00070e8a10" TYPE="ext4"
```

```bash
lsblk -f
```

```
vi /etc/fstab
UUID=be1671ac-e150-4a1b-84aa-da00070e8a10               /informes           xfs     defaults 0 0
```

---

*Las unidades de tipo mount en systemd permiten montar automáticamente sistemas de archivos en Linux sin necesidad de modificar /etc/fstab.

¿Cómo funcionan las unidades .mount? Se definen en /etc/systemd/system/ con el sufijo .mount. El nombre del archivo debe coincidir con el punto de montaje, reemplazando / por -

Ejemplo: Para montar /mnt/datos, la unidad debe llamarse mnt-datos.mount. systemd usa mount y umount de forma automática cuando se inicia el sistema o se detiene el servicio.

En systemd, el montaje de sistemas de archivos se gestiona a través de unit files (.mount y .automount). Estos permiten montar dispositivos de manera automática, persistente y bajo demanda.

## Estructura de un archivo .mount

### [Unit]

```conf
Description=Montaje de /mnt/datos
Documentation=man:systemd.mount(5)
Wants=network-online.target
After=network-online.target
```

### [Mount]

```
What=/dev/disk/by-uuid/1234-ABCD  #  Disco o partición a montar (se recomienda usar UUID)
Where=/mnt/datos                  #  Punto de montaje
Type=ext4                          #  Sistema de archivos (ext4, xfs, etc.)
Options=defaults,nofail            #  Opciones de montaje
```

### [Install]

```
WantedBy=multi-user.target         #  Activa el montaje al inicio del sistema
```

```bash
/run/systemd/generator/informes.mount
```

El archivo /etc/fstab (File System Table) es el archivo de configuración que define qué sistemas de archivos deben montarse automáticamente al iniciar Linux.

```bash
vi /etc/fstab
```

```
/dev/sdb1            /informes         xfs     defaults 0 0
```

## Unit tipo mount creada en tiempo de ejecucion desde el /etc/fstab

```bash
/run/systemd/generator/informes.mount
```

### [Unit]

```conf
SourcePath=/etc/fstab
Documentation=man:fstab(5) man:systemd-fstab-generator(8)
Before=local-fs.target
```

### [Mount]

```conf
Where=/informes
What=/dev/disk/by-uuid/63aaf614-860e-4dca-86e8-4bd3672e5cbc
Type=xfs
```

## Crear una unit desde cero, personalizada, el nombre de la unit se tiene que corresponder con el punto de montaje.

```bash
find /run -name "*.mount"
/run/systemd/generator/home.mount
/run/systemd/generator/boot.mount
```

```bash
cat /run/systemd/generator/boot.mount
```

## Automatically generated by systemd-fstab-generator

### [Unit]

```conf
SourcePath=/etc/fstab
Documentation=man:fstab(5) man:systemd-fstab-generator(8)
Before=local-fs.target
```

### [Mount]

```conf
What=/dev/disk/by-uuid/66275011-f541-4e37-a477-6fe07a6a0db3
Where=/boot
Type=xfs
```

## LABORATORIO crar una unit desde cero, personalizada, el nombre de la unit se tiene que corresponder con el punto de montaje.

```bash
vi /etc/systemd/system/informes.mount
```

### [Unit]

```conf
Description=Mount System Backups Directory
```

### [Mount]

```conf
What=/dev/sdb1
```

## by-uuid para el disco /dev/sdb1

## What=/dev/disk/by-uuid/5a2591ba-7009-4949-a0cd-b2792bf80820

```conf
Where=/informes
```

## Where=/cliente1/informes/data

```conf
Type=xfs
Options=defaults
```

### [Install]

```conf
WantedBy=multi-user.target
```

El término by-uuid hace referencia a la forma en que los sistemas Linux pueden identificar particiones de disco mediante su UUID (Universally Unique Identifier). Cada sistema de archivos tiene un UUID único que lo identifica, lo que permite que los sistemas operativos monten y gestionen las particiones de una manera más fiable que utilizando solo los nombres de dispositivos (como /dev/sda1), ya que estos pueden cambiar dependiendo del hardware.

```bash
ls -l /dev/disk/by-uuid
```

```bash
systemctl daemon-reload
systemctl start informes.mount
df -hT
```

```bash
systemctl stop informes.mount
df -hT
```

```bash
systemctl enable informes.mount
systemctl disable informes.mount
```

```bash
systemctl list-units --type mount --all
```

## Archivo /etc/systemd/system/informes.mount con Comentarios y mejorado:

[Unit]

## Descripción de la unidad de montaje

```conf
Description=Mount System Backups Directory
```

## Referencia a la documentación oficial de systemd para mounts

```conf
Documentation=man:systemd.mount(5)
```

Indica que este montaje debe estar disponible después de que la red esté activa. #  Útil si el punto de montaje depende de almacenamiento en red o servicios externos.

```conf
Wants=network-online.target
After=network-online.target
```

[Mount] #  Especifica el dispositivo que se montará. #  Se recomienda usar el UUID del disco en lugar de /dev/sdb1, ya que los nombres de dispositivos pueden cambiar.

```conf
What=/dev/disk/by-uuid/5a2591ba-7009-4949-a0cd-b2792bf80820
```

Punto de montaje en el sistema de archivos donde se accederá a los datos del dispositivo.

```conf
Where=/informes
```

Tipo de sistema de archivos que se montará (en este caso, XFS).

```conf
Type=xfs
```

## Opciones de montaje:

- defaults -> Configuración estándar del sistema (rw, suid, dev, exec, auto, nouser, async).
- nofail -> Evita que el sistema falle al arrancar si el dispositivo no está disponible.
- x-systemd.automount -> Permite automontar cuando se accede a /informes, reduciendo el tiempo de arranque.
- noatime -> Desactiva la actualización del timestamp de acceso a archivos, mejorando el rendimiento en HDD y SSD.

```conf
Options=defaults,nofail,x-systemd.automount,noatime
```

[Install] #  Indica que esta unidad debe activarse en el arranque del sistema para usuarios multiusuario. #  Esto significa que el montaje estará disponible después de que el sistema haya iniciado completamente.

```conf
WantedBy=multi-user.target
```

---

## El comando lsof le ayuda a determinar qué proceso está utilizando un archivo del punto de montaje en el momento de iniciar el comando lsof /backup/

### lsof /backup/

```
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
bash    8153 root  cwd    DIR   8,17     4096    2 /backup
```

Como administrador, puede iniciar fuser para forzar la parada de los procesos que estén accediendo al punto de montaje.

Es más que probable que no le guste nada al usuario correspondiente (en el caso presentado aquí, se parará  su shell y se cerrará la sesión).

## fuser

El comando fuser en Linux se utiliza para identificar los procesos que están utilizando un archivo, directorio o sistema de archivos en particular. Es muy útil cuando quieres saber qué procesos están accediendo a un recurso específico, lo que puede ser necesario antes de desmontar un sistema de archivos o eliminar un archivo que está en uso.

fuser --help fuser -km /backup

kill -9 8153

---

## EXT4 - Sistema de Archivos en Linux

El sistema de archivos EXT4 (Fourth Extended Filesystem) es el más utilizado en distribuciones Linux debido a su fiabilidad, rendimiento y compatibilidad. Es una mejora de EXT3, con nuevas características como journaling mejorado, mayor capacidad de archivos y mejor gestión de fragmentación.

## Características principales de EXT4

✅ Journaling mejorado: Protege contra corrupción de datos en caso de apagado inesperado. ✅ Soporte de archivos grandes: Maneja archivos de hasta 16 TiB y sistemas de archivos de hasta 1 EiB. ✅ Extents: Reduce la fragmentación y mejora el rendimiento. ✅ Desfragmentación en línea: Puede desfragmentarse sin desmontar. ✅ Compatibilidad con EXT2 y EXT3: Puede montar y actualizar sistemas anteriores. ✅ Reducible y expandible: Se puede aumentar y reducir el tamaño del sistema de archivos.

## comando fsck permite comprobar y arreglar un sistema de archivos extendida (ext2 ext3 ext4) ## El sistema de archivos que se quiere comprobar o arreglar no debería estar montado o, como mucho, montado en modo de sólo lectura.

```bash
df -Th
```

-f a fsck para forzar la comprobación -p para intentar una reparación automática -y para forzar las respuestas a sí

```bash
umount /informes
```

### fsck -fpVy /dev/sdb1

```bash
touch /informes/forcefsck
```

```
/dev/sdb1                 4,8G    21M  4,6G   1% /informes
```

## badblocks

El comando badblocks intenta comprobar los bloques defectuosos en el periférico de almacenamiento proporcionado como argumento.

mkfs o fsck pueden llamar a este comando si se les proporciona el parámetro -c (check).

Por defecto, badblocks lee la totalidad de los bloques del soporte y devuelve un error si uno o varios de ellos son ilegibles.

Se puede ejecutar el comando incluso aunque el sistema de archivos esté montado, excepto si usted una prueba en lectura y escritura, incluso no destructiva.

## badblocks -vnf /dev/sdb1

Los parámetros -n (no destructivo) y -w (write, con motivos, destructivo) intentan escribir en los bloques.

## e2label - Change the label on an ext2/ext3/ext4 filesystem

## Ponemos la label  oracledatos al /dev/sdb1

e2label /dev/sdb1  oracledatos

## Para ver la label del dispositivo

### e2label /dev/sdb1

```bash
lsblk -f
```

```
vi /etc/fstab
LABEL=oracledatos     /wwwdata              ext4    defaults       0 0
```

> Para montarlo de forma manual:

```bash
mount -L label_name_here /path/to/mount/point
mount -t ext4 -L oracledatos  /wwwdata
```

To list label name for all partitions or volumes you may try to use blkid command:

## blkid

```bash
/dev/sda5: UUID="f2756986-3749-4bd3-a6e5-f6a867cb4ebb" TYPE="swap"
/dev/sdc1: UUID="60254c19-67c0-404b-9743-1b8b7f0b11cb" TYPE="ext4" LABEL="Boot"
```

e2label /dev/sdb1

## Sistema de archivos XFS

XFS es un sistema de archivos de alto rendimiento diseñado para manejar grandes volúmenes de datos y cargas de trabajo intensivas. Es el sistema de archivos predeterminado en distribuciones como RHEL, CentOS y Rocky Linux.

## Características principales de XFS

✅ Journaling: Mantiene un registro (journal) para evitar corrupción de datos en caso de fallos. ✅ Alta escalabilidad: Soporta volúmenes de hasta 8 exabytes. ✅ Mejor rendimiento en archivos grandes: Más eficiente que ext4 en archivos grandes. ✅ Snapshots y cuota de disco: Soporta cuotas de usuarios y snapshots con xfsdump y xfsrestore. ✅ No se puede reducir (shrink): A diferencia de ext4, no permite reducir su tamaño, solo expandir.

## Creación de sistema de archivos XFS

```bash
mkfs.xfs /dev/sdf1
```

## Agrandar el sistema de archivos a traves de LVM:

Se pude utilizar la opción -D para indicar la cantidad de bloques a utilizar para crecer el sistema de archivos. Ejemplo: xfs_growfs 1048576 -D /dev/sdf1

## Para particiones formateadas a xfs:

Si se trata de un caso donde el sistema inicia en modo de sólo lectura y se requiere reparar sistema de archivos, puede utilizarse xfs_repair con la opción -d. Ejemplo:

### xfs_repair -d /dev/sdf1

## Cabe señalar que xfs_repair carece de capacidad para verificar bloques dañados utilizar el comando badblocks

## El comando badblocks intenta comprobar los bloques defectuosos en el periférico de almacenamiento ## Los parámetros -n (no destructivo) y -w (write, con motivos, destructivo) intentan escribir en los bloques.

badblocks -vn /dev/sdb1

## Asigna una etiqueta al dispositivo de almacenamiento dispositivo formateado a  xfs

xfs_admin -L etiqueta dispositivo xfs_admin -L oracle /dev/sdb1

```bash
mount -L oracle /informes
```

## Para ver la label

```bash
lsblk -f
```

```
vi /etc/fstab
LABEL=oracle    /informes        xfs   defaults       0 0
```

```bash
mount -a
df hT
```

Defragmentación de sistema de archivos.

La defragmentación se puede realizar con toda seguridad con el sistema de archivos activo y montado. Se utiliza la herramienta con la ruta del dispositivo de la partición deseada. Ejemplo:

### xfs_fsr /dev/sdf1

## Respaldo y restauración de sistema de archivos. Al igual que Ext3/Ext4 disponen de dump y restore, XFS dispone de xfsdump y

```bash
xfsrestore. Ambas están diseñadas para funcionar específicamente con unidades de
```

cinta.

## Herramientas de gestión y monitoreo

```
Comando                   Descripción
xfs_admin               Modifica atributos del sistema de archivos XFS, como el UUID y el label.
xfs_info               Muestra información detallada sobre un sistema de archivos XFS montado.
xfs_spaceman           Herramienta interactiva para ver y administrar la asignación de espacio en XFS.
xfs_estimate           Calcula el tamaño necesario para convertir un sistema de archivos a XFS.
```

## Herramientas de expansión y mantenimiento

```
Comando                   Descripción
xfs_growfs               Expande el tamaño de un sistema de archivos XFS montado.
xfs_fsr                   Realiza la desfragmentación de un sistema de archivos XFS.
xfs_freeze               Congela el sistema de archivos (bloquea modificaciones, útil para snapshots).
```

## Herramientas de diagnóstico y reparación

```
Comando                   Descripción
xfs_repair               Repara un sistema de archivos XFS corrupto.
xfs_check              (obsoleto en nuevas versiones)    Verifica la integridad del sistema de archivos.
xfs_db                   Depurador para sistemas de archivos XFS (permite analizar estructuras de datos internas).
xfs_logprint           Muestra el contenido del registro de journaling de XFS.
```

## Herramientas de copia y backup

```
Comando                   Descripción
xfs_copy               Clona un sistema de archivos XFS a otro dispositivo.
xfs_mdrestore           Restaura metadatos de un archivo generado por xfs_metadump.
xfs_metadump           Crea un volcado de metadatos de un sistema de archivos XFS para análisis.
xfs_rtcp               Copia archivos de forma optimizada en sistemas XFS con real-time subvolumes.
```

## Herramientas de cuota y control de espacio

```
Comando                 Descripción
xfs_quota             Administra cuotas de usuarios y grupos en XFS.
xfs_bmap             Muestra la asignación de bloques de un archivo en XFS.
xfs_ncheck             Lista archivos en XFS con sus números de inodo.
```

## Resumen

Mantenimiento y gestión: xfs_admin, xfs_info, xfs_spaceman Expansión y optimización: xfs_growfs, xfs_fsr, xfs_freeze Diagnóstico y reparación: xfs_repair, xfs_db, xfs_logprint Copia y backup: xfs_copy, xfs_metadump, xfs_mdrestore Cuotas y espacio: xfs_quota, xfs_bmap, xfs_ncheck

## tune2fs

> Pagina 250 Manual del curso PDF# #  --> Manual LINUX - Preparación a la certificación LPIC-1.pdf

> Laboratorio Desactivar el fsck automático de los sistemas de ficheros.pdf

El comando tune2fs en Linux se utiliza para ajustar los parámetros y configuraciones de un sistema de archivos ext2, ext3 o ext4. Con tune2fs, puedes modificar las opciones del sistema de archivos sin necesidad de desmontarlo, lo que lo hace útil para tareas de administración de sistemas, como ajustar el intervalo de revisiones del sistema de archivos, habilitar o deshabilitar ciertas características, o cambiar etiquetas.

## Resumen de las opciones más comunes del comando tune2fs:

```
Opción      Descripción
-l          Muestra la información detallada del sistema de archivos.
-c          Establece el número máximo de montajes antes de forzar una revisión (fsck). Usar -1 para deshabilitar la revisión basada en el número de montajes.
-i         Establece el intervalo de tiempo entre revisiones automáticas (fsck). Por ejemplo, 30d para 30 días.   Usar 0 para deshabilitar la revisión periódica.
-L         Cambia la etiqueta (nombre) del sistema de archivos.
-m         Cambia el porcentaje de bloques reservados para el superusuario (root). El valor predeterminado es 5%, pero puedes ajustarlo.
-e        Define qué hacer si se detecta un error en el sistema de archivos (opciones: continue, remount-ro, o panic).
-O        Habilita o deshabilita características específicas del sistema de archivos, como has_journal (registro de cambios).
-r        Establece el número de bloques reservados para el superusuario.
-T        Cambia la fecha del último chequeo del sistema de archivos.
-U        Cambia el UUID del sistema de archivos.
```

## Ver información del sistema de archivos ext4:

sudo tune2fs -l /dev/sdc1

## Establecer el número máximo de montajes antes de fsck:

sudo tune2fs -c 20 /dev/sdc1 tune2fs -l /dev/sdc1 | grep -E Mount\|Max

## Cambiar el intervalo de revisión automática a cada 30 días:

sudo tune2fs -i 30d /dev/sdc1

## Cambiar la etiqueta (nombre) del sistema de archivos:

sudo tune2fs -L "MI_DISCO" /dev/sdc1

## Cambiar el porcentaje de bloques reservados al superusuario:

sudo tune2fs -m 2 /dev/sdc1

## Btrfs

Btrfs (B-tree File System) es un sistema de archivos moderno para Linux diseñado para ofrecer alta confiabilidad, escalabilidad y administración avanzada de almacenamiento. Fue desarrollado por Oracle y es utilizado en distribuciones como SUSE Linux Enterprise Server (SLES), openSUSE y Fedora.

## Principales objetivos de Btrfs:

Autocorrección de errores y checksums en datos y metadatos. Snapshots y subvolúmenes para backups instantáneos. Soporte de RAID integrado sin necesidad de LVM o herramientas externas. Compresión transparente para reducir el uso de espacio. Redimensionamiento en vivo sin desmontar el sistema de archivos

## Características principales de Btrfs

```
Característica                Descripción
Snapshots                    Permite crear instantáneas del sistema sin duplicar datos.
Subvolúmenes                Cada directorio puede ser tratado como un volumen independiente.
```

RAID nativo                    Soporte para RAID 0, 1, 5, 6, 10 sin usar un gestor externo.

```
Compresión                    Opciones como ZSTD, LZO y ZLIB para optimizar el espacio.
Autocorrección                Detección y reparación de corrupción de datos con checksums CRC32.
```

Redimensionamiento en vivo  Expansión o reducción del sistema sin desmontarlo.

¿Se puede usar Btrfs en producción con Red Hat Enterprise Linux (RHEL)? Btrfs no está soportado oficialmente en Red Hat Enterprise Linux (RHEL) desde RHEL 8 en adelante. Red Hat eliminó el soporte de Btrfs en RHEL 7.4 y versiones posteriores, y no lo incluyó en RHEL 8 y RHEL 9.

Btrfs está soportado oficialmente por SUSE Linux Enterprise Server (SLES) y openSUSE. De hecho, SUSE ha sido uno de los principales promotores de Btrfs y lo usa como sistema de archivos predeterminado en algunas versiones de SLES y openSUSE.

---

## Laboratorio Respaldo y restauración de sistema de archivos xfsdump y xfsrestore para xfs:

Los comandos xfsdump y xfsrestore son herramientas utilizadas en sistemas de archivos XFS para realizar copias de seguridad y restauración de datos.

```bash
xfsdump: Realiza copias de seguridad incrementales o completas de un sistema de archivos XFS.
xfsrestore: Restaura datos desde un archivo de respaldo generado con xfsdump.
```

```
df -hT
S.ficheros              Tipo     Tamaño Usados  Disp Uso% Montado en
/dev/sdb1               xfs        5,0G    33M  5,0G   1% /informes
```

## Comprobamos y instalamos el software:

```bash
rpm -qa xfsdump
yum install xfsdump -y
```

## Creamos la particion y formateamos y la montamos

```bash
fdisk /dev/sdb
mkfs.xfs /dev/sdb1
mount /dev/sdb1 /informes
```

## Particionamos el /dev/sdb1 y lo monto en /informes

```bash
cp /etc/*.conf /informes
touch /informes/lunes02
```

## Realizo el backup de la particion /dev/sdb1 en un fichero en /cs

```bash
xfsdump -f /cs /dev/sdb1
```

```bash
rm -rf /informes/*
```

```bash
xfsrestore -f /cs /informes
ls -l /informes
```

## Con este comando podemos ver lo que tenemos en la copia, y restaurar los archivos de uno en uno si es necesario -i interactiva:

## Para este laboratorio utilizaremos el archivo lunes02

```bash
rm -rf /informes/lunes02
```

## Comenzamos la restauracion solo del archivo lunes02

```bash
xfsrestore -f /cs -i -v silent /informes
```

-> ls -> add lunes02 -> extract

## Comprobamos que se ha restaurado:

## ls -l /informes/lunes02

---

## Particionamos el /dev/sdc1 y lo monto en /informes-respaldo

```bash
xfsrestore -f /cs /informes-respaldo
```
