# Clase 3 Miercoles 25 02 2026

Apuntes de clase sobre Clase 3 Miercoles 25 02 2026, reorganizados para facilitar la consulta rápida y el repaso.

Miercoles 25/02/2026

## Referencias

- https://www.lpi.org/es/our-certifications/lpic-1-overview

## Materiales publicos de LPIC:

- https://learning.lpi.org/es/learning-materials/learning-materials/

Profesor/a Titular: Alberto Garcia

## Conectarme a traves del cliente ssh de Windows abrimos un cmd:

## Maquina rockylinux:

```bash
ssh root@192.168.33.10
```

## Maquina debian12:

```bash
ssh vagrant@192.168.33.11
```

## Para trabajar como root en la mv de debian:

sudo -i

---

## En esta clase veremos:

## Tema 102: Instalación de Linux y gestión de paquetes:

> -->Material Alumnos LPIC-1-2026\LPIC-1-exam-101\2-Topic 102-Instalacion de Linux y Gestion de Paquetes -Tema 102 Instalación de Linux y gestión de paquetes.pdf -Resumen Librerias Comportartidas linux.txt -Paquetes RPM y DPKG.txt -Laboratio install sofware debian-centos.txt -lab compilar nginx codigo fuente.txt

## instalar sosreport en redhat:

```bash
dnf install sos -y
```

sosreport

## Crearar el archivo /var/tmp/sosreport-rockylinux8-2026-02-25-xxxxxx

```bash
tar xvfJ /var/tmp/sosreport-rockylinux8-2026-02-25-djzrlqm.tar.xz -C /opt
```

---

## Averiguar que paquete me instala un comando que no tenga en mi linux:

## En debian y derivados averiguar paquete que instala un comando

```bash
apt-cache search nslookup
```

```bash
sudo apt-get update
sudo apt-get install apt-file
sudo apt-file update
sudo apt-file search nslookup
sudo apt-file list nombre_paquete
```

```bash
sudo apt install  -y nombre_paquete
```

## En Redhat y derivados averiguar paquete que instala un comando

```bash
yum provides lspci
dnf provides lspci
```

## El comando anterior da esta salida:

### pciutils-3.5.1-3.el7.x86_64 : PCI bus related utilities

```
Repositorio        : @base
```

Resultado obtenido desde: Nombre del archivo    : /usr/sbin/lspci

## Instalo el programa:

```bash
yum install -y pciutils-3.5.1-3.el7.x86_64
```

## El D-Bus Machine ID

El D-Bus Machine ID es un identificador único que usa D-Bus (y otros servicios del sistema) para distinguir una instalación específica de Linux, sobre todo útil en sistemas clonados, contenedores y entornos virtualizados.

¿Para qué sirve? Identificación única del sistema: usada por D-Bus, systemd, journalctl, etc. Evitar conflictos en entornos clonados: si clonas un sistema y no cambias el machine-id, podrías tener problemas con servicios que esperan unicidad. Contenedores: en contenedores, a veces es necesario regenerar este ID para evitar choques.

```bash
cat /etc/machine-id
```

El siguiente comando se puede usar para validar que existe una ID de máquina D-Bus para el sistema en ejecución: $ dbus-uuidgen --ensure

Si no se muestran mensajes de error, existe una ID para el sistema. Para ver la ID actual de la máquina D-Bus, ejecute lo siguiente: $ dbus-uuidgen --get 17f2e0698e844e31b12ccd3f9aa4d94a

Elimina el archivo actual de machine-id (por ejemplo, si fue clonado y está duplicado en varias máquinas).

```bash
sudo rm -f /etc/machine-id
```

Genera un nuevo UUID válido y lo escribe en /etc/machine-id solo si el archivo no existe. Esto asegura que D-Bus tenga un identificador único. sudo dbus-uuidgen --ensure=/etc/machine-id

---

## Compilar desde codigo fuente:

## Explicacion profesor comandos

```bash
wget http://nginx.org/download/nginx-1.19.6.tar.gz
tar xzfv nginx-1.19.6.tar.gz -C /opt
cat README
```

```bash
./configure --help
./configure --prefix=/etc
make
make install
```

```bash
./configure
```

Ejecuta un script llamado configure que prepara el entorno de compilación. Verifica que tu sistema tenga las librerías y dependencias necesarias. Crea los Makefiles, que son las instrucciones para make. Permite ajustar parámetros de instalación

```bash
make
```

Lee el archivo Makefile generado por configure. Compila el código fuente, creando los binarios. Si hay errores de librerías faltantes, aquí suelen aparecer.

```bash
make install
```

Copia los binarios, librerías y archivos de configuración al sistema. Por defecto, suele instalar en /usr/local/bin, /usr/local/lib, etc. (a menos que cambies el --prefix en ./configure). Importante: este paso normalmente requiere permisos de administrador:

## Diferencias clave .bash_profile .bashrc

.bash_profile → se ejecuta una sola vez al iniciar sesión. .bashrc → se ejecuta cada vez que abres un shell interactivo.

Lo normal: Variables globales en .bash_profile.

```bash
Alias, funciones y personalización en .bashrc.
```

Muchas veces .bash_profile llama a .bashrc para que ambas configuraciones se apliquen en cualquier sesión.

Un shell interactivo es un intérprete de comandos (como bash, zsh, etc.) que se usa directamente por el usuario para escribir y ejecutar comandos.

## Características principales del shell interactivo:

Espera a que el usuario escriba un comando y lo ejecuta. Muestra un prompt (ej. $ o usuario@host:~$). Permite usar el historial de comandos (↑, ↓, history). Soporta alias, autocompletado con Tab, funciones, etc.

Se suele lanzar cuando abres: una terminal gráfica, una consola en modo texto, una sesión por ssh

Shell no-interactivo Se usa para ejecutar scripts automáticamente, sin intervención del usuario. No muestra prompt ni espera input.

Resumen rápido Interactivo → cuando tú escribes comandos y el shell responde en vivo. No-interactivo → cuando el shell ejecuta instrucciones de un archivo/script sin esperar al usuario.
