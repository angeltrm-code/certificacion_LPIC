# Laboratorio LPIC 1 SSH

Documento practico para configurar OpenSSH, restringir accesos y trabajar con autenticacion mediante clave publica.

## Laboratorio 1: Configurar OpenSSH en Rocky Linux

Objetivo del laboratorio sobre el servidor `192.168.33.10`:

- cambiar el puerto SSH a `52412`
- denegar acceso al usuario `root`
- desactivar reenvio X11
- permitir acceso al usuario `vagrant`
- permitir acceso al usuario `operador` solo desde `192.168.33.11`
- definir un banner en `/etc/ssh/sshd-banner`
- copiar `c:\windows.txt` desde Windows hacia `/tmp`

### Esquema del laboratorio

```text
Windows PC (192.168.33.1)
    |
    | SCP de c:\windows.txt
    v
RockyLinux servidor (192.168.33.10)
    |
    | SSH puerto 52412
    v
Debian 12 VM (192.168.33.11)
```

### Copia de seguridad del archivo principal

```bash
cp /etc/ssh/sshd_config /root
```

### Crear el usuario `operador`

```bash
adduser operador
passwd operador
```

### Configuracion del servidor SSH

Editar el archivo principal:

```bash
vi /etc/ssh/sshd_config
```

Añadir al final:

```conf
Port 52412
PermitRootLogin no
X11Forwarding no
AllowUsers vagrant operador@192.168.33.11
Banner /etc/ssh/sshd-banner
```

Crear el banner:

```bash
vi /etc/ssh/sshd-banner
```

Contenido sugerido:

```text
Authorized access only!
Disconnect IMMEDIATELY if you are not an authorized user!!!
All actions will be monitored and recorded.
```

### Validacion y reinicio

Antes de reiniciar, comprobar la sintaxis:

```bash
sshd -t
```

Aplicar cambios:

```bash
systemctl restart sshd
systemctl status sshd
```

### Copiar archivo desde Windows al servidor

Copiar `c:\windows.txt` al directorio `/tmp` usando el puerto configurado:

```bash
scp -P 52412 c:\windows.txt vagrant@192.168.33.10:/tmp
```

Sin indicar el puerto correcto, la copia fallaria si el servicio ya no escucha en el puerto 22:

```bash
scp c:\windows.txt vagrant@192.168.33.10:/tmp
```

### Comprobaciones del laboratorio

Verificar que:

- el puerto es `52412`
- `vagrant` puede conectarse
- `root` no puede conectarse
- `operador` solo puede conectarse desde la maquina Debian autorizada

Prueba desde Debian 12:

```bash
ssh -p 52412 operador@192.168.33.10
```

Tambien debe comprobarse que `root` no entra y que `vagrant` si puede hacerlo.

### Restaurar configuracion por defecto

Al finalizar el laboratorio:

```bash
cp /root/sshd_config /etc/ssh/
systemctl restart sshd
systemctl status sshd
```

## Laboratorio 2: Ejecutar programas a traves de SSH con claves

En este procedimiento se trabaja entre:

- `rockylinux8` en `192.168.33.10`
- `debian` en `192.168.33.11`

Se utiliza el usuario `vagrant` en ambos sistemas y se genera autenticacion sin contraseña.

### Generar el par de claves

Cambiar al usuario `vagrant`:

```bash
su - vagrant
```

Generar el par de claves:

```bash
ssh-keygen -t rsa -b 4096
```

Durante el asistente, responder con Intro a todas las preguntas para no establecer passphrase.

Ejemplo de salida:

```text
Generating public/private dsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_dsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/vagrant/.ssh/id_dsa.
Your public key has been saved in /home/vagrant/.ssh/id_dsa.pub.
The key fingerprint is:
2c:73:30:fe:82:21:a5:52:78:49:37:cd:57:af:36:df vagrant@cliente
```

Comprobar los ficheros generados:

```bash
ls -l /home/vagrant/.ssh
```

Ficheros esperados:

- `id_rsa`
- `id_rsa.pub`

### Copiar la clave publica al servidor remoto

`ssh-copy-id` copia la clave publica al archivo `authorized_keys` del usuario remoto para permitir autenticacion basada en clave publica.

```bash
cd /home/vagrant/.ssh
ssh-copy-id vagrant@192.168.33.11
```

## Notas practicas adicionales

### Especificar una clave privada al conectar

```bash
ssh -i ~/.ssh/RSAPair user@hostname
```

### Copia remota con `scp`

```bash
scp -P 52341 algo.txt operador@192.168.70.99:/home/operador
scp -p -P 52341 algo.txt 192.168.70.99:/home/operador
scp -r Ejemplos-scrpts vagrant@192.168.33.10:/tmp
```

Ejemplo de copia remota preservando permisos y fechas:

```bash
cd /root
scp -P 52341 -rp operador@192.168.70.99:/home/operador/Mail ./
```

Ejemplo adicional desde Debian:

```bash
scp -P 52341 archivo operador@192.168.30.10:/tmp
```

Este formato no funcionaria, porque el puerto debe indicarse antes del fichero:

```bash
scp algo.txt -P 52341 operador@192.168.70.99:/home/operador
```

## Resumen del laboratorio

Al terminar, deberias poder:

- endurecer la configuracion de `sshd`
- validar la sintaxis con `sshd -t`
- restringir usuarios y origenes IP
- configurar banner de acceso
- transferir archivos con `scp`
- usar autenticacion SSH mediante clave publica
