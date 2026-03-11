# Ejecutar en systemd un script en Bash al arranque

Documento de referencia sobre Ejecutar en systemd un script en Bash al arranque con formato Markdown homogéneo y navegación más clara.

### Ejecutar en systemd un script en Bash para que arranque como demonio al encenderla máquina:

## cd /usr/bin

```bash
vi mail_arranque.sh
```

## !/bin/bash

echo se encendio el equipo $(hostname) a las $(date +%d-%m-%Y---%X) | mail usuario@correo.es

## chmod +x /usr/bin/mail_arranque.sh

---

```bash
vi /etc/systemd/system/mail_arranque.service
```

### [Unit]

```conf
Description= Envio hora de arranque
After=network.target
```

### [Service]

```conf
ExecStart=/usr/bin/mail_arranque.sh
Type=oneshot
RemainAfterExit=true
```

### [Install]

```conf
WantedBy=default.target
```

```bash
systemctl daemon-reload
systemctl enable mail_arranque.service
systemctl start mail_arranque.service
```

---

## Si queremos ver el enlace blando creado podemos encontrarlo en /etc/systemd/system/default.target.wants/

## RemainAfterExit=true hará que el servicio permanezca de acuerdo con systemd,

por lo que solo intentará ejecutarse la primera vez que ejecute systemctl start, pero no la segunda.

---

```bash
vi /usr/bin/rutas.sh
ip route add 192.168.3.0/25 via 172.16.1.36 dev eth1
ip route add 192.168.4.0/25 via 172.16.1.38 dev eth2
```

```bash
chmod 700 /usr/bin/rutas.sh
```

```bash
vi /etc/systemd/system/rutas.service
```

### [Unit]

```conf
Description= Envio hora de arranque
After=network.target
```

### [Service]

```conf
ExecStart=/usr/bin/rutas.sh
Type=oneshot
RemainAfterExit=true
```

### [Install]

```conf
WantedBy=default.target
```

```bash
systemctl daemon-reload
systemctl enable rutas.service
systemctl start rutas.service
```

## RemainAfterExit=true hará que el servicio permanezca de acuerdo con systemd,

por lo que solo intentará ejecutarse la primera vez que ejecute systemctl start, pero no la segunda.
