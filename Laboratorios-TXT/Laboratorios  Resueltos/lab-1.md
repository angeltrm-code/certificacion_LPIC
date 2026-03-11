# lab 1

Documento práctico sobre lab 1. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## En linux el / es de donde parte todo el fs:

```bash
/ el raiz de linux seria el equivalente de windows  c:\
```

## Copiar los archivos con extension conf del directorio /etc/ en el directorio /datos

```bash
mkdir /datos
ls -ld /datos
cp /etc/*.conf  /datos
```

## Como para averiguar el directorio actual

```bash
pwd
```

## Eliminar el directorio /a y su contenido

```bash
mkdir /a
rm -rf /a
```

## Copiar los archivos del directorio /etc que el segundo caracter sea una h en /b

```bash
mkdir /b
cp /etc/?h* /b
```

## Ver el contenido del archivo /etc/samba/smb.conf

### less /etc/samba/smb.conf

```bash
cat
```

more

## Que tipo de archivo es /etc/shadow

file /etc/shadow

## Crear un archivo vacio llamado lunes11 en el directorio /b

```bash
touch /b/lunes11
```

## Modificar la fecha de modificacion del archivo lunes11 a 200601021030 y verificarlo

```bash
touch --help
touch -m -t 200601021030 /b/lunes11
stat /b/lunes11
```

## Con el comando ls ordenar la salida por fecha de modificacion

```bash
ls --help
ls -lrta
```

## Con el comando ls visualizar los permisos de los archivos y archivos ocultos

```bash
ls -la
```

## Buscar archivos de mas de 100Megas

```bash
find / -type f -size +100M -ls
```

## Buscar archivos menores de 100Megas

```bash
find / -type f -size -100M -ls
```

## Buscar archivos con extension avi en el directorio /videos y borrarlos en la misma orden

```bash
find /videos -type f -name "*.avi" -exec rm -ri {} \;
find /videos -type f -name "*.avi" -ok rm -f {} \;
```

## Averiguar que particiones y discos detecta nuestro servidor

```bash
cat /proc/partitions
lsblk -f
```

## Buscar archivos que este setuid

```bash
find / -type f -perm -4000
```

## Permiso de Sticky Bit al directorio /datos

```bash
chmod 1777 /datos
chmod o+t /datos
```

## Buscar archivos que tengan permisos setuid

```bash
find / -type f -perm -4000
```

## Permiso de Sticky Bit al directorio /datos

```bash
chmod o+t /datos
```

## Permisos rw- r-- --- file1

```bash
chmod 640 file1
```

## Comando mascara por defecto

### umask -S

### umask

## Permiso  Sticky Bit al directorio /datos

## si no tengo el directorio lo creo:

```bash
ls -ld /datos
mkdir /datos
chmod o+t /datos
ls -ld /datos
```

## Buscar directorios con permiso permiso Sticky Bit

```bash
find / -type d -perm -1000
```

## Diferencias entre insmod rmmod y modprobe

```bash
insmod: Inserta un módulo en el kernel, pero no maneja dependencias.
```

```bash
rmmod: Elimina un módulo del kernel, pero no verifica dependencias.
```

```bash
modprobe: Carga o descarga módulos del kernel, gestionando automáticamente las dependencias.
```

Para la mayoría de los casos, modprobe es el comando recomendado debido a su capacidad para gestionar automáticamente las dependencias entre módulos del kernel.
