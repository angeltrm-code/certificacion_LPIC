# Laboratorio instalar software debian redhat

Documento práctico sobre Laboratorio instalar software debian redhat. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Referencias

- https://webmin.com/

## Comenzamos el laboratorio con la ultima verison de la web:

## Instalacion de Webmin con procedimiento en su Web con system-D:

- https://webmin.com/download/

```bash
cd /root
curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
```

## Ejecutamos el scrit setup-repos.sh genera los repositorios dependiendo del la version de sistema linux Red Hat Enterprise Linux, Alma, Rocky, Oracle, CentOS Stream, Fedora or Debian, Ubuntu, Kali.:

```bash
sh setup-repos.sh
```

## RHEL and derivatives

```bash
dnf install webmin -y
```

## Debian and derivatives

```bash
apt-get install webmin --install-recommends
```

## Asegurarse de tener detenido el firewall en redhat:

```bash
systemctl status firewalld
systemctl stop firewalld
systemctl disable firewalld
```

## Para arrancar Webmin:

```bash
systemctl start webmin
systemctl status webmin
```

```
netstat -putan |grep 10000
tcp        0      0 0.0.0.0:10000           0.0.0.0:*               LISTEN      26477/perl
```

```bash
ss -tan |grep 10000
```

```bash
ip a
ifconfig -a
```

- https://192.168.33.10:10000/

Las credenciales de acceso el la cuenta del root del servidor, en maquinas con debian entramos con el usuario vagrant.

## Parar el service de Webmin:

```bash
systemctl stop webmin
systemctl status webmin
ss -tan |grep 10000
```

---

## Cockpit

Cockpit es una herramienta libre de administración de servidores de código abierto que nos va a permitir supervisar y administrar fácilmente servidores Gnu/Linux individuales o múltiples a través de un navegador web.

## Para debian:

```bash
sudo apt-get install -y cockpit*
```

## En debian si tenemos el firewall

### sudo ufw allow 9090/tcp

### sudo ufw reload

### sudo ufw allow 9090/tcp

### sudo ufw reload

### sudo ufw disable

```bash
sudo systemctl disable ufw
```

## Cómo instalar Cockpit en Redhat x

```bash
dnf install -y cockpit*
```

## Para iniciar el service cockpit

```bash
systemctl start cockpit
```

## Y para habilitar Cockpit y que inicie automáticamente  usaremos la opción enable:

```bash
systemctl enable cockpit.socket
```

## Comprobamos tenemos el puerto del service cockpit iniciado, el puerto es el 9090:

```
netstat -putan |grep 9090
tcp        0      0 0.0.0.0:9090            0.0.0.0:*               LISTEN      1/systemd
```

### Puedes comprobar en cualquier momento el estado del servicio Cockpit con el comando:

```bash
systemctl status cockpit
```

## Para entrar en cockpit con las credenciales del usuario root y la ip de nuestra mv de linux:

```bash
ip a
```

- http://192.168.33.10:9090/
