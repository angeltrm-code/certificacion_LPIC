###Ejecutar en systemd un script en Bash para que arranque como demonio al encenderla máquina:###

# cd /usr/bin
# vi mail_arranque.sh

#!/bin/bash
echo se encendio el equipo $(hostname) a las $(date +%d-%m-%Y---%X) | mail usuario@correo.es

# chmod +x /usr/bin/mail_arranque.sh
-------------------------------------------------------------------------------------------------------------------------------------------
# vi /etc/systemd/system/mail_arranque.service 

[Unit]
Description= Envio hora de arranque
After=network.target

[Service]
ExecStart=/usr/bin/mail_arranque.sh
Type=oneshot
RemainAfterExit=true

[Install]
WantedBy=default.target




systemctl daemon-reload
systemctl enable mail_arranque.service
systemctl start mail_arranque.service
--------------------------------------------------------------------------------------------------------------------------------

##Si queremos ver el enlace blando creado podemos encontrarlo en /etc/systemd/system/default.target.wants/

##RemainAfterExit=true hará que el servicio permanezca de acuerdo con systemd, 
por lo que solo intentará ejecutarse la primera vez que ejecute systemctl start, pero no la segunda.

----------------------------------------------------------------------------------------------------------
vi /usr/bin/rutas.sh
ip route add 192.168.3.0/25 via 172.16.1.36 dev eth1
ip route add 192.168.4.0/25 via 172.16.1.38 dev eth2


chmod 700 /usr/bin/rutas.sh


# vi /etc/systemd/system/rutas.service 

[Unit]
Description= Envio hora de arranque
After=network.target

[Service]
ExecStart=/usr/bin/rutas.sh
Type=oneshot
RemainAfterExit=true

[Install]
WantedBy=default.target




systemctl daemon-reload
systemctl enable rutas.service
systemctl start rutas.service


##RemainAfterExit=true hará que el servicio permanezca de acuerdo con systemd, 
por lo que solo intentará ejecutarse la primera vez que ejecute systemctl start, pero no la segunda.
