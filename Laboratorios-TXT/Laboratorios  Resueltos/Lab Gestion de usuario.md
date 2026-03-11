# Lab Gestion de usuario

Documento práctico sobre Lab Gestion de usuario. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Desarrollo

### Crear el usuario1 y que su grupo primario sea informatica

### addgroup informatica

### addgroup micro

### adduser -g informatica ususario1

```bash
passwd usuario1
```

### Crear el usuario2 que no tenga shell y su grupo secuandario sea micro

### adduser -G micro -s /sbin/nologuin usuario2

```bash
passwd usuario2
```

### Crear el usuario3 que le expire la cuenta el miercoles 27

### adduser -e 20160127 usuario3

```bash
passwd usuario3
```

### Crear el usuario4 que su grupo primario sea informatica y su grupo secundario micro

### adduser -g informatica -G micro usuario4

```bash
passwd usuario4
```

### Crear el usuario5 que tenga los siguientes alias:

### que con rm borre y no le pida confirmacion

que con ls le muestre los archivos ocultos y permisos largos y ordene por fecha de modificacion mas reciente

### adduser usuario5

```bash
passwd usuario5
vi /home/usuario5/.bashrc
alias rm='rm -rf'
alias ls='ls -lrta'
```

### Modificar el usuario2 para que tenga shell y pertenece al grupo secundario informatica

```bash
usermod -s /bin/bash -G informatica usuario2
```

chage -d 0 usuario  Con este comando forzamos el cambio de contrase�a cuando el usuario inicia sesio, el pass es complejo

Crear el usuario usuario6 y forzar el cambio de contrase�a en el 1 inicio de sesion del usuario

### adduser usuario6

```bash
passwd usuario6
```

chage -d 0 usuario6
