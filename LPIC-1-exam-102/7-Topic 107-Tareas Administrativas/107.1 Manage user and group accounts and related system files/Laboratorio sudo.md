# sudo

sudo (abreviatura de Substitute User DO) es un comando fundamental en sistemas operativos tipo Unix, como Linux y macOS.

## Su función principal es permitir a un usuario ejecutar programas con los privilegios de seguridad de otro usuario, que por lo general es el superusuario o root (el administrador del sistema).


# ¿Cómo funciona en la práctica?
Normalmente, por seguridad, un usuario común no tiene permiso para instalar software, modificar archivos del sistema o cambiar configuraciones críticas. Si intentas hacerlo, el sistema te dará un error de "Permiso denegado".

#Cuando antepones sudo a un comando:
El sistema te pide tu propia contraseña (no la de root).
Verifica si estás en la "lista de permitidos" (archivo sudoers).
Si todo es correcto, ejecuta el comando como si fueras el administrador.


# Todo lo que los usuarios realizan con sudo se registra:
cat /var/log/secure

# Sudoreplay# 
Puedes reproducir esas sesiones y ver que acciones han ejecutado en sudo por los usuarios:


# Activarlo en la linea 51 del archivo /etc/sudoers:
# en el vi para activar numero de lineas:

# Ejecutamos el comando visudo y añado sobre la linea 51:
visudo
/etc/sudoers
:set nu 
:51
Defaults log_output


# Creamos este directorio.

mkdir -m 750 /var/log/sudo-io



# Laboratorio sudo:

adduser angel
passwd 1234

/etc/sudoers se edita con visudo y añadimos al final del archivo :

visudo

angel ALL = (ALL)  /bin/vi /etc/httpd/conf/httpd.conf, /usr/bin/systemctl restart httpd, /usr/bin/less,  /usr/bin/passwd [A-z]*, !/usr/bin/passwd root

#angel ALL = (ALL)  NOEXEC: /bin/vi /etc/httpd/conf/httpd.conf, /usr/bin/systemctl restart httpd,/usr/bin/less, /bin/rm

# Entramos en el sistema con el usuario angel siempre el password es el del usuario nominal (angel):
sudo -l

# Ejecuto el comando como usuario nominal a traves de sudo:
sudo /bin/vi /etc/httpd/conf/httpd.conf


# Ejecuto, si dentro del vi ejecuto
:shell

# Me tendria que quedar en el sistema como root:
id

# Si ahora ejecuto el comando exit me vuelvo al vi y si salimos del vi estaria ya como usuario en el sistema y cierro session del usuario con el comando:

exit

# Ahora como usuario root puedo ver lo que ha realizado mi usuario nominal a traves de sudoreplay:

# Para visualizar la grabación que queremos reproducir sólo hemos de especificar el TSID, por ejemplo:
sudoreplay -l

# Ejemplo de salida:
dic  4 10:45:01 2025 : berto : HOST=rockylinux8.curso.local ; TTY=/dev/pts/2 ; CWD=/home/berto ; USER=root ; TSID=00002Y ; COMMAND=/bin/vi /etc/httpd/conf/httpd.conf


# Para ver la grabacion ejecutarial el valor que tenga en TSID=00002Y:
sudoreplay 00002Y


# Pero también podemos filtrar por usuario, en este caso el usuario es operador:

sudoreplay -l user operador 

# Por comando, pongamos como ejemplo nano:

sudoreplay -l command rm