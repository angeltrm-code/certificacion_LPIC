# Explicacion 108.1 Maintain system time

Resumen técnico sobre Explicacion 108.1 Maintain system time, reordenado para mejorar la lectura sin alterar el contenido útil.

### **108.1 Mantener la hora del sistema

> # Resumen del manual de certificacion LPIC-1 pagina 390

El paquete chrony, un binario que nos ofrece la posibilidad de mantener la hora sincronizada con servidores NTP

¿Qué es hwclock?

hwclock es una utilidad en Linux que permite leer y modificar el reloj de hardware (RTC, Real-Time Clock).

Este reloj es independiente del sistema operativo y sigue funcionando aunque la máquina esté apagada (gracias a la batería CMOS).

## Linux maneja dos relojes:

Reloj de Hardware (RTC, BIOS/UEFI) → Funciona con la batería de la placa base. Reloj del Sistema (System Clock) → Se inicia desde el RTC y se sincroniza con NTP o manualmente.

Puede sincronizar la hora del sistema y la hora física en los dos sentidos.

## Para que se sincronice la hora física desde la hora del sistema:

```bash
hwclock --systohc
```

## Para realizar lo contrario:

```bash
hwclock --hctosys
```

## ntpdate

> Es posible forzar una sincronización manual con el comando ntpdate. Este comando utiliza como parámetro un nombre de servidor ntp. Si no desea utilizar el servicio ntpd, puede colocar este comando en crontab todos los días o todas las horas.

```bash
ntpdate es.pool.ntp.org
```

```bash
crontab -e
```

## /30 * * * * ntpdate es.pool.ntp.org

## /30: Se ejecuta cada 30 minutos.

- (en las otras posiciones): Significa que se ejecuta cada hora, cada día, cada mes y cualquier día de la semana.

ntpdate es.pool.ntp.org: Comando que sincroniza la hora del sistema con el servidor es.pool.ntp.org.

## timedatectl

El comando timedatectl se utiliza para controlar y consultar la configuración de fecha y hora en sistemas Linux.

```bash
timedatectl list-timezones
timedatectl set-timezone   Europe/Madrid
timedatectl set-ntp false
timedatectl set-ntp true
```

Sincronizar la hora manualmente con el comando timedatectl, si tenemos el valor  NTP enabled: yes

## no permite el cambio de hora manualmente:

```bash
timedatectl set-time 18:00
timedatectl set-ntp no
timedatectl
timedatectl set-time 18:00
timedatectl
```

## Para que tengamos la hora a traves de nuetro cliente de ntp:

```bash
timedatectl set-ntp yes
systemctl restart chronyd
```

## NTP

NTP (Network Time Protocol) es un protocolo que permite sincronizar los relojes de los ordenadores mediante la red y, en particular, TCP/IP, o sea Internet. Como nuestros ordenadores utilizan relojes de cuarzo, a veces éstos se pueden adelantar o atrasar mucho dependiendo de la calidad de los componentes.

## Mostrar la información sobre NTP con chrony

```bash
chronyc sources -v
```

## Mostrar la información sobre NTP con ntpd:

```bash
ntpq -p
```

## localectl

El comando localectl en sistemas Linux se utiliza para consultar y configurar las configuraciones locales del sistema, como la disposición del teclado y las configuraciones de idioma y localización. Estas configuraciones afectan cómo se manejan las fechas, números, divisas y el idioma predeterminado del sistema. Normalmente el juego de cartacteres es utf8.

```bash
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
```

```bash
cat /etc/locale.conf
LANG="es_ES.UTF-8"
```

El comando locale permite recuperar información sobre los elementos de regionalización soportados por su sistema locale

## Se puede modificar y adaptar cada una de las variables LC. Veamos su significado:

- LC_CTYPE: clase de caracteres y conversión.
- LC_NUMERIC: formato numérico por defecto, diferente del de la moneda.
- LC_TIME: formato por defecto de la fecha y la hora.
- LC_COLLATE: reglas de comparación y de ordenación (por ejemplo, los caracteres acentuados).
- LC_MONETARY: formato monetario.
- LC_MESSAGES: formato de los mensajes informativos, interactivos y de diagnóstico.
- LC_PAPER: formato de papel por defecto (por ejemplo, A4).
- LC_NAME: formato del nombre de una persona.
- LC_ADDRESS: igual para una dirección.
- LC_TELEPHONE: igual para el teléfono.
- LC_ALL: reglas para todas las demás variables LC.

## Para debian sin systemd

```bash
dpkg-reconfigure locales
```

```bash
vi /home/oracle/.bash_profile
LANG=es_ES.iso88591
LC_CTYPE="es_ES.iso88591"
export LANG LC_CTYPE
```

## iconv

Es posible convertir un archivo codificado en una tabla dada hacia otra tabla con el programa iconv. El parámetro -l le da todas las tablas soportadas

### iconv -l

Para convertir un archivo, utilice la sintaxis siguiente: iconv -f WINDOWS-1252 -t UTF8 nombre_archivo

---

## Husos horarios en servidores que no tienen system-D

El huso horario determina el desplazamiento temporal en comparación con la hora universal UTC, permite también gestionar el cambio de hora en primavera y otoño, de forma automática.

### Para reconfigurar el huso horario, o timezone, emplee los siguientes comandos:

- Ubuntu y Debian: dpkg-reconfigure tzdata
- Fedora, CentOS y RHEL: system-config-date o para las anteriores versiones redhat-config-date
- Para los otros: tzselect Los comandos tzselect y tzconfig están descontinuados en las distribuciones recientes.

> En este caso emplee el método manual explicado a continuación, o bien los comandos propios de su distribución. El huso horario se determina bajo la forma Continente/ciudad. Esta información se ubica en el archivo /etc/timezone.

El archivo /etc/timezone, en formato binario, contiene la información vinculada al huso horario, como el desfase horario con respecto a la hora UTC y las reglas para el cambio de hora en verano o en invierno.

## En centos7/8 Debian con System-D

```bash
timedatectl set-timezone "Europe/Madrid"
```

## No es recomendado utilizar como cliente ntp el paquete ntp, recomendado utilizar chrony:

```bash
vi /etc/ntp.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst
```

```bash
systemctl start ntpd
systemctl enable ntpd
timedatectl set-ntp true
```

## En centos6 con system-v si ser recomienda utilizar ntp

```bash
rm -rf /etc/localtime
```

### ln -s /usr/share/zoneinfo/Europe/Madrid  /etc/localtime

```bash
vi /etc/ntp.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst
```

```bash
service ntpd start
chkconfig --level 3 ntpd on
```

```bash
/# Configuring NTP using chrony recomendado para centos7/8 y debian10:
yum install chrony
apt install chrony
```

```bash
systemctl start chronyd
```

```bash
systemctl enable chronyd
```

```bash
vi  /etc/chrony.conf
```

```conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst
```

```bash
systemctl start chronyd
```

```bash
systemctl enable chronyd
```

**Comando chronyc El comando chronyc es una herramienta de línea de comandos utilizada para interactuar con el servicio Chrony, que es un demonio para la sincronización del tiempo en sistemas operativos Linux. Chrony es una alternativa ligera a NTP (Network Time Protocol), y se usa para mantener el reloj del sistema sincronizado con servidores de tiempo remotos o con un reloj de hardware.

## Funciones principales de chronyc

*Ver el estado de la sincronización: Puedes verificar el estado actual de la sincronización de tiempo utilizando el siguiente comando:

```bash
chronyc tracking
```

La salida podría verse así: Reference ID    : 203.0.113.10 (ntp.example.com)

```
Stratum         : 3
```

Ref time (UTC)  : Wed Oct 24 11:20:45 2024 System time     : 0.000001234 seconds slow Last offset     : -0.000001234 seconds RMS offset      : 0.000002345 seconds

```
Frequency       : 3.987 ppm slow
```

Esto muestra información sobre qué servidor NTP se está utilizando, el desajuste del reloj del sistema, el último ajuste aplicado y la frecuencia de sincronización.

Ver los servidores NTP en uso: Para ver la lista de servidores NTP que Chrony está utilizando o monitoreando para la sincronización:

```bash
chronyc sources
```

## Agregar o eliminar servidores NTP: Puedes agregar un servidor NTP con:

sudo chronyc add server 0.es.pool.ntp.org

## Para eliminar un servidor NTP:

sudo chronyc delete  0.es.pool.ntp.org

Comprobar la diferencia de tiempo: Para comprobar la diferencia entre el reloj del sistema y el reloj NTP:

```bash
chronyc makestep
```

Obtener estadísticas de tiempo: Para obtener estadísticas sobre la sincronización del tiempo con los servidores NTP, puedes usar:

```bash
chronyc sourcestats
```

Forzar una sincronización inmediata: Si deseas forzar una sincronización inmediata del reloj del sistema con los servidores NTP:

```bash
sudo chronyc burst 4/4
```

## date

El comando date en Linux se utiliza para mostrar y establecer la fecha y la hora del sistema

## Resumen de especificadores de formato:

%Y: Año completo (e.g., 2024) %m: Mes (01-12) %d: Día del mes (01-31) %H: Hora en formato de 24 horas (00-23) %M: Minutos (00-59) %S: Segundos (00-59) %A: Nombre completo del día de la semana (e.g., Thursday) %B: Nombre completo del mes (e.g., October)

## Mostrar la fecha y hora actuales:

```bash
date
```

## Mostrar solo la fecha (año-mes-día):

```bash
date +"%Y-%m-%d"
```

## Mostrar solo la hora (horas:minutos):

```bash
date +"%H:%M:%S"
```

## Mostrar la fecha completa en formato legible:

```bash
date +"%A, %B %d, %Y"
```

## Establecer la fecha y hora al 1 de enero de 2025, 10:30 AM:

```bash
sudo date 010110302025
```

## Mostrar la fecha de mañana:

```bash
date -d "tomorrow"
```

## Mostrar la fecha de hace una semana:

```bash
date -d "last week"
```

## Mostrar la fecha en formato UTC:

```bash
 date -u
```

## Mostrar la hora en la zona horaria de Nueva York:

```conf
TZ="America/New_York" date
```

## Cambiar la hora con el comando date

```bash
date --set 18:00
sudo date --set "2025-03-10 18:00:00"
```

## systemd-timesyncd

systemd-timesyncd, que es el daemon encargado de sincronizar la hora del sistema con servidores de tiempo NTP en Debian/Ubuntu.

## systemd-timesyncd en Debian/Ubuntu

```bash
sudo systemctl start systemd-timesyncd
```

## Verificar el estado del servicio

```bash
systemctl status systemd-timesyncd
```

## Forzar una sincronización inmediata con NTP

```bash
sudo systemctl restart systemd-timesyncd
sudo timedatectl set-ntp true
```

## Configurar servidores NTP manualmente

```bash
sudo vi /etc/systemd/timesyncd.conf
```

### [Time]

```conf
NTP=ntp.ubuntu.com time.google.com
FallbackNTP=pool.ntp.org
```

```bash
sudo systemctl restart systemd-timesyncd
```

¿Cuándo usar systemd-timesyncd vs. chronyd ?

```
Servicio                    Uso recomendado
systemd-timesyncd           Ideal para servidores y equipos de escritorio que solo necesitan sincronizarse con NTP sin configuraciones avanzadas.
```

```
chronyd                       Recomendado en sistemas con conexiones de red inestables o que necesitan ajustes de tiempo más precisos.
```

## Conclusión

✅ systemd-timesyncd es el servicio predeterminado de sincronización de hora en Debian/Ubuntu (cliente) ✅ Puedes verificar su estado con timedatectl status. ✅ Para cambiar la hora manualmente, desactiva la sincronización con NTP primero (timedatectl set-ntp false). ✅ Si necesitas servidores NTP específicos, edita /etc/systemd/timesyncd.conf.
