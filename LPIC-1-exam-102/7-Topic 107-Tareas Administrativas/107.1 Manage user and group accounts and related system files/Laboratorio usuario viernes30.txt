Crear los grupo sistemas informatica y micro
groupadd sistemas
groupadd informatica
groupadd micro


Crear el usario1 grupo primario informatica y no tiene shell
adduser -g informatica -s /sbin/nologin usuario1
passwd usuario1

Crear el usuario2 y la cuenta le caduca mañana
adduser -e 2020-11-02 usuario2
passwd usuario2
chage -l usuario2

Crear el usuario3 y que en el primer inicio de session le pida el cambio de password
adduser usuario3
passwd usuario3
chage -d 0 usuario3

Crear el usuario4
tiene que tener el alias de comando listar y sea un ls com permisos largos y ordene los ficheros por fecha de modificacion
Tiene instalado java en el directorio /usr/local/jdk1.7 tiene que esta la varible JAVA_HOME

adduser usuario4
passwd usuario4

vi  /home/usuario4/.bashrc
alias listar='ls -lrta'


vi  /home/usuario4/.bash_profile
JAVA_HOME=/usr/local/jdk1.7
export JAVA_HOME
--------------------------------------------------------------------------
env
echo $JAVA_HOME
echo $PATH
alias
