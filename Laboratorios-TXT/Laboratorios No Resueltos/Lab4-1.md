# Lab4-1 resuelto (Debian y RHEL)

## 1. Cuantos caracteres tiene el archivo `/etc/passwd`
**Debian**
```bash
wc -m /etc/passwd
```

**RHEL**
```bash
wc -m /etc/passwd
```

## 2. Conseguir del archivo passwd los usuarios y sus directorios personales
**Debian**
```bash
cut -d: -f1,6 /etc/passwd
```

**RHEL**
```bash
cut -d: -f1,6 /etc/passwd
```

## 3. Version del kernel
**Debian**
```bash
uname -r
```

**RHEL**
```bash
uname -r
```

## 4. Buscar archivos con permisos especiales setuid
**Debian**
```bash
find / -xdev -type f -perm -4000 2>/dev/null
```

**RHEL**
```bash
find / -xdev -type f -perm -4000 2>/dev/null
```

## 5. Con `ls` mostrar el numero de inodo del directorio `/root`
**Debian**
```bash
ls -id /root
```

**RHEL**
```bash
ls -id /root
```

## 6. Buscar archivos modificados hace menos de 5 minutos
**Debian**
```bash
find / -xdev -type f -mmin -5 2>/dev/null
```

**RHEL**
```bash
find / -xdev -type f -mmin -5 2>/dev/null
```

## 7. Version del sistema operativo
**Debian**
```bash
cat /etc/os-release
```

**RHEL**
```bash
cat /etc/redhat-release
cat /etc/os-release
```

## 8. Cuantas CPU y cuanta memoria tiene el servidor
**Debian**
```bash
lscpu
free -h
```

**RHEL**
```bash
lscpu
free -h
```

## 9. Modelo de disco duro y tarjeta de red
**Debian**
```bash
lsblk -d -o NAME,MODEL,SIZE
lspci | grep -Ei 'ethernet|network'
```

**RHEL**
```bash
lsblk -d -o NAME,MODEL,SIZE
lspci | grep -Ei 'ethernet|network'
```

## 10. Modelo de CDROM
**Debian**
```bash
lsblk -o NAME,TYPE,MODEL | grep rom
```

**RHEL**
```bash
lsblk -o NAME,TYPE,MODEL | grep rom
```

## 11. En `/datos` el propietario debe tener permisos de lectura, escritura y ejecucion (modo alfabetico)
**Debian**
```bash
chmod u+rwx /datos
ls -ld /datos
```

**RHEL**
```bash
chmod u+rwx /datos
ls -ld /datos
```

## 12. Ejecutar `ls` y guardar `stdout` y `stderr` en `/tmp/salida.txt`
**Debian**
```bash
ls /etc /noexiste > /tmp/salida.txt 2>&1
```

**RHEL**
```bash
ls /etc /noexiste > /tmp/salida.txt 2>&1
```

## 13. Listar las units de tipo service en systemd
**Debian**
```bash
systemctl list-units --type=service --all
```

**RHEL**
```bash
systemctl list-units --type=service --all
```

## 14. Poner al inicio el servicio de Apache en System V y systemd
**Debian (apache2)**
```bash
update-rc.d apache2 defaults
systemctl enable apache2
```

**RHEL (httpd)**
```bash
chkconfig httpd on
systemctl enable httpd
```

## 15. Arrancar el servicio Apache con System V y systemd
**Debian (apache2)**
```bash
service apache2 start
systemctl start apache2
```

**RHEL (httpd)**
```bash
service httpd start
systemctl start httpd
```

## 16. Averiguar si Apache se iniciara con el sistema (System V y systemd)
**Debian (apache2)**
```bash
ls /etc/rc*.d/S*apache2
systemctl is-enabled apache2
```

**RHEL (httpd)**
```bash
chkconfig --list httpd
systemctl is-enabled httpd
```

## 17. Cambiar al target/runlevel 3 en caliente (System V y systemd)
**Debian**
```bash
telinit 3
systemctl isolate multi-user.target
```

**RHEL**
```bash
telinit 3
systemctl isolate multi-user.target
```

## 18. Averiguar en que target arranca el sistema en systemd
**Debian**
```bash
systemctl get-default
```

**RHEL**
```bash
systemctl get-default
```

## 19. Ver con journalctl los logs de error del servicio SSH
**Debian (`ssh`)**
```bash
journalctl -u ssh -p err
```

**RHEL (`sshd`)**
```bash
journalctl -u sshd -p err
```

## 20. Ver todos los logs de error del sistema con journalctl
**Debian**
```bash
journalctl -p err
```

**RHEL**
```bash
journalctl -p err
```

## 21. Ver los logs del servicio Apache y MariaDB con journalctl
**Debian**
```bash
journalctl -u apache2 -u mariadb
```

**RHEL**
```bash
journalctl -u httpd -u mariadb
```

## 22. Ver los logs de los ultimos 5 minutos del servicio SSH
**Debian (`ssh`)**
```bash
journalctl -u ssh --since "5 minutes ago"
```

**RHEL (`sshd`)**
```bash
journalctl -u sshd --since "5 minutes ago"
```

## 23. Tarea programada a las 23:00 de lunes a viernes como root para buscar archivos modificados hace menos de 5 minutos en `/web`
**Debian**
```bash
crontab -e
```
Linea:
```cron
0 23 * * 1-5 /usr/bin/find /web -type f -mmin -5
```

**RHEL**
```bash
crontab -e
```
Linea:
```cron
0 23 * * 1-5 /usr/bin/find /web -type f -mmin -5
```

## 24. Denegar cron a todos los usuarios menos a gerente y operador
**Debian**
```bash
printf "gerente\noperador\n" > /etc/cron.allow
chmod 640 /etc/cron.allow
```

**RHEL**
```bash
printf "gerente\noperador\n" > /etc/cron.allow
chmod 640 /etc/cron.allow
```
