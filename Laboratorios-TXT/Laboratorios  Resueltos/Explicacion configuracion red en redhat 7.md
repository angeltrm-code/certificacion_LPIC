# Explicacion configuracion red en redhat 7

Resumen técnico sobre Explicacion configuracion red en redhat 7, reordenado para mejorar la lectura sin alterar el contenido útil.

## Contenido

```bash
vi /etc/sysconfig/network-scripts/ifcfg-eth0
systemctl restart NetworkManager
```

```bash
vi /etc/hostname
```

### hostnamaclt

```bash
hostnamectl set-hostname servidor1.curso.es
systemctl restart systemd-hostnamed
```

### Versiones anteriores a rh7

```bash
/etc/sysconfig/network
HOSTNAME=servidor1
```

```bash
/etc/resolv.conf
```

nameserver 192.168.1.25 nameserver 192.168.1.26 domain curso.es search curso.es madrid.curso.es asturias.curso.es

```bash
 vi /etc/NetworkManager/NetworkManager.conf
```

### [main]

```conf
 dns=none
```

```
 cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.1.5     sercentos7      sercentos7.curso.esp
```

```bash
ip link set eth0 down
ip link set eth0 up
```

```bash
 ifdown eth0
 ifup eth0
```
