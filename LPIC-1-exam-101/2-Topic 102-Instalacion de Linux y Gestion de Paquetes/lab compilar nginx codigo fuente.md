##Instalar desde las fuentes pagina 87 manual pdf###

#####Laboratorio install nginx en la version 1.19.6, con soporte SSL en nuestros servidores a traves de codigo fuente:


###En distribuciones  RockyLinux 8.x ###
yum groupinstall "Development Tools" -y      
yum install pcre-devel openssl openssl-devel wget -y

###Debian/Ubuntu :
apt-get update -y
apt  install libssl-dev  build-essential wget -y



##Explicacion profesor comandos###

cd /root
wget http://nginx.org/download/nginx-1.19.6.tar.gz
tar xzfv nginx-1.19.6.tar.gz -C /opt
cat README

./configure --help 
./configure --prefix=/etc
make
make install 

##La instalacion de la aplicacion compilada suele estar en esta ruta:
/usr/local/bin
/usr/local/sbin


#./configure
Ejecuta un script llamado configure que prepara el entorno de compilación.
Verifica que tu sistema tenga las librerías y dependencias necesarias.
Crea los Makefiles, que son las instrucciones para make.
Permite ajustar parámetros de instalación

#make
Lee el archivo Makefile generado por configure.
Compila el código fuente, creando los binarios.
Si hay errores de librerías faltantes, aquí suelen aparecer.

#make install
Copia los binarios, librerías y archivos de configuración al sistema.
Por defecto, suele instalar en /usr/local/bin, /usr/local/lib, etc. (a menos que cambies el --prefix en ./configure).
Importante: este paso normalmente requiere permisos de administrador:


-----------------------------------------------------------------------------

###Comenzamos el laboratorio###
cd /root
wget http://nginx.org/download/nginx-1.19.6.tar.gz
tar xzfv nginx-1.19.6.tar.gz -C /opt



cd /opt/nginx-1.19.6

Mirar el fichero README 

##Parar debian 12:
./configure --without-http_rewrite_module --without-http_gzip_module 
make
make install 



##Para centos Rocky Linux 8.x:
./configure --help
./configure --with-http_ssl_module  
make
make install 


##Para centos Rocky Linux 9.x 10.x:

./configure --without-http_rewrite_module
make 
make install

##Comprobamos la instalacion:

/usr/local/nginx/sbin/nginx -V

##Iniciar el ngix
/usr/local/nginx/sbin/nginx    
netstat -putan |grep -w 80
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      4603/nginx: master

##Averiguar ip maquina linux:
ip a

http://192.168.33.10

/usr/local/bin
/usr/local/sbin

##Para para el nginx:
killall nginx
netstat -putan |grep -w 80

----------------------------------------------------------------------------------------------------------------------------

##Crear un servicio para system-v:


vi /etc/init.d/nginx

#!/bin/bash
# chkconfig: - 99 10
case $1 in
start)
  /usr/local/nginx/sbin/nginx &
  ;;
stop)
  killall nginx
  ;;
*)
echo "No es una opcion para pasarle a script solo start y stop" 
;;
esac


chmod 700 /etc/init.d/nginx

/etc/init.d/nginx start 
service nginx start
netstat -putan |grep -w 80

service nginx stop
/etc/init.d/nginx stop


chkconfig --level 3 nginx on
/etc/rc3.d/S99nginx-->/etc/init.d/ngix

/etc/init.d/ngix stop

##Para poner el service al inicio del servidor en Redhat
chkconfig --level 3 nginx off
/etc/rc3.d/K10nginx-->/etc/init.d/nginx

##Debian no tenemos el comando chkconfig:
cd /etc/rc3.d/
ln -s S99nginx  /etc/init.d/nginx
------------------------------------------------------------------------------
##Creamos toda la configuacion para SystemD:

/usr/lib/systemd/system

vi  /etc/systemd/system/nginx.service
[Unit]
Description=Daemon of axample
After=network.target
Conflicts=httpd.service apache2.service

[Service]
ExecStart=/etc/init.d/nginx start
ExecStop=/etc/init.d/nginx stop
Type=forking

[Install]
WantedBy=multi-user.target



##Para que systemd se entere de que hemos creado un nuevo service:
systemctl daemon-reload

systemctl start nginx
netstat -putan |grep -w 80

systemctl stop nginx
netstat -putan |grep -w 80


systemctl enable nginx
systemctl disable nginx






