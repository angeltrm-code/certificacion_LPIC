
# Manual LINUX - Preparación a la certificación LPIC-1.pdf -->Pagina 426

ssh (Secure Shell) es un protocolo de red que permite conexiones seguras y encriptadas entre dos dispositivos en una red. Se utiliza comúnmente para administración remota, transferencia de archivos, y ejecución de comandos de forma segura, especialmente en sistemas Linux y Unix.


# Esquema de Comunicación SSH (Secure Shell) entre Cliente y Servidor

# Cliente inicia conexión
El cliente envía una solicitud de conexión al servidor SSH a través del puerto TCP 22.

# Negociación de protocolos
El servidor responde con la versión del protocolo SSH y la lista de algoritmos de cifrado soportados.
El cliente selecciona el mejor conjunto de algoritmos y confirma al servidor.

# Intercambio de claves
Se utiliza el algoritmo Diffie-Hellman para generar una clave compartida de manera segura.
El servidor envía su clave pública al cliente.
El cliente utiliza la clave pública del servidor para generar la clave compartida.

# Autenticación
El cliente se autentica ante el servidor.
Métodos comunes: contraseña, clave pública, autenticación de dos factores (2FA).
Si se usa clave pública, el cliente envía su clave pública al servidor, que la compara con las claves permitidas.

# Establecimiento de canal seguro
Una vez autenticado, se crea un canal seguro utilizando la clave compartida.
Todos los datos posteriores se cifran utilizando la clave generada.

# Comunicación de datos
El cliente y el servidor intercambian comandos y respuestas cifradas.
El cifrado garantiza la integridad y confidencialidad de los datos durante toda la sesión.

Cierre de la sesión
El cliente o el servidor pueden cerrar la sesión.
El canal seguro se destruye y finaliza la conexión.


# Diagrama ASCII de Comunicación SSH

+---------+       1. TCP connection       +---------+
| Cliente | -----------------------------> | Servidor |
+---------+                               +---------+

+---------+       2. Key Exchange          +---------+
| Cliente | <-----------------------------> | Servidor |
+---------+                               +---------+

+---------+       3. Authentication         +---------+
| Cliente | -----------------------------> | Servidor |
+---------+                               +---------+

+---------+       4. Encrypted Session       +---------+
| Cliente | <-----------------------------> | Servidor |
+---------+                                  +---------+


id_rsa  
id_rsa.pub

yum -y install openssh openssh-server openssh-clients
apt install -y openssh openssh-server openssh-clients

OpenSSH incluye servicio y clientes para los protocolos SSH, SFTP y SCP

# El directorio principal de configuración del servidor SSH.
/etc/ssh


# Archivo principal de configuración del servidor SSH.
/etc/ssh/sshd_config
cp /etc/ssh/sshd_config  /root


OpenSSH incluye servicio y clientes para los protocolos SSH, SFTP y SCP

# Archivo principal de configuración de los clientes SSH utilizados desde el
anfitrión local.
/etc/ssh/ssh_config

anfitrión local.
~/.ssh/config
Archivo personal para cada usuario, que almacena la configuración utilizada
por los clientes SSH utilizados desde el anfitrión local. Permite al usuario
local utilizar una configuración distinta a la definida en el archivo
/etc/ssh/ssh_config.
~/.ssh/known_hosts

Archivo personal para cada usuario, el cual almacena las firmas digitales de
los servidores SSH a los que se conectan los clientes. Cuando éstas firmas
cambian, se pueden actualizar utilizando el mandato ssh-keygen con la
opción -R y el nombre del anfitrión como argumento, el cual elimina la
entrada correspondiente del archivo ~/.ssh/known_hosts, permitiendo añadir
de nuevo el anfitrión con una nueva firma digital. Ejemplo: ssh-keygen -R
nombre.dominio.tld.

~/.ssh/authorized_keys
Archivo personal para cada usuario, el cual almacena los certificados de los
clientes SSH, para permitir autenticación hacia servidores SSH sin requerir
contraseña.

Cuando se utilizan cuentas con acceso al intérprete de mandatos, las opciones
suministradas al mandato ssh tienen precedencia sobre las opciones establecidas en el
archivo ~/.ssh/config, que a su vez tiene precedencia sobre las opciones definidas en el
archivo /etc/ssh/ssh_config.


# Para testear la configuracion del archivo /etc/ssh/sshd_config
sshd -t

# Para poner numeros de linea dentro del vi:
Pulsamos la tecla escape
:set nu



vi /etc/ssh/sshd_config
systemctl restart sshd
systemctl status sshd

# Resumen de opciones basica de OpenSSH:

*Opciones de configuración de sshd_config
# Port:
Define el puerto en el que el servidor SSH escuchará conexiones.
Ejemplo: Port 2222 (cambia el puerto predeterminado 22 a 2222).
Cambiar el puerto puede ayudar a reducir intentos de acceso no autorizados.

# ListenAddress:
Especifica la dirección IP en la que el servidor SSH escuchará conexiones.
Ejemplo: ListenAddress 192.168.1.10
Puede configurar múltiples direcciones usando varias líneas de ListenAddress.
Útil para limitar SSH a una interfaz específica en servidores con múltiples IPs.

# PermitRootLogin:
Controla si el usuario root puede iniciar sesión a través de SSH.
Opciones:
yes: Permite el inicio de sesión de root.
no: Desactiva el inicio de sesión de root (recomendado por seguridad).
prohibit-password: Solo permite root con autenticación de clave.
Ejemplo: PermitRootLogin no (recomendado).

# X11Forwarding:
Habilita o deshabilita el reenvío de sesiones X11, que permite ejecutar aplicaciones gráficas a través de SSH.
Opciones: yes o no.
Ejemplo: X11Forwarding yes (habilita el reenvío X11).
Se recomienda desactivar (no) si no necesitas ejecutar aplicaciones gráficas de forma remota.

# AllowUsers:
Define una lista específica de usuarios permitidos para iniciar sesión a través de SSH.
Ejemplo: AllowUsers usuario1 usuario2@192.168.1.5
Permite restricciones adicionales, como IPs específicas, para cada usuario.
Esto mejora la seguridad al limitar el acceso solo a ciertos usuarios.

La opción DenyUsers en el archivo de configuración de SSH (/etc/ssh/sshd_config) permite especificar una lista de usuarios a los que se denegará el acceso al servidor a través de SSH. Esta configuración es útil para mejorar la seguridad al restringir ciertos usuarios o combinaciones de usuario y dirección IP.

# UseDNS:
Controla si el servidor SSH realiza búsquedas DNS inversas para los clientes que se conectan.
Opciones: yes o no.
Ejemplo: UseDNS no
Desactivar (no) puede mejorar la velocidad de conexión en redes lentas o con problemas de DNS, ya que evita las búsquedas DNS inversas.



# OpenSSH incluye servicio y clientes para los protocolos SSH, SFTP y SCP.

# ssh
ssh (Secure Shell) es un protocolo y herramienta en Linux y otros sistemas operativos que permite realizar conexiones remotas seguras a otros sistemas. SSH cifra la conexión, protegiendo la transferencia de datos y la comunicación, lo que lo convierte en la opción preferida para administración remota de servidores, ejecución de comandos remotos, transferencia de archivos segura, y más.

ssh usuario@maquina.curso.local
ssh operador@192.168.1.5
ssh root@192.168.1.5 
ssh 192.168.33.150

ssh -p 52341 juan@192.168.70.99
-p puerto: Especifica el número de puerto del servidor SSH.

# Opciones comunes de ssh
-i: Especifica un archivo de clave privada para la conexión.
-N: No ejecuta ningún comando; solo establece la conexión (útil para túneles).
-T: Deshabilita la asignación de pseudo-terminal (para ejecutar comandos simples).
-f: Envía la conexión al background después de la autenticación (útil para túneles persistentes).
-v: Activa el modo de depuración (verboroso), útil para solucionar problemas de conexión.
-p puerto: Indica el número de puerto al que se debe conectar.


# SFTP
SFTP (SSH File Transfer Protocol) es un protocolo de transferencia de archivos que utiliza una conexión segura mediante SSH. A diferencia de FTP, SFTP cifra tanto la autenticación como la transmisión de datos, lo que lo hace adecuado para transferencias de archivos seguras en redes inseguras.

sftp usuario@servidor
sftp -o Port=52341 juan@192.168.70.99


-i ruta/a/clave: Usa una clave SSH específica para la autenticación.
-b archivo: Ejecuta un conjunto de comandos desde un archivo de texto.
-C: Activa la compresión durante la transferencia para archivos grandes
-o Port=52341: Especifica el puerto en el que el servidor SSH escucha las conexiones. Esto es útil cuando el servidor SSH no está en el puerto predeterminado (22).

# scp 
scp (Secure Copy Protocol) es una herramienta de línea de comandos en Linux y Unix que permite copiar archivos y directorios entre un sistema local y un servidor remoto, o entre dos servidores remotos, utilizando una conexión segura mediante SSH. scp cifra los datos en tránsito, protegiendo la transferencia de archivos frente a accesos no autorizados.

scp  /root/algo.txt operador@192.168.70.99:/home/operador

# Para que funcione la orden primero tenemos que colocar el puerto antes del fichero a copiar
scp  -P 52341 algo.txt  operador@192.168.70.99:/home/operador
scp  -p -P 52341 algo.txt   192.168.70.99:/home/operador


# Esto no funcionaria:
scp  algo.txt -P 52341   operador@192.168.70.99:/home/operador

# Donde Ejemplos-scrpts es un directorio:
scp -r Ejemplos-scrpts vagrant@192.168.33.10:/tmp

# Opciones comunes de scp
-r: Copia directorios de manera recursiva.
-P: Especifica el puerto SSH a utilizar.
-C: Habilita la compresión para acelerar la transferencia (útil para archivos grandes).
-i: Especifica un archivo de clave privada diferente para la autenticación.
-v: Activa el modo verboroso para obtener información adicional sobre la transferencia (útil para depuración).
-p: en scp preserva los permisos, marcas de tiempo y la propiedad del archivo o directorio al copiarlo al destino. Esto es útil cuando deseas mantener la integridad de los atributos del archivo original, como la hora de creación y modificación, permisos y el propietario.

En el siguiente ejemplo, se transferirá la carpeta Mail, junto con todo su contenido,
desde el directorio de inicio del usuario operador en el servidor 192.169.0.99, cuyo
servicio de SSH escucha peticiones a través del puerto 52341, preservando tiempos y
modos, hacia el directorio del usuario con el que se está trabajando en el anfitrión local.

cd /root
scp -P 52341 -rp operador@192.168.70.99:/home/operador/Mail ./


# Desde la mv debian copiamos un archivo:

scp -P 52341 archivo operador@192.168.30.10:/tmp


# Especificar la llave privada al Conectarse a un Host
Cuando te conectes a un host remoto, puedes especificar la llave privada con el parámetro -i de ssh:

ssh -i ~/.ssh/RSAPair user@hostname



# Ejemplo de configuracion, se añadiria al final del arhivo /etc/ssh/sshd_config

vi /etc/ssh/sshd_config

# Modificaion del adaministrador 25/10/2024
Port 2222
ListenAddress 192.168.1.10
PermitRootLogin no
X11Forwarding no
AllowUsers usuario1 gerente@192.168.1.25/24
UseDNS no


# Para aplicar los cambios en el servicio:
systemctl restart sshd
systemctl status sshd




***Laboratorio configurar Openssh COMPLETO LPIC-1:

# Realizamos una copia de seguridad del archivo principal del servidor:
cp /etc/ssh/sshd_config /root

# Configurar nuestro servidor openssh:
Puerto 52412
No permitimos conexion al usuario root
No permitimos el renvio de las X
Solamante el usuario vagrant se puede conectar a nuestro servidor ssh y el usuario operador desde la ip 192.168.33.151
Banner /etc/ssh/sshd-banner

# Copiamos de nuestro windows a nuestro linux el archivo c:\windows.txt /tmp

adduser operador
passwd operador

# Añadimos las entradas al final del archivo
vi  /etc/ssh/sshd_config

# Entra añadida administrador el 21/02/2025
Port 52412
PermitRootLogin no
X11Forwarding no
AllowUsers vagrant operador@192.168.33.151
Banner /etc/ssh/sshd-banner


vi  /etc/ssh/sshd-banner
# 
#                  Authorized access only!                     # 
#  Disconnect IMMEDIATELY if you are not an authorized user!!! # 
#          All actions Will be monitored and recorded          # 
# 


# Reiniciamos el servicio:
systemctl restart sshd
systemctl status sshd



# Copiamos de nuestro windows a nuestro linux el archivo c:\windows.txt al directorio /tmp

scp -P 52412 c:\windows.txt  vagrant@192.168.33.150:/tmp

# Para comprobar el laboratorio:
-El puerto es 52412
-Solo me puedo conectar con el usuario vagrant
-No puedo conectarme con el usuario root

-El usuario operador se puede conectar a traves de ssh desde la maquina nuestro linux que tiene la ip 192.168.33.151
 ssh -p 52412  operador@192.168.33.150

Comprobar que el usuario root no se puede conectar.
Comprobar que el usuario vagrant si se puede conectar



# Tras la finalizacion del laboratorio lo dejamos por defecto el servicio Openssh:

cp /root/sshd_config  /etc/ssh/
systemctl restart sshd
systemctl status sshd