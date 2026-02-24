Istalar el paquete webmin.rpm con el comando rpm
rpm -ivh webmin.rpm
Verificar la version de php que tenemos en nuestro servidor con rmp
rpm -qa php
rpi -qi php
Eliminar el paquete traceroute con rpm
rpm -e --nodeps traceroute
Bunscar informacion del paquete httpd con yum
yum info httpd
Instalar el paquete joomla.rpm que esta en local con yum
yum -y localinstall joomla-1.0.15-2.9.el5.al.noarch.rpm

Como excluir el paquete php del yum
vi /etc/yum.conf
[main]
exclude=php*

Ejecutar el comando ls y recuperar el stderr y stdout y llevarlo a /tmp/salida.txt
ls / 2>&1 > /tmp/salida
0 3 * * * find /web -mtime 3 -print 2>&1 |mail -s "Files modificados en los ultimos 3 dias" usuario@gmail.com
Que paquete instala en archivo httpd.conf
rpm -qf /etc/httpd/conf/httpd.conf
Actualizar el paquete mc.rpm
rpm -Uvh mc.rpm
Diferencias entre rpm -U y rpm -F
Como instalo el paquete joomla.rpm en local con yum para gestionar dependencias
yum -y localinstall joomla-1.0.15-2.9.el5.al.noarch.rpm

Informacion del paquete traceroute
rpm -qi traceroute
Averiguar que paquetes tengo disponibles para actualizar con yum
yum list updates | less







