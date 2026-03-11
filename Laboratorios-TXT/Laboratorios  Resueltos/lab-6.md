# lab 6

Documento práctico sobre lab 6. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Desarrollo

### Comando para ver la informacion del modulo vfat

```bash
modinfo vfat
```

### Listar los modolulos que tengo en memoria del kernel

```bash
lsmod
```

### Direfrencia entre el comando modprobre y insmod

insmod no gestiona dependencias a la hora de cargar los modulos

### Cagar el modulo vfat y sus dependencias

```
modprobe    vfat
```

### ver los procesos del usuario apache y oracle

### ps -u oracle,apache

### Cambiar la prioridad del proceso 1234 a -5

### renice -5 1234

### Lanzar el comando xterm en segundo plano y que no se cuelgue ante el cierre de sesion

### nohup xterm &

### Que hace el comando fc -->

### Trabaja con el historial fc -l y fc -s numeros del trabajo

### Instalar el archivo mc.rpm

```bash
rpm -i mc.rpm
dpkg -i mc.deb
```

### Eliminar el archivo mc

```bash
rpm -e mc
dpkg -r mc
```

### Que paquete rpm ha instalado el archivo

```bash
rpm -ql
dpkg -l
```

### Que paquetes php tengo instalados en el sistema

```bash
rpm -qa php
dpkg -l php
```

### Informacion sobre el paquete php

```bash
rpm -qi php
dpkg -i php
```

Forzar a instalar el paquete joomla.rpm sin sus dependencias.

```bash
rpm -i --nodeps joomla.rpm
```

### Cambiar el juego de caracteres al usuario operador a iso885915

### locale

```bash
vi /home/operador/.bash_profile
LANG=es_ES.iso88591
LC_CTYPE="es_ES.iso88591"
export LANG LC_CTYPE
```

### Que hace el comando iconv

### Modificar al usuario operador que no tenga shell

```bash
usermod -s /sbin/nologin operador
```
