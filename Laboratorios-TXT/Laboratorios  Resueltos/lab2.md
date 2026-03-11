# lab 2

Documento práctico sobre lab 2. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Version de sistema operativo

```bash
cat /etc/redhat-release
cat /etc/debian_version
lsb_release -a
cat /etc/*release
dnf provides lsb_release
```

## Arquitectura del sistema operativo

```bash
arch
```

## Averiguar si tenemos soporte de ntfs

```bash
cat /proc/filesystems
```

Tendremo que instalar el paquete ntfs-3g

## Fecha de modificacion del archivo /etc/passwd

```bash
stat /etc/passwd
ls -la /etc/passwd
```

## Buscar archivos desde el / modificados hace menos de 24 horas

```bash
find / -type f -mtime -1
```

### Buscar archivos desde el / con un tama�o superior a 200M

```bash
find / -type f -size +200M
```

### Buscar archivos con permisos de setuid, setguid y stickibit

```bash
find / -type f -perm -4000
find / -type d -perm -2000
find / -type d -perm -1000
```

### Cuantas lineas tine nuestro fichero /etc/passwd

### wc -l /etc/passwd

```
cat -n /etc/passwd
nl  /etc/passwd
```

### Cuantos caracteres tiene nuestro fichero /etc/shadow

### wc --help

### wc -m /etc/shadow

### Version del kenel del servidor

```bash
uname -r
```

### Modificar la fecha del sistema a 2014/11/03

```bash
date --set "2014-11-03"
date -s "2014-11-03"
timedatectl set-time "2014-11-03 14:30:00"
```

### Con el comando dmesg averiguar el modelo de disco duro

```bash
dmesg |grep -i sda
```

### Tama�o ocupado de la particion /

```bash
df -h /
```

### cuanto ocupa nuestro directorio /etc

```bash
du -hs /etc
```

### Cuanto ocupa el archivo passwd

```bash
du -hs /etc/passwd
```

### Sincronizar la fecha de la bios con el sistema con el comando hwclock

```bash
hwclock --hctosys
```

### Enviar un mensaje de apagado del servidor a todos los usuarios

```bash
echo "Reinicio del Servidor a la 12h" |wall
```

El comando wall (abreviatura de "write all") es una utilidad en Linux que permite enviar mensajes a todos los usuarios conectados a la m�quina en ese momento. Los mensajes enviados con wall aparecer�n en las terminales abiertas de los usuarios.

### Permisos al archivo  /datos.txt rw- --- ---

```bash
chmod 600 /datos.txt
chmod u=rw,go= /datos.txt
```

### Permisos de Sticky Bit al directorio /datos

```bash
chmod 1777 /datos
chmod o+t /datos
chmod +t /datos
```

### averiguar mascara por defecto

### umask -S

### Que hace el comando ldd

El comando ldd en Linux se utiliza para listar las dependencias de las bibliotecas compartidas que un ejecutable o un programa necesita para funcionar correctamente. En otras palabras, te muestra qu� bibliotecas din�micas (.so) requiere un programa.

### Me da las librerias vinculadas a un comando:

```bash
ldd /usr/sbin/fsck
```

### que hace la variable de entorno LD_LIBRARY_PATH

```bash
vi /root/.bash_profile
LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client/lib/:/usr/lib64/mysql
export LD_LIBRARY_PATH
```

### Buscar archivos o directorios con permisos Sticky Bit setuid setgid

```bash
find / -type f -perm -4000
find / -type d -perm -2000
find / -type d -perm -1000
```

### Poner al inicio el servicio httpd en systemd y sistemv

```bash
systemctl enable httpd
chkconfig --level 35 httpd on
```

### arrancar ahora el servicio httpd  systemd y sistemv

```bash
service httpd start
/etc/init.d/apache2 start
```

### systemct start httpd

### Comando para ver en systend el target actual y en systemv

### runlevel

```bash
systemctl get-default
```

### Comando para moverme en caliente entre en target o runlevel 5 en systemd systemv

### init 5

### telinit 5

```bash
systemctl isolate graphical.target
```
