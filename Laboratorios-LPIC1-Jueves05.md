# Laboratorio Practico
Crear una particion al disco /dev/sdb de 10G y formatearla a xfs y montarla en el directorio /informes, tiene que estar persistida en el /etc/fstab, la persistencia no la quiero de forma practica, solo en el procedimiento.


# Averiguar como se llaman los discos en nuestro equipo
cat /proc/partitions
fdisk -l
lsscsi
lsblk

# Averiguar info del disco, que temaÃ±o tiene
fdisk -l /dev/sdb

# Comenzamos a particionar, creamos la particion /dev/sdb1 y la guardamos y salimos del fdisk:
fdisk /dev/sdb

# Lo formateamos a xfs, con el siguiente comando:

mkfs.xfs /dev/sdb1

# Creamos el directorio informes
mkdir /informes

# Montamos la particion en /infomes:
systemctl daemon-reload
mount /dev/sdb1  /informes

df -hT

# Copiamos archivos en /informes
cp /etc/*.conf /informes
ls -l /informes

# Para persistirlo en el /etc/fstab, para que en el arranque este la particion montada:
umount /informes

df -hT

# Persistir el punto de montaje /informes al inicio del servidor:

# NO REALIZAR DE FORMA PRACTIA Al final del archivo /etc/fstab aÃ±adimos la line para persistir nuestra particion
vi /etc/fstab 

/dev/sdb1             /informes        xfs     defaults 0 0


# Montaje por dispositivo por UUID, sustituimos el /dev/sdb1 por el UUID obtenido anteriormente:
 
vi /etc/fstab 
UUID=be1671ac-e150-4a1b-84aa-da00070e8a10               /informes     xfs          defaults         0 0


# Comprobamos que todo esta correcto en el /etc/fstab:
mount -a
df hT

-------------------------------------------------------------------------------------

# Crear el usuario1 que la cuenta le caduca el 06/03/2026 y que en el primer inicio de session le pida cambiar el password:
useradd -e 2026-03-06 usuario1
passwd usuario1
chage -d 0 usuario1

# Con el comando ss mostrar los puertos en escucha
ss -tuln
# (si quieres ver tambien proceso/PID: ss -tulpn)

# Con el comando netstat mostrar los puertos en escucha
netstat -tuln
# (si quieres ver tambien proceso/PID: netstat -tulpn)

# Que hace la variable LD_LIBRARY_PATH
Define rutas adicionales donde el cargador dinamico busca librerias compartidas (.so) antes de las rutas por defecto.

# Que hace el comando ldd
Muestra las dependencias de librerias compartidas de un ejecutable.

# Averiguar cuanto tiempo lleva encensido nuestro servidor
uptime

# Permisos de Sticky Bit al directorio /datos en formato numerico y alfabetico
chmod 1777 /datos
chmod a+t /datos

# Permisos rw- --- --- al archivo datos.txt
chmod 600 datos.txt
chmod u=rw,go= datos.txt

# Buscar archivos modificados hace menos de un minuto
find /ruta -type f -mmin -1

# Buscar archivos con extension log, en el directorio /apache y eliminarlos en la misma orden
find /apache -type f -name "*.log" -delete

# Comando para mostrar la ubicacion de un binario
which nombre_binario
# alternativa portable: command -v nombre_binario

# Comando para mostrar el camino completo del passwd
which passwd
# alternativa portable: command -v passwd

# Que hace el comando bc
Es una calculadora de linea de comandos con soporte de precision arbitraria y operaciones matematicas.

# Tamaño del directorio /variable
du -sh /variable

# Que particiones minimas tengo en una instalacion de linux
Minimas recomendadas:
- /
- swap
En equipos UEFI tambien se usa la particion EFI (/boot/efi).

# Que tipo de particiones es 8e 82 83 fd
8e = Linux LVM
82 = Linux swap
83 = Linux (filesystem nativo)
fd = Linux RAID autodetect
