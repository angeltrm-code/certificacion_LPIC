# Laboratorio Compresión y descompresión de archivos

Documento práctico sobre Laboratorio Compresión y descompresión de archivos. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Instalamos el siguiente software en la mv:

```bash
dnf -y install tar zip unzip gzip bzip2 xz
apt -y install tar zip unzip gzip bzip2 xz-utils
```

## En resumen

gzip → rápido, menos compresión. Ideal para uso general y logs.

bzip2 → compresión mejor, pero más lento.

xz → compresión máxima, pero el más lento de todos. Ideal para almacenamiento o distribución.

## Creación y extracción de archivos *.tar.

### c -->empaqueta

### f--> file1

### t-->lista dentro del tar

### x --> Extraer

-C --> directorio en el que queremos extraer

-k, --keep-old-files

Don't replace existing files when extracting.

-v, --verbose              verbosely list files processed

```bash
tar -k opción tar -k solicita una confirmación si el file ya existe.
```

### Puede establecerlo de forma pnetworkingeterminada,

ya sea agregándolo a la variable TAR_OPTIONS ( TAR_OPTIONS="$TAR_OPTIONS -k" ) o creando un alias ( alias tar="tar -k" ).

## Comenzamos el laboratorio:

```bash
mkdir /viernes22
cp /etc/*.conf /viernes22
```

```bash
cd /root
```

## tar.gz

### z

```bash
tar cvfz viernes22.tar.gz /viernes22
ls -lrta
```

viernes22.tar.gz

## Visualizamos el contenido

```bash
tar tvfz viernes22.tar.gz
```

## Extraemos el contenido:

```bash
tar xvfz  viernes22.tar.gz  -C /opt
```

```bash
ls -l /opt/viernes22
```

## tar.bz2

### j

```bash
tar cvfj viernes22.tar.bz2 /viernes22
ls -lrta
```

viernes22.tar.bz2

## Visualizamos el contenido

```bash
tar tvfj viernes22.tar.bz2
```

## Extraemos el contenido:

```bash
tar xvfj  viernes22.tar.bz2  -C /opt
```

```bash
ls -l /opt/viernes22
```

## tar.xz

### J

```bash
tar cvfJ viernes22.tar.xz /viernes22
ls -lrta
```

viernes22.tar.xz

## Visualizamos el contenido

```bash
tar tvfJ viernes22.tar.xz
```

## Extraemos el contenido:

```bash
tar xvfJ  viernes22.tar.xz  -C /opt
```

```bash
ls -l /opt/viernes22
```
