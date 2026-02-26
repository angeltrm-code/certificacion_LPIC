Crear usuarios desde usu1 a usu5

Crear grupo informatica y grupo sistemas y micro
groupadd informatica
groupadd sistemas
groupadd micro
El usu1 pertenece al grupo primario informatica y al grupo secundario micro, y no tiene shell
adduser -g informatica -G micro,sistemas -s /sbin/nologuin usu1
passwd usu1

El usu2 su grupo primario es micro y tiene que cambiar el password al siguiente inicio de sesion
adduser -g micro usu2
passwd usu2
chage -d 0 usu2


El usue3 la cuenta le caduca este viernes.
adduser -e 20151017 usu3
passwd usu3
chage usu3

chage -E 2015/10/16 usu3

El usu4 no tiene shell y tiene la cuanta bloqueada
adduser -s /sbin/nologuin usu4
usermod -L usu4
passwd -S usu4
usermod -s /sbin/nologin usu4; passwd -l usu4

El usu5 grupo primario nominas le caduca el pass el viernes, y tine que tener los siguientes alias
adduser -g nominas -e 20151017 usu4
vi /home/usu4/.bashrc
alias rm='rm -i'
alias ls='ls -la'

groupadd nominas;usermod -g nominas usu5; chage -E 2015/10/16 usu5; sed -i 's/rm -i/rm -rf/g' /home/usu5/.bashrc; echo 'alias ls=\'ls -la\' >> /home/usu5/.bashrc

el comando rm no tiene que pedirle confirmacion al borrar

El comando ls tine que mostrar los ocultos y los permisos, ademas tiene que tener la variable LD_LIBRARY_PATH
del laboratorio de instalacion de librerias de oracle.

vi /home/usu5/.bash_profile
LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/lib
export LD_LIBRARY_PATH
