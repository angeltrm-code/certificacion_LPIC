# Lab rsyslog miercoles 04

Documento práctico sobre Lab rsyslog miercoles 04. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Añadimos al final del archivo:

```bash
vi /etc/profile
```

trap 'logger -p local1.notice "$(whoami) ejecutó: $(history 1)"' DEBUG

## En la regls del rsyslog

```bash
vi /etc/rsyslog.conf
```

```
local1.*    /var/log/commands.log
```

## Reinicio el service:

```bash
systemctl restart rsyslog
systemctl status rsyslog
```

## En un terminal ejecuto:

### tail -f /var/log/commands.log

Si ahora entramos por ssh con el usuario nominal tengo que ver lo comando que ejecuta en /var/log/commands.log
