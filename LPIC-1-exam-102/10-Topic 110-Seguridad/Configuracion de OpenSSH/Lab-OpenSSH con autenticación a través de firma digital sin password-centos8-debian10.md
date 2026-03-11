# Lab OpenSSH con autenticación a través de firma digital sin password centos 8 debian 10

Documento práctico sobre Lab OpenSSH con autenticación a través de firma digital sin password centos 8 debian 10. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Se debe generar una firma digital (firma digital pública) creada con rsa (Digital

### Signature Algorithm o Algoritmo de Firma digital). Si se desea evitar utilizar

### contraseña para autenticar, sólo se pulsa la tecla ENTER. Si asigna contraseña, está

### será utilizada para autenticar el certificado creado cada vez que se quiera utilizar éste

para autenticar remotamente.

## La opción -t significa tipo, mientras que RSA es el protocolo utilizado para la generación de claves.

RSA es el tipo predeterminado, así que también puedes usar la versión más simple del comando: ssh-keygen.

La clave predeterminada es de 2048 bits. Sin embargo, si deseas una seguridad más fuerte, puedes cambiar

### el valor a 4096 bits. En ese caso, el comando será:

```bash
ssh-keygen -t rsa -b 4096
```

## En este procedimiento ejecutaremos programas a traves de ssh desde rockylinux8 a debian, con el usuario vagrant en ambos servidores:

### rockylinux8--->192.168.33.10

### debian---> 192.168.33.11

En rockylinux8 con el usuario vagrant y no ponemos contraseña en el certificado respondemos a todo con intro:

```bash
su - vagrant
ssh-keygen -t rsa -b 4096
```

## Genera en /home/vagrant/.ssh estos dos ficheros :

### id_rsa

### id_rsa.pub

## Seguimos los pasos de nuestro laboratorio, sin palabra de paso en nuestros certificados:

ssh-copy-id es un comando de Linux que copia tu clave pública SSH a un servidor remoto, para que luego puedas conectarte sin tener que escribir la contraseña cada vez.

Se usa para configurar autenticación SSH basada en clave pública (más segura que usar contraseñas).

Esta orden copia el contenido de id_rsa.pub, en el servidor debian en el archivo /home/vagrant/.ssh/authorized_keys

```bash
cd /home/vagrant/.ssh
ssh-copy-id -i id_rsa.pub vagrant@192.168.33.11
```

## En debian con el usuario vagrant

```bash
/home/vagrant/.ssh
```

## Se crea el archivo authorized_keys con el contenido de id_rsa.pub de rockylinux8

authorized_keys

## Para probar que todo funciona desde el rockylinux8 ejecutamos:

```bash
 ssh 192.168.33.11 cat /etc/hostname
```

```bash
ssh vagrant@192.168.33.11
touch  /home/vagrant/datos.txt
scp /home/vagrant/datos.txt 192.168.33.11:/home/vagrant
```

```cron
0 23 * * 1-5  /opt/scripts/backup-servidor 2>&1 |mail -s "Salida del copia segu oracle"  usuario@correo.es
0 3  * *  1-5 scp /backup/backup-servidor.tar.gz  ipdebian:/backup
```

```bash
cat mi_clave_o_texto.pub | ssh vagrant@192.168.33.11 "cat >> ~/.ssh/authorized_keys"
```

---

## En este procedimiento ejecutaremos programas a traves de ssh desde debian a rockylinux8  con el usuario vagrant en ambos servidores:

### rockylinux8--->192.168.33.10

### debian---> 192.168.33.11

En debian con el usuario vagrant y no ponemos contraseña en el certificado respondemos a todo con intro:

```bash
ssh-keygen -t rsa -b 4096
```

## Genera en /home/vagrant/.ssh estos dos ficheros :

### id_rsa

### id_rsa.pub

## Seguimos los pasos de nuestro laboratorio, sin palabra de paso en nuestros certificados:

ssh-copy-id es un comando de Linux que copia tu clave pública SSH a un servidor remoto, para que luego puedas conectarte sin tener que escribir la contraseña cada vez.

Se usa para configurar autenticación SSH basada en clave pública (más segura que usar contraseñas).

Esta orden copia el contenido de id_rsa.pub, en el servidor rockylinux8 en el archivo /home/vagrant/.ssh/authorized_keys

```bash
cd /home/vagrant/.ssh
ssh-copy-id -i id_rsa.pub vagrant@192.168.33.10
```

## En rockylinux8 con el usuario vagrant

```bash
/home/vagrant/.ssh
```

## Se crea el archivo authorized_keys con el contenido de id_rsa.pub de rockylinux8

authorized_keys

## Para probar que todo funciona desde el debian ejecutamos:

```bash
ssh 192.168.33.10 cat /etc/hostname
```

```bash
ssh vagrant@ipdebian
scp /home/vagrant/datos.txt 192.168.33.10:/home/vagrant
sudo ssh vagrant@192.168.33.10
```
