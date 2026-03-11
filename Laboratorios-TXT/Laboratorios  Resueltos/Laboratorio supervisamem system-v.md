# Laboratorio supervisamem system v

Documento práctico sobre Laboratorio supervisamem system v. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

```bash
mkdir /opt/scripts
cp /tmp/supervisamem /opt/scripts
cp /tmp/iniciar-supervisamem /etc/init.d
cd /opt/scripts
chmod 700 supervisamem
./supervisamem
```

tail -f /var/log/supervisamem.log

---

```bash
chmod 700 /etc/init.d/iniciar-supervisamem
service iniciar-supervisamem start
```

### tail -f /var/log/supervisamem.log

```bash
service iniciar-supervisamem stop
```

ps -ef |grep supervisamem

---

```bash
chkconfig --level 35 iniciar-supervisamem on
```

### Tendremos que tener:

```bash
vi /etc/init.d/iniciar-supervisamem
```

## !/bin/bash

## chkconfig: - 99 10

## description: Supervisamem

```bash
cd /etc/rc3.d
cd /etc/rc5.d
ls -l
```

S99iniciar-supervisamem --> /etc/init.d/iniciar-supervisamem
