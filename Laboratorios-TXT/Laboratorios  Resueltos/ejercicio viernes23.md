# ejercicio viernes 23

Conjunto de ejercicios sobre ejercicio viernes 23, reorganizado para facilitar la práctica y la revisión.

## Desarrollo

### Como puedo sustituir con el comando tr la a por A en el archivo datos.txt

```bash
cat datos.txt | tr "a" "A" > datos2.txt
```

Con el comando cut selecionar del archivo passwd los usuarios y que shell tiene y redirigirlo /tmp/usuarios

### cut -d : -f 1,7 > /tmp/usuarios

### Con el comando sed sustituir la A por a en el archivo datos.txt

```bash
sed s/A/a datos.txt
```

### Desactivar del shell el history

### set +o history

### set -o

### Comnado para asisgnar una cuota al usuario viernes23

### edquota -u viernes23

### Comando para ver un reporte de las cuotas asignadas

### Verificamos las cuotas como root:

### quota -s -u viernes23

### repquota /usuarios

### Verificamos las cuotas como usuario:

### quota

### Comando para establecer periodo de gracia cuotas al usuario viernes23

### edquota -u viernes23 -T

### Comando para asisgnar una cuota al grupo nominas

### edquota -g nominas

### Como declaro la variable VAR1=5, para que sea global en nuestro shell

```bash
export VAR1=5
echo $VAR1
```

### Comando para dar permisos stickibit, setuid, setgid

```bash
chmod 1777 /directorio
chmod 4700 archivo
chmod g+s   root informatia /directorio
```

### oracle.informatica arch1

### root.informatica arch2

### Como veo la mascara de permisos por defecto

### umask -S

### 022

### rwx r-x r-x

### rw- r-- r--

### Cambiar de prioridad al proceso con el PID 2382 a -5

### renice -5 2382

### Como lanzo el proceso de httpd con prioridad -8

### nice -8 service httpd start

### Con el comando man que parametro me permite ver  las seciones asociadas

### y parametro para especificar la seccion

### man -f passwd

### man -s 5 passwd

### Listar con ls todos los arhivos que contengan 1 y 3

```
ls  *[1,3]
```

### Listar con ls todos los archivos de un directorio que no contengan 3

```
ls  *[!3]
```

PROGAMAR TAREA TANTO EN AT COMO EN CRON PARA EJECUTAR EL SCRIPT SUPERVISAMEN TODOS LOS D�AS A LAS

11 DE LA NOCHE.

### Para hacerlo con el comando 'at'

1�.- hay que levantar el servicio atd y hacer que se ejecute desde el inicio.

```bash
        service atd start                 --para iniciarlo ahora mismo.
        chkconfig --level 35 atd on     --para que se inicie autom�ticamente en el inicio.
```

### 2�.- Fijar la tarea con 'at'

### at 23:00

### at> ./opt/scripts/supervisamen &        --indico que quiero que se ejecute este script

### at> <EOT>                                --con Ctrl+d para finalizar

### job 5 at 2015-10-13 23:00

### Otra forma de hacer lo mismo:

### at 23:00 -f /opt/scripts/supervisamen

### Para hacerlo con el comando 'cron'

```bash
        crontab -e                         --me habre el editor vi para a�adir tareas en /etc/crontab
```

### Una de las l�neas de este archivo tiene que se como la siguiente:

```cron
        0 23 * * * root /opt/scripts/supervisamen
```

Para que el escrip se ejecute con las caracter�sticas del usuario "oracle", por ejemplo, habria

### que escribir la l�nea as�:

```cron
        0 23 * * * su -c "oracle" /opt/scripts/supervisamen
```

### Comando para visualizar las tareas programadas con at

### atq

### En el servicio ssh el archivo authorized_keys, que tarea realiza

### El comando ssh-copy-id -i que tarea realiza

### Copia la llave publica al servido de destino al archivo authorized_keys

### Comando para verificar en que target estamos con systemd

```bash
systemctl get-defaul
```

### Comando para cambiar de target con systemd a multi-user.target

```bash
systemctl set-default multi-user.target
```

### Con systemd queremos que el servicio httpd mariadb se inicien con el servidor

```bash
systemctl enable httpd mariadb
```

Con systemd queremos verificar si nuestro servicio de apache se va a iniciar con el servidor

```bash
systemctl is-enbles httpd
chkconfig --list httpd
```
