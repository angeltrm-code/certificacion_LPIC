# TCP Wrappers+GPG

Documento de referencia sobre TCP Wrappers+GPG con formato Markdown homogéneo y navegación más clara.

```bash
yum install nmap-frontend -y
```

### Descargar Instalar xming

Lanzo en comando xlaunch y seleciono no access control: ## Desde mi linux export la variable display contra mi servidor de windows que es donde esta ahora el servidor X del xming

```bash
export DISPLAY=192.168.1.2:0.0
```

zenmap

---

> Resumen manual de LPIC-1 pagina 484 Los archivos de configuración son /etc/hosts.allow y /etc/hosts.deny

```
[root@sercentos7 ~]# strings -f /usr/sbin/sshd | grep hosts_access
/usr/sbin/sshd: hosts_access
```

Si no se devuelve ninguna línea, el programa no utiliza las tcp_wrappers. Entre los servicios que utilizan las tcp_wrappers, encontramos:

- sendmail (incluyendo postfix);
- sshd (ssh);
- xinetd (y por lo tanto de manera indirecta todos los servicios asociados);
- vsftpd (ftp);
- portmap (y por lo tanto nis, nfs);
- in.telnetd (telnet), así como la mayoría de los servicios soportados por xinetd;

### La comprobación de acceso a un servicio embebido TCP se hace en tres etapas:

- ¿se autoriza el acceso de manera explícita?
- si no es el caso, ¿se prohíbe el acceso de manera explícita?
- si no es el caso, por defecto, se autoriza el acceso.

Para verificar una regla, el sistema lee primero /etc/hosts.allow, luego /etc/hosts.deny. La búsqueda se detiene en la primera correspondencia encontrada. Una línea en hosts.allow autoriza la conexión. Una línea en hosts.deny prohíbe la conexión. Si no se deniega de manera explícita el acceso, se autoriza: la petición no corresponde a ningún criterio.

Los archivos de configuración son /etc/hosts.allow y /etc/hosts.deny. La sintaxis es común:

### En el ejemplo siguiente:

- Sólo los miembros de la subred 192.168.1.0 tienen permiso para conectarse al servidor ftp (prohibido para todos los demás).
- Los anfitriones puesto1 y puesto2 tienen acceso a telnet y portmap.
- Los anfitriones de baddominio.org, excepto trusted, no tienen conexión alguna posible.
- Se prohíbe el servicio pop/imap a todos los de la red 192.168.0.0, salvo 192.168.1.5.

```bash
 /etc/hosts.allow
```

vsftpd: 192.168.1. in.telnetd, portmap: puesto1, puesto2 ALL:/opt/script/supervisamen servicio: lista_de_hosts [:shell_command]

## # /etc/hosts.deny

ALL: .baddominio.org except trusted.baddominio.org UNKNOWN vsftpd,in.telnetd,portmap: ALL dovecot : 192.168.0. EXCEPT 192.168.0.5

---

> GPG##  PAG 493 Manual del Curso LPIC1 GPG (Gnu Privacy Guard) es un clon libre de PGP (Pretty Good Privacy). Implementa el algoritmo de cifrado RSA. PGP es objeto de una norma que GPG respeta. Esto significa que las dos implementaciones son compatibles: las claves generadas por uno u otro se pueden intercambiar. El objetivo de GPG es cifrar una comunicación gracias a un cifrado por claves asimétricas. Una clave permite firmar el texto, otra clave sirve para encriptar el texto.

## Install GPG To Ubuntu, Debian:

```bash
sudo apt install gnupg
```

```bash
Install GPG To CentOS, Fedora, RHEL:
```

```bash
yum install gnupg
```

## Crear claves públicas y privadas

Ahora comenzaremos con la creación de claves públicas y privadas. # Como sabemos, la criptografía pública proporciona dos claves donde la clave privada es una clave secreta que debe protegerse # en consecuencia. La clave pública, como su nombre indica, está abierta a todas las personas con las que queremos colaborar. # Entonces necesitamos estas llaves. # Podemos crearlos con la --gen-key opción que se muestra a continuación.

### Este comando nos hará algunas preguntas como las siguientes

Dirección de e-mail:usuario@correo.com Nombre real: Alberto

gpg --gen-key

## Lista de claves GPG

gpg --fingerprint usuario

## Gestionar el almacén de claves

### gpg --list-key

## Puede exportar su clave pública hacia un servidor de claves GPG, por defecto keys.gnupg.net. Así, una persona que desea obtener su clave pública, para firmarla por ejemplo como veremos más adelante,

## podrá recuperarla en el servidor correspondiente

### gpg --fingerprint alberto

```
pub   2048R/8B60153B
```

gpg --send-keys 2048R/8B60153B

## Si luego se dirige al servirdor http://keys.gnupg.net/

y teclea (por ejemplo, el e-mail o el identificador de clave funcionan también), obtendrá la lista de las claves correspondientes y, entre ellas, la anterior.

## Importar una clave

Puede importar una clave en su almacén con el parámetro --import. El segundo parámetro puede ser un archivo que contiene la clave. Si no lo tiene, efectúe un copiar-pegar de la clave en la consola, con la última línea que debe ser -----END PGP PUBLIC KEY BLOCK-----; luego teclee [Ctrl] D.

## También puede recibir una clave de un servidor:

gpg --recv-keys 8B60153B

## Puede suprimir una clave del almacén de la manera siguiente:

### gpg --delete-keys 8B60153B

## Encrypt A File with GPG, vamos a encriptar el archivo de texto /root/archivo-cifrador en el archivo cifrado archivo-cifrador.enc # Usaremos nuestra clave privada para cifrar datos dados como un archivo de texto. # Usaremos --encrypt con la --receipent que configuraremos la clave privada y la última el archivo que queremos cifrar. # También podemos usar la --output opción para especificar el nombre del archivo encriptado.

gpg --encrypt --recipient 'Alberto' --output /root/archivo-cifrador.enc /root/archivo-cifrador

## Descifrar un archivo con GPG

Ahora, si recibimos un archivo que está encriptado por nuestras claves públicas, necesitamos descifrarlo con nuestra clave privada. Usaremos --decrypt option. También podemos especificar opcionalmente el archivo de salida con una --output opción como la siguiente.

gpg --output archivo-descifrado.txt --decrypt /root/archivo-cifrador.enc

## Lista de claves GPG instaladas:

gpg --list-keys

## Eliminar clave GPG:

gpg --delete-key Alberto

## Eliminar clave con claves secretas

## Al eliminar claves si hay un secreto relacionado, también deberíamos proporcionar la --delete-secret-keys opción. Si no, obtendremos un error como el siguiente.

gpg: ¡hay una clave secreta para la clave pública "Alberto"! $ gpg  --delete-secret-keys 'usuario@correo.com'
