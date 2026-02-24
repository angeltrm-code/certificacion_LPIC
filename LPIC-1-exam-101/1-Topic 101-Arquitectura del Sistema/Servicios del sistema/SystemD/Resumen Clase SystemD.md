https://wiki.archlinux.org/index.php/systemd_(Espa%C3%B1ol)

##SystemD##

systemd apareció por primera vez en 2010, cuando fue anunciado por Lennart Poettering y Kay Sievers, ingenieros de Red Hat. Fue diseñado como un reemplazo moderno para el tradicional System V init y Upstart, con el objetivo de mejorar la gestión de servicios en sistemas Linux.


SystemD es un sistema de inicialización y gestor de servicios ampliamente utilizado en sistemas operativos basados en Linux. Fue diseñado para reemplazar sistemas de inicialización tradicionales como SysVinit y Upstart, proporcionando una forma más eficiente y flexible de gestionar los servicios del sistema.

##Principales características de SystemD:

#Gestión de servicios:

SystemD permite iniciar, detener y supervisar servicios del sistema mediante unidades (units).
Soporta dependencias entre servicios y garantiza un inicio ordenado del sistema.
Paralelismo:
Utiliza un enfoque basado en sockets para iniciar servicios de manera paralela, mejorando los tiempos de arranque.
Unidades (units):

Representan configuraciones de servicios, montajes, dispositivos, temporizadores, etc.

#Tipos comunes de unidades:
service: Un servicio (e.g., nginx, sshd).
target: Agrupaciones de unidades (equivalente a los runlevels tradicionales).
timer: Tareas programadas.
mount: Puntos de montaje.

#Journaling:
SystemD incluye journald, un sistema de logging centralizado que almacena logs binarios del sistema y servicios.
Soporte para cgroups:
Integra cgroups para limitar y monitorizar recursos utilizados por procesos.
Compatibilidad retroactiva:

Ofrece compatibilidad con scripts de inicio de SysVinit para facilitar la transición.

##Principales características de systemd
Inicio paralelo de servicios, reduciendo el tiempo de arranque.
Uso de "sockets" para activación de servicios.
Administración simplificada de procesos con systemctl.
Soporte para "cgroups" (control groups) para limitar recursos de servicios.
Unificación de logs mediante journald.
Herramientas integradas como systemd-networkd, systemd-resolved, systemd-timesyncd.


ps -ef |more
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 08:31 ?        00:00:01 /usr/lib/systemd/systemd

systemctl

systemctl --version


##SystemD en debian para mostrar el pid 1 si nos dice que es init##

cat /proc/1/stat
1 (systemd)

apt update
apt install psmisc -y
pstree -Apn |more

------------------------------------------------------------------------------------------------------------
##Existen siete tipos diferentes de unidades:
- service: Demonios que pueden ser iniciados, detenidos, reiniciados o recargados.

- socket: Esta unidad encapsula un socket en el sistema de archivos o en Internet. Cada unidad socket tiene una unidad de servicio correspondiente.

- device: Esta unidad encapsula un dispositivo en el árbol de dispositivos de Linux.

- mount: Esta unidad encapsula un punto de montaje en la jerarquía del sistema de archivos.

- automount: Encapsula un punto de montaje automático. Cada unidad automount tiene una unidad mount correspondiente, que se inicia al acceder al directorio de automontaje.

- target: Utilizada para la agrupación lógica de unidades. Referencia a otras unidades, que pueden ser controladas conjuntamente, un ejemplo sería multi-user.target, que básicamente desempeña el papel de nivel de ejecución 3 en el sistema clásico SysV.

- snapshot: Similar a las unidades target.

- timer (.timer) es una unidad que programa la ejecución de un servicio (.service) en un momento específico o de manera recurrente, funcionando como un reemplazo más flexible y moderno de cron.

##systemd-cgls nos muestra recursivamente el contenido del árbol de jerarquías de un determinado
##grupo de control de Linux:

systemd-cgls

 systemctl list-units --all
 
##Para ver las units de tipo service
systemctl list-units --type service --all

UNIT               LOAD      ACTIVE   SUB     DESCRIPTION

2. LOAD (Cargado)
Indica si la unidad ha sido cargada desde el disco.
Puede tener valores como:
loaded → El archivo de unidad existe y está cargado en systemd.
not-found → El archivo de unidad no existe.

3. ACTIVE (Estado global de la unidad)
Estado principal de la unidad:
active → Está en ejecución o lista para ejecutarse.
inactive → Está detenida.
failed → Falló su ejecución.

4. SUB (Estado detallado de la unidad)
Muestra un estado más específico dentro del estado ACTIVE, dependiendo del tipo de unidad:
Para servicios (.service):
running → Servicio en ejecución.
exited → Servicio finalizado correctamente.
dead → Servicio detenido.
Para timers (.timer):
waiting → Esperando para ejecutarse.
elapsed → Ya se ejecutó.
Para sockets (.socket):
listening → Está esperando conexiones.

5. DESCRIPTION (Descripción)
Breve descripción de la unidad, generalmente tomada del archivo .service o .timer.


##Para trabajar con targets.

En systemd, un target (.target) es una unidad que agrupa varias unidades (.service, .socket, .mount, etc.) y se usa para gestionar el estado del sistema. Los targets reemplazan los runlevels de SysVinit y permiten organizar el inicio y apagado del sistema de manera flexible.

cat /etc/inittab
To view current default target, run:
# systemctl get-default
#
# To set a default target, run:
# systemctl set-default TARGET.target

systemctl get-default

systemctl set-default graphical.target

##Para cambiar en caliente de target equivalente al comando init o el comando telinit
systemctl isolate  TARGET.target

systemctl isolate runlevel1.target 
systemctl isolate rescue.target


##Targets Principales en systemd
Los targets más importantes en un sistema Linux con systemd son:

Target	         Descripción
default.target	Target por defecto al iniciar el sistema (generalmente es un alias a graphical.target o multi-user.target).

rescue.target	Modo rescate, similar al "single-user mode" en SysVinit.

multi-user.target	Similar a runlevel 3, permite acceso multiusuario en modo consola sin GUI.

graphical.target	Similar a runlevel 5, inicia el sistema con una interfaz gráfica (GUI).

network.target	Se usa para indicar que la red está disponible.

shutdown.target	Apaga el sistema.

reboot.target	Reinicia el sistema.

emergency.target	Modo emergencia con acceso root sin dependencias.




systemctl snapshot actualizacion
systemctl list-units --type snapshot --all

Ahora podemos revertir el snapshot:
# systemctl isolate actualizacion.snapshot

##Borrar el snapshot del laboratorio
systemctl delete actualizacion.snapshot


##Systemd introduce el concepto de unidades systemd. Estas unidades están configuradas en archivos localizados 
##en las siguientes ubicaciones:

/usr/lib/systemd/system/: unidades distribuidas con paquetes RPM deb instalados.
/run/systemd/system/: unidades creadas en tiempo de ejecución. Tiene precedencia sobre el directorio anterior.
/etc/systemd/system/: unidades creadas y administradas por el administrador del sistema. 
Este directorio tiene precedencia sobre el directorio anterior

apt install apache2 -y

yum install httpd -y 
------------------------------------------------------------------
systemctl status httpd
systemctl is-active httpd
systemctl start  httpd
systemctl stop httpd
systemctl reload httpd
systemctl restart httpd


systemctl enable httpd
systemctl disable  httpd.service
systemctl is-enabled  httpd

##Pondria al inicio el service httpd y lo arrancara ahora.
systemctl enable httpd --now

# Enmascarar
systemctl mask nombre.service

# Desenmascarar
systemctl unmask nombre.service

##Para ver todas las units en masked:
systemctl list-unit-files | grep masked


#Para controlar Systemd en otra máquina:
systemctl --host nombre_usuario@nombre_maquina comando

O bien, también se puede utilizar SSH:
Puede utilizar las siguientes órdenes systemctl con el parámetro -H usario@host 
para controlar una instancia de systemd en una máquina remota. 
Esto utilizará SSH para conectarse a la instancia systemd remota.


##Ejemplo Conflicts unit service con sendmial y postfix levan los dos el mismo puerto 25
systemctl restart  sendmail
netstat -putan |grep -w 25
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      23638/sendmail: acc


 systemctl restart postfix.service

netstat -putan |grep -w 25
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      24288/master




yum install httpd -y
apt-get install apache2 -y


systemctl cat sendmail.service

#Muestra todas las propiedades del servicio sendmail.service, que es el servicio de Sendmail en sistemas basados en systemd 
systemctl show sendmail.service

vi /root/.bash_profile
export EDITOR=/usr/bin/vi

##Ejecutando este comando recargamos el .bash_profile
source /root/.bash_profile

echo $EDITOR

systemctl edit --full sendmail.service

##Averguar las modificaciones en nuestras units de tipo service:
systemd-delta

#Se pueden ver todas las sobreescrituras de scripts con el comando:


* El comando systemd-delta permite comparar configuraciones personalizadas de systemd con las predeterminadas del sistema. Es útil cuando has modificado archivos de configuración o cuando systemd anula archivos debido a sobreescrituras en /etc/systemd/system/

systemd-delta

#Este comando devolverá los siguientes estados:

MASKET: Muesta las unidades que no se pueden iniciar.
EQUIVALENT: Sobreescriben otras unidades con el mismo contenido
REDIRECT: Symbolic links a otras unidades
OVERRIDDEN: Unidades sobreescritas
EXTENDED: Unidades extendidas con ficheros .conf

-----------------------------------------------------------------------------------------------------------------
###Resumen de comandos systemd:
systemctl start	Iniciar un servicio
systemctl stop	Detener un servicio
systemctl restart	Reiniciar un servicio
systemctl reload	Recargar la configuración de un servicio
systemctl enable	Habilitar un servicio en el arranque
systemctl disable	Deshabilitar un servicio en el arranque
systemctl status	Ver el estado de un servicio
systemctl list-units --type=service	Ver todos los servicios
systemctl daemon-reload	Recargar configuraciones de systemd
journalctl -u	Ver logs de un servicio específico
systemctl reboot	Reiniciar el sistema
systemctl poweroff	Apagar el sistema

#Estos comandos te permiten gestionar qué servicios o targets se inician automáticamente cuando el sistema arranca y te ayudan a verificar si un servicio está habilitado o no.

sudo systemctl enable	Habilita un servicio para que se inicie al arrancar
sudo systemctl disable	Deshabilita un servicio para que no se inicie al arrancar
systemctl is-enabled	Verifica si un servicio está habilitado o deshabilitado

##TARGET:
systemctl list-units --type=target	Listar todos los targets disponibles
systemctl isolate nombre_del_target	Cambiar al target especificado
systemctl set-default nombre_del_target	Establecer el target por defecto al arrancar
systemctl get-default	Ver el target por defecto
systemctl list-dependencies nombre_del_target	Listar todas las dependencias del target
systemctl start nombre_del_target	Activar un target sin cambiar inmediatamente
systemctl disable nombre_del_target	Deshabilitar un target



#El comando journalctl permite ver, buscar y analizar registros (logs) generados por systemd. Es el reemplazo moderno de syslog y almacena los logs de todos los servicios del sistema en un solo lugar.

-->Lectura Laboratorio journalctl.pdf

##Comandos journalctl:
journalctl	Ver todos los logs
journalctl -f	Seguir los logs en tiempo real
journalctl -b	Ver logs desde el último arranque
journalctl -u nombre_servicio	Ver los logs de un servicio específico
journalctl -u httpd.service -u sshd.service

journalctl -p err	Ver solo logs de nivel de error
journalctl --since "YYYY-MM-DD HH:MM:SS"	Ver logs desde un tiempo específico
journalctl --vacuum-size=500M	Limpiar logs antiguos que excedan un tamaño
journalctl -r	Ver los logs en orden inverso (más reciente primero)

#muestra los registros del journal de systemd con detalles extendidos (-x) y en modo seguimiento (-e para ir al final del log).
journalctl -xe


#¿Quién puede ver los registros que va recopilando journald?
 Solo root
 
#Para que un usuario nominal pueda utilizar el comando journalctl, tiene que estar en el grupo systemd-journal:
adduser operador
passwd operador
usermod -aG  systemd-journal operador


#Procedimiento para persistir el journal:

#mkdir -p /var/log/journal/
#systemd-tmpfiles --create --prefix /var/log/journal
#chown root:systemd-journal /var/log/journal
#chmod 2775 /var/log/journal

Then, restart journald to apply the change:
#systemctl restart systemd-journald
 


###Límite del tamaño de journal

Si journal se ha creado como permanente (no volátil), el límite de su tamaño se establece con un valor predeterminado correspondiente al 10% del tamaño del sistema de archivos.

Por ejemplo, con /var/log/journal alojado en una partición raíz de 50 GiB, esto permitiría almacenar hasta 5 GiB de datos en journal. El tamaño máximo del journal permanente puede ser controlado por SystemMaxUse en /etc/systemd/journald.conf, por lo que, para limitarlo, por ejemplo, a 50 MiB, descomente y modifique la correspondiente línea a:
SystemMaxUse=50M

#Rotamos el log a 50 Megas.
#vi /etc/systemd/journald.conf Descontentamos: SystemMaxUse=50M

#Limpiar registros reteniendo como máximo 2GB
journalctl --vacuum-size=2G

# Limpiar registros y retener sólo los 2 últimos años
journalctl --vacuum-time=2years

journalctl --vacuum-time=7d

##Explicación:
--vacuum-time=7d: Elimina los registros más antiguos de 7 días.
7d significa 7 días (también puedes usar 1month, 1year, etc.).

#Verificar el tamaño actual de los logs:
journalctl --disk-usage


##ver los logs del service sshd del ultimo minuto:
journalctl --since '1 min ago' -u sshd


##Si quieres eliminar todos los logs, si tenemos el journal persistido usa:
journalctl --flush --rotate
rm -rf /var/log/journal/*
systemctl restart systemd-journald


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
####Ejecutar un systemd Service en el Home del Usuario####

Ejecutar un systemd Service en el Home del Usuario (~/.config/systemd/user/)
En systemd, los usuarios pueden ejecutar sus propios servicios sin permisos de root. Estos servicios se definen en la carpeta ~/.config/systemd/user/ y pueden ejecutarse solo cuando el usuario ha iniciado sesión.

#Si la carpeta no existe, créala:
mkdir -p ~/.config/systemd/user

Ejemplo: Ejecutar un script ~/mi-script.sh al iniciar sesión.

#Crear el script en ~/mi-script.sh
echo -e '#!/bin/bash\n\n echo "Servicio iniciado por el usuario $(whoami)" >> ~/mi-servicio.log' > ~/mi-script.sh


##Le damos permiso al script:
chmod +x ~/mi-script.sh

##Crear la unidad de servicio en ~/.config/systemd/user/mi-servicio.service:
[Unit]
Description=Mi Servicio Personal de Usuario
After=default.target

[Service]
ExecStart=%h/mi-script.sh
Restart=always
WorkingDirectory=%h
StandardOutput=append:%h/mi-servicio.log
StandardError=append:%h/mi-servicio.log

[Install]
WantedBy=default.target

%h se expande a /home/usuario, lo que hace que el servicio sea independiente del nombre de usuario.
Restart=always reinicia el servicio si se detiene.
WantedBy=default.target asegura que se inicie con la sesión del usuario.


##Tendremos que tener una session del usuario nomimal iniciada, a traves de ssh.


systemctl --user daemon-reload

#Para iniciar el servicio manualmente:
systemctl --user start mi-servicio

#Para habilitar el servicio y que se ejecute al iniciar sesión:
systemctl --user enable mi-servicio

systemctl --user status mi-servicio

#Ver los Logs del Servicio
journalctl --user -u mi-servicio --follow

#Detener y Deshabilitar el Servicio
systemctl --user stop mi-servicio
systemctl --user disable mi-servicio

#Si deseas eliminar completamente el servicio:
rm ~/.config/systemd/user/mi-servicio.service
systemctl --user daemon-reload


#Habilitar Servicios de Usuario sin Iniciar Sesión
Por defecto, los servicios en ~/.config/systemd/user/ solo funcionan si el usuario ha iniciado sesión. Para ejecutarlos en segundo plano sin necesidad de iniciar sesión:

loginctl enable-linger usuario

Esto permite que systemd mantenga corriendo los servicios incluso después de cerrar sesión.

#Conclusión
Los usuarios pueden ejecutar servicios sin permisos de root en ~/.config/systemd/user/.
Se definen con archivos .service, usando %h para la home del usuario.
Se gestionan con systemctl --user start/stop/status nombre-servicio.
loginctl enable-linger permite que los servicios sigan activos después de cerrar sesión.
Si necesitas más detalles, dime qué tipo de servicio quieres ejecutar en el home del usuario.

