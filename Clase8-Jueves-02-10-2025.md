# Clase 8 Jueves 02 10 2025

Apuntes de clase sobre Clase 8 Jueves 02 10 2025, reorganizados para facilitar la consulta rápida y el repaso.

**Jueves 02/10/2026

## Referencias

- https://www.lpi.org/es/our-certifications/lpic-1-overview

## Materiales publicos de LPIC:

- https://learning.lpi.org/es/learning-materials/learning-materials/

## Guias IBM:

- https://developer.ibm.com/tutorials/l-lpic1-map

Profesor/a Titular: Alberto Garcia

## Examen presencial del LPIC 101 y LPIC 102 el Lunes 17 Noviembre  en el CNTG

- https://www.lpi.org/about-lpi/frequently-asked-questions/

## Conectarme a traves del cliente ssh de Windows abrimos un cmd:

## Maquina rockylinux:

```bash
ssh root@192.168.33.10
```

## Maquina debian12:

```bash
ssh vagrant@192.168.33.11
```

## Para trabajar como root en la mv de debian:

### sudo -i

> Clonar repositorio formador para realizar los laboratorio del Shell Bash de Linux Comandos Manejo de Texto.pdf :

```bash
dnf install git unzip -y
apt install git unzip -y
```

```bash
cd /
git clone https://github.com/agarciafer/lpic1.git
cd /lpic1
unzip access_log.zip
```

---

## En esta clase veremos:

## LPIC-102

## Tema 108: Servicios esenciales del sistema

Material Alumnos LPIC-1-2026\LPIC-1-exam-102\8-Topic 108 Essential System Services

## Tema 108.2 Registros del sistema

> -->Topic-108-Rsyslog-Logrotate.pdf -->Explicacion Configuracion rsyslog.txt -->Explicacion Logrotate.txt

## Tema 108: Servicios esenciales del sistema

-->108.3 Conceptos básicos del Agente de Transferencia de Correo -->Cofiguracion correo lpic-1.txt

## Tema 108.4 Gestión de la impresión y de las impresoras

> Material Alumnos LPIC-1-2026\LPIC-1-exam-102\8-Topic 108 Essential System Services -->Impresion comandos.txt -->Instalación y configuración de CUPS.pdf -->Laboratorio Gestion_Impresoras.pdf -->Ejercicio_Impresora-Cups.pdf -->Realizado sobre mv debian

---

## Enable syslog remote en nuestro servidor linux 192.168.33.10 y utilizaremos como cliente nuestro servidor debian12 192.168.33.11:

## Descomentamos las siguientes lineas en el servidor de syslog 192.168.33.10:

```bash
vi /etc/rsyslog.conf
```

## Provides UDP syslog reception

```conf
$ModLoad imudp
$UDPServerRun 514
```

## Reiniciamos el service:

```bash
systemctl restart rsyslog.service
systemctl status rsyslog.service
```

## Comprobamos que esta iniciado el syslog remote a traves de UDP:

```bash
netstat -putan |grep 514
```

```
udp        0      0 0.0.0.0:514             0.0.0.0:*                           1213/rsyslogd
```

Configurar un cliente linux para que escriba los logs en nuestro syslog remoto 192.168.33.10

```
[root@debian ~]# vi /etc/rsyslog.conf
```

The authpriv file has restricted access.

```
auth,authpriv.*                 /var/log/auth.log
```

@192.168.33.10

## Reiniciamos el service:

```bash
systemctl restart rsyslog.service
systemctl status rsyslog.service
```

Ahora comprobamos que en el servidor remoto de syslog este escibiendo 192.168.33.10: Iniciamos una conexion a traves de ssh al servidor cliente y veremos como el log se registra en nuestro servidor de syslog remoto:

## tail -f /var/log/secure

ahora en nuestro servidor de syslog 192.168.33.10 si iniciamos session en debian tendriamos que ver en el log:

### root@rockylinux8 ~ # tail -f /var/log/secure

```
Oct  8 03:20:02 debian sshd[962]: pam_unix(sshd:session): session opened for user vagrant(uid=1000) by (uid=0)
Oct  8 03:20:02 debian sshd[962]: pam_env(sshd:session): deprecated reading of user environment enabled
```

---

## Enabling Persistent Storage journal servidor 192.168.33.10:

### By default, Journal stores log files only in memory or a small ring-buffer in the

```bash
/run/log/journal/ directory
```

## mkdir -p /var/log/journal/

## systemd-tmpfiles --create --prefix /var/log/journal

## chown root:systemd-journal /var/log/journal

## chmod 2775 /var/log/journal

Then, restart journald to apply the change:

```bash
systemctl restart systemd-journald
```

---

## Laboratorio Gestion de Usuarios:

### Cear los grupos sistemas informatica y micro

```bash
groupadd informatica
groupadd sistemas
groupadd micro
```

### Crear del usu1 al usu5

El usu1 no tiene shell y grupo primario informatica adduser -s /sbin/nologin  -g informatica usu1

```bash
passwd usu1
```

El usu2 grupo secundario sistemas y micro grupo primario adduser -G sistemas -g micro usu2

```bash
passwd usu2
```

El usu3 en el primer inicio de sesion tiene que cambiar el password adduser usu3

```bash
passwd usu3
```

### chage -d 0 usu3

### Password,259

El usu4 le caduca la cuenta el 14/10/2026 adduser -e 2026-10-14 usu4

```bash
passwd usu4
```

### chage -l usu4

El usu5 grupo primario informatica grupo secundario sistemas Tiene la variable JAVA_HOME=/usr/jdk.1.8 Tiene el alias de comando borrar tiene que pedirle confirmacion Y el alias listar es un ls pero tiene que dar los permisos largos y el numero de inodo

### adduser -g informatica -G sistemas usu5

```bash
passwd usu5
```

```bash
vi /home/usu5/.bash_profile
```

```bash
export JAVA_HOME PS1
```

```bash
vi /home/usu5/.bashrc
alias borrar='rm -i'
alias listar='ls -li'
```

## Para comprobar el usu5:

```bash
alias
```

---

Laboratorio ampliar particion swap en 4GB en el procedimiento lo persistimos en el /etc/fstab:

---

### Laboratorio de gestión de paquetes en Linux practico sobre nuestros servidores:

### Laboratorio de gestión de paquetes en Linux

### 1) Debian/Ubuntu (dpkg + apt)

### 1.1 Instalar un paquete con dpkg

```bash
apt-get download sl
sudo dpkg -i sl_5.02-1+b1_amd64.deb
```

### 1.2 Ver contenido de un paquete .deb

```bash
dpkg -c sl_5.02-1+b1_amd64.deb
```

### 1.3 Ver información del paquete instalado

```bash
dpkg -l | grep sl
dpkg -s sl
```

### 1.4 Actualizar un paquete

```bash
sudo apt-get install –only-upgrade sl
```

--only-upgrade → le dice a apt que solo actualice si el paquete ya está instalado, y no lo instale si no lo está.

### 1.5 Eliminar un paquete

```bash
sudo dpkg -r sl # elimina binarios, mantiene configs sudo dpkg -P sl #
```

### elimina todo, incluidas configs

### 2) Red Hat / CentOS / Rocky (rpm + yum/dnf)

### 2.1 Instalar un paquete con rpm

```bash
dnf remove mc -y
yum install  --downloadonly --downloaddir=/root  mc
sudo rpm -ivh mc-4.8.19-9.el8.x86_64.rpm
dnf install -y  /root/mc-4.8.19-9.el8.x86_64.rpm
```

### 2.2 Ver contenido de un paquete .rpm

```bash
rpm -qlp mc
```

### 2.3 Ver información de un paquete instalado

```bash
rpm -qi mc
```

### 2.4 Actualizar un paquete

```bash
sudo rpm -Uvh mc
sudo yum update mc
 sudo dnf upgrade mc
```

### 2.5 Eliminar un paquete

```bash
sudo rpm -e mc
```

3) Comparación rápida de comandos

---

```
  Acción           Debian (dpkg/apt)               Red Hat (rpm/yum/dnf)
```

---------------- ------------------------------- ----------------------- Instalar paquete dpkg -i paquete.deb / apt       rpm -ivh paquete.rpm /

```
                   install                         yum install
```

### Ver contenido    dpkg -c paquete.deb             rpm -qlp paquete.rpm

### Ver info paquete dpkg -s nombre / dpkg -l        rpm -qi nombre

```
  Actualizar       apt-get install –only-upgrade   rpm -Uvh paquete.rpm /
  paquete          nombre                          yum update nombre
```

Eliminar paquete dpkg -r nombre o dpkg -P nombre rpm -e nombre

---

---

## Explicar los comandos:

```bash
ldconfig
```

### variable LD_LIBRARY_PATH

```bash
ldd
```

### locale

### 1) ldconfig

- Actualiza la caché de librerías compartidas (ld.so.cache).
- Usa /etc/ld.so.conf y /etc/ld.so.conf.d/.
- Ejemplo:

```bash
  sudo ldconfig -p | grep ssl
```

### 2) LD_LIBRARY_PATH

- Variable de entorno que indica rutas extra para buscar librerías.
- Sintaxis: directorios separados por :
- Ejemplo:

```bash
  export LD_LIBRARY_PATH=/usr/local/lib:/opt/lib:$LD_LIBRARY_PATH
```

### 3) ldd

- Muestra librerías que necesita un ejecutable.
- Ejemplo:

```bash
  ldd /bin/ls
```

### 4) locale

- Muestra configuración regional (idioma, codificación, formatos).
- Variables: LANG, LC_ALL, LC_TIME, LC_NUMERIC, etc.
- Ejemplo:

### locale

```bash
  export LANG=C
```

---

## Laboratorio mv debian correo:

```bash
apt --fix-broken install -y
```

```bash
apt update -y
apt install -y postfix mailutils
```

```bash
systemctl status postfix
```

### tail -f /var/log/maillog

```bash
 mail vagrant
```

Cc: Subject: hola desde root jueves02 fdfsdff

## Como root

```
vi  /etc/aliases
```

## See man 5 aliases for format

```
postmaster:    root
```

cntg: root, vagrant

## Para aplicar los cambios en el archivo /etc/aliases:

### newaliases

### Ahora desde cualquier usuario, tiene que llegar el correo al usuario root y vagrant:

```bash
mail cntg
```
