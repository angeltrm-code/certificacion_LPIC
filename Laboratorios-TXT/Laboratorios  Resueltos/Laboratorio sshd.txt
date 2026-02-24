Configurar en el Redhat6 el servicio de ssh
-El usuario root no se puede conectar
-Solo se puede conectar el usuario miercoles21
No se permite el renvio de las X
Desactivamos la resolucion inversa del cliente en el DNS.
adduser miercoles21
passwd miercoles21

vi /etc/ssh/sshd_config
PermitRootLogin no
AllowUsers miercoles21
X11Forwarding no
UseDNS no

systemctl restart sshd
servie sshd restart


Desde el r7 creamos un archivo /root/r7.txt y lo copiamos al directorio root del r6
touch /root/r7.txt
scp /root/r7.txt root@192.168.1.150:/root

Desde el r6 creamos un archivo /root/r6.txt y lo copiamos al directorio root del r7

touch /root/r6.txt
scp /root/r6.txt   root@192.168.1.5:/root
