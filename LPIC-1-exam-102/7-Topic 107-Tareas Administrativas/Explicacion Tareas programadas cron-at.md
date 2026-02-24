https://crontab.guru/
https://www.site24x7.com/es/tools/crontab/cron-generator.html

**107.2 Automatizar tareas administrativas del sistema mediante la programación de trabajos

##Crond es un servicio del sistema que ejecuta mandatos en horarios determinados. Los mandatos programados pueden definirse en el archivo de configuración /etc/crontab.

Se puede utilizar además el directorio /etc/cron.d, que sirve para almacenar archivos con el mismo formato del archivo /etc/crontab.

##El sistema dispone además de varios directorios utilizados por el servicio crond:
/etc/cron.daily: todo lo que se coloque dentro de este directorios, se ejecutará una vez todos los días.
/etc/cron.weekly: todo lo que se coloque dentro de este directorios, se ejecutará una vez cada semana.
/etc/cron.monthly: todo lo que se coloque dentro de este directorios, se ejecutará una vez al mes.

systemctl status crond

El archivo /etc/crontab es un archivo global de configuración de cron en sistemas Linux. A diferencia del crontab -e (que es específico por usuario), este archivo puede contener tareas programadas para cualquier usuario, ya que incluye el campo del usuario en cada línea.

# m h dom mon dow user  command
17 *    * * *   usuario    run-parts /etc/cron.hourly
25 6    * * *   root    /usr/local/bin/backup.sh
25 4    * * *   oracle    /usr/local/bin/backup-oracledb.sh



##Diferencias clave entre /etc/crontab y  crontab -e
Característica	            crontab -e	                     /etc/crontab
Especifica usuario	        ❌ No	                         ✅ Sí
Alcance	                    Usuario actual	                Global (multiusuario)
Ubicación física	        ~/.crontab gestionado	        Archivo real: /etc/crontab
Editable por	            Solo el usuario	                Root o sudoers

Se recomienda no editar /etc/crontab si puedes usar crontab -e, para mantener las cosas separadas y más seguras.

Todos los usuarios del sistema operativo pueden utilizar cron.

crontab -l
crontab -e


##Como usuario root podemos ver las tareas programadas de otros usuarios / incluso programarles tareas
crontab -l -u berto
crontab -e -u berto

# Example of job definition:
# .---------------- minute (0 - 59)
# | .------------- hour (0 - 23)
# | | .---------- day of month (1 - 31)
# | | | .------- month (1 - 12) OR jan,feb,mar,apr ...
# | | | | .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat // 1-5 serian dias laborables Lunes a Viernes
# | | | | |
# * * * * * user-name command to be executed

Minutos  Horas Día del mes Mes Día semana  Comando

0 23 * * * su -c "oracle" /opt/scripts/backuporacle 2>&1 |mail -s "Salida del copia segu oracle"  usuario@correo.es

0 3 * * 1-5  /opt/scripts/backuservidorA 2>&1 |mail -s "Salida del copia segu servidorA"  usuario@gmail.com  berto

0 3 * * 1-5  /opt/scripts/backuservidorA


#cron que genera un backup de la carpeta /etc en el directorio /var/backups.
#Este trabajo debe ejecutarse diariamente a las 2:15 a.m. y a las 2:15 p.m

15 2,14 * * * tar -czf /var/backups/backup.tar.gz /etc

Minuto: 15
Hora: 2,14 → a las 02:15 y a las 14:15
Día del mes: * → todos los días
Mes: * → todos los meses
Día de la semana: * → cualquier día


1 14 * * *  /home/fulano/bin/tarea.sh > /dev/null

##Tarea cada 5 minutos
*/5 * * * *  /sbin/service httpd reload > /dev/null 2>&1
*/5 * * * *  /usr/bin/systemctl reload httpd.service > /dev/null 2>&1

##No funciona ruta absoluta a el comando systemctl:
*/5 * * * *  systemctl reload httpd.service > /dev/null 2>&1



##a las 23h de todos los viernes
0 23 * * 5 root /usr/bin/yum -y update > /dev/null 2>&1

##Tarea cada 3 dias:
* * */3 * * root /sbin/service httpd reload > /dev/null 2>&1

##Se ejecuta cada 5 minutos. los dias laborables de lunes a viernes:
*/5 * * * 1-5 /usr/bin/rsync -av  -e ssh /datos/   vagrant@192.168.33.10:/datos/



@reboot  mail -s "El sistema de  ha reiniciado" alguien@gmail.com vagrant
@reboot echo "$(date '+%Y-%m-%d %H:%M:%S') - El sistema $(hostname) ha reiniciado" | tee -a /var/log/reinicio.log 



0 22 * * * find /web -mtime 3 -print 2>&1 |mail -s "Ficheros modificados en los ultimos 3 dias"  usuario@correo.es

##Ejecuta la tarea a las 14:1 solo de lunes a Viernes
1 14 * * 1-5 fulano /home/fulano/bin/tarea.sh > /dev/null

##Ejecución de df todos los días, todo el año, cada cuarto de hora:

0,15,30,45 * * * * /usr/bin/df > /tmp/libre

##Arranque de un comando cada 5 minutos a partir de 2 (2, 7, 12, etc.) a las 18 horas los días 1 y 15 de cada mes:
2-57/5 18, 1,15 * * comando


Campo 1: Minuto → 2-57/5
Empieza en el minuto 2.
Termina en el minuto 57.
Avanza en pasos de 5 minutos.

Campo 2: Hora → 18,1,15
El comando se ejecuta en las horas:
01
15
18

##Editar la crontab de un usuario particular como root:

crontab -e -u user
 
##Lanzo el script como usuario root, para que el script se ejecute con las características del usuario "oracle",
##por ejemplo, habria que escribir la línea así:
		
0 23 * * * su -c "oracle" /opt/scripts/backuporacle.sh

El comando su -c sirve para ejecutar un comando como otro usuario, sin necesidad de abrir una sesión interactiva.
 
##Control de acceso Se puede controlar el acceso con el comando crontab por usuario 
con los archivos /etc/cron.allow  y /etc/cron.deny. 

##Si creamos el archivo /etc/cron.allow, solomanete los usuarios que esten en este archivo pueden utilizar cron.
touch /etc/cron.allow

##Creo una tarea como root en el cron del usuario oracle
crontab -e -u oracle

El usuario root no le afecta /etc/cron.allow  y /etc/cron.deny
--------------------------------------------------------------------------------------------------------------
##at

Los mandatos at y batch se utilizan sólo para programar la ejecución de mandatos de una sola ocasión.
En el caso de que se requiera programar mandatos para ser ejecutados periódicamente, se sugiere hacerlo a través de crontab.

systemctl status atd

COMANDO PARA COMPROBAR LA COLA DE AT Y CÓMO ELIMINAR UNA TAREA PROGRAMADA TMB EN AT.
		atq 			--para el comando at vemos los jobs que tenemos programados
		atrm 1			--para eliminar la tarea 1 programada con 'at'
		crontab -l 		--para el comando cron 

Fijar la tarea con 'at'
		at 23:00 
		at> ./opt/scripts/supervisamen &		--indico que quiero que se ejecute este script
		at> <EOT>								--con Ctrl+d para finalizar
		job 5 at 2015-10-13 23:00

Otra forma de hacer lo mismo:
		
at 21:00 -f /opt/scripts/supervisamem	

Hora Se puede formatear la hora de la manera siguiente:
• HHMM o HH:MM.
• La hora puede tener el formato de 12 o 24 h. Con el formato de 12 horas, puede especificar AM (mañana) o PM (tarde). • Midnight (medianoche), noon (mediodía), teatime (16:00 h, típicamente inglés). • MMJJAA, MM/JJ/AA o JJ.MM.AA para una fecha particular. • Now: ahora.
• + n minutes/hours/days/weeks: la hora actual a la que se añaden n minutos/horas/días/semanas.


También permite establecer la ejecución utilizando today (hoy) y tomorrow (mañana) como argumentos. Ejemplo
at 12:25 tomorrow -f /opt/scripts/supervisamem
at 08:25 today -f    /usr/bin/systemctl status httpd.service > /tmt/status-apache 2>&1


Se colocan los jobs (tareas) en el directorio /var/spool/atjobs, a razón de un ejecutable por tarea.
/var/spool/at

Control de acceso Es posible controlar el acceso al comando at por usuario con los archivos
 /etc/at.allow y /etc/at.deny	

Todo el mundo puede utiliza at. porque solo existe el archivo  /etc/at.deny
Si creamos el archivo /etc/at.allow  solomente los que estan en este archivo pueden utizar at.
--------------------------------------------------------------------------------------
##El comando systemd-run se puede utilizar para crear e iniciar una unidad .service o .scope transitoria y ejecutar el COMANDO especificado en ella.

##No solicite al usuario la autenticación para operaciones privilegiadas.
systemd-run --no-ask-password ...

Establece una propiedad en el ámbito o unidad de servicio que se crea. Esta opción toma una asignación en el mismo formato que el comando set-property de systemctl(1).
systemd-run --property ...

Una vez finalizado el proceso de servicio, mantenga el servicio activo hasta que se detenga explícitamente. Esto es útil para recopilar información de tiempo de ejecución sobre el servicio una vez que terminó de ejecutarse. Consulte también RemainAfterExit= en systemd.service(5).
systemd-run -r ...

Establece el tipo de servicio. Consulte también Type= en systemd.service(5). Esta opción no tiene ningún efecto en combinación con
systemd-run --service-type ...

Ejecuta el proceso de servicio bajo el usuario y grupo UNIX especificado. Consulte también Usuario= y Grupo= insystemd.exec(5).
systemd-run --uid ...


##Cree un comando que ejecutará un script llamado prueba.sh, que está en /opt, a las 5:55 a.m.

systemd-run --unit=laboratorio1 --on-calendar '*-*-* 5:55:00' /bin/bash /opt/prueba.sh
systemctl list-timers

#significa:
Cualquier año
Cualquier mes
Cualquier día
A las 05:55:00 (de la mañana)

#Es decir:
Ejecuta /opt/prueba.sh todos los días a las 05:55.


systemd-run --service-type=notify /etc/init.d/iniciar-supervisamem

#hace lo siguiente:

Crea y ejecuta un servicio transitorio: systemd-run genera un servicio temporal, administrado por systemd, que se ejecutará en segundo plano. Este servicio se eliminará automáticamente una vez que el script termine su ejecución.

Tipo de servicio simple: Al especificar --service-type=simple, systemd ejecuta el script especificado directamente. Esto significa que systemd no espera ninguna señal adicional ni requiere que el script realice operaciones adicionales para indicar que está completamente inicializado. El proceso del script se ejecuta tal cual y systemd lo considera "activo" hasta que el script finalice.

Ejecución del script: El script ubicado en /path/a/tu/script.sh se ejecuta como si hubieras ejecutado el comando directamente en la terminal, pero ahora está gestionado por systemd, lo que le permite integrarse mejor con las características de systemd (como la gestión de registros, límites de recursos, y otras funcionalidades de supervisión de servicios).

systemd-run --service-type=notify /tomcat-9/bin/startup.sh

systemctl list-units --type=service
systemctl status run-20255.service


##Unit de tipo timer
En systemd, los archivos de tipo .timer permiten programar tareas al estilo cron, pero con más flexibilidad, como retrasos, eventos basados en arranque o activación condicional. Un .timer se asocia a un .service, que define la acción a ejecutar.

vi /etc/systemd/system/backup.service

# /etc/systemd/system/backup.service
[Unit]
Description=Backup diario

[Service]
Type=oneshot
ExecStart=/usr/local/bin/backup.sh



vi /etc/systemd/system/backup.timerbackup.timer

# /etc/systemd/system/backup.timer
[Unit]
Description=Ejecuta backup diariamente a las 2:00 AM

[Timer]
OnCalendar=*-*-* 02:00:00
Persistent=true

[Install]ers
WantedBy=tim.target


#Explicación de opciones:
OnCalendar=*-*-* 02:00:00 → cada día a las 02:00 AM.
Persistent=true → si el sistema estuvo apagado a la hora programada, lo ejecuta al encenderse (útil para laptops/servidores que no están siempre encendidos).

WantedBy=timers.target → para que se active automáticamente al iniciar el sistema.

#Activación del timer
# Recargar systemd
sudo systemctl daemon-reexec
sudo systemctl daemon-reload

# Habilitar el timer
sudo systemctl enable --now backup.timer

#Ver estado del timer
sudo systemctl start backup.service

###Ejemplos:
#Ejecutar cada lunes a las 8:00 AM
[Unit]
Description=Ejecutar mantenimiento semanal (cada lunes a las 08:00)

[Timer]
OnCalendar=Mon 08:00:00
Persistent=true

[Install]
WantedBy=timers.target


#Ejecutar cada 5 minutos
[Unit]
Description=Verificador de estado (cada 5 minutos)

[Timer]
OnUnitActiveSec=5min
Persistent=true

[Install]
WantedBy=timers.target

OnUnitActiveSec=5min ejecuta la unidad 5 minutos después de la última vez que se ejecutó exitosamente.

#Ejecutar al iniciar el sistema
[Unit]
Description=Tarea que corre al iniciar el sistema

[Timer]
OnBootSec=1min
Persistent=true

[Install]
WantedBy=timers.target

##Explicacion:
OnBootSec=1min ejecuta la tarea 1 minuto después de que el sistema arranca.



Formato general de OnCalendar=
OnCalendar=Y-M-D H:M:S


#Fechas y horas exactas

Opción	Descripción	Ejemplo
2025-04-23 08:00:00	Fecha y hora exacta	Solo el 23 de abril de 2025 a las 08:00:00
*-04-23 08:00:00	Todos los años, 23 de abril a las 8:00	Anual
*-*-01 00:00:00	Primer día de cada mes	Mensual
*-*-* 12:00:00	Todos los días a las 12:00	Diario
Mon *-*-* 08:00:00	Cada lunes a las 8:00	Semanal

#Alias rápidos (sin fecha específica)

Alias	Significado
daily	Todos los días a medianoche (00:00)
weekly	Todos los lunes a medianoche
monthly	Día 1 de cada mes a medianoche
yearly / annually	1 de enero a medianoche
hourly	Al inicio de cada hora

OnCalendar=daily
OnCalendar=hourly


##Días de la semana y repetición
Opción	Descripción
Mon,Fri 08:00	Lunes y viernes a las 8:00
Mon..Fri 09:30	De lunes a viernes a las 9:30
Sat,Sun 22:00	Fines de semana a las 22:00

#Ejemplos con rangos y combinaciones
OnCalendar=*-*-1..7 10:00    # Entre el 1 y el 7 de cada mes a las 10:00
OnCalendar=Mon..Fri *-*-* 18:30   # Lunes a viernes a las 18:30
OnCalendar=*-04-* 07:00      # Todo abril a las 7:00 cada día
OnCalendar=*:0/15            # Cada 15 minutos (requiere systemd >= 240)

se usa para listar todos los timers activos gestionados por systemd, mostrando cuándo se ejecutaron por última vez y cuándo volverán a ejecutarse.

systemctl list-timers

NEXT                         LEFT          LAST                         PASSED        UNIT                         ACTIVATES
Wed 2025-04-23 14:00:00 CEST 12min left    Wed 2025-04-23 13:00:00 CEST 47min ago     logrotate.timer              logrotate.service
Wed 2025-04-23 14:02:00 CEST 14min left    Wed 2025-04-23 13:02:00 CEST 45min ago     systemd-tmpfiles-clean.timer systemd-tmpfiles-clean.service
...


#Explicación de columnas:
#Columna	Significado
NEXT	    Fecha y hora de la próxima ejecución del timer
LEFT	    Cuánto falta para la próxima ejecución
LAST	    Cuándo se ejecutó por última vez
PASSED	    Cuánto tiempo ha pasado desde la última ejecución
UNIT	    El nombre del archivo .timer
ACTIVATES	El nombre del archivo .service que se ejecuta