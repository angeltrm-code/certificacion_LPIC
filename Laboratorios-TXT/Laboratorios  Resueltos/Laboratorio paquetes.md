Comando para instalar con rpm mc.rpm
rpm -ivh mc.rpm
Ver informacion del paquete php
rpm -qi php
Eliminar el paquete php-mysql
rpm -e php-mysql
Excluir del yum el kernel y php
vi /etc/yum.conf
exclude=kernel* php*
Directorio donde se encuentran los repositorios de yumI
/etc/yum.repos.d
Instalar con dpkg el paquete mc.deb
dpkg -i  mc.deb
Purgar el paquete mc.deb
dpkg -P mc.deb
Convertir el paquete mc.rpm a mc.deb
alien -d mc.rpm
Verificar si se instalo el paquete mc.deb
dpkg -l mc
Que paquete rpm instala /etc/shadow
rpm -qf /etc/shadow
Instalar con yum el paquete mc
yum -y install mc
Desisntalar con yum el paquete mc 
yum remove mc
Comando rpm para mostrar informacion del paquete php
rpm -qi php
Descomprimir el archivo pdfedit.tar.gz en el directorio /opt
tar xvfz pdfedit.tar.gz -C /opt
Descomprimir el archivo pdfedit.tar.xz en el directorio /opt
tar xvfJ pdfedit.tar.xz -C /opt
Diferencia del parametro de rpm -U y rmp -F
Particiones minimas para una instalacion de linux
swap /
Que entendemos como /dev/sdb2
Particion primaria 2 en el segundo disco iscsi del servidor
Que entendemos como /dev/sdb5
Particion extendia o logica del 2 disco iscsi del servidor
Comando para recuperar los permisos por defecto con rmp sobre un fichero
rpm --setperms paquete

