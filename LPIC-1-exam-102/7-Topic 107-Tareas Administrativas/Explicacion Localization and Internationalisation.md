# Explicacion Localization and Internationalisation

Resumen tecnico sobre fecha, hora, NTP, locale, teclado, conversion de codificaciones y zonas horarias en Linux.

> Referencias del manual LPIC-1: paginas 390 y 393.

## Sincronizacion horaria y NTP

NTP, Network Time Protocol, se utiliza para sincronizar la hora de los sistemas de una red con precision. Mantener la hora correcta es importante para:

- registros de auditoria
- transacciones
- autenticacion
- coordinacion de eventos distribuidos

`chrony` sustituye en muchos entornos a `ntpd` y permite mantener el reloj sincronizado con servidores NTP.

## Gestion del reloj hardware con `hwclock`

`hwclock` consulta directamente el reloj hardware RTC. Puede sincronizar el reloj del sistema y el reloj fisico en ambos sentidos.

### Copiar la hora del sistema al reloj hardware

```bash
hwclock --systohc
```

### Copiar la hora del reloj hardware al sistema

```bash
hwclock --hctosys
```

## Sincronizacion manual con `ntpdate`

Es posible forzar una sincronizacion puntual con `ntpdate`. Si no se usa el servicio `ntpd`, este comando puede programarse periodicamente con `cron`.

Ejemplo:

```bash
ntpdate es.pool.ntp.org
```

Ejemplo de tarea cada hora:

```cron
*/1 * * * * /usr/sbin/ntpdate es.pool.ntp.org
```

## Gestion de fecha y hora con `timedatectl`

`timedatectl` permite consultar y cambiar fecha, hora, zona horaria y estado de sincronizacion NTP en sistemas con `systemd`.

```bash
timedatectl list-timezones
timedatectl set-timezone Europe/Madrid
timedatectl set-ntp false
timedatectl set-ntp true
```

### Cambio manual de hora

Si `NTP enabled` esta en `yes`, el sistema no permitira cambiar la hora manualmente hasta desactivar NTP.

```bash
timedatectl set-time 18:00
timedatectl set-ntp no
timedatectl
timedatectl set-time 18:00
timedatectl
```

Para volver a usar el cliente NTP:

```bash
timedatectl set-ntp yes
```

## Localizacion del sistema con `localectl`

`localectl` gestiona idioma, teclado y parametros regionales del sistema.

```bash
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
localectl
```

Comprobar la configuracion actual:

```bash
cat /etc/locale.conf
```

```text
LANG="es_ES.UTF-8"
```

## Informacion regional con `locale`

`locale` muestra la configuracion regional activa para el usuario actual.

Variables `LC_*` relevantes:

- `LC_CTYPE`: clases de caracteres y conversion.
- `LC_NUMERIC`: formato numerico.
- `LC_TIME`: formato de fecha y hora.
- `LC_COLLATE`: reglas de comparacion y ordenacion.
- `LC_MONETARY`: formato monetario.
- `LC_MESSAGES`: mensajes interactivos y de diagnostico.
- `LC_PAPER`: formato de papel.
- `LC_NAME`: formato del nombre de persona.
- `LC_ADDRESS`: formato de direccion.
- `LC_TELEPHONE`: formato de telefono.
- `LC_ALL`: aplica al resto de variables `LC`.

### Debian sin systemd

Para reconfigurar los locales del sistema en Debian o Ubuntu:

```bash
dpkg-reconfigure locales
```

### Ejemplo para un usuario Oracle en ISO-8859-1

```bash
vi /home/oracle/.bash_profile
LANG=es_ES.iso88591
LC_CTYPE="es_ES.iso88591"
export LANG LC_CTYPE
```

## Conversion de codificaciones con `iconv`

`iconv` sirve para convertir archivos entre distintas codificaciones de caracteres.

Casos de uso habituales:

- UTF-8
- ISO-8859-1
- ASCII
- Windows-1252

Listar codificaciones soportadas:

```bash
iconv -l
```

Ejemplo de conversion:

```bash
iconv -f WINDOWS-1252 -t UTF8 nombre_archivo
```

## Conversion de finales de linea con `dos2unix`

`dos2unix` convierte archivos con formato Windows, `CRLF`, a formato Unix, `LF`, y viceversa.

| Sistema | Final de linea |
|---|---|
| Windows | `CRLF` -> `\r\n` |
| Linux / Unix | `LF` -> `\n` |

Instalacion:

```bash
dnf install dos2unix -y
```

### De Windows a Linux

```bash
dos2unix archivo.txt
```

### De Linux a Windows

```bash
unix2dos archivo.txt
```

## Zonas horarias en sistemas sin systemd

El huso horario determina el desfase respecto a UTC y gestiona automaticamente los cambios de hora de verano e invierno.

Herramientas mencionadas:

- Debian y Ubuntu: `dpkg-reconfigure tzdata`
- Fedora, CentOS y RHEL: `system-config-date`
- Versiones antiguas de Red Hat: `redhat-config-date`
- Otras distribuciones: `tzselect`

> `tzselect` y `tzconfig` estan descontinuados en muchas distribuciones recientes. En esos casos puede utilizarse el metodo manual.

La informacion de zona horaria suele referenciarse como `Continente/Ciudad`. Se menciona tambien el archivo `/etc/timezone`.

## Configuracion horaria con `ntpd` en sistemas antiguos

### CentOS 7 con systemd

```bash
timedatectl set-timezone "Europe/Madrid"
vi /etc/ntp.conf
```

```conf
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

### CentOS 6 con System V

```bash
cp /etc/localtime /root
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime
vi /etc/ntp.conf
```

```conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst
```

```bash
service ntpd start
chkconfig --level 3 ntpd on
```

## Programar un script con `systemd-run`

Ejemplo para ejecutar `/opt/prueba.sh` a las `05:55`:

```bash
systemd-run --unit=laboratorio1 --on-calendar '*-*-* 5:55:00' /bin/bash /opt/prueba.sh
systemctl list-timers
```

## Configuracion de Chrony

Chrony es el servicio NTP moderno predeterminado en muchas distribuciones.

### Configuracion del cliente

Archivo principal:

```bash
vi /etc/chrony.conf
```

Servidores de ejemplo:

```conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst
```

Activar el servicio:

```bash
systemctl start chronyd
systemctl enable chronyd
```

Comprobar fuentes NTP:

```bash
chronyc sources -v
```

### Nota sobre `iburst`

`iburst` envia una pequeña rafaga de paquetes cuando falla el primer intento de conexion y acelera la sincronizacion inicial.

La opcion `burst` no debe usarse sin permiso explicito, ya que puede provocar bloqueos o blacklist.

## Configuracion para laboratorios LPIC-1

### En CentOS 6

```bash
yum install ntp -y
cp /etc/localtime /root
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime
vi /etc/ntp.conf
```

```conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst
```

```bash
service ntpd start
chkconfig --level 3 ntpd on
```

### En Rocky Linux, Red Hat y derivados

```bash
dnf install chrony -y
timedatectl set-timezone "Europe/Madrid"
timedatectl
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
localectl
cat /etc/locale.conf
vi /etc/chrony.conf
```

```conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst
```

```bash
systemctl start chronyd
systemctl enable chronyd
chronyc sources -v
```
