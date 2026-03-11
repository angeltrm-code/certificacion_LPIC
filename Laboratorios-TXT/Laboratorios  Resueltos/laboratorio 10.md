# laboratorio 10

Documento práctico sobre laboratorio 10. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Desarrollo

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

6. �COMO EXCLUYO PAQUETES RPM CON YUM?

Editando /etc/yum.conf y en la variable 'exclude' listar los paquetes que quiero excluir.

```conf
    exclude=php* kernel* mc*
```

Una de las cosas que se suelen excluir en las empresas, y seg�n sus pol�ticas, es el Kernel. Sobretodo

si se trata de Kernels compilados para drivers especificos.

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

### 1. IMAGINAR EL ARBOL:

### NUMEROS/UNO/DOS

QUIERO QUE LOS DIR. TNGAN LOS SIGUIENTES PERMISOS Y DEBEN PERTENECER AL USUARIO 'ROOT' Y AL GRUPO 'INFORMATICA':

```
NUMEROS/     -->  RW- R-- ---
UNO/        -->  RW- --- ---    + PERMISOS DE SETGID
DOS/        -->  R-- R-- R--    + PERMISOS DE STIK BIT
```

### Para crear los directorios:

```bash
        mkdir -p /numeros/uno/dos
```

### Para cambiar los permisos:

```bash
        chmod 640 /numeros; chmod 600 /numeros/uno; chmod 444 /numeros/uno/dos;
```

### Resultado:

### drwxr----- 3 root root 4096 oct 31 11:57 /numeros/

### drw------- 3 root root 4096 oct 31 11:57 /numeros/uno/

### dr--r--r-- 2 root root 4096 oct 31 11:57 /numeros/uno/dos

### Creaci�n del grupo de 'informatica':

```bash
        groupadd informatica
```

### Cambiar de grupo los directorios:

### chgrp -R informatica /numeros/

### Resultado:

### drwxr----- 3 root informatica 4096 oct 31 11:57 /numeros/

### drw------- 3 root informatica 4096 oct 31 11:57 /numeros/uno/

### dr--r--r-- 2 root informatica 4096 oct 31 11:57 /numeros/uno/dos

### EN NUMEROS/ CREAR ARCHIVO CON NOMBRE PERSONAL CON PERSMISOS SETUID

```bash
touch /numeros/archivo
chmod 4700 /numeros/archivo
```

### 4. VER LA INFO DEL RPM

```bash
rpm -i
```

5. VER QU� INSTALA EL PAQUETE Y D�NDE.

```bash
rpm -ql
```

1. SETEAR LA FECHA Y HORA DEL SISTEMA A LA ACTUAL.

```bash
    date --set "2016-06-09 12:54"
```

### 3. DESACTIVAR MENSAJES DE CONSOLA

### mesg n

4. �PARA QU� SIRVE EL COMANDO BC?

Es una calculadora avanzada desde la l�nea de comandos.

### 5. CON EL COMANDO UNAME MOSTRAR EL NOMBRE DEL HOSTNAME CON EL COMANDO UNAME

```bash
uname -n
```

### Otra opcci�n: hostname

### 6. MOSTRAR ULITMOS 10 MENSAJES DEL HISTORIAL

### fc -l -10

### 7. REPETIR ULTIMO MENSAJE DEL HISTORIAL CON EL COMANDO FC

### fc -n 1057

Otra opci�n es ejecutar: !!

### 8. MOSTRAR DEL FICHERO PASSWD LA FECHA DE MODIFICACI�N

### Primero saber d�nde esta:

```bash
    find / -type f -name "\passwd"
```

### Luego ver la informaci�n que se solicita:

```bash
    stat /etc/passwd | grep -i "Modify"
```

### 9. MOSTRAR LAS 20 PRIMERAS LINEAS DEL FICHERO MESSAGES CON EL COMANDO HEAD

### head -n 20 /var/log/messages

### 10. BUSCAR EN EL SISTEMA FICHEROS CON PERMISOS DE STICKY BIT

```bash
find / -type d -perm -1000
```

### 11. BUSCAR EN EL SIST. FICHEROS DE CREACI�N O MODIFICACI�N CON MENOS DE 5 MINUTOS

```bash
find / -mmin -5
```

### 12. BUSCAR EN EL SIST. FICHEROS CON LA EXTENSI�N .AVI Y ELIMINARLOS EN LA MISMA ORDEN

```bash
find / -type f -name "*.avi" -exec rm -rf {} \;
```

### 13. VISUALIZAR EL ARCHIVO MESSAGES EMPEZANDO POR EL FINAL

```bash
tac /var/log/messages
```

14. MASCARA DE CREACI�N POR DEFECTO QUE TENEMOS EN EL SISTEMA.

### umask -S

### 15 Averiguar el pid del ultimo proceso ejecutado

```bash
echo $!
```

### 16 Averiguar el pid del shell actual

```bash
echo $$
```

### 17 Averiguar si el ultimo comando se ha ejecutado con exito

```bash
echo $?
```

### 18 Comando que convierte en caracteres

### tr

### 19 Dividir un archivo para impresion en 66 lineas

### pr -l

### 20 Comanddo para ordenar un texto numericamente

```bash
sort -n
```
