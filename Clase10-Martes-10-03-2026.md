# Clase 10 Martes 10 03 2026

Apuntes de clase sobre Clase 10 Martes 10 03 2026, reorganizados para facilitar la consulta rápida y el repaso.

**Martes 10/03/2026

## Referencias

- https://www.lpi.org/es/our-certifications/lpic-1-overview

## Materiales publicos de LPIC:

- https://learning.lpi.org/es/learning-materials/learning-materials/

## Guias IBM:

- https://developer.ibm.com/tutorials/l-lpic1-map

Profesor/a Titular: Alberto Garcia

## Conectarme a traves del cliente ssh de Windows abrimos un cmd:

## Maquina rockylinux:

```bash
ssh root@192.168.33.10
```

## Maquina debian12:

```bash
ssh vagrant@192.168.33.11
```

## Para trabajar como root en la mv de debian:

### sudo -i

> Clonar repositorio formador para realizar los laboratorio del Shell Bash de Linux Comandos Manejo de Texto.pdf :

```bash
dnf install git unzip -y
apt install git unzip -y
```

```bash
cd /
git clone https://github.com/agarciafer/lpic1.git
cd /lpic1
unzip access_log.zip
```

---

## En esta clase veremos:

## Tema 110: Seguridad

Material Alumnos LPIC-1-2025\LPIC-1-exam-102\10-Topic 110-Seguridad\Configuracion de OpenSSH

> -->Configuración de OpenSSH.pdf -->Explicacion Configurar SSHd.txt -->OpenSSH con autenticación a través de firma digital sin password.txt -->OpenSSH con autenticación a través de firma digital sin password-centos8-debian10.txt -->Laboratorio ssh-agent.txt

## Tema 105: Shells y scripts

> 105.1 Personalizar y usar el entorno de shell 105.2 Personalización y escritura de scripts sencillos Material Alumnos LPIC-1-2025\LPIC-1-exam-102\5-Topic 105-Interprete de comandos Scripts y Gestion de Datos -->Resumen Advanced Shell Features.txt -->Ejemplos Bash Scripts.txt -->Advanced Shell Features.pdf -->1-Guía rápida para crear scripts en Bash.pdf

---

## Laboratorio configurar Openssh COMPLETO en el servidor 192.168.33.10 RockyLinux:

### +----------------+

                            |    Windows PC   |
                            | (Origen archivo)|
                            | 192.168.33.1    |

+--------+--------+ | (Copia windows.txt usando SCP) | v +----------+-----------+

                          |  RockyLinux Servidor  |
                          |    192.168.33.10      |
                          |    OpenSSH Server     |

+----------+-----------+ ^ | (Conexión SSH al puerto 52412 - según permisos) | +---------------------------+------------------------------+

         |                                                          |

```
+-------------------+                                  +--------------------+
```

|  Debian 12 VM     |                                  | Usuario vagrant     |
| 192.168.33.11     |                                  | 192.168.33.10       |
| Usuario operador  | -------------------------------->| Usuario vagrant     |
| SSH permitido     |                                  | SSH permitido       |
                                                       |  puerto 52412       |

```
+-------------------+                                  +--------------------+
```

## Realizar una copia de seguridad de nuestro fichero del servidor:

```bash
cp /etc/ssh/sshd_config /root
```

## Configurar nuestro servidor openssh:

Puerto 52412 No permitimos conexion al usuario root No permitimos el renvio de las X Solamante el usuario vagrant se puede conectar a nuestro servidor ssh y el usuario operador desde la ip 192.168.33.1 Banner /etc/ssh/sshd-banner

Copiamos de nuestro windows a nuestro linux 192.168.33.10 el archivo c:\windows.txt /tmp con el usuario vagrant

## SOLUCION Configurar nuestro servidor openssh:

### adduser operador

```bash
passwd operador
```

## Añadimos las entradas al final del archivo

```
vi  /etc/ssh/sshd_config
```

## Entra añadida administrador el 07/10/2025

```conf
Port 52412
PermitRootLogin no
X11Forwarding no
AllowUsers vagrant operador@192.168.33.11
```

### Banner /etc/ssh/sshd-banner

```
vi  /etc/ssh/sshd-banner
```

Authorized access only! # Disconnect IMMEDIATELY if you are not an authorized user!!!

## All actions Will be monitored and recorded

## Para testear la configuracion del archivo /etc/ssh/sshd_config, antes de reiniciar el servicio:

```bash
sshd -t
```

## Reiniciamos el servicio:

```bash
systemctl restart sshd
systemctl status sshd
```

### Copiamos de nuestro windows a nuestro linux el archivo c:\windows.txt al directorio /tmp

```bash
scp -P 52412 c:\windows.txt  vagrant@192.168.33.10:/tmp
```

## Para comprobar el laboratorio:

-El puerto es 52412 -Solo me puedo conectar con el usuario vagrant a traves de ssh -No puedo conectarme con el usuario root

-El usuario operador se puede conectar a traves de ssh desde la maquina nuestro linux (debian) que tiene la ip 192.168.33.12 ##Desde la mv de debian12:

```bash
 ssh -p 52412  operador@192.168.33.10
```

Comprobar que el usuario root no se puede conectar. Comprobar que el usuario vagrant si se puede conectar

## Tras la finalizacion del laboratorio lo dejamos por defecto el servicio Openssh:

```bash
cp /root/sshd_config  /etc/ssh/
systemctl restart sshd
systemctl status sshd
```

---

## En este procedimiento ejecutaremos programas a traves de ssh desde rockylinux8 a debian, con el usuario vagrant en ambos servidores:

rockylinux8--->192.168.33.10 debian---> 192.168.33.11

En rockylinux8 con el usuario vagrant y no ponemos contraseña en el certificado respondemos a todo con intro: vagrant@rockylinux8 / #su - vagrant vagrant@rockylinux8 / #ssh-keygen -t rsa -b 4096

## Genera en /home/vagrant/.ssh estos dos ficheros :

vagrant@rockylinux8 / # ls -l /home/vagrant/.ssh id_rsa id_rsa.pub

## Seguimos los pasos de nuestro laboratorio, sin palabra de paso en nuestros certificados:

ssh-copy-id es un comando de Linux que copia tu clave pública SSH a un servidor remoto, para que luego puedas conectarte sin tener que escribir la contraseña cada vez.

Se usa para configurar autenticación SSH basada en clave pública (más segura que usar contraseñas).

Esta orden copia el contenido de id_rsa.pub, en el servidor debian en el archivo /home/vagrant/.ssh/authorized_keys vagrant@rockylinux8 / #cd /home/vagrant/.ssh vagrant@rockylinux8 / #ssh-copy-id -i id_rsa.pub vagrant@192.168.33.11

## En debian con el usuario vagrant

vagrant@debian:~$ ls -l /home/vagrant/.ssh

## Se crea el archivo authorized_keys con el contenido de id_rsa.pub de rockylinux8

authorized_keys

## Para probar que todo funciona desde el rockylinux8 ejecutamos:

### vagrant@rockylinux8 / #ssh 192.168.33.11 cat /etc/hostname

vagrant@rockylinux8 / #ssh vagrant@ipdebian vagrant@rockylinux8 / #scp /home/vagrant/datos.txt ipdebian:/home/vagrant

---

## Laboratorio ssh-agent:

ssh-agent es un manejador de claves para SSH, es decir, mantiene las claves privadas en memoria, descifradas y listas para usarse. Esto nos facilita el hecho de utilizar dichas claves sin necesidad de cargarlas y descifrarlas (en el caso de que hayamos seteado una passphrase) cada vez que vayamos a usarlas.

## Habilitar root por ssh en la mv debian12:

root@debian:~#sudo cp  /etc/ssh/sshd_config /root

## Modifico la line 33 del fichero  /etc/ssh/sshd_config

Para situarme el en vi en una linea ejecutamos la tecla escape y ponemos  :33    que es el numero linea root@debian:~#sudo vi   /etc/ssh/sshd_config

```conf
PermitRootLogin yes
```

## Reiniciamos el service sshd

root@debian:~#sudo systemctl restart sshd

## Ponemos de password vagrant al usuario root:

### root@debian:~#sudo passwd root

Ahora me conectar como root al servidor debian12

## En este procedimiento ejecutaremos programas a traves de ssh desde  debian a rockylinux8 ,

con el usuario root en ambos servidores, utilizaremos contraseña en la creacion del certificado:

rockylinux8--->192.168.33.10 debian---> 192.168.33.11

En debian con el usuario root, en la creacion del certificado  a la pregunta  passphrase ponemos una contraseña:

## Enter passphrase (empty for no passphrase):

## Enter same passphrase again:

### root@debian:~# id

```conf
uid=0(root) gid=0(root) groups=0(root)
```

## Enter passphrase (empty for no passphrase):

## Enter same passphrase again:

root@debian:~#ssh-keygen -t rsa -b 4096

## Genera en /root/.ssh estos dos ficheros :

root@debian:~#ls -l root/.ssh id_rsa id_rsa.pub

Desde debian, esta orden copia el contenido de id_rsa.pub, en el servidor debian en el archivo /root/.ssh/authorized_keys root@debian:~#cd /root/.ssh root@debian:~#ssh-copy-id -i id_rsa.pub root@192.168.33.10

En rockylinux8 con el usuario root puedo comprobar la creacion del archivo authorized_keys, creado con el comando anterior

root@rockylinux8 / # ls -l /root/.ssh

## Se crea el archivo authorized_keys con el contenido de id_rsa.pub de rockylinux8

authorized_keys

## Para probar que todo funciona desde el servidor debain ejecutamos:

## Anotacion ssh-agent:

## Si la llave privada es creada con un password en el ejemplo servidor rockylinux8 (ssh-add)

El comando eval $(ssh-agent) se usa para iniciar el agente SSH (ssh-agent) y configurar el entorno para que las claves SSH puedan utilizarse sin necesidad de ingresar la contraseña en cada conexión.

### root@debian:~#eval $(ssh-agent)

root@debian:~#ssh-add -t 2m /root/.ssh/id_rsa

## Ahora no nos tendra que pedir el password de la llave privada:

### root@debian:~#ssh 192.168.33.10 cat /etc/hostname

root@debian:~#ssh root@192.168.33.10 exit

root@debian:~#scp /etc/hostname  root@192.168.33.10:/tmp

## Pasado los dos minutos Tiene que pedir el password del certificado para conectarme:

### root@debian:~#ssh root@192.168.33.10

eval $(ssh-agent) inicia un agente SSH y “inyecta” en tu shell las variables que imprime (SSH_AUTH_SOCK y SSH_AGENT_PID). Así, los clientes SSH/Git hablan con el agente, que guarda tus claves privadas en memoria y evita reintroducir la passphrase.

## Qué ocurre

```bash
ssh-agent imprime asignaciones de entorno.
```

eval las ejecuta en tu shell actual → quedan exportadas: SSH_AUTH_SOCK: socket UNIX para hablar con el agente. SSH_AGENT_PID: PID del agente.

---

Procedimiento ampliar la swap en 2GB obteniendo de la particion / en el laboratorio practico no persistimos en el /etc/fstab.

---

Crear el usuario martes7 grupo primario informatica y grupo secundario sistemas.

El usuario martes7 tiene una tarea en el cron: Buscar en el /tmp archivos modificados hace menos de 5 minustos, la tarea es en dias laborables y se lanza a las 11:30 horas.

El usuario sabdo25 tiene una regla de sudo: le permitimos ediar con el vi  el archivo /etc/ssh/sshd_config

El usuario sabdo25 tiene un alias de correo para todos los correos locales enviados a empres-a.

A todos los usuarios del sistema tiene que tener de forma mandatoria la variable PS1:

## Prompt colorido permanente (verde brillante sobre fondo negro)

```conf
PS1='\[\e[1;32m\]\u@\h:\w\$\[\e[0m\] '
```

---

```bash
vi /root/.bash_profile
PATH=$PATH:$HOME/bin:/lpic1:/scripts
```

### lo que hace es añadir al final de tu PATH dos directorios:

### "$HOME/bin"

### "/lpic1"

Al quedar al final, los binarios del sistema (p. ej. /usr/bin, /bin) siguen teniendo prioridad. Si en esos directorios hay ejecutables con el mismo nombre que en el sistema, se usará el del sistema primero.
