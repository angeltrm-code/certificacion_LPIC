*dump y restore seria el mismo prodecimientos para fs ext4

#xfsdump es una herramienta para realizar backups de sistemas de archivos XFS de forma consistente, incluso si están montados.

#xfsrestore se utiliza para restaurar copias creadas con xfsdump.
Solo funciona con backups hechos desde sistemas de archivos XFS.


##Respaldo y restauración de sistema de archivos xfsdump y xfsrestore para xfs:

rpm -qa xfsdump
yum install xfsdump -y

fdisk /dev/sdb
mkfs.xfs /dev/sdb1
mount /dev/sdb1 /logs

Particionamos el /dev/sdb1 y lo monto en /logs
cp /etc/*.conf /logs

##Realizo el backup de la particion /dev/sdb1 en un fichero en /cs
xfsdump -f /cs /dev/sdb1

rm -rf /logs/*

xfsrestore -f /cs /logs

##Con este comando podemos ver lo que tenemos en la copia, y restaurar los archivos de uno en uno
##si es necesario -i interactiva:

xfsrestore -f /cs -i -v silent /logs
 -> ls
 -> add asound.conf
 -> extract

# ls -l /logs/
------------------------------------------------

Particionamos el /dev/sdc1 y lo monto en /logs-resplado


xfsrestore -f /cs /logs-resplado