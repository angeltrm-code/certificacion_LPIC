# lab 3 comandos

Documento práctico sobre lab 3 comandos. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Arquitectura del Sistema operativo

```bash
arch
```

## Buscar archivos con extension mp3 en todo /

```bash
find / -type f -name *.mp3
```

## Buscar archivos en el directorio /var con un tamaño superior a 100M

```bash
find /var -type f -size +100M -ls
```

## Buscar archivo el el directorio / con un tama�o menor de 1M

```bash
find / -type f  -size -1M
```

## Cuantas linea tiene el archivo passwd

### wc -l /etc/passwd

```bash
cat -n /etc/passwd
```

nl /etc/passwd

## Cuantos lineas palabras y caracteres tiene el archivo shadow

wc /etc/shadow

## Buscar archivos modificados de hace menos de 5 minutos

```bash
find / -type f -mmin -5
```

Buscar archivos en el directorio /musica con extension mp3 y que se eliminen de forma automatica, pidiendo confirmacion

```bash
find /musica -type f -name "*.mp3" -ok rm -rf {} \;
find /musica -type f -name "*.mp3" -exec rm -rf {} \;
```

```bash
find /datos2 -type f -name "archivo*" -exec cp {} /miercoles7  \;
```

## Que hace el comado fc

El comando fc en Linux y sistemas similares a Unix es una utilidad del shell que permite manipular el historial de comandos, ya que el shell almacena los comandos que se han ejecutado para que se puedan reutilizar o editar mas tarde.

### fc -l

## Como repito el comando del historial 99

### fc -s 99

!99

## Cuanto ocupa el archivo smb.conf

```bash
find / -name smb.conf
du -h /etc/samba/smb.conf
ls -lh /etc/samba/smb.conf
```

```bash
ls -lh
```

## Lista archivos con tamaño logico (contenido)

```bash
du -h
```

## Muestra uso real de disco (bloques usados)

## Cuanto ocupa el directorio /etc

```bash
du -hs /etc
```

## Cuanto espacio tengo libre en el /

```bash
df -hT /
```

## Version de mi sistema operativo

```bash
cat /etc/redhat-release
cat /etc/debian_version
cat /etc/*release
```

## Buscar archivos con permisos de setuid

```bash
find / -type f -perm -4000
```

## Buscar directorios con permisos de setgid

```bash
find / -type d -perm -2000
```

## Permiso de Sticky Bit al directorio /nominas

```bash
chmod 1777 /nominas
chmod o+t /nominas
```

## Buscar directorios con permiso setguid en el sistema

```bash
find / -type d -perm -2000
```

## Averiguar mascara por defecto

umask -S

## Comando ps para ver los procesos del usuario apache y el usuario operador

ps -u apache,operador

## Comando ps en formato BSD

ps -aux

## Que libreria tengo vinculada al comando smbpasswd

```
ldd   /usr/bin/smbpasswd
```

## Permiso de Sticky Bit al directorio /nominas

```bash
chmod 1777 /nominas
chmod o+t /nominas
```

## Buscar directorios con permiso setguid en el sistema

```bash
find / -type d -perm -2000
```

## Averiguar mascara por defecto

### umask -S

### umask

## Que hace la variable de entorno LD_LIBRARY_PATH

es una variable de entorno en sistemas Unix y Linux que especifica una lista de directorios donde el sistema debe buscar bibliotecas compartidas (shared libraries) antes de las rutas estandar del sistema cuando se ejecutan programas. Esta variable es muy util cuando tienes bibliotecas que no estan en las ubicaciones estandar o cuando quieres utilizar versiones personalizadas de las mismas sin alterar las del sistema.

## instalar webmin con rpm como dpkg

```bash
rpm -ivh
dpkg -i
```

## Eliminar un paquete con rpm y dpkg

```bash
rpm -e
dpkg -r -P
```

## Listar si tengo instalado php con rpm y dpkg

```bash
rpm -qa php
dpkg -l php
```

## Listar los ficheros que instala php con rmp y dpkg

```bash
rpm -ql php
dpkg -L php
```

## Ver los procesos del usuario apache y root

ps -u apache,root

## arrancar el service httpd en ssistemv y sistemd

```bash
service httpd start
systemctl start httpd
```

## Poner al inicio el service httpd en systemv y systemd

```bash
chkconfig --level 3 httpd on
systemctl enable httpd
systemctl is-enabled httpd
```

## cambiar de runlevel en systemv al runlevel 3 y lo mismo para systemd

### telinit 3

### init 3

```bash
systemctl isolote multi-user.target
```

Comando para averiguar que unit de tipo service se han modificado o extendido en nuestro systemd

### systemd-delta

```
Tipo    Significado
OVERRIDDEN    La unidad fue completamente reemplazada (hay otro archivo con el mismo nombre en /etc/systemd/system).
EXTENDED    Hay un drop-in file (un archivo adicional, generalmente en un directorio .d/, que añade o cambia parametros).
MASKED    La unidad ha sido deshabilitada redirigiendola a /dev/null.
EQUIVALENT    No hay diferencias (opcional al usar --type=equivalent).
REDIRECTED    La unidad fue movida o redirigida.
```
