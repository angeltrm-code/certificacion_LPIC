---------------------------------------------------------------------------------------------------------------
###Laboratorio configurar Openssh COMPLETO:
cp /etc/ssh/sshd_config /root

#Configurar nuestro servidor openssh:
Puerto 52412
No permitimos conexion al usuario root
No permitimos el renvio de las X
Solamante el usuario vagrant se puede conectar a nuestro servidor ssh y el usuario operador desde la ip 192.168.33.151
Banner /etc/ssh/sshd-banner

#Copiamos de nuestro windows a nuestro linux el archivo c:\windows.txt /tmp

adduser operador
passwd operador

#Añadimos las entradas al final del archivo
vi  /etc/ssh/sshd_config

##Entra añadida administrador el 21/02/2025
Port 52412
PermitRootLogin no
X11Forwarding no
AllowUsers vagrant operador@192.168.33.151
Banner /etc/ssh/sshd-banner


vi  /etc/ssh/sshd-banner
###############################################################
#                 Authorized access only!                     #
# Disconnect IMMEDIATELY if you are not an authorized user!!! #
#         All actions Will be monitored and recorded          #
###############################################################


##Reiniciamos el servicio:
systemctl restart sshd
systemctl status sshd



Copiamos de nuestro windows a nuestro linux el archivo c:\windows.txt al directorio /tmp

scp -P 52412 c:\windows.txt  vagrant@192.168.33.150:/tmp

##Para comprobar el laboratorio:
-El puerto es 52412
-Solo me puedo conectar con el usuario vagrant
-No puedo conectarme con el usuario root

-El usuario operador se puede conectar a traves de ssh desde la maquina nuestro linux que tiene la ip 192.168.33.151
 ssh -p 52412  operador@192.168.33.150

Comprobar que el usuario root no se puede conectar.
Comprobar que el usuario vagrant si se puede conectar

##Tras la finalizacion del laboratorio lo dejamos por defecto el servicio Openssh:

cp /root/sshd_config  /etc/ssh/
systemctl restart sshd
systemctl status sshd