# Laboratorio Configurar NTP en mv laboratorios

Documento práctico sobre Laboratorio Configurar NTP en mv laboratorios. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## En las maquinas virutales rockylinux y debian12 deberiamos de utilizar chrony:

## NTP

NTP (Network Time Protocol) es un protocolo que permite sincronizar los relojes de los ordenadores mediante la red y, en particular, TCP/IP, o sea Internet. Como nuestros ordenadores utilizan relojes de cuarzo, a veces éstos se pueden adelantar o atrasar mucho dependiendo de la calidad de los componentes.

### NTP utiliza UDP como su capa de transporte, usando el puerto 123

## En las maquinas virutales rockylinux y debian10 deberiamos de utilizar chrony:

## Configuring NTP using chrony

```bash
yum install chrony -y
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

---

## En la mv rockylinux/rocky Linux

```bash
yum install chrony -y
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
systemctl restart chronyd
```

```bash
systemctl enable chronyd
```

Mostrar la información sobre NTP

```bash
chronyc sources -v
```

La opción iburst está recomendada, ya que envía una serie («burst») de paquetes solo si no se puede obtener una conexión  con el primer intento. Por otro lado, la opción burst siempre está presente, incluso en el primer intento, pero nunca debe utilizarse sin permiso explícito, dado que puede incluirse en blacklist.)

---

## En centos6 (DEPRECADO)

```bash
yum install ntp -y
```

```bash
cp /etc/localtime /root
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

Mostrar la información sobre NTP

## ntpq -p

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
systemctl status chrony
```

```bash
systemctl start chrony
```

```bash
systemctl enable chrony
```

Mostrar la información sobre NTP

```bash
chronyc sources -v
```
