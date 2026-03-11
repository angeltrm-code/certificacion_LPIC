# Laboratorio 5 comandos systemv d

Documento práctico sobre Laboratorio 5 comandos systemv d. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Desarrollo

### Volcado de 3 interaciones del comanto top en un archivo llamado uso_sistema.txt

### top -bn 3 > uso_systema.csv

### Ordenar top por memoria

### top -o

### Lanzar el comando xterm en segundo plano y que no se cuelgue ante el cierre de sesion

### nohub xterm &

### Traer a prirmer plano el trabajo del xterm

### jobs

### fg 1

### Comando para iniciar apache en sistemd y sistemv

```bash
service httpd start
systemctl start httpd
```

### Comando para poner al inicio el servicio atd en systemv y systemd

### chhkconfig --level 5 atd on

```bash
systemctl enable atd
```

### En systemd que no se inicia el servicio httpd

```bash
systemctl disable httpd
```

### En systemd enmascarar el servicio httpd

```bash
systemctl mask httpd
```

### Cambiar de runlevel y targes grafico en redhat7

```bash
systemctl isolatle graphical.target
```

### init 5

### telinit 5

### Comando para averiguar el target por defecto

```bash
systemctl get-default
```

### runlevel

### Comando para listar las units tipo service

```bash
systemctl list-units --type service
```

### Mostrar toda la informacion de la unit httpd.service

```bash
systemctl show httpd
```
