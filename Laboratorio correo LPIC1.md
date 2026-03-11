# Laboratorio correo LPIC 1

Documento práctico sobre Laboratorio correo LPIC 1. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

Configuración básica de Postfix como laboratorio para el dominio curso.local en el servidor rockylinux8.curso.local 192.168.33.10

### root@rockylinux8 ~ #  cat   /etc/hosts

```
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.33.10  rockylinux8.curso.local rockylinux8
192.168.33.11  debian.curso.local debian
```

LABORATORIO Añadimos solamente esta configuracion al main.cf, asegurarse de tener una copia del archivo original 192.168.33.10:

```bash
dnf install -y sendmail sendmail-cf dovecot mailx postfix* mutt
```

```bash
cp /etc/postfix/main.cf /root
```

## Edito y borro todo el contenido del archivo /etc/postfix/main.cf

```bash
vi /etc/postfix/main.cf
```

## Pego ahora todo este contenido:

## --- Identidad del servidor ---

```conf
myhostname = rockylinux8.curso.local
mydomain = curso.local
myorigin = $mydomain
```

## --- Interfaces y protocolos ---

## Para laboratorio, escucha en loopback y en la IP de la LAN

```conf
inet_interfaces = 192.168.33.10, 127.0.0.1
inet_protocols = ipv4
```

## --- Dominios que este servidor considera "locales" (entrega local) ---

```conf
mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain
```

## --- Redes de confianza (pueden usar el servidor como relay) ---

## Solo tu LAN y loopback

```conf
mynetworks = 127.0.0.0/8, 192.168.33.0/24
```

## --- Seguridad anti-open-relay (básico y correcto) ---

```conf
smtpd_relay_restrictions = permit_mynetworks, reject_unauth_destination
```

## --- Entrega local en Maildir ---

```conf
home_mailbox = Maildir/
```

## --- Alias locales ---

```conf
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
```

## --- Banner (opcional, útil en laboratorio) ---

```conf
smtpd_banner = $myhostname ESMTP (Postfix - laboratorio)
```

## --- Límites (opcional) ---

Establece tamaño máximo permitido para un mensaje de correo (incluidos adjuntos). Limita los correos a 10 MB; los mensajes más grandes serán rechazados

```conf
message_size_limit = 10240000
```

tamaño máximo del buzón de cada usuario. El valor 0 indica sin límite impuesto por Postfix, quedando el control del espacio a cargo del sistema de archivos o de cuotas de disco si existen.

```conf
mailbox_size_limit = 0
```

## FIN DE LA CONFIGURACION

## Crear buzones Maildir para usuarios del sistema

Postfix, por sí solo, no crea los buzones. Necesitas crearlos para cada usuario que vaya a recibir correos. Por ejemplo, para los usuario root y vagrant:

### for user in root vagrant

### do

```bash
  mkdir -p /home/$user/Maildir/{cur,new,tmp}
  chown -R $user:$user /home/$user/Maildir
```

done

## Ver la configuración de Postfix que realmente se está aplicando

postconf -n

## Habilitar y reiniciar Postfix

```bash
systemctl enable postfix
systemctl restart postfix
systemctl status postfix
```

mutt es un cliente de correo en modo texto para Linux/Unix que permite leer, enviar y gestionar correos desde la terminal.

Luego, el usuario vagrant puede revisar su buzón en /home/vagrant/Maildir (si usas Maildir) o en /var/mail/vagrant (si usas mbox).

## Trabajamos con 3 sessiones dos sesiones como root y una session como usuario vagrant

### root@rockylinux8 ~ #  mail vagrant

### Subject: hola desde root jueves05

### hola

.

## En otra consola como root, veo la salida de los correos

### root@rockylinux8 ~ #  tail -f /var/log/maillog

Como estamos utilizando Maildir, utilizaremos mutt y vemos los correos que llegan al usuario vagrant:

[vagrant@rockylinux8 ~]$ mutt -f ~/Maildir

---

**newaliases

El comando newaliases se utiliza en sistemas Linux/Unix para reconstruir la base de datos de alias del servidor de correo a partir del archivo de texto /etc/aliases.

### Pasa los cambios del archivo /etc/aliases a /etc/aliases.db

Es común en servidores de correo como Postfix o Sendmail.

## Crearme una lista de correo con aliases, al final del archivo

### root@rockylinux8 ~ #  vi /etc/aliases

```
cntg:        root, vagrant, usu-nominal
```

## Pasa los cambios del fichero /etc/aliases a /etc/aliases.db

root@rockylinux8 ~ #  newaliases

## Envio el correo:

### root@rockylinux8 ~ #  mail cntg

### Subject: Prueba de lista de correo CNTG jueves05

### hola lista de correo CNTG jueves05

.

Como estamos utilizando Maildir, utilizaremos mutt, para ver el correo de la lista cntg que le tiene que llegar al usuario vagrant:

[vagrant@serockylinux1 ~]$ mutt -f ~/Maildir
