# Laboratorio SSH agent

Documento práctico sobre Laboratorio SSH agent. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Laboratorio ssh-agent:

## ssh-agent

ssh-agent es un manejador de claves para SSH, es decir, mantiene las claves privadas en memoria, descifradas y listas para usarse. Esto nos facilita el hecho de utilizar dichas claves sin necesidad de cargarlas y descifrarlas (en el caso de que hayamos seteado una passphrase) cada vez que vayamos a usarlas.

- Seguridad: utilizar una passphrase para la clave es más seguro que utilizar solamente una password, más si alguien se hace con nuestra computadora. De hecho sería conveniente establecer una passphrase a la hora de generar la clave privada.

- Comodidad: a nivel práctico, utilizar clave privada con passphrase sería similar a conectarse sin usar clave privada: el sistema igual nos pide una contraseña/passphrase.

Desde el punto de vista del servidor SSH, el protocolo funciona de la siguiente manera (muy breve y resumido:

- El cliente le da su clave pública.

- El servidor genera un mensaje denominado Key Challenge, y lo envía al cliente para realizar la verificación de identidad.

- El cliente usa la clave privada para realizar la verificación, y responde al servidor.
- El servidor constata la veracidad del Key Challenge del cliente.
- El servidor ahora sabe que el cliente es quien dice ser y establece el túnel.
- Luego de esto se generan claves simétricas efímeras para el intercambio de tráfico cifrado.

Ahora bien, cuando decimos que el cliente usa su clave privada para generar la firma, en realidad «pide» al ssh-agent la firma del mensaje, y el ssh-agent, que tiene acceso a la clave privada, lo firma y la devuelve.

**En este procedimiento ejecutaremos programas a traves de ssh desde  debian a rockylinux8 ,

**con el usuario root en ambos servidores, utilizaremos contraseña en la creacion del certificado:

### rockylinux8--->192.168.33.10

### debian---> 192.168.33.11

En debian con el usuario root, en la creacion del certificado  a la pregunta  passphrase ponemos una contraseña:

### Enter passphrase (empty for no passphrase):

### Enter same passphrase again:

```bash
su -
ssh-keygen -t rsa -b 4096
```

## Genera en /root/.ssh estos dos ficheros :

### id_rsa

### id_rsa.pub

Desde debian, esta orden copia el contenido de id_rsa.pub, en el servidor debian en el archivo /root/.ssh/authorized_keys

```bash
cd /root/.ssh
ssh-copy-id -i id_rsa.pub root@192.168.33.10
```

En rockylinux8 con el usuario root puedo comprobar la creacion del archivo authorized_keys, creado con el comando

### anterior

```bash
ls -l /root/.ssh
```

## Se crea el archivo authorized_keys con el contenido de id_rsa.pub de rockylinux8

authorized_keys

## Para probar que todo funciona desde el servidor debain ejecutamos:

## Anotacion ssh-agent:

## Si la llave privada es creada con un password en el ejemplo servidor rockylinux8 (ssh-add)

El comando eval $(ssh-agent) se usa para iniciar el agente SSH (ssh-agent) y configurar el entorno para que las claves SSH puedan utilizarse sin necesidad de ingresar la contraseña en cada conexión.

### eval $(ssh-agent)

```
ssh-add  /root/.ssh/id_rsa
```

## NO REALIZARLO EN EL LABORATORIO EXPLICACION FORMADOR:

## stop SSH-Agent

## if not execute it, SSH-Agent process remains even if you logout System, be careful

### eval $(ssh-agent -k)

## EJEMPLOS NO REALIZAR EL ESTE LABORATORIO Ahora cuando ejecuto este comando me pedira el password del certificado que se guradara en la variable ssh-agent:

## Ejemplos:

```bash
ssh-add -t 1800 # 1800 seconds
ssh-add -t 45m # 45 minutes
ssh-add -t 3h42 # 3 hours 42 minutes
```

## Nuestro laboratorio este comando me pide el pass de la llave privada y la guarda en el ssh-agent:

```bash
ssh-add /root/.ssh/id_rsa
ssh-add -t 45m /root/.ssh/id_rsa # 45 minutes
ssh-add -t 2m /root/.ssh/id_rsa # 2 minutes
```

## Ahora no nos tendra que pedir el password de la llave privada:

```bash
ssh 192.168.33.10 cat /etc/hostname
```

```bash
ssh root@192.168.33.10
touch /root/miercoles15-root
scp /root/miercoles15-root  root@192.168.33.10:/tmp
```

## El comando eval interpreta los argumentos dados como un comando Bash.

## Si ejecutamos este comando en debian

eval $(ssh-agent -k)

## Tiene que pedir el password del certificado:

```bash
ssh root@192.168.33.10
```

---

## Permite poner clave o cambiar una clave al certificado privado.

```bash
ssh-keygen -p -f <ruta al fichero de la clave privada id_rsa>
```

Este comando sirve para cambiar la contraseña (passphrase) de una clave privada SSH existente, sin generar una nueva clave.

## En resumen:

Si tu clave privada actual no tiene contraseña, puedes añadirle una.

Si ya tiene una contraseña, puedes cambiarla o eliminarla.

## Permite poner clave o cambiar una clave al certificado privado.

```bash
ssh-keygen -p -f <ruta al fichero de la clave privada id_rsa>
```

```
Opción    Significado
-p        Indica que quieres cambiar el passphrase.
-f      <ruta>    Especifica el archivo de clave privada que quieres modificar (por ejemplo ~/.ssh/id_rsa).
```
