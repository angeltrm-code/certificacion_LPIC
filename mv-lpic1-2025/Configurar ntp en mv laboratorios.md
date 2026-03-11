# Configurar NTP en mv laboratorios

Documento de referencia sobre Configurar NTP en mv laboratorios con formato Markdown homogéneo y navegación más clara.

## En las maquinas virutales Rockylinux8 y debian12 deberiamos de utilizar chrony:

## Configuring NTP using chrony

```bash
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

---

## En Rockylinux8

```bash
timedatectl set-timezone "Europe/Madrid"
```

```bash
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
```

## En debian12

```bash
apt-get update -y
apt-get install chrony -y
timedatectl set-timezone "Europe/Madrid"
```

```bash
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
```

```bash
vi /etc/chrony/chrony.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst
```

```bash
sudo systemctl restart chrony
sudo systemctl enable chrony
```
