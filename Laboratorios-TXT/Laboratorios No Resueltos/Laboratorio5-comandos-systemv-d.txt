Volcado de 3 interaciones del comanto top en un archivo llamado uso_sistema.txt
top -bn 3 > uso_systema.csv
Ordenar top por memoria
top -o
Lanzar el comando xterm en segundo plano y que no se cuelgue ante el cierre de sesion
nohub xterm &
Traer a prirmer plano el trabajo del xterm
jobs
fg 1
Comando para iniciar apache en sistemd y sistemv
service httpd start
systemctl start httpd

Comando para poner al inicio el servicio atd en systemv y systemd
chhkconfig --level 5 atd on
systemctl enable atd
En systemd que no se inicia el servicio httpd
systemctl disable httpd
En systemd enmascarar el servicio httpd
systemctl mask httpd
Cambiar de runlevel y targes grafico en redhat7
systemctl isolatle graphical.target
init 5
telinit 5
Comando para averiguar el target por defecto
systemctl get-default
runlevel
Comando para listar las units tipo service
systemctl list-units --type service
Mostrar toda la informacion de la unit httpd.service
systemctl show httpd