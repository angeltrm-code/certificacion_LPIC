# Configurar la zona horaria

Documento de referencia para gestionar fecha, zona horaria, localizacion del sistema y sincronizacion NTP en equipos Linux con systemd.

## Gestion de fecha y zona horaria con `timedatectl`

`timedatectl` permite consultar y configurar la fecha, la hora y la zona horaria del sistema en distribuciones con systemd, como Ubuntu, Debian, Rocky o RHEL.

```bash
timedatectl list-timezones
timedatectl set-timezone Europe/Madrid
timedatectl set-ntp false
timedatectl set-ntp true
```

## Gestion del idioma y el teclado con `localectl`

`localectl` se utiliza para consultar y configurar el idioma del sistema y la distribucion del teclado.

```bash
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
```

### CentOS 8

Para disponer de paquetes de idioma en CentOS 8:

```bash
dnf install langpacks-es
```

Comprobacion del locale activo:

```bash
cat /etc/locale.conf
```

```text
LANG="es_ES.UTF-8"
```

## Instalacion y configuracion de Chrony

Chrony es un conjunto de herramientas para sincronizar la hora del sistema mediante NTP. Es mas preciso y rapido que el antiguo `ntpd`, especialmente en maquinas virtuales y servidores con cambios frecuentes de red.

Comandos principales:

```text
chronyd: servicio o daemon
chronyc: cliente para consultar y administrar Chrony
```

En muchas distribuciones modernas, Chrony es el servicio NTP por defecto.

### Instalacion

```bash
dnf install chrony -y
```

### Configuracion

```bash
vi /etc/chrony.conf
```

```conf
server 3.es.pool.ntp.org iburst
server 1.europe.pool.ntp.org iburst
server 3.europe.pool.ntp.org iburst
```

### Activacion del servicio

```bash
systemctl enable chronyd
systemctl start chronyd
systemctl status chronyd
```

### Verificacion

```bash
chronyc sources -v
```

```text
netstat -putan
udp        0      0 127.0.0.1:323           0.0.0.0:*                           692/chronyd
```

## Nota sobre `iburst`

La opcion `iburst` esta recomendada porque envia una pequena rafaga de paquetes solo cuando no se consigue conexion en el primer intento. Esto acelera la sincronizacion inicial.

La opcion `burst`, en cambio, envia rafagas siempre y no debe utilizarse sin permiso explicito, ya que puede provocar bloqueos o blacklist en algunos servidores.
