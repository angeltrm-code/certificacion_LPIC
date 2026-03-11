# Explicacion Configurar SSHD

Resumen tecnico sobre OpenSSH, su configuracion principal y el uso de `ssh`, `sftp` y `scp`.

> Referencia del manual del curso LPIC-1: pagina 426.

## Que es SSH

SSH, Secure Shell, es un protocolo de red que permite conexiones seguras y cifradas entre dos equipos. Se utiliza para administracion remota, transferencia de archivos y ejecucion de comandos a traves de una conexion protegida.

## Esquema de comunicacion SSH

### 1. Inicio de conexion

El cliente abre una conexion TCP hacia el servidor, normalmente por el puerto 22.

### 2. Negociacion de protocolos

El servidor responde indicando la version del protocolo SSH y los algoritmos de cifrado soportados. El cliente selecciona el conjunto mas adecuado y confirma la negociacion.

### 3. Intercambio de claves

Se utiliza un mecanismo de intercambio de claves, como Diffie-Hellman, para generar una clave compartida. El servidor presenta su clave publica y el cliente la usa para establecer el canal seguro.

### 4. Autenticacion

El cliente se autentica frente al servidor. Los metodos mas comunes son:

- contraseña
- clave publica
- autenticacion de dos factores

### 5. Sesion cifrada

Una vez autenticado el cliente, se establece un canal seguro y toda la comunicacion posterior viaja cifrada.

### 6. Cierre de sesion

El cliente o el servidor pueden cerrar la sesion. En ese momento se destruye el canal seguro.

## Diagrama ASCII

```text
+---------+       1. TCP connection       +---------+
| Cliente | -----------------------------> | Servidor |
+---------+                               +---------+

+---------+       2. Key Exchange         +---------+
| Cliente | <-----------------------------> | Servidor |
+---------+                               +---------+

+---------+       3. Authentication       +---------+
| Cliente | -----------------------------> | Servidor |
+---------+                               +---------+

+---------+       4. Encrypted Session    +---------+
| Cliente | <-----------------------------> | Servidor |
+---------+                               +---------+
```

## Instalacion de OpenSSH

```bash
yum -y install openssh openssh-server openssh-clients
apt install -y openssh openssh-server openssh-clients
```

OpenSSH incluye servicio y clientes para los protocolos SSH, SFTP y SCP.

## Archivos y rutas importantes

### Configuracion del servidor

- Directorio principal: `/etc/ssh`
- Archivo principal del servidor: `/etc/ssh/sshd_config`

Ejemplo de copia de seguridad:

```bash
cp /etc/ssh/sshd_config /root
```

### Configuracion del cliente

- Archivo global del cliente: `/etc/ssh/ssh_config`
- Configuracion por usuario: `~/.ssh/config`
- Claves conocidas por usuario: `~/.ssh/known_hosts`
- Claves autorizadas para acceso sin contraseña: `~/.ssh/authorized_keys`

El orden de precedencia habitual es:

1. Opciones en la linea de comandos.
2. Configuracion de `~/.ssh/config`.
3. Configuracion global de `/etc/ssh/ssh_config`.

Si cambia la huella del servidor, puede eliminarse la entrada antigua con:

```bash
ssh-keygen -R nombre.dominio.tld
```

## Validacion y edicion de configuracion

Validar el archivo del servidor antes de reiniciar:

```bash
sshd -t
```

Mostrar numeros de linea en `vi`:

```text
Esc
:set nu
```

Aplicar cambios:

```bash
vi /etc/ssh/sshd_config
systemctl restart sshd
systemctl status sshd
```

## Opciones importantes de `sshd_config`

### `Port`

Define el puerto en el que escucha el servidor SSH.

Ejemplo:

```conf
Port 2222
```

### `ListenAddress`

Especifica la direccion IP en la que escuchara el servicio SSH.

Ejemplo:

```conf
ListenAddress 192.168.1.10
```

### `PermitRootLogin`

Controla si el usuario `root` puede iniciar sesion por SSH.

Valores habituales:

- `yes`
- `no`
- `prohibit-password`

Ejemplo recomendado:

```conf
PermitRootLogin no
```

### `X11Forwarding`

Habilita o deshabilita el reenvio de aplicaciones graficas X11.

Ejemplo:

```conf
X11Forwarding no
```

### `AllowUsers`

Limita los usuarios autorizados a conectarse por SSH y permite restringir por IP.

Ejemplo:

```conf
AllowUsers usuario1 usuario2@192.168.1.5
```

### `DenyUsers`

Permite denegar explicitamente el acceso a determinados usuarios o combinaciones de usuario e IP.

### `UseDNS`

Controla si el servidor hace resolucion DNS inversa del cliente. Desactivarlo puede acelerar el acceso en redes lentas o con problemas de DNS.

Ejemplo:

```conf
UseDNS no
```

## Uso del comando `ssh`

Ejemplos de conexion:

```bash
ssh usuario@maquina.curso.local
ssh operador@192.168.1.5
ssh root@192.168.1.5
ssh 192.168.33.150
ssh -p 52341 juan@192.168.70.99
```

Parametro destacado:

- `-p`: especifica el puerto SSH.

Opciones comunes:

- `-i`: usa una clave privada concreta.
- `-N`: no ejecuta comandos; util para tuneles.
- `-T`: deshabilita pseudo-terminal.
- `-f`: envia la sesion al background tras autenticarse.
- `-v`: activa modo verboso.

Ejemplo con clave privada:

```bash
ssh -i ~/.ssh/RSAPair user@hostname
```

## Uso de `sftp`

SFTP permite transferir archivos a traves del canal SSH.

Ejemplos:

```bash
sftp usuario@servidor
sftp -o Port=52341 juan@192.168.70.99
```

Opciones comunes:

- `-i`: usa una clave SSH concreta.
- `-b`: ejecuta comandos desde un archivo por lotes.
- `-C`: habilita compresion.
- `-o Port=52341`: especifica un puerto distinto del 22.

## Uso de `scp`

`scp` permite copiar archivos y directorios a traves de SSH entre origen y destino local o remoto.

Ejemplos:

```bash
scp /root/algo.txt operador@192.168.70.99:/home/operador
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

Importante: el puerto debe indicarse antes de la ruta origen o destino. Este ejemplo no funcionaria:

```bash
scp algo.txt -P 52341 operador@192.168.70.99:/home/operador
```

Opciones comunes de `scp`:

- `-r`: copia recursiva de directorios.
- `-P`: puerto SSH.
- `-C`: compresion.
- `-i`: clave privada.
- `-v`: modo verboso.
- `-p`: conserva permisos, marcas de tiempo y propietario.

## Ejemplo de configuracion endurecida

Configuracion de ejemplo al final de `/etc/ssh/sshd_config`:

```conf
Port 2222
ListenAddress 192.168.1.10
PermitRootLogin no
X11Forwarding no
AllowUsers usuario1 gerente@192.168.1.25/24
UseDNS no
```

Aplicar cambios:

```bash
systemctl restart sshd
systemctl status sshd
```
