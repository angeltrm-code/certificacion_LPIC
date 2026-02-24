Crear el usuario1 y que su grupo primario sea informatica
addgroup informatica
addgroup micro
adduser -g informatica ususario1
passwd usuario1
Crear el usuario2 que no tenga shell y su grupo secuandario sea micro
adduser -G micro -s /sbin/nologuin usuario2
passwd usuario2
Crear el usuario3 que le expire la cuenta el miercoles 27
adduser -e 20160127 usuario3
passwd usuario3
Crear el usuario4 que su grupo primario sea informatica y su grupo secundario micro
adduser -g informatica -G micro usuario4
passwd usuario4

Crear el usuario5 que tenga los siguientes alias:
que con rm borre y no le pida confirmacion
que con ls le muestre los archivos ocultos y permisos largos y ordene por fecha de modificacion mas reciente

adduser usuario5
passwd usuario5
vi /home/usuario5/.bashrc
alias rm='rm -rf'
alias ls='ls -lrta'

Modificar el usuario2 para que tenga shell y pertenece al grupo secundario informatica
usermod -s /bin/bash -G informatica usuario2

chage -d 0 usuario  Con este comando forzamos el cambio de contraseña cuando el usuario inicia sesio, el pass es complejo

Crear el usuario usuario6 y forzar el cambio de contraseña en el 1 inicio de sesion del usuario
adduser usuario6
passwd usuario6
chage -d 0 usuario6