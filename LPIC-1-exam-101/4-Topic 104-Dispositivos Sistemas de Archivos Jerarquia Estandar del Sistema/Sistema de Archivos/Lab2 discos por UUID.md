
#Laboratorio disco /dev/sdc
Crear una particion /dev/sdc1
formatearla a ext4
Montarla en el directorio /datos
Persistirlo en el fstab a traves de montaje por UUID
---------------------------------------------------------------------------------------------------
fdisk /dev/sdc
/dev/sdc1

mkfs.ext4 /dev/sdc1
mkdir /datos
mount /dev/sdc1  /datos
df -h

umount /datos
df -h

blkid /dev/sdc1
/dev/sdc1: UUID="be1671ac-e150-4a1b-84aa-da00070e8a10" TYPE="ext4"

vi /etc/fstab 

UUID=be1671ac-e150-4a1b-84aa-da00070e8a10               /datos        ext4     defaults 0 0

mount /datos
df -h
