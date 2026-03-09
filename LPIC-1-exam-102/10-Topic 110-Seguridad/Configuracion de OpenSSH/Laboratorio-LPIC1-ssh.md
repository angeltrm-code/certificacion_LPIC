# Laboratorio configurar Openssh COMPLETO en el servidor 192.168.33.10 RockyLinux:

                            +----------------+
                            |    Windows PC   |
                            | (Origen archivo)|
							| 192.168.33.1    | 
                            +--------+--------+
                                     |
                  (Copia windows.txt usando SCP)
                                     |
                                     v
                          +----------+-----------+
                          |  RockyLinux Servidor  |
                          |    192.168.33.10      |
                          |    OpenSSH Server     |
                          +----------+-----------+
                                     ^
                                     |
           (Conexión SSH al puerto 52412 - según permisos)
                                     |
         +---------------------------+------------------------------+
         |                                                          |
+-------------------+                                  +--------------------+
|  Debian 12 VM     |                                  | Usuario vagrant     |
| 192.168.33.11     |                                  | 192.168.33.10       |
| Usuario operador  | -------------------------------->| Usuario vagrant     |
| SSH permitido     |                                  | SSH permitido  	 |
                                                       |  puerto 52412       |
+-------------------+                                  +--------------------+



# Realizar una copia de seguridad de nuestro fichero del servidor:
cp /etc/ssh/sshd_config /root

# Configurar nuestro servidor openssh:
Puerto 52412
No permitimos conexion al usuario root
No permitimos el renvio de las X
Solamante el usuario vagrant se puede conectar a nuestro servidor ssh y el usuario operador desde la ip 192.168.33.1
Banner /etc/ssh/sshd-banner

# Copiamos de nuestro windows a nuestro linux 192.168.33.10 el archivo c:\windows.txt /tmp con el usuario vagrant


# SOLUCION Configurar nuestro servidor openssh:

adduser operador
passwd operador -> vagrant

# Añadimos las entradas al final del archivo
vi  /etc/ssh/sshd_config

# Entrada añadida administrador el 07/10/2026
Port 52412
PermitRootLogin no
X11Forwarding no
AllowUsers vagrant operador@192.168.33.11
Banner /etc/ssh/sshd-banner


vi  /etc/ssh/sshd-banner
# 
#                  Authorized access only!                     # 
#  Disconnect IMMEDIATELY if you are not an authorized user!!! # 
#          All actions Will be monitored and recorded          # 
# 


# Para testear la configuracion del archivo /etc/ssh/sshd_config, antes de reiniciar el servicio:
sshd -t


# Reiniciamos el servicio:
systemctl restart sshd
systemctl status sshd



# Copiamos de nuestro windows a nuestro linux el archivo c:\windows.txt al directorio /tmp

scp -P 52412 c:\windows.txt  vagrant@192.168.33.10:/tmp

scp  c:\windows.txt  vagrant@192.168.33.10:/tmp


# Para comprobar el laboratorio:
-El puerto es 52412
-Solo me puedo conectar con el usuario vagrant a traves de ssh
-No puedo conectarme con el usuario root

-El usuario operador se puede conectar a traves de ssh desde la maquina nuestro linux (debian) que tiene la ip 192.168.33.12

# Desde la mv de debian12:
 ssh -p 52412  operador@192.168.33.10

Comprobar que el usuario root no se puede conectar.
Comprobar que el usuario vagrant si se puede conectar

# Tras la finalizacion del laboratorio lo dejamos por defecto el servicio Openssh en 192.168.33.10:

cp /root/sshd_config  /etc/ssh/
systemctl restart sshd
systemctl status sshd
------------------------------------------------------------------------------------------------------

# Laboratorio2:

En este procedimiento ejecutaremos programas a traves de ssh desde rockylinux8 a debian, con el usuario vagrant en ambos servidores:

rockylinux8--->192.168.33.10
debian---> 192.168.33.11

# En rockylinux8 con el usuario vagrant y no ponemos contraseña en el certificado respondemos a todo con intro:
vagrant@rockylinux8 / # su - vagrant

# Se utiliza para generar un par de claves SSH (una pública y una privada) usando el algoritmo RSA con un tamaño de 4096 bits
vagrant@rockylinux8 / # ssh-keygen -t rsa -b 4096

# Le damos a todo intro:
Generating public/private dsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_dsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/vagrant/.ssh/id_dsa.
Your public key has been saved in /home/vagrant/.ssh/id_dsa.pub.
The key fingerprint is:
2c:73:30:fe:82:21:a5:52:78:49:37:cd:57:af:36:df vagrant@cliente


# Genera en /home/vagrant/.ssh estos dos ficheros :
vagrant@rockylinux8 / #  ls -l /home/vagrant/.ssh 
id_rsa
id_rsa.pub

# Seguimos los pasos de nuestro laboratorio, sin palabra de paso en nuestros certificados:

ssh-copy-id es un comando de Linux que copia tu clave pública SSH a un servidor remoto, para que luego puedas conectarte sin tener que escribir la contraseña cada vez.
Se usa para configurar autenticación SSH basada en clave pública (más segura que usar contraseñas).

# Esta orden copia el contenido de id_rsa.pub, en el servidor debian en el archivo /home/vagrant/.ssh/authorized_keys
vagrant@rockylinux8 / # cd /home/vagrant/.ssh
vagrant@rockylinux8 / # ssh-copy-id -i id_rsa.pub vagrant@192.168.33.11





# En debian con el usuario vagrant
vagrant@debian:~$ ls -l /home/vagrant/.ssh
# Se crea el archivo authorized_keys con el contenido de id_rsa.pub de rockylinux8
authorized_keys



# Para probar que todo funciona desde el rockylinux8 ejecutamos:
 vagrant@rockylinux8 / # ssh 192.168.33.11 cat /etc/hostname
 
vagrant@rockylinux8 / # ssh vagrant@192.168.33.11
vagrant@rockylinux8 touch  /home/vagrant/datos.txt
vagrant@rockylinux8 / # scp /home/vagrant/datos.txt 192.168.33.11:/home/vagrant
----------------------------------------------------------------------------------------------------------
# Laboratorio ssh-agent:

ssh-agent es un manejador de claves para SSH, es decir, mantiene las claves privadas en memoria, descifradas y listas para usarse. Esto nos facilita el hecho de utilizar dichas claves sin necesidad de cargarlas y descifrarlas (en el caso de que hayamos seteado una passphrase) cada vez que vayamos a usarlas.


# Habilitar root por ssh en la mv debian12:

root@debian:~# sudo cp  /etc/ssh/sshd_config /root

# Modifico la line 33 del fichero  /etc/ssh/sshd_config
# Para situarme el en vi en una linea ejecutamos la tecla escape y ponemos  :33    que es el numero linea
root@debian:~# sudo vi   /etc/ssh/sshd_config
PermitRootLogin yes

# Reiniciamos el service sshd
root@debian:~# sudo systemctl restart sshd

# Ponemos de password vagrant al usuario root:
root@debian:~# sudo passwd root 

Ahora me conectar como root al servidor debian12



# En este procedimiento ejecutaremos programas a traves de ssh desde  debian a rockylinux8 ,
con el usuario root en ambos servidores, utilizaremos contraseña en la creacion del certificado:


rockylinux8--->192.168.33.10
debian---> 192.168.33.11

# En debian con el usuario root, en la creacion del certificado  a la pregunta  passphrase ponemos una contraseña:
# Enter passphrase (empty for no passphrase):
# Enter same passphrase again:

root@debian:~#  id
uid=0(root) gid=0(root) groups=0(root)

# Enter passphrase (empty for no passphrase):
# Enter same passphrase again:

root@debian:~# ssh-keygen -t rsa -b 4096

# Genera en /root/.ssh estos dos ficheros :
root@debian:~# ls -l root/.ssh
id_rsa
id_rsa.pub


#  Desde debian, esta orden copia el contenido de id_rsa.pub, en el servidor debian en el archivo /root/.ssh/authorized_keys
root@debian:~# cd /root/.ssh
root@debian:~# ssh-copy-id -i id_rsa.pub root@192.168.33.10


# En rockylinux8 con el usuario root puedo comprobar la creacion del archivo authorized_keys, creado con el comando
anterior

root@rockylinux8 / #  ls -l /root/.ssh
# Se crea el archivo authorized_keys con el contenido de id_rsa.pub de rockylinux8
authorized_keys



# Para probar que todo funciona desde el servidor debain ejecutamos:

# Anotacion ssh-agent:
# Si la llave privada es creada con un password en el ejemplo servidor rockylinux8 (ssh-add)

El comando eval $(ssh-agent) se usa para iniciar el agente SSH (ssh-agent) y configurar el entorno para que las claves SSH puedan utilizarse sin necesidad de ingresar la contraseña en cada conexión.

root@debian:~# eval $(ssh-agent)

root@debian:~# ssh-add -t 2m /root/.ssh/id_rsa

# Ahora no nos tendra que pedir el password de la llave privada:

root@debian:~# ssh 192.168.33.10 cat /etc/hostname
 
root@debian:~# ssh root@192.168.33.10
exit

root@debian:~# scp /etc/hostname  root@192.168.33.10:/tmp


# Pasado los dos minutos Tiene que pedir el password del certificado para conectarme:
root@debian:~# ssh root@192.168.33.10


eval $(ssh-agent) inicia un agente SSH y “inyecta” en tu shell las variables que imprime (SSH_AUTH_SOCK y SSH_AGENT_PID). Así, los clientes SSH/Git hablan con el agente, que guarda tus claves privadas en memoria y evita reintroducir la passphrase.

# Qué ocurre
ssh-agent imprime asignaciones de entorno.
eval las ejecuta en tu shell actual → quedan exportadas:
SSH_AUTH_SOCK: socket UNIX para hablar con el agente.
SSH_AGENT_PID: PID del agente.

