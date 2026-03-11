# Lab trabajando con sudo

Documento práctico sobre Lab trabajando con sudo. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Desarrollo

### BASADO EN SYSTEM V CUAL ES EL COMANDO PARA IMPRIMIR UN ARCHIVO

### lp /ruta/fichero

### 2.- CON EL COMANDO lpstat C�MO VEO UNA IMPRESORA QUE TENGO POR DEFECTO

### lpstat -d

### 3.- CON EL COMANDO lpr COMO IMPRIMO UN ARCHIVO

### 4.- CON EL COMANDO lpq COMO VEO EL ESTADO DE LOS TRABAJOS EN UNA IMPRESORA

### lpr -P /ruta/fichero

5.- COMO VEO LAS COLAS DE CORREO ELECTR�NICO, �CON QU� COMANDO?

### mailq

### 7.- PARA QUE SIRVE LA VARIABLE LD_LIBRARY_PATH

Para especifacar donde se encuentran las librerias de ciertos programas que instalamos.

8.- DADOS ESTOS ARCHIVOS: ARCHIVO1 ARCHIVO2 ARCHIVO3 ARCHIVO4 EN UN DIRECTORIO, LISTAR LOS ARCHIVOS

DEL 1 AL 3 Y CON OTRO COMANDO LOS ARCHIVOS1 Y ARCHIVO4, TAMB MOSTRAR TODOS LOS FICHEROS QUE NO

### CONTENGAN EL '3'

```bash
ls archivo[1-3]
    ls archivo[1,4]
    ls *[!^3]             --archivos que terminen en 3
    ls *[!3]
```

-----------Practica sudo:----------------

### PRIMERO CREAR 1 USUARIO NO ADMINISTRADOR LLAMADO 'VIERNES14'

EDITAMOS EL ARCHIVO /etc/sudoers, QUE SE PUEDE EDITAR DIRECTAMENTE CON EL COMANDO 'VISUDO'.

A�ADIMOS LA SIGUIENTE L�NEA AL FICHERO PARA OTROGAR PERMISOS DE EJECUCI�N DE LOS SIGUIENTES COMANDOS:

- REINICIAR EL SERVICIO DE APACHE (httpd)
- EDITAR EL FICHERO httpd.conf
- EDITAR EL FICHERO php.ini

Cmnd_Alias MANDATOS4 = /sbin/service httpd reload, /usr/bin/vim /etc/httpd/conf/httpd.conf,

```bash
    /usr/bin/vim /etc/php.ini
```

### ESTA OTRA L�NEA INDICAMOS A QU� USUARIO LO APLICAMOS:

- USUARIO 'VIERNES14'
- "ALL" DESDE CUALQUIER SITIO
- "MANDATOS4" INDICA QUE PUEDE EJECUTAR LAS ORDENES QUE EST�N BAJO ESE ALIAS  Y LOS SIGUIENTES

### COMANDOS QUE SE LISTAN A CONTINUACI�N

- LAS ORDENES QUE EST�N PRECEDIDAS POR '!' INDICAN LAS QUE **NO** PODR�N EJECUTAR.

viernes14 ALL = NOPASSWD: MANDATOS4, /usr/sbin/useradd, /usr/bin/passwd *, !/usr/bin/passwd root

LUEGO CAMBIAMOS O INICAMOS A UNA SESI�N DEL USUARIO 'viernes14' PARA COMPROBAR QUE PODEMOS USAR LAS

ORDENES PERMITIDAS Y QUE NOS DENIEGA LAS QUE HEMOS PROHIBIDO EXPRESAMENTE.

NOTA: EL USUARIO TIENE QUE PONER LA RUTA A LAS ORDENES QUE SE LE HA PERMITIDO EJECUTAR, YA QUE NO

TIENE ACCESO POR DEFECTO AL DIR /sbin Y ES MALA IDEA A�ADIRLA A SU 'PATH'. EN ESE DIRECTORIO EST�N

LAS ORDENES O COMANDOS QUE SOLO EL ROOT PUEDE EJECUTAR.

### Forzar el el siguiente reinicio que el fsck se pase automaticamente

```bash
touch /forcefsck
```

### Poner el top en modo bach

### top -bn 100 > /tmp/salidamandatotop.txt
