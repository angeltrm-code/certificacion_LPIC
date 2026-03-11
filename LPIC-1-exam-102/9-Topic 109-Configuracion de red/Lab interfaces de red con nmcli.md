# Lab interfaces de red con nmcli

Documento práctico sobre Lab interfaces de red con nmcli. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

¿Qué es nmcli?

nmcli (Network Manager Command Line Interface) es la herramienta en línea de comandos para gestionar la red cuando el sistema utiliza NetworkManager.

## Entidad relacionada:

NetworkManager

## Permite administrar:

### Interfaces de red

### Conexiones (cableadas, WiFi)

### Direcciones IP

### DNS

### Puertas de enlace

### Estado de red

## Tener instalado el paquete bash-completion

```bash
rpm -qa bash-completion
dpkg -l bash-completion
```

```bash
/etc/sysconfig/network-scripts/ifcfg-eth1
/etc/sysconfig/network-scripts/ifcfg-eth0
```

```bash
nmcli del status
```

## Eliminando el interface:

```bash
nmcli connection delete eth0
nmcli connection delete eth1
```

```bash
nmcli connection show
ip a
nmcli connection add type ethernet ifname eth0 con-name lan  ipv4.addresses 192.168.1.5/24
```

> ipv4.gateway 192.168.1.1 ipv4.dns 8.8.8.8 connection.autoconect yes ipv4.method manual

```bash
ip a
```

### Ya tendriamos la IP

```bash
/etc/sysconfig/network-scripts/ifcfg-eth0
```

## Configuracion a traves de DHCP:

```bash
nmcli connection add type ethernet ifname eth1 con-name eth1 connection.autoconect yes ipv4.method auto
```

## Modificar conexion a DHCP:

```bash
nmcli connection modify eth0  connection.autoconect yes ipv4.method auto
nmcli connection down eth0
nmcli connection up eth0
```

## Modificar una conexion:

```bash
nmcli connection show
nmcli connection show "System\ eth1"
nmcli connection modify "System\ eth1"  +ipv4.dns 8.8.8.8
nmcli connection show "System\ eth1"
nmcli connection modify "System\ eth1"  -ipv4.dns 8.8.8.8
nmcli connection show "System\ eth1"
```

```bash
nmcli connection show "System eth1" |grep -w ipv4.dns
cat /etc/sysconfig/network-scripts/ifcfg-eth1
```

## Eliminar ruta por defecto:

```bash
route del default gw 192.168.1.1
```

## Ver GATEWAY por defecto:

```bash
route -n
netstat -r
```

## Add  Default Gateway:

```bash
route add default gw ipdeleth1
```

## Para poner como gw al eth1:

```bash
cat  /etc/sysconfig/network-scripts/ifcfg-eth0
```

## GATEWAY=192.168.1.1

## DEFROUTE=yes

```bash
systemctl restart network
systemctl restart NetworkManager
```

## route -n

### Kernel IP routing table

```
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.92.2    0.0.0.0         UG    100    0        0 eth1
```

## Rutas estáticas:

```bash
ip route add [red]/[máscara] via [puerta-de-enlace] dev [dispositivo]
```

## En el siguiente ejemplo se definirá la ruta estática hacia la red 192.168.3.0 con máscara de 25 bit (255.255.255.128),

## puerta de enlace a través de la dirección IP 172.16.1.36 y a través del dispositivo de red eth2:

```bash
ip route add 192.168.3.0/25 via 172.16.1.36 dev eth2
```

## Comandos para trabajar con la red en linux:

```bash
ip addr show
ip addr show eth1
ip link show
ip link show eth0
```

```bash
ip addr add 192.168.70.61/25 dev eth0
ip addr del 192.168.70.61/25 dev eth0
```
