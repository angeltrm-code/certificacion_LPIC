#Con el comando ss mostrar los puertos en escucha
ss -l
ss -putan
ss -putan |grep -w 80

#Con el comando netstat mostrar los puertos en escucha
netstat -putan |grep -i listen

#Que hace la variable LD_LIBRARY_PATH
Ruta de librerias compartidas para el sistema

#Que hace el comando ldd
Mostrar libreria vinculadas a un binario
ldd /usr/sbin/httpd

#Averiguar cuanto tiempo lleva encensido nuestro servidor
uptime

#Permisos de Sticky Bit al directorio /datos en formato numerico y alfabetico
chmod 1777 /datos
chmod o+t /datos

#Permisos rw- --- --- al archivo datos.txt
chmod 600  datos.txt

#Buscar archivos modificados hace menos de un minuto
find / -type f -mmin -1

#Buscar archivos con extension log, en el directorio /apache y eliminarlos en la misma orden
find /apache -type f -name "*.log" -exec rm -ri {} \;
find /apache -type f -name "*.log" -delete

-delete: elimina los archivos encontrados.

find /apache -type f -name "*.log" -ok rm -rf {} \;




#Comando para mostrar la ubicacion de un binario
whereis
whereis ls

#Comando para mostrar el camino completo del passwd
which passwd

whereis busca binarios, código fuente y páginas de manual.
which muestra solo la ruta del binario ejecutable en $PATH.

#Que hace el comando bc
calculadora binaria
man bc

#Tamaño del directorio /var
du -hs /var

#Que particiones minimas tengo en una instalacion de linux
lsblk -f
swap
/

#Que tipo de particiones es 8e 82 83 fd
8e LVM
82 Swap
83 Linux extandar
fd linux raid

#Empaquetar el directorio /datos en un archivo llamado datos.tar.xz
mkdir /datos
cp /etc/*.conf /datos
cd /root
tar Jcvf datos.tar.xz /datos/*

#Desempaquetar datos.tar.xz en el directorio /opt
cd /root
tar Jxvf datos.tar.xz  -C /opt

#Empaquetar el directorio /datos en datos.tar.gz
cd /root
tar zcvf datos.tar.gz /datos/*

#Cuantos caracteres tiene el archivo passwd
wc --help
wc -m /etc/passwd

#Buscar archivos con permisos setuid
find / -type f -perm -4000

#Apagar el servidor para dentro de 10m 
shutdown -h 10 "Parada servidor en 10m" 
shutdown -c 


#Instalar webmin con rpm y dpkg
rpm -i
dpkg -i

#Ver si tengo instalado webmin.rpm webmin.deb
rpm -qi 
dpkg -l

#Mostrar la version del paquete instado webmin tando rpm y dpkg
rpm -qi 
dpkg -p

#Mostrar la informacion del paquete  rpm y dpkg
rpm -qi 
dpkg -I

#Diferencia entre yum y rpm
rpm: Es un administrador de paquetes de bajo nivel que permite instalar, actualizar, eliminar y consultar paquetes .rpm directamente. Sin embargo, no gestiona dependencias automáticamente.

yum: Es un administrador de paquetes de alto nivel que utiliza rpm en segundo plano. Su principal ventaja es que gestiona automáticamente las dependencias, descargando e instalando los paquetes necesarios.

dnf: Es un administrador de paquetes de alto nivel que utiliza rpm en segundo plano. Su principal ventaja es que gestiona automáticamente las dependencias, descargando e instalando los paquetes necesarios.

dnf es el reemplazo moderno de yum, introducido en Fedora 22 y RHEL 8 (incluyendo Rocky Linux 8).

##rpm y dpkg
#Instalar el paquete webmin en debian y centos
dpkg -i
rpm -i

#Ver que archivos instala el paquete webmin en debian y centos
dpkg -S webmin
rpm -ql webmin

#Elimnar el paquete webmin en centos y debian
dpkg -P webmin
rpm -e webmin

#instalar webmin con apt-get y yum
apt-get install 
yum install

#Eliminar archivos .log en /ruta
find /ruta -name "*.log" -delete

#Eliminar archivos vacíos:
find /ruta -type f -empty -delete

#Eliminar archivos modificados hace más de 7 días:
find /ruta -type f -mtime +7 -delete

