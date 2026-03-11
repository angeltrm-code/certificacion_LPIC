# Laboratorio supervisamem SYSTEM D

Documento práctico sobre Laboratorio supervisamem SYSTEM D. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Desarrollo

```bash
cd /opt/scripts
chmod 700 supervisamem
 chmod 700 iniciar-supervisamem
/etc/init.d/ iniciar-supervisamem
```

---

```bash
cd /etc/systemd/system
vi supervisamem.service
```

[Unit]

```conf
Description=Daemon of axample
```

[Service]

```conf
ExecStart=/etc/init.d/iniciar-supervisamem start
ExecStop=/etc/init.d/iniciar-supervisamem stop
Type=forking
```

[Install]

```conf
WantedBy=multi-user.target
```

---

```bash
systemctl daemon-reload
systemctl start supervisamem.service
```

## tail -f /var/log/supervisamem.log

```bash
systemctl stop supervisamem
```

```bash
systemctl enable suspervisamem.service
```
