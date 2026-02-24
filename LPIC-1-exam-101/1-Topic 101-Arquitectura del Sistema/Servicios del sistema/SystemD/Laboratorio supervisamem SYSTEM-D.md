 /usr/lib/systemd/system/: unidades distribuidas con paquetes  instalados.
 /run/systemd/system/: unidades creadas en tiempo de ejecución. Tiene precedencia sobre el directorio anterior.
 /etc/systemd/system/: unidades creadas y administradas por el administrador del sistema.
 Este directorio tiene precedencia sobre el directorio anterior

###Pagina 159 pdf Red_Hat_Enterprise_Linux-7-System_Administrators_Guide-en-US.pdf
-----------------------------------------------------------------------------------------------------------------------------
##Para realizar este lab tener el repo del formador clonado:
cd /
git clone https://github.com/agarciafer/lpic1.git

cd /lpic1

mkdir /opt/scripts
cd /opt/scripts
cp /lpic1/supervisamem .
chmod 700 supervisamem

cp /lpic1/iniciar-supervisamem  /etc/init.d
chmod 700  /etc/init.d/iniciar-supervisamem

##Asegurarse de ejecutar el comando:
dos2unix /opt/scripts/supervisamem

-------------------------------------------------------- 

cp /lpic1/supervisamem.service  /etc/systemd/system

cat  /etc/systemd/system/supervisamem.service

[Unit]
Description=Daemon of axample
After=network.target 
#Conflicts=httpd.service nginx.service

[Service]
ExecStart=/etc/init.d/iniciar-supervisamem start
ExecStop=/etc/init.d/iniciar-supervisamem stop
Type=forking

[Install]
WantedBy=multi-user.target

------------------------------------------------
systemctl daemon-reload
systemctl start supervisamem.service
tail -f /var/log/supervisamem.log
systemctl stop supervisamem


systemctl enable supervisamem.service
systemctl disable supervisamem.service

systemctl is-enabled supervisamem.service


--------------------------------------------------------------------------------------------------------
enable --now equivale al enable && start

systemctl enable --now supervisamem.service

systemctl enable supervisamem.service
systemctl start supervisamem.service
----------------------------------------------------------
Nota Importante:
Si los servicios no tienen una sección [Install] significa, por lo general, que se les llama de forma automática
por otros servicios. Pero si necesita instalarlos manualmente, utilice la orden siguiente, 
reemplazando foo con el nombre del servicio.

# ln -s /usr/lib/systemd/system/foo.service /etc/systemd/system/multi-user.target.wants/

# ln -s /etc/systemd/system/foo.service /etc/systemd/system/multi-user.target.wants/

---------------------------------------------------------------------------
systemctl cat httpd.service
export EDITOR=vi
systemctl edit --full httpd.service 

systemctl edit httpd.service 
/etc/systemd/system/httpd.service.d/override.conf

##Puede usar systemd-delta para ver qué archivos de la unidad se han sobrescrito o ampliado
y qué se ha cambiado exactamente.
systemd-delta 
----------------------------------------------------------
**Importante:
Si los servicios no tienen una sección [Install] significa, por lo general, que se les llama de forma automática
por otros servicios. Pero si necesita instalarlos manualmente, utilice la orden siguiente, 
reemplazando foo con el nombre del servicio.

# ln -s /usr/lib/systemd/system/foo.service /etc/systemd/system/multi-user.target.wants/

# ln -s /etc/systemd/system/foo.service /etc/systemd/system/multi-user.target.wants/

---------------------------------------------------------------------------
systemctl cat httpd.service
export EDITOR=vi
systemctl edit --full httpd.service 

##Puede usar systemd-delta para ver qué archivos de la unidad se han sobrescrito o ampliado
y qué se ha cambiado exactamente.
systemd-delta 

##Ejemplo Conflicts unit service con sendmial y postfix levan los dos el mismo puerto 25
systemctl restart  sendmail
netstat -putan |grep -w 25
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      23638/sendmail: acc


 systemctl restart postfix.service

netstat -putan |grep -w 25
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      24288/master
