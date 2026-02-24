###Los registros (logs) del sistema 
Manual LINUX - Preparación a la certificación LPIC-1.pdf -->Pagina 378

#Syslog
Syslog es el sistema estándar de registro de eventos (logs) en sistemas Unix/Linux.
Permite que el sistema y los servicios escriban mensajes sobre:
-Arranque del sistema
- Errores
- Servicios (SSH, cron, etc.)
- Kernel
- Seguridad

#syslog tenemos diferentes versiones de syslog:
| Implementación   | Tipo              | Estado actual | Soporte remoto   | Archivo config                  |
| ---------------- | ----------------- | ------------- | ---------------- | ------------------------------- |
| Syslog (BSD)     | Clásico           | Obsoleto      | UDP básico       | `/etc/syslog.conf`              |
| rsyslog          | Moderno           | Muy usado     | UDP, TCP, TLS    | `/etc/rsyslog.conf`             |
| syslog-ng        | Moderno avanzado  | Empresarial   | UDP, TCP, TLS    | `/etc/syslog-ng/syslog-ng.conf` |
| systemd-journald | Integrado systemd | Actual        | Reenvío opcional | `/etc/systemd/journald.conf`    |

#Archivos de log comunes
En Debian/Ubuntu:
/var/log/syslog
/var/log/auth.log
/var/log/kern.log

#En RHEL/Rocky:
/var/log/messages
/var/log/secure

journal
journalctl

#syslogd
syslogd: gestiona los logs del sistema. Distribuye los mensajes a archivos, tuberías,
destinos remotos, terminales o usuarios, usando las indicaciones especificadas en su
archivo de configuración /etc/rsyslog.conf, donde se indica qué se loguea y a dónde se
envían estos logs.

klogd: se encarga de los logs del kernel. Lo normal es que klogd envíe sus mensajes a
syslogd pero no siempre es así, sobre todo en los eventos de alta prioridad, que salen
directamente por pantalla.


/var/log/messages: aquí encontraremos los logs que llegan con prioridad info
(información), notice (notificación) o warn (aviso).

/var/log/kern.log: aquí se almacenan los logs del kernel, generados por klogd.

/var/log/auth.log: en este log se registran los login en el sistema, las veces que hacemos
su, etc. Los intentos fallidos se registran en líneas con información del tipo invalid
password o authentication failure, en debian.

/var/log/dmesg: en este archivo se almacena la información que genera el kernel
durante el arranque del sistema. Podemos ver su contenido con el comando dmesg: $
dmesg

/var/log/secure autentica los login del sistema en redhat.


*Configura el rsyslog remoto a traves de UDP:

#Qué es rsyslog remoto?
rsyslog remoto es la capacidad de rsyslog de enviar y recibir mensajes de registro (logs) a través de la red entre diferentes equipos.

En lugar de almacenar los logs únicamente en el sistema local (por ejemplo, en /var/log), se pueden transmitir a otro servidor centralizado que los recibe, procesa y almacena.

*Objetivo principal
#Centralizar los logs de múltiples sistemas en un único servidor para:
- Auditoría
- Seguridad
- Monitorización
- Análisis forense
- Cumplimiento normativo
Es habitual en entornos empresariales y centros de datos.


vi /etc/rsyslog.conf

# Provides UDP syslog reception
$ModLoad imudp
$UDPServerRun 514

# Provides TCP syslog reception
#$ModLoad imtcp
#$InputTCPServerRun 514

systemctl restart rsyslog.service

netstat -putan |grep 514
udp        0      0 0.0.0.0:514             0.0.0.0:*                           1220/rsyslogd


##En el servidor de linux como cliente de syslog para que envie los logs al servidor de syslog en este ejemplo 192.138.33.10:

vi /etc/rsyslog.conf


# Log anything (except mail) of level info or higher.
# Don't log private authentication messages!
*.info;mail.none;authpriv.none;cron.none                /var/log/messages
                                                        @192.168.33.10

# The authpriv file has restricted access.
authpriv.*                                              @192.168.33.10                                        
                                                        



systemctl restart rsyslog.service

###Importante si el servidor de syslog esta configurado como TCP, en el cliente de linux la configuracion seria:

vi /etc/rsyslog.conf


# Log anything (except mail) of level info or higher.
# Don't log private authentication messages!
*.info;mail.none;authpriv.none;cron.none                /var/log/messages
                                                        @@192.168.33.10

# The authpriv file has restricted access.
authpriv.*                                              /var/log/secure
                                                        @@192.168.33.10
														
		
# Log all the mail messages in one place.
mail.info                                                -/var/log/maillog



En una configuración de cliente para escribir en un syslog remoto, se utiliza @@ antes de la dirección IP o nombre de host del servidor syslog remoto para indicar que se debe utilizar el protocolo TCP en lugar del protocolo UDP estándar.

@ (un solo símbolo @): Indica que el mensaje se enviará al servidor syslog remoto utilizando el protocolo UDP.
@@ (doble símbolo @@): Indica que el mensaje se enviará al servidor syslog remoto utilizando el protocolo TCP.
Usar TCP (@@) en lugar de UDP (@) para el envío de mensajes syslog remoto tiene algunas ventajas:

Fiabilidad: TCP ofrece garantías de entrega y retransmisión de mensajes en caso de pérdida o congestión en la red. Esto asegura que los mensajes no se pierdan, lo que puede ser crucial para los registros críticos del sistema.

Integridad: TCP garantiza que los mensajes se entreguen en el orden correcto. Esto es útil para mantener la coherencia de los registros, especialmente en entornos donde el orden de los eventos es importante.

Manejo de Red: TCP es más adecuado para entornos de red más complejos, donde puede haber retrasos, pérdidas o congestiones. UDP, por otro lado, puede perder mensajes en estas condiciones sin retransmisión.

Por lo tanto, al usar @@ en la configuración de rsyslog en un cliente para enviar mensajes a un servidor syslog remoto, se está optando por una comunicación más robusta y confiable a través del protocolo TCP. Esto es especialmente importante en entornos donde la integridad y la fiabilidad de los registros son críticas.


##Probando los logs locales
El comando logger en Linux se utiliza para enviar mensajes al sistema de registro de eventos (syslog o rsyslog). Es una forma conveniente de generar mensajes de registro directamente desde la línea de comandos o desde scripts.

Para probar nuestro sistema de forma local, vamos a simular un error en una aplicación
de correo. Los logs no se escriben a mano sino a través de la orden “logger”. La sintaxis
la puedes consultar con:

$ man logger


##Entrada en el rsyslog.conf, para los logs de mail:
# Log all the mail messages in one place.
mail.*                                                  -/var/log/maillog


##En nuestro caso vamos a usar la orden:

logger -p mail.info "Esto es una prueba"
logger -p mail.emerg "Esto es una prueba de emergencia"

tail -f /var/log/maillog


La opción -p imprime el mensaje “Esto es una prueba” en el subsitema llamado “mail.err”		

##Equivalente para systemd al comando logger de syslog:

El comando systemd-cat es una utilidad en Linux que permite enviar mensajes de registro directamente al journal de systemd. Es una alternativa a logger, pero en lugar de enviar los mensajes a syslog o rsyslog, los envía directamente al Journal de systemd.

systemd-cat

##Execute process with stdout/stderr connected to the journal.
systemd-cat

journalctl -f

echo 'hello1' | systemd-cat -p info
echo 'hello2' | systemd-cat -p warning
echo 'hello3' | systemd-cat -p emerg


El comando journalctl en sistemas Linux se utiliza para ver y analizar los logs del sistema generados por systemd. Este comando es muy útil para depurar problemas y obtener información detallada sobre los eventos del sistema.


*Enabling Persistent Storage journal:
#Por defecto, systemd-journald puede guardar los registros:
En memoria (volátil)
En disco (persistente)

Si están en memoria, los logs se pierden al reiniciar el sistema.

Si están en disco, permanecen después del reinicio.
/run/log/journal/ 

#Procedimiento:

mkdir -p /var/log/journal/
systemd-tmpfiles --create --prefix /var/log/journal
chown root:systemd-journal /var/log/journal
chmod 2775 /var/log/journal

Then, restart journald to apply the change:
systemctl restart systemd-journald


##Resumen de Comandos journalctl:
journalctl es el comando que permite consultar los registros almacenados por systemd-journald, el sistema de logging integrado en systemd.

journalctl	Ver todos los logs
journalctl -f	Seguir los logs en tiempo real
journalctl -b	Ver logs desde el último arranque
journalctl -u nombre_servicio	Ver los logs de un servicio específico
journalctl -p err	Ver solo logs de nivel de error
journalctl --since "YYYY-MM-DD HH:MM:SS"	Ver logs desde un tiempo específico
journalctl --vacuum-size=500M	Limpiar logs antiguos que excedan un tamaño
journalctl -r	Ver los logs en orden inverso (más reciente primero)

#Limpiar registros reteniendo como máximo 2GB
journalctl --vacuum-size=2G

# Limpiar registros y retener sólo los 2 últimos años
journalctl --vacuum-time=2years

#ver los logs del service sshd del ultimo minuto:
journalctl --since '1 min ago' -u sshd
 
#¿Quién puede ver los registros que va recopilando journald?
 Solo root
 
#Para que un usuario nominal pueda utilizar el comando journalctl, tiene que estar en el grupo systemd-journal:
adduser operador
passwd operador
usermod -aG  systemd-journal operador

----------------------------------------------------------------------------------------------------------------------------------
Facilidades en rsyslog
======================

En rsyslog (y en general en los sistemas de registro de logs de Linux), las facilidades (facilities) son categorías que identifican el origen o tipo de los mensajes de log. Estas facilidades permiten clasificar y gestionar los logs de manera más eficiente.

Facilidades en rsyslog
----------------------

Las facilidades se utilizan para identificar el tipo de aplicación o servicio que está generando el mensaje de log. Cada facilidad tiene un nombre predefinido y un código numérico asociado. Las facilidades más comunes son:

| Facilidad | Código Numérico | Descripción                                       |
|----------|----------------|-----------------------------------------------------|
| auth     | 4              | Mensajes relacionados con la autenticación del sistema |
| authpriv | 10             | Mensajes de autenticación privados, como SSH         |
| cron     | 9              | Mensajes relacionados con el servicio cron            |
| daemon   | 3              | Mensajes de procesos del sistema (como servicios)     |
| kern     | 0              | Mensajes del kernel                                   |
| lpr      | 6              | Mensajes de impresión                                 |
| mail     | 2              | Mensajes relacionados con correo electrónico          |
| news     | 7              | Mensajes de servidores de noticias (NNTP)              |
| syslog   | 5              | Mensajes generados por el propio servicio syslog       |
| user     | 1              | Mensajes generados por procesos de usuario             |
| uucp     | 8              | Mensajes de protocolos UUCP                            |

Facilidades Locales (local0 a local7)
-------------------------------------

Las facilidades local0 a local7 están reservadas para uso personalizado o privado. No están asignadas a ningún servicio en particular, lo que permite a los administradores y desarrolladores utilizarlas para registrar mensajes específicos de sus aplicaciones o procesos personalizados.

| Facilidad | Código Numérico |
|----------|----------------|
| local0   | 16             |
| local1   | 17             |
| local2   | 18             |
| local3   | 19             |
| local4   | 20             |
| local5   | 21             |
| local6   | 22             |
| local7   | 23             |

Ejemplos de Uso de Facilidades Locales
--------------------------------------

#Configuración en rsyslog:

vi /etc/rsyslog.conf

#Añadimos en rules:
local0.*    /var/log/local0.log
local1.*    /var/log/local1.log
local7.*    /var/log/local7.log

systemctl restart rsyslog.service


#¿Qué es logger?
logger es un comando que permite enviar mensajes manualmente al sistema de logs (syslog o journald).

#Es muy útil para:
Pruebas
Scripts
Auditoría
Verificar que el sistema de logging funciona

#Generar mensajes de log con logger, los ficheros se crean cuando lanzamos el comando logger:
logger -p local0.info "Mensaje de prueba en local0"
logger -p local1.warn "Advertencia en local1"
logger -p local7.error "Error crítico en local7"

#Verificar los logs:
tail -f /var/log/local0.log
tail -f /var/log/local1.log
tail -f /var/log/local7.log


##Recomendaciones para el Uso de Facilidades Locales

1. Organización y Documentación:
   - Define claramente el propósito de cada facilidad en tus aplicaciones.
   - Mantén una convención consistente.

2. Rotación de Logs:
   - Configura la rotación de logs para evitar que los archivos crezcan sin control.

3. Centralización de Logs:
   - Si tienes varios servidores o dispositivos de red, considera enviar los logs locales a un servidor central.

#Conclusión
----------
Las facilidades local0 a local7 están reservadas para uso personalizado y son muy útiles para centralizar logs de aplicaciones propias o dispositivos de red. Utilizarlas de manera organizada y documentada permite gestionar eficientemente los logs en entornos complejos.