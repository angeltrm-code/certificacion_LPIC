# Resumen Librerias Comportartidas linux

Resumen de estudio sobre Resumen Librerias Comportartidas linux con jerarquía Markdown consistente y bloques técnicos normalizados.

> ### Pagina 99 Manual curso LPIC1 pdf

### Instalamos un soft que me deja esta ruta de librerias:

```bash
/usr/lib/oracle/10.2.0.5/client/lib/
```

## Por convención se colocan las librerías compartidas en directorios llamado lib:

- /lib: librerías de sistema básicas, vitales
- /usr/lib: librerías: de usuario básicas, no necesarias al boot.
- /usr/local/lib: librerías locales para los programas para la maquina
- /usr/X11R6/lib: librerías del entorno X windows
- /opt/kde3/lib: librerías de KDE....

En las distribuciones Linux recientes (las basadas en systemd), los directorios /lib y /lib64 ya no están en la raíz, su contenido se ha cambiado a /usr/lib y /usr/lib64

Bajo Linux (y Unix, en general), las librerías compartidas llaman a Shared Objects (so) en el sentido en que se trata de ficheros de objetos sin bloque de instrucción main. Llevan el sufijo .so.

El comando ldd permite determinar cuales son las librerías vinculadas a un programa y también si están persistentes o no

```bash
ldd /usr/sbin/fsck
```

### which passwd

```bash
/usr/bin/passwd
```

```bash
ldd /usr/bin/passwd
```

## Configurar la cache del editor de vínculos, decirle a sistema operativo donde estan la librerias instaladas:

El cargador de vínculos ld.so busca las librerías en varios lugares, entre los cuales, se encuentran, por este orden:

- las rutas precisadas en la variable de entorno LD_LIBRARY_PATH. Se separan las rutas, como para el PATH, por ":"
- el contenido del fichero /etc/ld.so.cache, que contiene una lista compilada (formato binario) de las librerías encontradas en las rutas predeterminadas.
- los directorios /lib y /usr/lib

```bash
cat /etc/ld.so.conf
```

### include ld.so.conf.d/*.conf

### Añado al directorio /etc/ld.so.conf.d/oracle_client.conf

```bash
/usr/lib/oracle/10.2.0.5/client/lib/
```

## Regeneramos la cache con el comando ldconfig

```bash
ldconfig
```

### El comando ldconfig:

- actualiza la caché para las rutas definidas en /etc/ld.so.conf y asociadas, así como para /usr/lib y /lib;
- actualiza los vínculos simbólicos en las librerías;
- permite también listar las librerías conocidas en la caché.

---

## LD_LIBRARY_PATH  SIEMPRE CAE EN EL EXAMEN

LD_LIBRARY_PATH es una variable de entorno en sistemas Unix y Linux que especifica una lista de directorios donde el sistema busca bibliotecas dinámicas (shared libraries) antes de buscar en los directorios predeterminados (como /lib y /usr/lib). Esta variable se usa cuando quieres que un programa busque en ubicaciones específicas para las bibliotecas que necesita en tiempo de ejecución.

```bash
vi /root/.bash_profle
LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client/lib/:/usr/lib64/mysql/lib:/tomcat-9/lib/
export LD_LIBRARY_PATH
```

## Afectaria a todos los usuarios del sistema operativo:

```bash
vi /etc/profile
LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client/lib/:/usr/lib64/mysql/lib
export LD_LIBRARY_PATH
```

```bash
vi /home/usuario1/.bash_profle
export LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client/lib/
```

```bash
vi /root/.bash_profle
export LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client/lib/
```

---

## Resumen explicacion  en este laboratorio instalo las libreria del base de datos oracle en la version 10.2.0.5 y tengo que decir al sistema como encontrarlas dichas librerias:

### Ruta de librerias tras instalacion sera:

```bash
/usr/lib/oracle/10.2.0.5/client/lib/
```

## Instalación librerías cliente Oracle y gestionarlas como Librerías compartidas

## Instalo las librerías cliente Oracle mediante rpm

```bash
rpm -Uvh oracle-instantclient-*.rpm
```

## Dos formas de darle al sistema la ruta de las librerias:

1-Creo el archivo /etc/ld.so.conf.d/oracle_client.conf, donde le pongo la ruta de las librerias, cualquier usuario del sistema opetativo tiene acceso:

```bash
vi /etc/ld.so.conf.d/oracle_client.conf
/usr/lib/oracle/10.2.0.5/client/lib/
```

## Regeneramos la cache con el comando ldconfig, la rutas de las librerias:

```bash
ldconfig
```

## Listamos las librerías conocidas del editor de vínculos con:

```bash
ldconfig -p |grep oracle
```

LD_LIBRARY_PATH es una variable de entorno en sistemas Unix y Linux que especifica una lista de directorios donde el sistema busca bibliotecas dinámicas (shared libraries) antes de buscar en los directorios predeterminados (como /lib y /usr/lib). Esta variable se usa cuando quieres que un programa busque en ubicaciones específicas para las bibliotecas que necesita en tiempo de ejecución.

### 2-Forma a traves de la variable LD_LIBRARY_PATH, en este ejemplo en el usuario root:

```bash
vi /root/.bash_profile
LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client/lib/:/usr/lib/mysql/lib
export LD_LIBRARY_PATH
```

```bash
vi /home/oracle/.bash_profile
LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client/lib/
export LD_LIBRARY_PATH
```

## Para todo el sistema operativos, es decir para todos los usuarios:

```bash
vi /etc/profile
export LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client/lib/
```
