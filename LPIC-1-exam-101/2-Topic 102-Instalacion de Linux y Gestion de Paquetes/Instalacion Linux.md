## Pagina 208 y pagina 39 Manual del curso PDF Almacenamiento ##

## Pagina 38 Manual del curso PDF-Instalación de Linux y de los paquetes de software

## Introduccion a discos en linux

cat /proc/partitions
fdisk -l /dev/sda
lsscsi
lsblk -f

## Tipo de particiones para GPT
8300 : partición de tipo Linux (datos)
 • 8200 : partición de tipo swap 
 • fd00 : partición de tipo RAID 
 • 8e00 : partición de tipo LVM
 
## Tipo de particiones MBR 
83 : partición de tipo Linux (datos)
 • 82 : partición de tipo swap 
 • fd : partición de tipo RAID 
 • 8e : partición de tipo LVM
 
a. IDE Los discos con controladores IDE (también llamados PATA, Parallel Ata o ATAPI) se llaman hdX:
• hda: IDE0, Master 
• hdb: IDE0, Slave 
• hdc: IDE1, Master 
• hdd: IDE1, Slave 


b. SCSI, SATA, USB, FIREWIRE, etc. 
sda: primer disco SCSI
• sdb: segundo disco SCSI 
• sdc: tercer disco SCSI • etc.
La norma SCSI marca una diferencia entre los diversos soportes. Así, los lectores de CD-Rom, DVD, HD-DVD, BlueRay y 
los grabadores asociados no llevan el mismo nombre. Los lectores y grabadores están en
 srX (sr0, sr1, etc.). 
 
También puede encontrar scd0, scd1, etc. Pero suelen ser vínculos simbólicos hacia sr0, sr1, etc.

En la instalacion de un so linux la particion /boot tiene que estar en 83 partición de tipo Linux (datos)


fdisk -l /dev/sda

Disk /dev/sda: 68.7 GB, 68719476736 bytes, 134217728 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Identificador del disco: 0x000b294d

Disposit. Inicio    Comienzo      Fin      Bloques  Id  Sistema
/dev/sda1   *        2048     2099199     1048576   83  Linux
/dev/sda2         2099200   134217727    66059264   8e  Linux LVM

[root@sercentos7 boot]# lsblk
NAME            MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda               8:0    0  64G  0 disk
├─sda1            8:1    0   1G  0 part /boot
└─sda2            8:2    0  63G  0 part
  ├─centos-root 253:0    0  41G  0 lvm  /
  ├─centos-swap 253:1    0   2G  0 lvm  [SWAP]
  └─centos-home 253:2    0  20G  0 lvm  /home
-------------------------------------------------------------------------------------
# Instalar servidor NTP  chrony
El paquete chrony, un binario que nos ofrece la posibilidad de mantener la hora sincronizada con servidores NTP y a la vez él mismo ofrecerse como servidor NTP para otros clientes

yum install chrony -y
apt install chrony -y

vi /etc/chrony.conf
server hora.roa.es iburst
server minuto.roa.es iburst

systemctl enable chronyd
systemctl start chronyd
systemctl status chronyd

# Mostrar la información sobre NTP
chronyc sources -v


## Debian
vi /etc/chrony/chrony.conf
server 3.es.pool.ntp.org iburst
server 1.europe.pool.ntp.org iburst
server 3.europe.pool.ntp.org iburst

Servidores de la marina en Rota

systemctl enable chronyd
systemctl start chronyd
systemctl status chronyd

Mostrar la información sobre NTP
# chronyc sources -v

 timedatectl
               Local time: mié 2025-12-03 15:53:23 CET
           Universal time: mié 2025-12-03 14:53:23 UTC
                 RTC time: mié 2025-12-03 14:53:22
                Time zone: Europe/Madrid (CET, +0100)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no


# Qué hace exactamente iburst
Cuando un cliente NTP o Chrony arranca, normalmente envía una sola solicitud NTP al servidor, y espera su respuesta.
Si el servidor tarda o hay pérdida de paquetes, la sincronización inicial puede demorar hasta varios minutos.

Con iburst, en lugar de un solo paquete, el cliente envía una ráfaga de 4 a 8 solicitudes muy rápidas (una cada pocos milisegundos) cuando intenta contactar con un servidor por primera vez.
Esto permite que la sincronización inicial se realice en cuestión de segundos.