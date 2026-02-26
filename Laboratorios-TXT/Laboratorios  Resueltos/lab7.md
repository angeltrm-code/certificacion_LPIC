Como forzar el fsck al proximo reinicio del sistema /
touch /forcefsck
como añadir el servicio de apache al inicio  con sysv y systemd
systemctl enable httpd  
chkconfig --level 35 httpd on
/etc/rc3.d/S85httpd --> /etc/init.d/httpd
/etc/rc5.d/S85httpd --> /etc/init.d/httpd


Forzar el cambio de password a un usuario  en el proximo inicio de sesion
chage -d 0 usuario
Bloquear la cuenta del usuario3
usermod -L usuario3
passwd -l usuario3
passwd -S usuario3

Eliminar del sistema al usuario3
userdel -r  usuario3

Excluir los paquetes del kernel de la actualizacion de dnf
vi /etc/dnf.conf 
exclude=kernel* php*
dnf update --exclude=php* kernel*

Comamdo para ver el runlevel en el que estoy  actualmente
runlevel
systemctl get-default
cat   /etc/systemd/system/default.target

Comando para poner en segundo plano un proceso
bg

Buscar archivos modificados en los ultimos 5 minutos
find / -type f -mmin -5
find / -type f -mtime -1

Buscar archivos modificados entre mas de 1 hora  y menos de 3
find / -type f -mmin +60 -mmin -180
Buscar archivos modificados hace menos de 3 minutos
find / -type f mmin -3
Archivo donde se configura el runlevel predeterminado de systemV
/etc/inittab

Desbloquear la cuenta del usuario3
passwd -u usuario3
usermod -U usuario3
passwd -S usuario3

Comando para localizar un comando a traves del path
which httpd

Tarea programada en el cron para el script /opt/supervisamem
 todos los dias a las 15 horas y que su salida (stdout,stderr) la envie por correo
0 15 * * * /opt/supervisamem 2>&1 |mail -s "Ejecucion de supervisamem" operador@m.com

Proramar una tarea con at a las 12h para que lance el script /opt/supervisamem
at -f /opt/supervisamen 12:00
atq
atrm numero del job

Renviar los correos electronicos del usuario local becario al correo sistemas@miempresa.com
/home/becario/.forward
sistemas@miempresa.com