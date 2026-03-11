# Todos los Ejercicios LPIC 1

Documento de referencia sobre Todos los Ejercicios LPIC 1 con formato Markdown homogéneo y navegación más clara.

```bash
/***************************************************************************
```

### *

- EJERCICIOS DEL CURSO LPIC-1

* ***************************************************************************/

### --- EJERCICIO 27/10/2014 ---

### 1. COPIAR DEL DIR ETC EL ARCHIVO PASSWD EN EL DIR DATOS

```bash
    mkdir datos/uno; cp /etc/passwd datos/
```

### 2. COPIAR DEL DIR ETC EL ARCHIVO SHADOW EN EL DIR /DATOS/UNO

```bash
    cp /etc/shadow datos/uno/
```

### 3. ARQUITECTURA DEL SO

```bash
    arch
```

### 4. COMANDO PARA MOSTRAR ARCHIVOS OCULTOS Y NÚMERO INNODO DE CADA UNO DE ELLOS

```bash
    ls -ai
```

### 5. COMANDO LS ORDENADOS POR RECIENTE CREACIÓN A CREACIÓN MÁS ANTIGUA

```bash
    ls -tl
```

### para más antiguos a más modernos (lo más moderno en la parte baja de la pantalla:

```bash
    ls -tlr
```

### 6. PERMISOS DEL DIR DATOS, DUEÑO

```bash
    ls -ld datos/
```

### 7. ELIMINAR DIR 'UNO' Y TODO SU CONTENIDO

```bash
    rm -fr datos/uno
```

### --- FIN EJERCICIOS ---

### --- EJECICIOS  28/11/2014 ---

1. COMANDO ARQUITECTURA DEL SISTEM OP.

```bash
    uname -p                     ----> i686
    arch                         ----> i686
```

### 2. VERSION DE LINUX INSTALADA

```bash
    cat /etc/redhat-release     ----> CentOS release 5 (Final)
```

3. USUARIOS CONECTADOS AL SIST.

```
    w                             ---->
```

```
                                        13:49:36 up  2:37,  2 users,  load average: 0,00, 0,00, 0,00
                                        USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
                                        root     pts/3    :0.0             11:22    2:27m  0.01s  0.01s bash
                                        root     pts/1    192.168.50.106   11:42    0.00s  0.16s  0.00s w
```

### 4. CUANTO OCUPA EL /ETC

```bash
    du -hs                        ----> 111M    /etc
```

### 5. CUANTO LOS FICHEROS /etc/passwd Y /etc/shadow

```bash
    du -hs /etc/passwd             ----> 4,0K    /etc/passwd
    du -hs /etc/shadow            ----> 4,0K    /etc/shadow
```

### 6. CUANTO ESPACIO LIBRE EN LA PARTICIÓN RAIZ

```bash
    cat /proc/meminfo | grep -i MemFree        ----> MemFree:        359956 kB
    ////! NO VÁLIDO PORQUE MUESTRA LA MEMORIA RAM LIBRE, NO LA DEL DISCO.
```

```
    df -h /                        ---->
                                        S.ficheros          TamaÃ±o Usado  Disp Uso% Montado en
                                        /dev/mapper/VolGroup00-LogVol00
                                                               18G  5,3G   12G  33% /
                                        /dev/sda1              99M   11M   83M  12% /boot
                                        tmpfs                 506M     0  506M   0% /dev/shm
```

### 7. CUANTAS CPUs TENGO

```
    cat /proc/cpuinfo             ---->
                                        processor       : 0
                                        vendor_id       : GenuineIntel
```

### cpu family      : 6

```
                                        model           : 26
```

### model name      : Intel(R) Core(TM) i7 CPU         950  @ 3.07GHz

```
                                        stepping        : 5
```

cpu MHz         : 3066.445 cache size      : 8192 KB

```
                                        fdiv_bug        : no
                                        hlt_bug         : no
                                        f00f_bug        : no
                                        coma_bug        : no
                                        fpu             : yes
                                        fpu_exception   : yes
```

### cpuid level     : 11

```
                                        wp              : yes
                                        flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss nx constant_tsc up pni
                                        bogomips        : 6133.83
```

### 8. VERSIÓN DE Kernel

```bash
    uname -r            ----> 2.6.18-8.el5
```

### 9. CUANTO TIEMPO LLEVA ENCENDIDO EL SERVIDOR

```
    uptime                     ----> 14:05:50 up  2:53,  2 users,  load average: 0.04, 0.02, 0.00
```

### 10. MODELO DE DISCO DURO

```bash
    dmesg | grep -i sda     ---->
```

SCSI device sda: 41943040 512-byte hdwr sectors (21475 MB) sda: Write Protect is off sda: Mode Sense: 61 00 00 00 sda: cache data unavailable sda: assuming drive cache: write through SCSI device sda: 41943040 512-byte hdwr sectors (21475 MB) sda: Write Protect is off sda: Mode Sense: 61 00 00 00 sda: cache data unavailable sda: assuming drive cache: write through sda: sda1 sda2 sd 0:0:0:0: Attached scsi disk sda EXT3 FS on sda1, internal journal

### 11. MODELO DE TARJETA DE RED

```bash
    dmesg | grep -i eth0    ---->
```

eth0: registered as PCnet/PCI II 79C970A eth0: link up eth0: link up eth0: no IPv6 routers present eth0: link up eth0: no IPv6 routers present

### 12. QUIERO CONFIGURAR LO SIGUIENTE:

```bash
IP 192.168.1.100
```

PUERTA ENLACE 192.100.1.1 DNS 192.168.1.1 DOMINIO miempresa.com

```bash
HOSTNAME trasgu
```

### Para ajustar la IP, Puerta de enlace y máscara:

```bash
    vim /etc/sysconfig/network-scripts/ifcfg-eth0
```

### Después toca reiniciar el servicio:

```bash
    service network restart
```

### Para el nombre del servidor:

```bash
    vim /etc/resolv.conf
```

### Para el nomrbe del Host:

```
    vim /etc/host
            192.168.1.100    trasgu.miempresa.com  trasgu
```

### ---- FIN EJERCICIOS ----

### --- EJERCICIOS 29/11/2014 ---

> Vamos a simular una incidencia. Eliminar el GRUB con lo que no va a arrancar el sistema. Después entraremos en el modo rescate para restaurarlo. Ver el PDF "Laboratorio Copia de seguridad y restauración GRUB.pdf"

### --- FIN EJERCICIO ---

```
---  EJERCICIOS 30/10/2014 ---
```

### 1. COMANDO RPM PARA DESINSTALAR UN PAQUETES

```bash
    rpm -e paquete.rpm
```

### 2. RPM. PARA VER INFO DE UN PAQUETES

```bash
    rpm -qi paquete
```

3. RPM. ELIMINAR UN PAQUETE.

```bash
    rpm -e paquete.rpm
```

### 4. INSTALAR UN PAQUETE RPM ELIMNANDO DEPENDENCIAS

```bash
    rpm -i --nodeps paquete.rpm
```

5. ELIMINAR UN PAQUETE CON YUM.

```bash
    yum remove paquete
```

6. ¿COMO EXCLUYO PAQUETES RPM CON YUM? Editando /etc/yum.conf y en la variable 'exclude' listar los paquetes que quiero excluir.

Una de las cosas que se suelen excluir en las empresas, y según sus políticas, es el Kernel. Sobretodo si se trata de Kernels compilados para drivers especificos.

### 7. INSTALR UN PAQUETE CON DPKG

```bash
    dpkg -i paquete.deb
```

### 8. ELIMINAR PAQUETE CON DPKG

```bash
    dpkg -r paquete
```

### 9. ELIMINAR CON TODAS SUS DEPENCIAS CON DPKG

```bash
    dpkg --purge paquete
```

### 10. BUSCAR PAQUETES INSTALADOS EN EL SIST. CON DPKG

```bash
    dpkg -l *.deb
```

### --- FIN EJERCICIOS ---

### --- EJERCICIOS 31/10/2014 ---

### TODOS LOS EJERCIOS HAY QUE PROBARLOS EN CONSOLA AL MENOS 1 VEZ

### 1. IMAGINAR EL ARBOL:

### NUMEROS/UNO/DOS

QUIERO QUE LOS DIR. TNGAN LOS SIGUIENTES PERMISOS Y DEBEN PERTENECER AL USUARIO 'ROOT' Y AL GRUPO 'INFORMATICA':

```
NUMEROS/     -->  RW- R-- ---
UNO/        -->  RW- --- ---    + PERMISOS DE SETGID
DOS/        -->  R-- R-- R--    + PERMISOS DE STIK BIT
```

### EN NUMEROS/ CREAR ARCHIVO CON NOMBRE PERSONAL CON PERSMISOS SETUID

### Para crear los directorios:

```bash
        mkdir -p /numeros/uno/dos
```

### Para cambiar los permisos:

```bash
        chmod 640 /numeros; chmod 600 /numeros/uno; chmod 444 /numeros/uno/dos;
```

Resultado: drwxr----- 3 root root 4096 oct 31 11:57 /numeros/ drw------- 3 root root 4096 oct 31 11:57 /numeros/uno/ dr--r--r-- 2 root root 4096 oct 31 11:57 /numeros/uno/dos

### Creación del grupo de 'informatica':

```bash
        groupadd informatica
```

Cambiar de grupo los directorios: chgrp -R informatica /numeros/

Resultado: drwxr----- 3 root informatica 4096 oct 31 11:57 /numeros/ drw------- 3 root informatica 4096 oct 31 11:57 /numeros/uno/ dr--r--r-- 2 root informatica 4096 oct 31 11:57 /numeros/uno/dos

### Añadir permiso SETGID al directorio /NUMEROS/UNO/:

```bash
        chmod g+s /numeros/uno/
```

Resultado: drw---S--- 3 root informatica 4096 oct 31 11:57 /numeros/uno/

### Añadir permiso de STICKY BIT al directorio /numeros/uno/dos/

```bash
        chmod 1777 /numeros/uno/dos
```

### Creamos archivo con nuestro nombre y añadimos permiso de Setuid:

```bash
        touch /numeros/jonathan
        chmod 4700 /nombre/jonathan
```

### 2. COMANDO PARA INSTALAR RPM

```bash
    rpm -i paquete.rpm
```

### 3. COMANDO PARA DESINSTALAR RPM

### 4. VER LA INFO DEL RPM

```bash
    rpm -qi paquete.rpm
```

5. VER QUÉ INSTALA EL PAQUETE Y DÓNDE.

```bash
    rpm -ql paquete.rpm
```

### --- FIN DE EJERCIOS ---

### --- EJERCICIO GESTIÓN DE LIBRERIAS 31/10/2014 ---

> EN MATERIAL EN EL MÓDULO 3 - GESTIÓN DE FICHEROS -> EJERCICIOS LIBRERIAS TENEMOS UN PDF CON EL EJERCICIO.

### --- FIN EJERCICIOS ---

### --- EJERCICIOS 3/11/2014 ---

1. SETEAR LA FECHA Y HORA DEL SISTEMA A LA ACTUAL.

```bash
    date --set "2015-10-5 12:54"
```

2. ¿EN QUÉ CONSOLA ESTAMOS ACTUALMENTE? Comando 'w' Resultado:

```
         12:54:28 up  1:02,  1 user,  load average: 0,12, 0,05, 0,01
        USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
        root     pts/1    192.168.50.106   03Nov14  0.00s  0.06s  0.00s w
```

### En TTY indica que estamos en la consola pts/1

3. DESACTIVAR MENSAJES DE CONSOLA mesg n

4. ¿PARA QUÉ SIRVE EL COMANDO BC? Es una calculadora avanzada desde la línea de comandos.

### 5. CON EL COMANDO UNAME MOSTRAR EL NOMBRE DEL HOSTNAME CON EL COMANDO UNAME

```bash
    uname -n
```

### Otra opcción: hostname

6. MOSTRAR ULITMOS 10 MENSAJES DEL HISTORIAL fc -l -10

7. REPETIR ULTIMO MENSAJE DEL HISTORIAL CON EL COMANDO FC fc -n 1057 Otra opción es ejecutar: !!

8. MOSTRAR DEL FICHERO PASSWD LA FECHA DE MODIFICACIÓN Primero saber dónde esta:

```bash
    find / -type f -name "\passwd"
```

### Luego ver la información que se solicita:

```bash
    stat /etc/passwd | grep "Modify"
```

9. MOSTRAR LAS 20 PRIMERAS LINEAS DEL FICHERO MESSAGES CON EL COMANDO HEAD head -n 20 /var/log/messages

### 10. BUSCAR EN EL SISTEMA FICHEROS CON PERMISOS DE STICKY BIT

```bash
    find / -type d -perm -1000
```

### 11. BUSCAR EN EL SIST. FICHEROS DE CREACIÓN O MODIFICACIÓN CON MENOS DE 5 MINUTOS

```bash
    find / -mmin -5
```

### 12. BUSCAR EN EL SIST. FICHEROS CON LA EXTENSIÓN .AVI Y ELIMINARLOS EN LA MISMA ORDEN

```bash
    find / -type f -name "*.avi" -exec rm -rf{}\;
```

### 13. VISUALIZAR EL ARCHIVO MESSAGES EMPEZANDO POR EL FINAL

```bash
    tac /var/log/messages
```

14. MASCARA DE CREACIÓN POR DEFECTO QUE TENEMOS EN EL SISTEMA. umask -S

Por defecto a los archivos no se les aplica el permiso de ejecución. A los directorios sí.

### --- FIN EJERCICIOS ---

### --- EJERCICIOS 3/11/2014 ---

> REALIZAR EL LABORATORIO DESCRITO EN EL PDF: "Laboratorio creacion de un nivel de ejecucion personalizado con aplicaciones especificas.pdf"

Toca crear el directorio 'scripts' bajo el directorio /opt Copiamos en él el escript 'supervisamen' y le damos permisos de ejecución y ejecutamos:

```bash
    ./supervisamen &
```

El '&' para que se ejecute en 2º plano. con el comando: tail -f /var/log/supervisamen.log vemos en caliente los logs de supervisamen y vemos si funcionan.

Para que esto se ejecute en los inicios.

Hay que copiar en /etc/init.d el script 'iniciar-supervisamen' y le damos permisos de ejecución.

Varias formas para iniciarlo en el momento: 1. /etc/init.d/iniciar-supervisamen start 2. service iniciar-supervisamen start

> Para ponerlo en marcha al inicio de sesión. ## Forma manual En /etc/rc5.d (donde iniciamos nosotros por defecto) crariamos él un archivo S99iniciar-supervisamen en el que habría la siguiente línea:

```bash
        /etc/init.d/iniciar-supervisamen on
```

## Forma autmatizada

### Ejecutar la instrucción:

```bash
        chkconfig --level 35 iniciar-supervisamen on
```

Esto funcionará siempre y cuando en el archivo iniciar-supervisamen estén las siguientes líneas en la cabecera:

## # chkconfig: - 98 15

description: Descripcion molona de mi servicio.

## # processname: nombreservicio

La primera línea indica el orden de inicio del servicio. La segunda es una pequeña descripción del servicio que uno puede elegir poner. La tercera es el nombre que le damos.

### --- FIN EJERCICIO ---

### --- EJERCICIO 04/11/2014 ---

COMPILAR LA VERSIÓN 2.6.27 Y AÑADIR SOPORTE AL SISTEMA DE FICHEROS NTFS UTILIZANDO LA HERRAMIENTA GRÁFICA XCONFIG.

### OTROS EJERCICIOS:

### 1. BUSCAR FICHEROS MODIFICADOS EN LOS ULTIMOS 3 DÍAS CON COMANDO FIND

```bash
    find / -type f -mtime -3
```

2. AVERIGUAR EN QUÉ CONSOLA TRABAJO comando 'w' Resultado:

```
        13:56:29 up  3:00,  2 users,  load average: 1,72, 1,60, 1,01
        USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
        root     pts/1    192.168.50.106   11:01   14:18   0.25s  0.02s make all
        root     pts/2    192.168.50.106   13:51    0.00s  0.00s  0.00s -bash
```

Tengo compilando el Kernel en otra consola diferente a la que he utilizado para ejecutar la ordenpo por lo que estoy en la pts/2

### 3. LIMPIAR EL HISTORIAL

```bash
    cat /dev/null > ~/.bash_history
```

Otra opción: history -c

4. REPETIR DEL HISTORIAL EL 951 CON COMANDO FC fc -s 951

5. CON EL MAN DECIR LAS SECCIONES ASOCIADAS AL COMANDO SMBPASSWD Y MOSTRAR LA 8 man -f smbpasswd man -s 8 smbpasswd

### 6. BUSCAR ARCHIVOS CON PERMISOS SETGID DENTRO DEL SISTEMA

```bash
    find / -type d -perm -2000
```

7. REDIRIGIR EL CONTENIDO DEL ARCHIVO smb.conf AL /tmp/samba.conf Y QUE ENUMERE LAS LÍNEAS. TODO EN LA MISMA ORDEN.

```bash
    find / -type f -name "smb.conf" -exec cat -n {} > /tmp/samba.conf \;
```

### 8. COMO INSTALAR Y ELIMINAR UN PAQUETE EN DEBIAN CON APT-GET, RPM Y YUMP

```bash
    apt-get install paquete.deb
    dpkg -i paquete.deb
    rpm -i paquete.rpm
    yum install paquete.rpm
```

9. COMO EMPAQUETO Y COMPRIMO UN ARCHIVO CON TAR.GZ Y COMO DESEMPAQUETO Y DESCOMPRIMO.

```bash
    tar cvfz paquete.tar.gz ruta/archivo_acomprimir --> para empaquetar y comprimir
    tar xvfz paquete.tar.gz -C ruta/donde/descomprimir --> para desempaquetar y descomprimir.
```

10. VISUALIZAR LAS 2 PRIMERAS LÍNEAS DEL ARCHIVO PASSWD head -n 2 /etc/passwd

### --- FIN DE EJERCICIOS ---

> --- EJERCICIOS 05/11/2014 --- EJERCICIO EXPLICADO EN EL PDF: "Ejercicio Gestión de procesos y trabajos.pdf" PÁG. 1 A LA 7

El comando kill por defecto envía al proceso la orden 'SIGTERM' que significa que termine de forma ordenada. En caso que no funcione hay que usar la opción -9 para terminar si o si a la fuerza.

### --- FIN EJERCICIOS --

### --- EJERCICIOS 06/11/2014 ---

1. GENERAR SOSREPORT Y EL FICHERO GENERADO ENVIARLO AL USB sosreport --se responde a las preguntas que hace--

```bash
    mkdir /usb;
    mount /dev/sdf1 /usb
    cp /tmp/jlopez.1.tar.bz2 /usb
```

### 2. EXPLICAR CADA COLUMNA/CAMPO DEL ARCHIVO /etc/fstab

```
    PARTICIÓN            PUNTO MONTAJE                    SIST. FICHEROS        OPCIONES         COREDUMP    FSCK
    /dev/sdb1            /log                            ext3                default                0          0
```

En COREDUMP: En principio se le pone un '0'. Si le ponemos '1' se puede generar un volacado de información cuando se genere un fallo (archivos del orden de GB) para después poder analizarlo y ver qué ha fallado.

En FSCK:    0 lo normal inicia normalmente 1 cuando inicia el sistema chequea la integridad del disco 2 cuando inicia el sistema chequea la integridad del disco en background PELIGRO, SI EL DISCO ES MUY GRANDE PUEDE TARDAR MCUHÍSIMO Y NO ARRANCARÁ HASTA QUE TERMINE.

En PARTICION en lugar de indicar el lugar donde está el disco/partición se puede inciar el UUID del mismo.

3. ¿COMO CAMBIO LAS OPCIONES DE UN PUNTO DE MONTADE DE E/S A SOLO LECTURA EN CALIENTE?

```bash
    mount -o ro,remount /logs
```

### 4. QUE HACE EL COMANDO NICE Y RENICE

```
    nice            --Cambia la prioridad de un proceso AL LANZARLO. Números negativos mayor prioridad.
```

### Máxima prioridad es '-20'

```
    renice             --Cambia la prioridad de un proceso que ya está en marcha.
```

5. QUIERO OBTENER DE /etc/passwd EL 1 Y EL 7 CAMPO SEPARADOS POR ':' Y GUARDAR EN /tmp/usuarios cut -f 1,7 -d : /etc/passwd > /tmp/usuarios

6. ¿CUANTAS LÍNEAS TIENE /etc/shadow? wc

7. ¿CUANTAS PALABRAS TIENE EL FICHERO /etc/grow?

### 8. HACER UN 'ls' QUE SOLO MUESTRE ARCHIVOS QUE CONTENGAN  3 Y 5

```bash
    ls *[3,5]
```

### --- FIN EJERCICIOS ---

### --- EJERCICIOS 7/11/2014 ---

1. INSTALAR NUEVA MÁQUINA VIRTUAL QUE LA PARTICIÓN LA HAGA POR DEFECTO EN LA RED 192.168.0.6 EL NOMBRE DEL HOST ES "LINUX6". DESACTIVAR EL SELINUX. EL DNS ES EL 192.168.0.150 Y EL DOMINIO ES EL "CURSO.ESP"

### Para la configuración de la red: /etc/sysconfig/network-scripts/ifcfg-eth0

### --- FIN EJERCICIO ---

### --- EJERCICIOS 10/11/2014 ---

1. SE NECESITA CREAR 5 USUARIOS (DE USUARIO[1-5]) Y 2 GRUPOS INFORMATICA Y MICRO Primero creo los 2 grupos para después asignarselos a los usuarios según los vaya creando.

### 2. EL USUARIO1 PERTENECE COMO GRUP SEC A MICRO Y GRUP PRIMARIO INFORMATICA

```bash
    useradd -g informatica -G micro usuario1
    passwd usuario1
```

### 3. EL USUARIO2 PERTENECE COMO GRUP SEC A MICRO E INFORMATICA Y NO TIENE SHEL

```bash
    useradd -G micro,informatica -s /sbin/nologin usuario2
    passwd usuario2
```

4. EL USUARIO3 SU GRUP PRIMARIO ES INFORMATICA Y SU HOME ESTÁ INFORMATICA Y LA CUENTA LE EXPIRA MAÑANA

```bash
    useradd -g informatica -e 20141111 -d /informatica usuario3
    passwd usuario3
```

### -- si /informatica no existe lo crea

5. EL USUARIO4 NO TIENE SHELL Y LA CUENTA ESTÁ BLOQUEADA.

```bash
    useradd -s /sbin/nologin usuario4
```

-- si no asignamos ninguna contraseña está bloqueada por defecto.

6. EL USUARIO5 SU GRUP PRIMARIO ES INFORMATICA TIENE EN SU CAMPO DE DESCRIPCIÓN TIENE QUE DECIR QUE ES ADMIN DE SIST. Y CUANDO ESCRIBA RM TIENE QUE PEDIRLE CONFIRMACIÓN DE LO QUE BORRA. CUANDO ESCRIBA LS TIENE QUE MOSTRARLE FICHEROS OCULTOS Y LOS PERMISOS. CUANDO HAGA UN CP QUE LE PIDA CONFIRMACIÓN DE LO QUE COPIA

```bash
    useradd -g informatica -c "Administrador de sistemas" usuario5
    passwd usuario5
```

### -- Para definir los alias se tiene que editar el archivo .bashrc para añadir:

```bash
    alias rm='rm -i'
    alias ls='ls -la'
    alias cp='cp -i'
```

### --- FIN EJERCICIOS ---

### --- EJERCICIOS 10/11/2014 ---

### CREAR CUOTAS DE 1MB PARA EL USUARIOS lunes10

### 1º. CREAR USUARIOS LUNES10

```bash
        useradd -d /logs/lunes10 lunes10
        passwd lunes10
```

### 2º. EDITAR FSTAB PARA INSERTAR LAS CUOTAS EN EL EL DIRECTORIO /logs

```bash
        vim /etc/fstab
```

### --modifico la siguiente línea para añadir 'usrquota'

```
        UUID=6d9e161d-0640-4f88-8dc9-ea74ca65cb32               /logs                   ext3    defaults,usrquota       0 0
```

### 3º. VUELVO A MONTAR EL SITEMA DE FICHEROS

```bash
        mount -o remount /logs --recarga el fstab pero solo para ese sistema de ficheros.
```

4º. CREO LOS FICHEROS QUE CONTIENEN LA INFO DE CUOTA.

```bash
        touch /logs/aquota.user /logs/aquota.group
```

5º. INICIAMOS LAS CUOTAS quotaon /logs

6º. ESTABLECEMOS LAS CUOTAS PARA lunes10 edquota lunes10

-- nos habre un archivo con vi y tenemos que editar los campos 'soft' y 'hard' de la parte blocs -- SOLO ESOS CAMPOS, añadimos los datos en KB.

### Disk quotas for user lunes10 (uid 508):

```
          Filesystem                   blocks       soft       hard     inodes     soft     hard
          /dev/sdb1                        32       1024       1024          8        0        0
```

7º. ESPECIFICAR EL PERIODO DE GRACIA. El plazo para que el usuario reduzca el tamaño de sus archivos por debajo o igual al limite 'soft'

### edquota -t

COMPROBAR EL FUNCIONAMIENTO CON EL WINscp SUBIENDO UN ARCHIVO MAYOR DE 1MB. Se inicia WINscp como usuario lunes10 y se trata de subir un archivo mayor de 1MB y da error, se intenta subir un archivo menor de 1MB y en este caso si lo acepta.

### --- FIN EJERCICIOS ---

### --- EJERCICIOS 11/11/2014 ---

### 1.- ELIMINAR USUARIOS Y SU HOME CREADOS AYER

```bash
    userdel -r usuario1
    userdel -r usuario2
    userdel -r usuario3
    userdel -r usuario4
    userdel -r usuario5
```

2.- CREAR USUARIO MARTES11 (ONCE) QUE SE LE APLIQUE UNA CUOTA DE 2MB CON /logs (DONDE TENEMOS HABILITADO EL SISTEMA DE CUOTAS.

```bash
    useradd -d /logs/martes11 martes11
    passwd martes11
```

### edquota martes11

### --en el archivo vi modificamos el archivo para que quede como sigue:

### Disk quotas for user martes11 (uid 503):

```
      Filesystem                   blocks       soft       hard     inodes     soft     hard
      /dev/sdb1                      1076       2048       2048         11        0        0
```

3.- PROGAMAR TAREA TANTO EN AT COMO EN CRON PARA EJECUTAR EL SCRIPT SUPERVISAMEN TODOS LOS DÍAS A LAS 11 DE LA NOCHE.

Para hacerlo con el comando 'at' 1º.- hay que levantar el servicio atd y hacer que se ejecute desde el inicio.

```bash
        service atd start                 --para iniciarlo ahora mismo.
        chkconfig --level 35 atd on     --para que se inicie automáticamente en el inicio.
```

2º.- Fijar la tarea con 'at' at 23:00 at> ./opt/scripts/supervisamen &        --indico que quiero que se ejecute este script at> <EOT>                                --con Ctrl+d para finalizar job 5 at 2015-10-13 23:00

### Otra forma de hacer lo mismo:

### at 23:00 -f /opt/scripts/supervisamen

### Para hacerlo con el comando 'cron'

```bash
        crontab -e                         --me habre el editor vi para añadir tareas en /etc/crontab
```

### Una de las líneas de este archivo tiene que se como la siguiente:

```cron
        0 23 * * * root /opt/scripts/supervisamen
```

Para que el escrip se ejecute con las características del usuario "oracle", por ejemplo, habria que escribir la línea así:

```cron
        0 23 * * * su -c "oracle" /opt/scripts/supervisamen
```

Si no se especifica el usuario se ejecutará como el usuario que soy en el momento de editar el fichero.

4.- COMANDO PARA COMPROBAR LA COLA DE AT Y CÓMO ELIMINAR UNA TAREA PROGRAMADA TMB EN AT.

```
        atq             --para el comando at
```

### atrm 1            --para eliminar la tarea 1 programada con 'at'

```bash
        crontab -l         --para el comando cron
```

5.- ¿PARA QUÉ SIRVE EL DIRECTORIO /etc/skel? De modo predefinido las cuentas de usuario del sistema utilizarán como molde al directorio

```bash
        /etc/skel para crear el directorio de inicio de todos los usuarios del sistema. Regularmente,
```

### y como mínimo, /etc/skel incluye lo siguiente:

### .bash_logout .bash_profile .bashrc .gtkrc

6.- DADO EL DIRECTORIO /usr/local/Java/jdk-1.7/bin PARA EL USUARIO MARTES11 PONERLE LAS VARIABLES DE ENTORNO JAVA_HOME PARA QUE UTILICE ESA VERSIÓN DE JAVA.

```bash
    vim /logs/martes11/.bash_profile
```

### Tienemos que añadir las siguientes líneas:

```bash
        JAVA_HOME=/usr/local/java/jdk-1.7/
        export JAVA_HOME
```

Para que estén disponibles los binarios de java en la consola sin tener que escribir toda la ruta hasta ellos habría que añadirlo a la variable PATH:

```conf
            PATH=$PATH:$HOME/bin:/opt/scripts/:$JAVA_HOME/bin
```

7.- AL USUARIO MARTES11 CAMBIARLE EL JUEGO DE CARACTERES A ISO8859-1 [martes11@orion ~]$ export LANG=es_ES.ISO8859-1     --realizo el cambio de codificación [martes11@orion ~]$ locale                            --compruebo y veo el resultado del cambio.

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

9.- COMO CONVIERTO UN FICHERO QUE ESTÁ EN FORMATO WINDOWS A UNIX PARA PODER SER EJECUTADO. dos2unix fichero.sh

> 10.- COMO SINCRONIZO MI SERVIDOR DE FORMA MANUAL CON EL SERVIDOR NTP

ntpdate 1.es.pool.ntp.org

### 11.- EXPLICAR CON EL AT COMO FUNCIONA EL PERMITIR O DENEGAR SU USO A LOS USUARIOS

El archivo /etc/at.deny se utiliza para definir una lista de usuarios a los cuales se les denegará el uso del mandato at. Cuando este archivo está vacío, implica que todos los usuarios del sistema pueden hacer uso del mandato at.

El archivo /etc/at.allow es inexistente de modo predeterminado. Cuando éste existe, sólo los usuarios listados en su interior pueden hacer uso del mandato at.

### 12.- EXPLICAR CON EL CRON COMO FUNCIONA EL PERMITIR O DENEGAR SU USO A LOS USUARIOS

Todos los usuarios puede utilizar el 'cron'. Existen por usuarios en /etc/cron.allow  y el /etc/cron.deny Si /etc/cron.allow existe, por defecto no existe, solo los usuarios allí indicados podrán utilizar cron y todos los demás no. En caso de no existir /etc/cron.allow 'cron' verifica el archivo /etc/cron.deny y solo aquellos que NO estén en la lista podrán ejecutarlo.

El /etc/cron.allow prevalece sobre el /etc/cron.deny en caso de existir ambos.

Para eliminar las tareas hay que editar el fichero para eliminar la linea o comentarla.

### --- FIN EJERCICIOS ---

### --- EJERCICIOS 12/11/2014 ---

1.- CÓMO HABILITO EL SYSLOG REMOTO EN MI SERVIDOR En el archivo /etc/syslog.conf a cada servicio lo enviamos a una IP. Por ejemplo:

```
        authpriv.*                                              @192.168.50.150
```

Ahora hay que configurar la máquina que recibe los logs.

Editar /etc/sysconfig/syslog, en la parte "SYSLOGD_OPTIONS -m 0" hay que añadir la opción '-r' quedando:

### syslogd_option -m 0 -r

### Después reiniciamos el servicio con:

```bash
        service syslog reinice
```

2.- QUE DIFERENCIA HAY ENTRE QUE SEA TCP Y UDP una @ es udp dos @ es tcp

### 3.- COMO ENVIO UN MAIL POR COMANDO, EN CONSOLA

mail nombreusuario (o correo electrónico si es externo)

4.- SERVIDORES QUE TENEMOS DE SMTP Postfix, Dovecot [MAL, ESTE ES DE RECEPCIÓN POP/POP3 NO DE ENVIAR], Sendmail, Exim, Qmail

5.- COMO CREO UN ALIAS O UNA LISTA DE CORREO Editando el archivo /etc/aliases Despues hay que ejecutar "newaliases" para que se carguen las modificaciones.

6.- COMO LANZO UN PROCESO PARA QUE CUANDO CIERRE LA SESIÓN SE MANTENGA EL PROCESO. Con el comando 'nohub' y luego el proceso que queremos lanzar.

7.- EL FICHERO PASSWB QUIERO VER LA COLUMNA 1 Y LA 7 cut -f 1,7 -d : /etc/passwd

8.- PASAR UN FICHERO A OCTAL od fichero

9.- CUANTAS LINEAS TIENE EL ARCHIVO SHADOW wc -l /etc/shadow

### 10.- COMANDO PARA VER INFORMACIÓN DE UN PAQUETE CON RPM Y DEB

```bash
    rpm -qi paquete.rpm
    dpkg -l paquete.deb
```

11.- COMO RESTAURO EL GRUB EN MI DISCO sdb grub-install /dev/sdb

### 12.- DIFERENCIAS ENTRE MODPROBE Y INSMOD

```
    modprobe            --carga o descarga modulos del kernel y todas sus dependencias
    insmod                --solo carga modulos en el kernel, NO carga las dependencias.
```

13.- PROGRAMAR UNA TAREA PARA QUE SE EJECUTE DE LUNES A VIERNES PARA QUE SE REINICIE EL SYSLOG

```bash
    crontab -e
```

### --añadir la siguiente linea

```cron
        0 14 * * 1-5 /etc/init.d/syslog restart
```

### --- FIN EJERCICIOS ---

### --- EJERCICIOS 13/11/2014 ---

1.- BASADO EN SYSTEM V CUAL ES EL COMANDO PARA IMPRIMIR UN ARCHIVO lp /ruta/fichero

2.- CON EL COMANDO lpstat CÓMO VEO UNA IMPRESORA QUE TENGO POR DEFECTO lpstat -d

3.- CON EL COMANDO lpr COMO IMPRIMO UN ARCHIVO lpr -P /ruta/fichero

4.- CON EL COMANDO lpq COMO VEO EL ESTADO DE LOS TRABAJOS EN UNA IMPRESORA lpq -P

5.- COMO VEO LAS COLAS DE CORREO ELECTRÓNICO, ¿CON QUÉ COMANDO? mailq

6.- COMO ACTIVO LAS CUOTAS A UN FILESYSTEM en el fichero /etc/fstab

```bash
        vim /etc/fstab
```

### --modifico la siguiente línea para añadir 'usrquota'

```
        UUID=6d9e161d-0640-4f88-8dc9-ea74ca65cb32               /logs                   ext3    defaults,usrquota       0 0
```

crear archivos aquota.group y aquota.user Para habilitarla a un determinado usuario: edquota martes11

### --en el archivo vi modificamos el archivo para que quede como sigue:

### Disk quotas for user martes11 (uid 503):

```
      Filesystem                   blocks       soft       hard     inodes     soft     hard
      /dev/sdb1                      1076       2048       2048         11        0        0
```

7.- PARA QUE SIRVE LA VARIABLE LD_LIBRARY_PATH Para especifacar donde se encuentran las librerias de ciertos programas que instalamos.

8.- DADOS ESTOS ARCHIVOS: ARCHIVO1 ARCHIVO2 ARCHIVO3 ARCHIVO4 EN UN DIRECTORIO, LISTAR LOS ARCHIVOS DEL 1 AL 3 Y CON OTRO COMANDO LOS ARCHIVOS1 Y ARCHIVO4, TAMB MOSTRAR TODOS LOS FICHEROS QUE NO CONTENGAN EL '3'

```bash
    ls archivo[1-3]
    ls archivo[1,4]
    ls *[!^3]             --archivos que terminen en 3
    ls *[!3]
```

### --- FIN EJERCICIOS ---

### --- EJECICIOS 14/11/2014 ---

USO Y CONFIGURACIÓN DE SUDO

---

### PRIMERO CREAR 1 USUARIO NO ADMINISTRADOR LLAMADO 'VIERNES14'

EDITAMOS EL ARCHIVO /etc/sudoers, QUE SE PUEDE EDITAR DIRECTAMENTE CON EL COMANDO 'VISUDO'.

AÑADIMOS LA SIGUIENTE LÍNEA AL FICHERO PARA OTROGAR PERMISOS DE EJECUCIÓN DE LOS SIGUIENTES COMANDOS:

- REINICIAR EL SERVICIO DE APACHE (httpd)
- EDITAR EL FICHERO httpd.conf
- EDITAR EL FICHERO php.inicia

Cmnd_Alias MANDATOS4 = /sbin/service httpd reload, /usr/bin/vim /etc/httpd/conf/httpd.conf,

```bash
    /usr/bin/vim /etc/php.ini
```

### ESTA OTRA LÍNEA INDICAMOS A QUÉ USUARIO LO APLICAMOS:

- USUARIO 'VIERNES14'
- "ALL" DESDE CUALQUIER SITIO
- "MANDATOS4" INDICA QUE PUEDE EJECUTAR LAS ORDENES QUE ESTÁN BAJO ESE ALIAS  Y LOS SIGUIENTES

### COMANDOS QUE SE LISTAN A CONTINUACIÓN

- LAS ORDENES QUE ESTÁN PRECEDIDAS POR '!' INDICAN LAS QUE **NO** PODRÁN EJECUTAR.

viernes14 ALL = NOPASSWD: MANDATOS4, /usr/sbin/useradd, /usr/bin/passwd *, !/usr/bin/passwd root

LUEGO CAMBIAMOS O INICAMOS A UNA SESIÓN DEL USUARIO 'viernes14' PARA COMPROBAR QUE PODEMOS USAR LAS ORDENES PERMITIDAS Y QUE NOS DENIEGA LAS QUE HEMOS PROHIBIDO EXPRESAMENTE.

NOTA: EL USUARIO TIENE QUE PONER LA RUTA A LAS ORDENES QUE SE LE HA PERMITIDO EJECUTAR, YA QUE NO TIENE ACCESO POR DEFECTO AL DIR /sbin Y ES MALA IDEA AÑADIRLA A SU 'PATH'. EN ESE DIRECTORIO ESTÁN LAS ORDENES O COMANDOS QUE SOLO EL ROOT PUEDE EJECUTAR.

### --- FIN EJERCICIO ---

### --- EJERCICIOS 14/11/2014 ---

### 1.- QUIERO QUE EL SERVICIO SSH LISTE POR LA IP QUE TNGO

### 2.- NO PERMITIR CONEXIONES A ROOT EN EL SSH

### 3.- NO QUERIO QUE SE RESUELVA POR DNS LA IP DE ESE CLIENTE

### 4.- EL PUERTO DE ESCUCHA SERÁ EL 52341

5.- SOLO SE PODRÁ CONECTAR EL USUARIO VIERNES14 Y DESDE LA IP DE MI WINDOWS Y LA DE MI COMPAÑERA

### Todo lo anterior se hace modificando las opciones del archivo /etc/ssh/sshd_config

6.- CREAR ARCHIVO CON NOMBRE PERSONAL Y COPIAR EN LA MÁQUINA DE NUESTRO COMPAÑERA. CON EL COMANDO

```bash
SCP.
```

Creamos un archivo en nuestro Windows con nuestro nombre y mediante WinSCP se copia en la máquina de la compañera.

### --- FIN EJERCICIOS ---

--- EJERCICIOS 17/11/2014 --- [SCRIPTING]

1.- INSTALAR PARA EL USUARIO LUNES17 EL jdk-8 PARA QUE CUANDO EJECUTE 'java --version' APAREZCA ESA VERSIÓN DE JAVA.

```bash
    useradd lunes17
    passwd lunes17
    tar xvfz jdk-8u25-linux-i586.tar.gz -C /usr/java/
    vi /home/lunes17/.bash_profile
```

## # User specific environment and startup programs

```bash
        JAVA_HOME=/usr/java/jdk1.8.0_25/bin
        export JAVA_HOME
        PATH=$HOME/bin:$JAVA_HOME
        export PATH
```

### Para comprobar, entramos como lunes17 en el servidor y tecleamos:

### java -version

2. CREAR UN SCRIPT '*.sh' PARA QUE QUE CUALQUIER USUARIO QUE NO TENGA UNA VARIABLE JAVA_HOME EN SU '.bash_profile' INICE CON ESTA VERSIÓN DE JAVA.

### Para que afecte a todos los usuarios el script debe estar en /etc/profile.d

3. MODIFICAR EN CALIENTE LA VARIABLE $JAVA_HOME PARA PASARLA A LA VERSIÓN 1.6, LA QUE TENIAMOS ANTERIORMENTE. set JAVA_HOME=/usr/java/jdk1.6.0_07/

```bash
    export $JAVA_HOME
```

### Para comprobar:

```bash
    echo $JAVA_HOME
```

export PATH=$JAVA_HOME:$PATH   --El orden es importante, en el PATH ya tenemos la version 1.8

Para comprobar: java -version

4. COMO IMPRIMO EL ARCHIVO DATOS.TXT TANTO DESDE EL COMANDO 'lpr' Y 'lp' lp -d HP-casa fichero

```
    lpr    -P nombre_cola fichero
```

5. CONVERTIRNOS EN EL USUARIO JBOSS5 Y LANZAR EL SERVICIO 'jboss5' Y MOSTRAR TODOS LOS PROCESOS QUE TENGO CON ESTE USUARIO

```bash
    su - jboss5
    service jboss5 start
```

### ps -ef | grep -i $USER

6. MATAR PROCESOS DE jboss5 CON EL COMANDO KILL TANTO CON SEÑAL ABRUPTA COMO FINALIZACIÓN NORMAL (ORDENADA) kill PID_del_proceso kill -9 PID_del_proceso            --terminamos bruscamente

7. MODIFICAR EL USUARIO lunes17 PARA QUE SU GRUPO PRIMARIO SERA informati SU GRUPO SECUNDARIO SEA

```
micro  Y ADEMÁS NO TENGA SHELL
    usermod -g informatica -G micro -s /sbin/nologin lunes17
```

--- FIN EJERCICIOS ---
