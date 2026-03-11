# lab

Documento práctico sobre lab. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

### 1.- ELIMINAR USUARIOS Y SU HOME CREADOS  en laboratorios anteriores

```bash
userdel -r usuario
```

### 2-Comando para poner en el inicio del servicio de httpd (apache), en systemd y systemV

```bash
systemctl enable httpd
chkconfig --level 35 httpd on
```

3.- PROGAMAR TAREA TANTO EN AT COMO EN CRON PARA EJECUTAR EL SCRIPT SUPERVISAMEN TODOS LOS D�AS A LAS

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

4.- COMANDO PARA COMPROBAR LA COLA DE AT Y C�MO ELIMINAR UNA TAREA PROGRAMADA TMB EN AT.

```
atq             --para el comando at
```

### atrm 1            --para eliminar la tarea 1 programada con 'at'

5.- �PARA QU� SIRVE EL DIRECTORIO /etc/skel, y que modificaciones podemos realizan en dicho directorio?

### De modo predefinido las cuentas de usuario del sistema utilizar�n como molde al directorio

```bash
        /etc/skel para crear el directorio de inicio de todos los usuarios del sistema. Regularmente,
```

### y como m�nimo, /etc/skel incluye lo siguiente:

.bash_logout .bash_profile .bashrc

6.- DADO EL DIRECTORIO /usr/local/Java/jdk-1.7/bin PARA EL USUARIO MARTES11 PONERLE LAS VARIABLES DE ENTORNO

JAVA_HOME PARA QUE UTILICE ESA VERSI�N DE JAVA, y que tenga disponibles los binarios.

```bash
vim /home/martes11/.bash_profile
```

## Tienemos que a�adir las siguientes l�neas:

```bash
        JAVA_HOME=/usr/local/java/jdk-1.7/bin
        export JAVA_HOME
```

Para que est�n disponibles los binarios de java en la consola sin tener que escribir toda la

### ruta hasta ellos habr�a que a�adirlo a la variable PATH:

```conf
            PATH=$PATH:$HOME/bin:/opt/scripts/:$JAVA_HOME
```

### 7.- AL USUARIO oracle CAMBIARLE EL JUEGO DE CARACTERES A ISO8859-1

```bash
    cat /etc/locale.conf juego caracteres x defecto redhat7
    /etc/sysconfig/i18n--> juego de caracteres x defecto en redhat6
```

```bash
vim /home/oracle/.bash_profile
export LANG=es_ES.ISO8859-1     --realizo el cambio de codificaci�n
```

[oracle@orion ~]$ locale                            --compruebo y veo el resultado del cambio.

```conf
    LANG=es_ES.ISO8859-1
    LC_CTYPE="es_ES.ISO8859-1"
    LC_NUMERIC="es_ES.ISO8859-1"
    LC_TIME="es_ES.ISO8859-1"
    LC_COLLATE="es_ES.ISO8859-1"
    LC_MONETARY="es_ES.ISO8859-1"
    LC_MESSAGES="es_ES.ISO8859-1"
    LC_PAPER="es_ES.ISO8859-1"
    LC_NAME="es_ES.ISO8859-1"
    LC_ADDRESS="es_ES.ISO8859-1"
    LC_TELEPHONE="es_ES.ISO8859-1"
    LC_MEASUREMENT="es_ES.ISO8859-1"
    LC_IDENTIFICATION="es_ES.ISO8859-1"
    LC_ALL=
```

### 8.- SINCRONIZAR HORA DEL SIST. CON LA HORA DEL HARDWARE

```bash
hwclock --hctosys
```

9.- COMO CONVIERTO UN FICHERO QUE EST� EN FORMATO WINDOWS A UNIX PARA PODER SER EJECUTADO en un linux.

### dos2unix fichero.sh

> 10.- COMO SINCRONIZO MI SERVIDOR DE FORMA MANUAL CON EL SERVIDOR NTP

```bash
ntpdate 1.es.pool.ntp.org
vi /etc/ntpd.conf
```

### server 1.es.pool.ntp.org

```bash
systemctl start ntpd
service start ntpd
```

### 11.- EXPLICAR CON EL AT COMO FUNCIONA EL PERMITIR O DENEGAR SU USO A LOS USUARIOS

El archivo /etc/at.deny se utiliza para definir una lista de usuarios a los cuales se les denegar� el

uso del mandato at. Cuando este archivo est� vac�o, implica que todos los usuarios del sistema pueden

hacer uso del mandato at.

El archivo /etc/at.allow es inexistente de modo predeterminado. Cuando �ste existe, s�lo los usuarios

listados en su interior pueden hacer uso del mandato at.

### 12.- EXPLICAR CON EL CRON COMO FUNCIONA EL PERMITIR O DENEGAR SU USO A LOS USUARIOS

13- Sincronizar la hora ente el servidor a y el servidor b a la hora actual, con el comando date.

```bash
date --set "2015-10-16 18:45"
```

### 14-Archivo de configuracion que marca el runlevel de inicio en systemV

```bash
/etc/inittab
```

15- En un servidor Redhat donde se configuran los parametros regionales.

```bash
cat /etc/locale.conf juego caracteres x defecto redhat7
    /etc/sysconfig/i18n--> juego de caracteres x defecto en redhat6
```

16-Que cadena tiene que tener un script, para que pueda ser tratado con el comando chkconfig

## chkconfig: - 98 33
