# Configuracion de interfaces

Documento de referencia sobre Configuracion de interfaces con formato Markdown homogéneo y navegación más clara.

## Contenido

RedHat6 setup

```bash
/etc/sysconfig/network-scripts/ifcfg-eth3
 /etc/sysconfig/network
 /etc/resolv.conf
  /etc/hosts
  service network restart
```

### Redhat 7

### nmtui

```bash
  /etc/sysconfig/network-scripts/ifcfg-eth0
  /etc/resolv.conf
  /etc/hosts
  systemctl restart network
  /etc/hostname
  hostnamectl
```

```bash
  service NetworkManager start
  systemctl start NetworkManager
```
