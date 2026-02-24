#Volcado de 3 interaciones del comanto top en un archivo llamado uso_sistema.csv
top -bn 3 > uso_sistema.csv

#Ordenar top por memoria
top M

#Lanzar el comando xterm en segundo plano y que no se cuelgue ante el cierre de sesion
nohup xterm &
echo $$

#Traer a prirmer plano el trabajo del xterm
jobs
fg 1

#Programamar el status de la red cada 5 minutos y que nos lo envie por correo con cron
crontab -e
*/5 * * * * /usr/bin/systemctl NetworkManager status   2>&1 |mail -s "Estado network" operador


#Comando para eliminar una tarea programada en at
atrm 1

#Comando para ver la colas de tareas programada con at
atq 
/var/spool/at

#Programar a las 11h el scrtip /opt/backup.sh con at
at 11:00  -f /opt/backup.sh

#Comando para cambiar prioridad de un proceso
renice

#Prohibir utilizar a todos los usuario cron y at excepto a root y operador
vi /etc/cron.allow
vi /etc/at.allow

root
operador


#Comando para cambiar como usuario el grupo primario informatica
newgrp informatica

#Comando para forzar a un usuario el cambio de password al siguiente inicio de sesion al usuario operador.
chage -d 0 operador
passwd -e operador

chage -l operador

#Crear el usuario usuario1 sin shell y su grupo primario informatica
adduser -s /sbin/nologin -g informatica usuario1
passwd usuario1

#Añadir al grupo secundario sistemas al usuario1
usermod -Ga sistemas usuario1
gpasswd -a usuario1 sistemas

#Poner una tarea programada cada 5 minutos con el cron para reinicar el service httpd
*/5 * * * *  /usr/bin/systemctl restart httpd   2>&1 |mail -s "Estado del Apache" operador



#Que hace el comando mail -s
Envia un mail -s 

#Comando para imprimir con lp el archivo datos.txt 3 copias
lp -dimpresona -n 3 datos.txt

#Que hace el comando systemd-cat
systemd-cat es una herramienta que permite enviar la salida de comandos o scripts directamente al journal de systemd, el sistema de gestión de servicios y registros (logging) en sistemas basados en systemd. Esto es útil para registrar mensajes o la salida de procesos en el journald para su análisis posterior.

echo 'Reinicar el servidor' | systemd-cat -p emerg


#Eliminar el trabajo 3 de at
atrm 3

#Comando para ver los trabajos de cron que tenemo en cola para nuestro usuario
crontab -l

#Bloquear la cuenta del usuario usu1, con el comando usermod y passwd, y como puedo ver que la cuenta esta bloqueada
y averiguar si el usuario tiene el password bloqueado.

usermod -L usu1
passwd -l usu1

chage -l usu1
passwd -S usu1
