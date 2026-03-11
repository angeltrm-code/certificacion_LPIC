# Instalacion Linux

Documento de referencia sobre identificacion de discos, tipos de particion y sincronizacion horaria con Chrony.

> Referencias del manual del curso: paginas 38, 39 y 208.

## Identificacion de discos en Linux

Comandos basicos para identificar discos, particiones y sistemas de archivos:

```bash
cat /proc/partitions
fdisk -l /dev/sda
lsscsi
lsblk -f
```

### Tipos de particion en GPT

- `8300`: particion de tipo Linux (datos)
- `8200`: particion de tipo swap
- `fd00`: particion de tipo RAID
- `8e00`: particion de tipo LVM

### Tipos de particion en MBR

- `83`: particion de tipo Linux (datos)
- `82`: particion de tipo swap
- `fd`: particion de tipo RAID
- `8e`: particion de tipo LVM

### Nomenclatura de discos IDE

Los discos con controladores IDE, tambien llamados PATA, Parallel ATA o ATAPI, se nombran como `hdX`:

- `hda`: IDE0, master
- `hdb`: IDE0, slave
- `hdc`: IDE1, master
- `hdd`: IDE1, slave

### Nomenclatura de discos SCSI, SATA, USB y FireWire

Los discos de tipo SCSI y tecnologias relacionadas se nombran como `sdX`:

- `sda`: primer disco SCSI
- `sdb`: segundo disco SCSI
- `sdc`: tercer disco SCSI

La norma SCSI distingue entre discos y unidades opticas. Los lectores y grabadores suelen aparecer como `srX` (`sr0`, `sr1`, etc.). Tambien pueden existir enlaces simbolicos como `scd0` o `scd1` apuntando a esas unidades.

> En una instalacion de Linux con esquema MBR, la particion `/boot` debe estar marcada como tipo `83` (Linux datos).

## Ejemplo de particionado

Ejemplo de salida de `fdisk`:

```bash
fdisk -l /dev/sda
```

```text
Disk /dev/sda: 68.7 GB, 68719476736 bytes, 134217728 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Identificador del disco: 0x000b294d

Disposit. Inicio    Comienzo      Fin      Bloques  Id  Sistema
/dev/sda1   *        2048     2099199     1048576   83  Linux
/dev/sda2         2099200   134217727    66059264   8e  Linux LVM
```

Ejemplo de salida de `lsblk`:

```text
[root@sercentos7 boot]# lsblk
NAME            MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda               8:0    0  64G  0 disk
├─sda1            8:1    0   1G  0 part /boot
└─sda2            8:2    0  63G  0 part
  ├─centos-root 253:0    0  41G  0 lvm  /
  ├─centos-swap 253:1    0   2G  0 lvm  [SWAP]
  └─centos-home 253:2    0  20G  0 lvm  /home
```

## Instalacion y configuracion de Chrony

`chrony` permite sincronizar la hora con servidores NTP y, al mismo tiempo, ofrecer servicio horario a otros equipos.

### RHEL / CentOS

Instalacion del paquete:

```bash
yum install chrony -y
```

Configuracion basica:

```conf
server hora.roa.es iburst
server minuto.roa.es iburst
```

Activacion del servicio:

```bash
systemctl enable chronyd
systemctl start chronyd
systemctl status chronyd
```

### Debian

En Debian la configuracion suele editarse en:

```bash
vi /etc/chrony/chrony.conf
```

Ejemplo de servidores:

```conf
server 3.es.pool.ntp.org iburst
server 1.europe.pool.ntp.org iburst
server 3.europe.pool.ntp.org iburst
```

Tambien se mencionan como referencia los servidores de la marina en Rota.

Activacion del servicio:

```bash
systemctl enable chronyd
systemctl start chronyd
systemctl status chronyd
```

### Verificacion

Consultar fuentes NTP:

```bash
chronyc sources -v
```

Comprobar el estado horario general del sistema:

```text
timedatectl
               Local time: mié 2025-12-03 15:53:23 CET
           Universal time: mié 2025-12-03 14:53:23 UTC
                 RTC time: mié 2025-12-03 14:53:22
                Time zone: Europe/Madrid (CET, +0100)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

## Que hace exactamente `iburst`

Cuando un cliente NTP o Chrony arranca, normalmente envia una unica solicitud NTP al servidor y espera la respuesta. Si el servidor tarda en responder o hay perdida de paquetes, la sincronizacion inicial puede demorarse varios minutos.

Con `iburst`, en lugar de enviar un solo paquete, el cliente envia una rafaga de entre 4 y 8 solicitudes muy rapidas cuando contacta por primera vez con el servidor. Esto acelera notablemente la sincronizacion inicial y permite que se complete en pocos segundos.
