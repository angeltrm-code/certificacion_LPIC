#Cuantos caracteres tiene el archivo /etc/passwd
wc --help
wc -m /etc/passwd 

#Conseguir del archivos passwd los usuarios y sus directorios personales
cut -d : -f 1,6 /etc/passwd

#Version del kernel
uname -r

#Buscar archivos con permisos especiales setuid
find / -perm -4000 -ls

#Con el comando ls mostrar el numero de inodo del directorio /root
ls -lid /root
ls -lid /root |tr -s " " |cut -d " " -f1,10

#Buscar archivos modificados de hace menos de 5 minutos
find / -type f -mmin -5

#Version del sistema oprativo
cat /etc/redhat-release
cat /etc/debian_version
lsb_release -a

#Cuantas cpus tenemos y cuantas memoria tiene el servidor
cat /proc/cpuinfo
lscpu

cat /proc/meninfo
free -h

#Modelo de disco duro y tarjeta de red
dmesg |grep -i sda ; dmesg |grep -i eth0
lspci
lspci -s 00:03.0 -v
lspci -s 00:03.0 -k


#Modelo de Cdrom
dmesg |grep -i cdrom
dmesg |grep -i sr0
lspci

#Al directorio /datos el propietarios tiene permisos de lectura, escritura y ejecucion en modo alfabetico
chmod u+rwx /datos
chmod 700 /datos
ls -ld /datos

#Ejecutar el comando ls y recuperar el stderr y stdout y llevarlo a /tmp/salida.txt
ls / 2>&1 > /tmp/salida.txt
du -sh /  2>  /dev/null
du -sh /  >  /tmp/files  --> Este comando calcula el uso total del espacio en disco del sistema y guarda el resultado en el archivo /tmp/files


#Listar las units de tipo service en systemd
systemctl list-units --type service --all

#Poner al inico el servicio de apache en systemv y systemd
chkconfig --level 3 httpd on
ln -s /etc/init.d/httpd   /etc/rc3.d/S85httpd

systemctl enable httpd

#Arrancar el service httpd con systemv y systemd
service httpd start
/etc/init.d/httpd start
systemctl start httpd

#Averiguar si el apache se iniciara con el sistema en systemv y systemd
chkconfig --list httpd apache2
systemctl  is-enabled httpd apache2

#Cambiar al target o runlevel 3 tanto en systemd como en systemv en caliente
init 3
telinit 3

systemctl isolate multi-user.target

#Averiguar en que target arranca el sistema en systemd
systemctl get-default

#Ver con journalctl los logs de error del servicio sshd
journalctl -p err -u sshd

#Ver todos los logs de error del sistema con journalctl
journalctl -p err

#Ver los logs del service httpd y mariadb con journalctl
journalctl -u mariadb -u httpd

#Ver los logs de los ultimos 5 minutos del servicio sshd
journalctl --since '5 min ago' -u sshd

#Tarea programada a las 23 horas de lunes a viernes como root para buscar archivos modificados hace menos de 5 minustos en /web
0 23 * * 1-5  /usr/bin/find /web -type f -mmin -5  2>&1 |mail -s "Archivos modificado hace menos de 5 minutos" usuario@gmail.com vagrant

#Denegar el cron a todos los usuario menos a gerente y operador.
touch /etc/cron.allow

vi  /etc/cron.allow
gerente
operador
