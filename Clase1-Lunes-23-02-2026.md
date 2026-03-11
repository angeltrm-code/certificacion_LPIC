# Clase 1 Lunes 23 02 2026

Apuntes de clase sobre Clase 1 Lunes 23 02 2026, reorganizados para facilitar la consulta rápida y el repaso.

Lunes 23/09/2025

## Referencias

- https://www.lpi.org/es/our-certifications/lpic-1-overview

## Materiales publicos de LPIC:

- https://learning.lpi.org/es/learning-materials/learning-materials/

Horario de Clases online de 16:00 a 21:00.

Profesor/a Titular: Alberto Garcia agarcif@outlook.es alberto@rootdesdezero.com

- https://www.virtualbox.org/wiki/Changelog-7.1#v4

---

## Resumen de competencias LPIC-1

## Examen 102-500

## 101: Arquitectura del sistema

Determinar y configurar hardware al inicio (BIOS/UEFI, arranque). Procesos de arranque (GRUB2, systemd). Ejecutar diferentes niveles de arranque y detener/reiniciar el sistema.

## 102: Instalación de Linux y gestión de paquetes

Diseño de particiones, montajes, swap. Instalación de bootloaders (GRUB). Gestión de paquetes en Debian/Ubuntu (dpkg, apt) y en Red Hat/Fedora (rpm, dnf/yum). Localización e internacionalización (idioma, zona horaria, variables locales).

## 103: Comandos GNU y Unix

Uso básico de la shell (bash). Manipulación de archivos (ls, cp, mv, rm, find). Manipulación de texto (cat, less, head, tail, wc, sort, cut, tr, grep, sed, awk). Redirecciones (>, >>, 2>, |). Archivos comprimidos y archivados (tar, gzip, bzip2, xz, zip, unzip).

## 104: Dispositivos, sistemas de archivos y FHS

Crear y configurar particiones y sistemas de archivos (fdisk, mkfs, lsblk). Montar y desmontar (mount, umount, /etc/fstab). Mantenimiento de integridad (fsck). Jerarquía de archivos FHS (/, /etc, /var, /home, /tmp, /usr, /opt). Gestión de cuotas de disco.

## Examen 102-500

## 105: Shells, scripting y gestión de datos

Personalización de entorno (~/.bashrc, ~/.profile). Construcción de scripts simples (#!/bin/bash, variables, condicionales, bucles). Control de trabajos (bg, fg, jobs, kill). Programación básica de tareas (cron, at).

## 106: Interfaces de usuario y escritorios

Variables de entorno relacionadas con display ($DISPLAY, X11). Configuración de acceso gráfico básico. Acceso remoto a escritorios (X, VNC, RDP).

## 107: Tareas administrativas

Gestión de usuarios y grupos (useradd, usermod, passwd, groupadd). Archivos de configuración de cuentas (/etc/passwd, /etc/shadow, /etc/group, /etc/skel). Gestión de procesos (ps, top, kill, nice, renice). Localización de archivos y documentación (man, info, which, locate).

## 108: Servicios esenciales del sistema

Configuración del reloj del sistema (date, hwclock, timedatectl). Logs del sistema (/var/log/, journalctl). Programación de tareas con cron y at. Envío de mails desde línea de comandos.

## 109: Fundamentos de redes

Protocolos y puertos básicos (TCP/IP, UDP, ICMP). Configuración de red con ip, ifconfig, ss, netstat. Resolución de nombres (/etc/hosts, /etc/resolv.conf, dig, nslookup). Diagnóstico de red (ping, traceroute, curl, wget).

## 110: Seguridad

Gestión de permisos y modos (rwx, chmod, umask). Permisos especiales (SUID, SGID, sticky bit). Gestión de acceso root (su, sudo). Configuración de cortafuegos básico (iptables, firewalld, ufw). Seguridad de cuentas (passwd, políticas de contraseñas).

## Enfoque de examen

Son 2 exámenes: 101-500 y 102-500. Preguntas de selección múltiple y de completar. No se permite acceso a internet, pero sí se espera uso práctico de comandos.

## Formato del examen

Preguntas de opción múltiple, respuesta múltiple y rellenar espacios (comandos o rutas). Duración: 90 minutos por examen. Idiomas: inglés, español y otros. Modalidad: en centros Pearson VUE o en línea con supervisión (OnVUE).

## La certificación LPIC-1 se aprueba realizando dos exámenes:

101-500 102-500

## Detalles de la puntuación

Escala: 200 a 800 puntos.

### Nota mínima de aprobación: 500 puntos en cada examen.

El puntaje no es simplemente “preguntas correctas ÷ total”; LPI usa un sistema de ponderación por dificultad de cada pregunta.

---

## Tema 103: Comandos GNU y Unix

## Comandos basicos:

> \Material Alumnos LPIC-1-2025\LPIC-1-exam-101\3-Topic 103-Comandos GNU y UNIX Comandos-Basicos-linux.pdf Clase-1.txt Clase-2.txt Diferencias entre enlaces simbolicos.pdf

> Manual LINUX - Preparación a la certificación LPIC-1.pdf -->Pagina 112

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
dnf provides lspci
```

Tabla comparativa de comandos para saber qué paquete provee un archivo/comando como lspci en RHEL/CentOS/Fedora(RPM/DNF) y en Debian/Ubuntu (DPKG/APT):

Distribución / Gestor    Si el comando ya está instalado    Si el comando no está instalado    Ejemplo con lspci: RHEL / CentOS / Fedora    rpm -qf $(which lspci)    dnf provides lspci    pciutils

Debian / Ubuntu    dpkg -S $(which lspci)    apt-file search bin/lspci (requiere apt-file)    pciutils

## ¿Qué paquete provee un comando/archivo en Linux, ejemplo el comando lspci?

====================== RHEL / CentOS / Fedora (basado en RPM / DNF) ===========

## Si el comando ya está instalado:

```bash
rpm -qf $(which )
```

- Si el comando NO está instalado: dnf provides

## Ejemplo con lspci:

```bash
rpm -qf $(which lspci)
dnf provides lspci
```

### -> paquete: pciutils

### ============= Debian / Ubuntu (basado #en DPKG / APT) ===========

- Si el comando ya está instalado: dpkg -S $(which )

- Si el comando NO está instalado: apt-file search bin/

- Si ya sabes el paquete probable: apt show

## Ejemplo con lspci: dpkg -S $(which lspci)

```bash
apt-file search bin/lspci
apt show pciutils -> paquete: pciutils
```

## Laboratorio:

```bash
mkdir /datos
cd /datos
touch archivo{1..5}
```

### Crear el directorio /datos y los archivo1 a archivo2, archivo3 archivo4 archivo5

### Los archivos que tienen 1 o 2

```bash
            ls *[12]
```

### Todos los ficheros que no terminen en 3

```bash
             ls *[!3$]
```

### Lista de los archivos del 1 al 3

```bash
              ls *[1-3]
```

ls *[1,3] Muestra el archivo1 y el archivo3

## Los caracteres de patrón especiales tienen los siguientes significados:

## Concuerda con cualquier cadena de caracteres, incluida la cadena vacía. ? Concuerda con un solo carácter cualquiera. [...] Concuerda con uno de los caracteres entre corchetes. Un par de caracteres separados por un signo menos denota un rango [!...] La concordancia es con cualquier carácter de los que no estén entre los corchetes.

## Expansión de llaves { }

La expansión de llaves es un mecanismo por el cual pueden generarse cadenas arbitrarias. Los patrones a ser expandidos con la expansión de llaves toman la forma de un preámbulo opcional seguido por una serie de cadenas separadas por comas entre un par de llaves, seguido por un post scriptum opcional. El preámbulo sirve de prefijo a cada cadena de entre las llaves, y el post scriptum se añade luego a cada cadena resultante, expandiendo de izquierda a derecha.

### Ejemplo:

```bash
touch archivo{1..5}
mkdir dir{1..5}
```

---

## Resumen extendido de comandos básicos de Linux:

### 1. Navegación por el sistema de archivos

```bash
pwd → muestra la ruta actual.
ls → lista archivos y directorios.
ls -l → listado largo (permisos, propietario, tamaño, fecha).
ls -a → muestra archivos ocultos.
ls -lh → tamaños legibles (K, M, G).
cd <ruta> → cambia de directorio.
cd .. → subir un nivel.
cd - → volver al directorio anterior.
```

### 2. Manipulación de archivos y directorios

```bash
touch archivo.txt → crea un archivo vacío.
mkdir carpeta → crea un directorio.
mkdir -p ruta1/ruta2 → crea estructura de directorios.
cp origen destino → copia archivos.
cp -r dir1 dir2 → copia directorios recursivamente.
mv origen destino → mueve o renombra archivos.
rm archivo → elimina archivo.
rm -r carpeta → elimina carpeta recursivamente.
rm -rf carpeta → elimina forzando (¡peligroso!).
```

### 3. Visualización y edición de archivos

cat archivo → muestra contenido completo.

less archivo → muestra de forma paginada (q para salir). head -n 10 archivo → primeras 10 líneas. tail -n 10 archivo → últimas 10 líneas. tail -f archivo.log → seguimiento en vivo de logs.

### Editores comunes:

```bash
nano archivo (sencillo).
vim archivo (avanzado).
```

### 4. Gestión de permisos y propietarios

```bash
ls -l → muestra permisos (rwx).
chmod 755 archivo → cambia permisos numéricos.
chmod u+x script.sh → agrega permiso de ejecución al usuario.
chown usuario:grupo archivo → cambia propietario.
```

5. Procesos y gestión del sistema ps aux → lista procesos. top → muestra procesos en tiempo real. htop → versión mejorada (si está instalada). kill <PID> → termina un proceso. kill -9 <PID> → termina forzado. jobs → muestra procesos en background. fg %1 → trae un proceso al foreground.

### 6. Usuarios y grupos

```bash
whoami → usuario actual.
```

id → muestra UID y grupos. adduser usuario → crea usuario.

```bash
passwd usuario → cambia contraseña.
usermod -aG grupo usuario → añade usuario a grupo.
```

groups usuario → muestra grupos del usuario.

### 7. Búsqueda de archivos y texto

```bash
find /ruta -name archivo.txt → busca por nombre.
find / -type d -name carpeta → busca directorios.
```

locate archivo.txt → búsqueda rápida (requiere updatedb).

```bash
grep "texto" archivo → busca texto en archivo.
grep -i → ignora mayúsculas.
grep -r "texto" /ruta → búsqueda recursiva.
```

### 8. Redes

```bash
ping host → comprueba conectividad.
curl http://url → descarga contenido.
wget http://url → descarga archivo.
ifconfig o ip addr → muestra interfaces de red.
ss -tulpn → puertos en uso.
scp archivo user@host:/ruta → copia segura por SSH.
ssh user@host → conexión remota.
```

### 9. Compresión y empaquetado

```bash
tar -cvf archivo.tar dir/ → crear tar.
tar -xvf archivo.tar → extraer tar.
tar -czvf archivo.tar.gz dir/ → crear tar.gz.
tar -xzvf archivo.tar.gz → extraer tar.gz.
```

gzip archivo → comprime. gunzip archivo.gz → descomprime. zip archivo.zip f1 f2 → comprime.

```bash
unzip archivo.zip → descomprime.
```

10. Paquetes y actualizaciones

## En Debian/Ubuntu:

```bash
apt update → actualiza lista de paquetes.
apt upgrade → instala actualizaciones.
apt install paquete → instala paquete.
apt remove paquete → elimina paquete.
apt search paquete → busca paquete.
```

## En RHEL/CentOS/Fedora:

```bash
dnf install paquete
dnf remove paquete
dnf search paquete
dnf update
```

### 11. Almacenamiento y discos

```bash
df -h → espacio en disco.
du -sh carpeta → tamaño de carpeta.
mount → ver montajes activos.
lsblk → lista discos y particiones.
fdisk -l → muestra particiones.
```

12. Misceláneos útiles history → muestra comandos usados. !! → ejecuta el último comando. !n → ejecuta el comando número n del history.

```bash
alias ll="ls -lh" → crea un alias.
date → muestra fecha y hora.
```

uptime → tiempo encendido del sistema.
