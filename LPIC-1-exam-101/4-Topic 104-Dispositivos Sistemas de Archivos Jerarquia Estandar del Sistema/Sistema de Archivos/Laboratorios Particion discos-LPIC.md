# Laboratorios Particion discos LPIC

Documento práctico sobre Laboratorios Particion discos LPIC. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Mv de virtualbox

```bash
/dev/sdb
/dev/vdb -->En las mv de KVM
```

## Crear una particion /dev/sdb1

### formatearla a xfs

### Montarla en el directorio /informes

## En Debian y derivados:

```bash
sudo apt update
sudo apt install xfsprogs
```

## Averiguar como se llaman los discos en nuestro equipo

```bash
cat /proc/partitions
fdisk -l
lsscsi
lsblk
```

## Averiguar info del disco, que temaño tiene

```bash
fdisk -l /dev/sdb
```

## Comenzamos a particionar, creamos la particion /dev/sdb1 y la guardamos y salimos del fdisk:

```bash
fdisk /dev/sdb
```

## Lo formateamos a xfs, con el siguiente comando:

```bash
mkfs.xfs /dev/sdb1
```

## Creamos el directorio informes

```bash
mkdir /informes
```

## Montamos la particion en /infomes:

```bash
systemctl daemon-reload
mount /dev/sdb1  /informes
```

```bash
df -hT
```

## Copiamos archivos en /informes

```bash
cp /etc/*.conf /informes
ls -l /informes
```

## Para persistirlo en el /etc/fstab, para que en el arranque este la particion montada:

```bash
umount /informes
```

```bash
df -hT
```

## Persistir el punto de montaje /informes al inicio del servidor:

## Utilizar el mcedit instalandos el mc --> dnf install mc -y

```bash
vi /etc/fstab
```

## Al final del archivo /etc/fstab añadimos la line para persistir nuestra particion

```bash
vi /etc/fstab
```

```
/dev/sdb1             /informes        xfs     defaults 0 0
```

## Ejemplo NO REALIZAR EN NUESTRO LABORATORIO:

```
/dev/sdc1             /tmp       xfs    rw,nodev,nosuid,noexec  0 0
```

## Probamos el punto de montaje:

```bash
mount -a
df -hT
```

---

## Montar particion a traves de  UUID estamos utilizando la particion  /dev/sdb1 del disco /dev/sdb

## Ejemplo obtenemos el UUID:

### blkid /dev/sdb1

```bash
/dev/sdb1: UUID="be1671ac-e150-4a1b-84aa-da00070e8a10" TYPE="xfs"
```

```bash
umount /infomes
df -hT
```

## Montaje por dispositivo por UUID, sustituimos el /dev/sdb1 por el UUID obtenido anteriormente:

```
vi /etc/fstab
UUID=be1671ac-e150-4a1b-84aa-da00070e8a10               /informes     xfs          defaults         0 0
```

## Comprobamos que todo esta correcto en el /etc/fstab:

```bash
mount -a
df -hT
```

---

## Laboratorio utilizando el disco /dev/sdc en este ejemplo los discos son de 10G

```bash
/dev/sdc1 --> 5Gb formateado a xfs y montados en /uno
/dev/sdc2 --> 5Gb formateado a ext4 y montados en /dos
```

Persistirlo en el /etc/fstab.

## Para ver el tamaño de nuestro diso /dev/sdc

```bash
fdisk -l /dev/sdc
```

## Creamos la primera particion a nuestro disco /dev/sdc

```bash
fdisk /dev/sdc
```

dev/sdc1

## Formateamos a xfs la particion /dev/sdc1

```bash
mkfs.xfs /dev/sdc1
mkdir /uno
mount /dev/sdc1  /uno
```

## Copiamos archivos:

```bash
cp /etc/*.conf /uno
ls -l /uno
df -hT
```

## Lo desmontamos para persistirlo en el /etc/fstab:

```bash
umount /uno
df -h
```

## Persistir el punto de montaje /dev/sdc1 al inicio del servidor, añadimos la linea al final del arhivo:

```bash
vi /etc/fstab
```

```
/dev/sdc1             /uno        xfs     defaults 0 0
```

## Lo montamos desde la linea de comandos, para comprobar que la entrada en el /etc/fstab esta correcta:

```bash
mount -a
df -h
```

---

## Ahora la particion  /dev/sdc2 --> 5Gb formateado a ext4 y montados en /dos

## Creo la particion /dev/sdc2, con el espacio restantante del disco:

```bash
fdisk /dev/sdc
/dev/sdc2
```

## La formateamos a ext4:

```bash
mkfs.ext4 /dev/sdc2
mkdir /dos
mount /dev/sdc2  /dos
df -hT
```

```bash
cp /etc/*.conf /dos
ls -l /dos
```

## La desmontamos para persistirla en el /etc/fstab:

```bash
umount /dos
df -h
```

## Persistir el punto de montaje /dev/sdc2 al inicio del servidor, añadimos la linea al final del arhivo:

```bash
vi /etc/fstab
```

```
/dev/sdc2             /dos        ext4    defaults 0 0
```

## Lo montamos desde la linea de comandos, para comprobar que la entrada en el /etc/fstab esta correcta:

```bash
mount -a
df -h
```

---

## Resultados final de los laboratorios de almacenamiento:

```
vi /etc/fstab
/dev/sdb1             /informes       xfs    defaults 0 0
/dev/sdc1             /uno        xfs    defaults 0 0
/dev/sdc2             /dos        ext4    defaults 0 0
```

---

## LABORATORIO crar una unit desde cero, personalizada, el nombre de la unit se tiene que corresponder con el punto de montaje.

### Utilizaremos el disco /dev/sdb y crearemos una particion a todos el disco duro, /dev/sdb1

## wipefs detecta y elimina firmas o metadatos de sistemas de archivos (ext4, xfs, btrfs…), RAID (mdadm), LVM, particiones, etc.

- La opción -a (--all) ordena eliminar todas las firmas encontradas.
- Esto NO sobrescribe todo el disco, pero sí borra la información necesaria para que el sistema lo reconozca como un sistema de archivos o un volumen válido.

### wipefs -a /dev/sdb

```bash
fdisk -l /dev/sdb
```

## Crear una particion /dev/sdb1 formatearla a xfs

## Montarla en el directorio /logs

## Averiguar como se llaman los discos en nuestro equipo

```bash
cat /proc/partitions
fdisk -l
lsscsi
lsblk
```

## Comenzamos a particionar, creamos la particion /dev/sdb1 y la guardamos y salimos del fdisk:

```bash
fdisk /dev/sdb
```

## Lo formateamos a xfs, con el siguiente comando:

```bash
mkfs.xfs /dev/sdb1
```

## Creamos el directorio informes

```bash
mkdir /logs
```

## Montamos la particion en /infomes:

```bash
systemctl daemon-reload
mount /dev/sdb1  /logs
```

```bash
df -hT
```

## Lo dejaremos desmontado:

```bash
umount /logs
```

## Ahora nos creamos una unit de tipo mount:

```bash
vi /etc/systemd/system/logs.mount
```

[Unit]

```conf
Description=Mount System Backups Directory
```

[Mount]

```conf
What=/dev/sdb1
```

## by-uuid para el disco /dev/sdb1

## What=/dev/disk/by-uuid/5a2591ba-7009-4949-a0cd-b2792bf80820

```conf
Where=/logs
```

## Where=/cliente1/logs/data

```conf
Type=xfs
Options=defaults
```

[Install]

```conf
WantedBy=multi-user.target
```

## Explicacion teorica formador:

El término by-uuid hace referencia a la forma en que los sistemas Linux pueden identificar particiones de disco mediante su UUID (Universally Unique Identifier). Cada sistema de archivos tiene un UUID único que lo identifica, lo que permite que los sistemas operativos monten y gestionen las particiones de una manera más fiable que utilizando solo los nombres de dispositivos (como /dev/sda1), ya que estos pueden cambiar dependiendo del hardware.

```bash
ls -l
/dev/disk/by-uuid
```

## Continuamos con el laboratorio:

```bash
systemctl daemon-reload
systemctl start logs.mount
df -hT
```

```bash
systemctl stop logs.mount
df -hT
```

```bash
systemctl enable logs.mount
```

## Ahora reiniciamos el sistema y tenemos que ver la unit montada:

### reboot

```bash
df -hT
```

## Para finalizar el laboratorio la quitaremos del inicio:

```bash
systemctl disable logs.mount
```

```bash
systemctl list-units --type mount --all
```

## EXPLICACION FORMADOR Archivo /etc/systemd/system/logs.mount con Comentarios y mejorado:

[Unit]

## Descripción de la unidad de montaje

```conf
Description=Mount System Backups Directory
```

## Referencia a la documentación oficial de systemd para mounts

```conf
Documentation=man:systemd.mount(5)
```

Indica que este montaje debe estar disponible después de que la red esté activa.

Útil si el punto de montaje depende de almacenamiento en red o servicios externos.

```conf
Wants=network-online.target
After=network-online.target
```

[Mount]

Especifica el dispositivo que se montará.

Se recomienda usar el UUID del disco en lugar de /dev/sdb1, ya que los nombres de dispositivos pueden cambiar.

```conf
What=/dev/disk/by-uuid/5a2591ba-7009-4949-a0cd-b2792bf80820
```

Punto de montaje en el sistema de archivos donde se accederá a los datos del dispositivo.

```conf
Where=/logs
```

Tipo de sistema de archivos que se montará (en este caso, XFS).

```conf
Type=xfs
```

## Opciones de montaje:

- defaults -> Configuración estándar del sistema (rw, suid, dev, exec, auto, nouser, async).

- nofail -> Evita que el sistema falle al arrancar si el dispositivo no está disponible.

- x-systemd.automount -> Permite automontar cuando se accede a /logs, reduciendo el tiempo de arranque.

- noatime -> Desactiva la actualización del timestamp de acceso a archivos, mejorando el rendimiento en HDD y SSD.

```conf
Options=defaults,nofail,x-systemd.automount,noatime
```

[Install]

Indica que esta unidad debe activarse en el arranque del sistema para usuarios multiusuario.

Esto significa que el montaje estará disponible después de que el sistema haya iniciado completamente.

```conf
WantedBy=multi-user.target
```
