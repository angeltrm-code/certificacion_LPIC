# Laboratorio Configurar NTP en mv laboratorios LPIC 1

Documento práctico sobre Laboratorio Configurar NTP en mv laboratorios LPIC 1. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

### En las maquinas virutales RockyLinux/derivados y debian10/12 deberiamos de utilizar chrony:

NTP (Network Time Protocol) es un protocolo que permite sincronizar los relojes de los ordenadores mediante la red y, en particular, TCP/IP, o sea Internet. Como nuestros ordenadores utilizan relojes de cuarzo, a veces éstos se pueden adelantar o atrasar mucho dependiendo de la calidad de los componentes.

### NTP utiliza UDP como su capa de transporte, usando el puerto 123

Chrony es un servicio para sincronizar la hora del sistema usando NTP (Network Time Protocol).

Es más moderno y eficiente que el antiguo ntpd, y hoy es el predeterminado en muchas distribuciones

## Configuring NTP using chrony

```bash
dnf install chrony
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
server hora.roa.es iburst
server minuto.roa.es iburst
```

```bash
systemctl start chronyd
```

```bash
systemctl enable chronyd
```

---

## En la mv RockyLinux/derivados

```
dnf  install chrony -y
```

```bash
timedatectl set-timezone "Europe/Madrid"
timedatectl
```

## un comando para listar y modificar la configuración de localización/mapa del teclado.

```bash
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
localectl
```

```bash
cat /etc/locale.conf
LANG=es_ES.utf8
```

El paquete chrony, un binario que nos ofrece la posibilidad de mantener la hora sincronizada con servidores NTP y a la vez él mismo ofrecerse como servidor NTP para otros clientes.

## Fichero principal de configuracion de nuestro cliente chrony:

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

Mostrar la información sobre NTP

```bash
chronyc sources -v
```

## iburst

La opción iburst está recomendada, ya que envía una serie («burst») de paquetes solo si no se puede obtener una conexión con el primer intento. Por otro lado, la opción burst siempre está presente, incluso en el primer intento, pero nunca debe utilizarse sin permiso explícito, dado que puede incluirse en blacklist.)

---

---

## En debian10/12

```bash
apt-get update
apt-get install chronyd -y
timedatectl set-timezone "Europe/Madrid"
```

```bash
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
```

```bash
vi  /etc/chrony/chrony.conf
```

```conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst
```

```bash
systemctl start chronyd
systemctl status chronyd
systemctl enable chronyd
```

## Mostrar la información sobre NTP

```bash
chronyc sources -v
```

## Para listar y modificar la configuración de localización/mapa del teclado.

```bash
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
localectl
```

```bash
cat /etc/locale.conf
LANG=es_ES.utf8
```
