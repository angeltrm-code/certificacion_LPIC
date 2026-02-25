## Pagina 75 Manual del curso Debian Package

## .deb ##
La base de datos dpkg en /var/lib/dpkg
/root/webmin.deb

El comando DPKG en Linux es una herramienta utilizada para administrar paquetes a través de su instalación,
eliminación y compilación. En una distribución basada en Debian, Linux preconfigura el gestor de paquetes ¨apt¨o ¨apt–get¨ por paquete, el cual a su vez, destina al comando DPKG para que se encargue de la gestión de paquetes de Debian.

**Este comando no resuelve dependencias

## Resumen esencial de  los comandos para trabajar con dpkg:

# Instalar un paquete:
dpkg -i paquete.deb

# Eliminar un paquete (sin borrar configuración):
dpkg -r paquete

# Eliminar un paquete y su configuración:
dpkg --purge paquete

# Listar todos los paquetes instalados:
dpkg -l

# Mostrar información de un paquete instalado:
dpkg -s paquete

# Listar archivos instalados por un paquete:
dpkg -L paquete

# Buscar qué paquete instaló un archivo:
dpkg -S /ruta/al/archivo

# Reconfigurar un paquete:     !!!  Pregunta de certificacion   !!!
El comando dpkg-reconfigure se usa en distribuciones Debian y Ubuntu para reconfigurar paquetes instalados mediante dpkg (Debian Package Manager). Permite volver a ejecutar el asistente de configuración de un paquete sin necesidad de reinstalarlo.

dpkg-reconfigure paquete


## Opciones avanzadas de dpkg:

# Instalar ignorando dependencias:
dpkg --force-depends -i paquete.deb

# Listar paquetes con patrón:
dpkg -l 'paquete*'

# Mostrar problemas de instalación:
dpkg --audit

# Ver archivos dentro de un .deb:
dpkg --contents paquete.deb

# Eliminar paquetes parcialmente instalados:
dpkg --remove paquete

# Reparar paquetes rotos:
dpkg --configure -a

# Cambiar arquitectura:
dpkg --add-architecture i386

# Verificar integridad de un paquete:
dpkg -V paquete

# Extraer archivos de un .deb sin instalar:
dpkg-deb -x paquete.deb directorio

# Ver información de un .deb:
dpkg-deb --info paquete.deb


## Resumen extendido:

dpkg -i {package.deb} : usado para instalar el paquete.
dpkg -R {directory} : este comando instala todos los paquetes de un estructura de directorio.
dpkg -l : muestra la lista de paquetes instalados.
dpkg -c {package.deb} : lista los archivos en un paquete.
dpkg -L {package} : muestra los archivos proporcionados por un paquete instalado.
dpkg -S {pattg/to/file} : determina los paquetes que pertenecen a un archivo.
dpkg -r {package} : elimina un paquete instalado, pero deja sus archivos de configuración.
dpkg -P {package} :elimina un paquete instalado, incluyendo sus archivos de configuración.
dpkg --get-selections : es utilizado para buscar paquetes instalados, desinstalados y purgados en el sistema operativo.
dpkg --configure --pending : función para reconfigurar cualquier paquete que no haya pasado por un proceso de configuración.
dpkg --info pp.deb : se encarga de mostrar información sobre las dependencias y sus extensiones.
dpkg --version: para consultar la licencia del paquete dpkg.
dpkg --unpack nombre_paquete.deb : usado para descomprimir un archivo deb.
dpkg -R –install /deb-files-location/ : instala varios archivos deb de forma simultánea, siempre y cuando se encuentren en la misma carpeta.
sudo dpkg --help: para obtener ayuda sobre cómo usar la herramienta en cuestión.
dpkg --force-all --purge nombre_del_paquete

dpkg-reconfigure reconfigura paquetes después de su instalación. Introduzca los nombres
del paquete o paquetes a reconfigurar. Formulará preguntas de configuración de forma
similar a cuando el paquete se instaló en primer lugar.

apt-cache sobre todo se utiliza para buscar programas pero también para obtener información de programas
o paquetes que haya en los repositorios o que tengamos instalado en el ordenador.
Los parámetros más utilizados son search y show para buscar y obtener información de programas. 


apt-get es la herramienta que utiliza Debian y sus derivadas (Ubuntu incluida), para gestionar los paquetes instalables disponibles en los repositorios s hacer con apt-get desde una terminal:
Comandos "apt-get":

/etc/apt/sources.list

### APT (Advanced Package Tool)

El comando APT (Advanced Package Tool por sus siglas en inglés que traducen Herramienta Avanzada de Empaquetado)
es un elemento de línea de comandos creado por el proyecto Debian con el objetivo de permitirle a los usuarios gestionar y administrar los paquetes de sus distribuciones de Linux Debian.

APT es la herramienta predeterminada en gran parte de distribuciones, como por ejemplo, Ubuntu, Linux Mint y
demás programas basados en el sistema de Debian.

Dentro de las funciones principales de este comando, se puede encontrar que Linux APT te permite instalar, actualizar, eliminar paquetes o programas del sistema en Linux, entre otras funciones.

Los llamados repositorios APT Linux hacen referencia a una colección de paquetes Deb que pueden ser entendidos por toda la familia de herramientas apt (es decir apt-get y demás). Contar con este tipo de repositorios, te permitirá realizarla instalación, eliminación, actualización y demás operaciones de paquetes, a través del uso de paquetes individuales
o grupos de paquetes. 

## Principales comandos de APT:

apt-get install {package} : funciona para instalar programas o paquetes.
apt-get reinstall {package} : cumple la función de reinstalar un paquete completo desde cero, en caso de que este presente
algún problema en su funcionamiento.
apt-get update {package} : comando diseñado para actualizar los paquetes del sistema.
apt-get remove {package} : se encarga de eliminar los paquetes instalados, pero deja sus archivos de configuración.
apt-get remove -purge {package} : este comando remueve por completo un programa o paquete, incluyendo también,
sus archivos de configuración asociados.
apt-get update: Actualiza la lista local de paquetes disponibles desde los repositorios. No instala nada.
apt-get upgrade: funciona para actualizar el sistema de Linux, incluyendo los paquetes de seguridad.
apt-get dist-upgrade: encargado de actualizar las distribuciones de Linux.

# El comando APT, también cuenta con otras herramientas que le facilitan la ejecución de ordenes y el cumplimiento de sus funciones
como por ejemplo:

apt-cache search {package} : la ejecución de este elemento cumplirá la función de buscar elementos a través del nombre del paquete.
apt list: esta herramienta te permite ver un lista de los paquetes y actualizaciones disponibles en la opción de Linux APT.
apt show: este comando cumple la función de mostrar los detalles de alguno de los paquetes APT Linux en concreto.
apt shows rc: con esta herramienta se cumple la función de mostrar detalles de los paquetes fuentes de los repositorios del sistema
apt autoremove: este elemento funciona para eliminar las dependencias del sistema que no sean necesarias.
apt edit-sources : su función es la de permitir ver y editar la lista de software.
apt satisfy {package} : este comando se encarga de recuperar y satisfacer dependencias.



### Ejemplos apt-get:

1. Actualizar el listado de paquetes disponibles:

sudo apt-get update


2. Comprobar que todo ha ido bien tras la utilización de apt-get update:

sudo apt-get check


3. Instalar los programas deseados:

sudo apt-get install paquete1 paquet2


4. Reinstalar un programa:

sudo apt-get -reinstall install paquete


5. Actualizar solo los paquetes ya instalados que no necesitan, como dependencia, la instalación o desinstalación de otros paquetes:

sudo apt-get upgrade


6. Actualizar todos los paquetes del sistema, instalando o desinstalando los paquetes que sean necesarios para resolver las dependencias que pueda generar la actualización de algún paquete:

sudo apt-get dist-upgrade


7. Desinstalar un paquete:

sudo apt-get remove paquete


8. Desinstalar un paquete y elimina los archivos de configuración:

sudo apt-get remove --purge paquete


9. Resolver problemas con dependencias y paquetes rotos:

sudo apt-get -f install

Puede ser necesario reconfigurar dpkg con:

sudo  dpkg --configure -a


10. Para limpiar los paquetes descargados e instalados:

sudo apt-get clean


11. Para limpiar los paquetes viejos que ya no se usan:

sudo apt-get autoclean


12. Para buscar un paquete determinado:

sudo apt-cache search paquete


13. Descargar archivos fuente:

sudo apt-get source paquete


14. Configurar las dependencias de construcción para paquetes fuente:

sudo apt-get build-dep paquete


15. Seguir las selecciones de dselect:

sudo apt-get dselect-upgrade


16. Para conocer que paquetes hay instalados:

sudo apt-show-versions (-u)


17. Obtener más información de un paquete específico:

sudo apt-cache show paquete


18. Más información aún:

sudo apt-cache showpkg paquete


19. Para saber de que paquete depende:

sudo apt-cache depends paquete


20. Para encontrar el nombre de un paquete desde un archivo:

sudo apt-file search archivo


21. Listar el contenido de un paquete:

sudo apt-file list paquete


22. Para mantener al día esta función:

sudo apt-file update


23. Para mantener el sistema limpio de bibliotecas inútiles:

sudo apt-get autoremove


24. Actualizar la caché de paquetes (/var/cache/apt/pkgcache.bin), crea un nuevo árbol de dependencias:

sudo apt-get check


25. Mostrar un resumen de las dependencias no satisfechas en la caché de paquetes:

sudo apt-cache unmet


26. Mostrar una lista de todo lo que tenemos instalado en el sistema:

sudo apt-cache pkgnames -generate

Opciones:

-s 	Simula una acción.
-d 	Sólo descarga.
-y 	No pregunta y asume que si a todo.
-u 	Muestra paquetes actualizados.
-h 	Muestra texto de ayuda.
-q 	Salida registrable - sin indicador de progreso.
-qq 	Sin salida, excepto si hay errores.
-f 	Intenta continuar sí la comprobación de integridad falla (dependencias rotas).
-m 	Intenta continuar si los archivos no son localizables.
-b 	Construye el paquete fuente después de obtenerlo.
-V 	Muesta números de versión detallados.
-c=? 	Lee este archivo de configuración.
-o=? 	Establece una opción de configuración arbitraria.



Actualización: A partir de Ubuntu 14.04, el gestor de paquetes apt ("Avanced Package Tool") tiene nuevas opciones. Ya no es necesario
escribir "apt-get" y se puede utilizar simplemente "apt", (apt seguirá funcionando).

## Para consultar un comando que paquete nos lo instala....
sudo apt-get update
sudo apt install apt-file
sudo apt-file search lspci
---------------------------------------------------------------------
## La herramienta alien permite convertir paquetes RPM en DPKG y viceversa ##
El parámetro por defecto -d convierte del rpm al dpkg (.deb):
alien -d lgtoclnt-7.4-1.i686.rpm
alien -r lgtoclnt-7.4-1.i686.deb
----------------------------------------------
-----------------------------------------------------------------
### Red Hat Package Manager pagina 63 pdf manual del curso ###

El comando rpm es el gestor de paquetes de bajo nivel en distribuciones basadas en Red Hat, como Rocky Linux, RHEL, CentOS y Fedora. Se usa para instalar, eliminar, actualizar y consultar paquetes .rpm.

**Este comando no resuelve dependencias


## paquete.rpm ##
/var/lib/rpm
rpm --rebuilddb

Regenera los archivos de la base de datos de RPM en /var/lib/rpm/.
Corrige inconsistencias cuando la base de datos está corrupta.
No afecta los paquetes instalados, solo repara la información sobre ellos.


## Instalar con rpm
rpm -ivh paquete.rpm

# Borrar un paquete:
rpm -evh paquete
--nodeps
--force
rpm -ivh --nodeps paquete.rpm

## Actualizar ##
rpm -U paquetev2.rpm
rpm -F paquetev2.rpm

## Auditar el chesksums de un paquete
rpm -V php
Un punto significa que una etapa de comprobación está OK. Si no es así:
• S: se modificó el tamaño del archivo.
• 5: la suma MD5 ya no se corresponde.
• T: la fecha de modificación ya no es la misma.
• U: se modificó el propietario.
• G: se modificó el grupo.
• L: se modificó el vínculo simbólico.
• M: se modificaron los permisos o el tipo de archivo.
• D: se modificó el periférico (major/minor).

## Consultas ##
rpm -qa php
rpm -qa httpd*
rpm -qi paquete --> informacion sobre el paquete
rpm -ql php --> Nos dice que ficheros instala el paquete y donde
rpm -qf /etc/passwd  --> Le damos un archivo y nos dice que paquete lo instalo

rpm -qp --requires joomla-1.0.15-2.9.el5.al.noarch.rpm --> veo las dependencias que necesita el paquete
yum -y localinstall /root/webmin-1.955-1.noarch.rpm
service webmin start
service webmin status
netstat -tan |grep -i listen
ss -tan
https://192.168.2.5:10000/
---------------------------------------------------------------------------
## Trabajar con yum/dnf
/etc/dnf/dnf.conf
/etc/yum.conf: Fichero de configuración
• /var/log/yum.log: Registro de actividad
• /var/log/dnf.log: Registro de actividad
• /etc/yum.repos.d: Directorio de trabajo de los repositorios

/etc/yum.conf
/etc/yum.repos.d/*.repo

yum install paquete1  paquete2 -y
yum remove paquete1 -y
yum erase paquete
yum info php
yum update 
yum upgrade

##Buscamos que paquete contiene el archivo mc
yum provides /*netstat
yum provides lspci

yum install net-tools -y


• all: es el caso por defecto: se listan primero los paquetes instalados y luego los disponibles para la instalación.
• available: los paquetes disponibles para instalación.
• updates: los paquetes que se pueden actualizar.
• installed: los paquetes actualizados.
• obsoletes: los paquetes del sistema obsoletos debido a las versiones superiores disponibles.
• recent: los últimos paquetes añadidos en los repositorios.
• repolist: los repositorios configurados en yum.conf o yum.repos.d.

 yum clean all --> borramos la cache de yum.
tail -f /var/log/yum.log 

yum check-update

vi /etc/yum.conf
[main]
exclude=php* kernel*

yum --exclude=php* kernel*  update
yum update php

## El gestor de paquetes yum provee de la opción --downloadonly.
Como su nombre lo indica, el uso de esta opción hará que se simplemente se descarguen los programas requeridos
y sus dependencias.
Por defecto, los archivos se guardarán en el directorio /var/cache/yum/x86_64/<versión de distro>/<repositorio>/packages

yum install  --downloadonly --downloaddir=/root  mc

## Instalar rpm locales gestionando dependencias con yum:

yum --nogpgcheck localinstall /root/nginx-1.12.2-2.el7.x86_64.rpm

Qué hace exactamente?
Detecta que estás pasando un archivo local (./xxx.deb).
Lo instala, pero si faltan dependencias, las busca e instala desde los repositorios que tengas configurados en el sistema.
apt install ./xxx.deb

#Y Para redhat
yum localinstall /root/webmin-1.955-1.noarch.rpm



yum history list 
yum history info 29

Repetir o deshacer una determinada transacción.
## Rehacer
yum history redo 23

## deshacer
yum history undo 23

## Configurar salida yum con proxy en empresa:
vi /etc/yum.conf
/etc/dnf/dnf.conf
[main]
………………
proxy=http://<Proxy-Server-IP-Address>:<Proxy_Port>
proxy_username=<Proxy-User-Name>
proxy_password=<Proxy-Password> 

------------------------------------------------------------------------------------------------
# Zypper

zypper es el gestor de paquetes de openSUSE y SUSE Linux Enterprise (SLE).
Trabaja con paquetes RPM y repositorios configurados en el sistema.

# Es el equivalente a:
apt en Debian/Ubuntu
dnf en RHEL/Rocky

zypper [--opciones-globales]  [--opciones-comando] [argumentos]
 
  Opciones globales:
        --help, -h              Ayuda.
        --version, -V           Mostrar el número de versión.
        --config, -c   Usar el archivo de configuración indicado en lugar del predeterminado.
        --quiet, -q             Suprimir la salida estándar, muestra sólo los
                        mensajes de error.
        --verbose, -v           Aumentar el nivel de detalle.
        --no-abbrev, -A         No abreviar el texto en las tablas.
        --table-style, -s       Formato de tabla (entero).
        --rug-compatible, -r    Activar la compatibilidad con rug.
        --non-interactive, -n   No preguntar nada, utilizar las
                        respuestas predeterminadas de forma automática.
        --xmlout, -x            Salida en XML.
 
        --reposd-dir, -D   Utilizar un directorio alternativo para el archivo
                                de definiciones.
        --cache-dir, -C    Utilizar un directorio alternativo para el cache.
        --raw-cache-dir    Utilizar un directorio alternativo para el cache de.
                                los meta datos en crudo (raw).
        --solv-cache-dir   Utilizar un directorio alternativo para el cache del.
                                archivo solv.
        --pkg-cache-dir    Utilizar un directorio alternativo para el cache de.
                                paquetes.
 
     Opciones de repositorios:
        --no-gpg-checks         Ignorar fallos en verificación GPG y continuar.
        --gpg-auto-import-keys  Confiar e importar automáticamente las nuevas firmas
                                del repositorio.
        --plus-repo, -p    Utilizar un repositorio adicional.
        --disable-repositories  No leer los meta-datos de los repositorios.
        --no-refresh            No actualizar los repositorios.
        --no-cd                 Ignorar los repositorios en CD/DVD.
        --no-remote             Ignorar repositorios remotos.
 
     Opciones de destino:
        --root, -R         Utilizar un directorio raíz diferente.
        --disable-system-resolvables
                                No leer paquetes instalados.                                          
 
  Comandos:
        help, ?                 Visualiza la ayuda.
        shell, sh               Acepta múltiples comandos a la vez.                                   
 
     Manejo del repositorio:
        repos, lr               Enumera todos los repositorios definidos.
        addrepo, ar             Añade un nuevo repositorio.
        removerepo, rr          Elimina el repositorio especificado.
        renamerepo, nr          Renombra el repositorio especificado.
        modifyrepo, mr          Modifica el repositorio especificado.
        refresh, ref            Actualiza todos los repositorios.
        clean                   Limpia las caches locales.
 
        Manejo de Servicios:
        services, ls            Lista los servicios definidos.
        addservice, as          Agregar un nuevo servicios.
        modifyservice, ms       Modificar el servicio indicado.
        removeservice, rs       Eliminar el servicio indicado.
        refresh-services, refs  Actualizar todos los servicios.
 
        Gestión de software:
        install, in             Instala paquetes.
        remove, rm              Elimina paquetes.
        verify, ve              Verificar la integridad de las dependencias del paquete.
        update, up              Actualiza los paquetes con nuevas versiones.
        dist-upgrade, dup       Realiza una actualización de la distribución.
        source-install, si      Instala los paquetes fuente y sus dependencias de construcción.
        install-new-recommends, inr  Instala nuevos paquetes recomendados por los ya instalados.
 
     Gestión de Actualizaciones:
        update, up              Actualizar paquetes instalados.
        list-updates, lu        Listar actualizaciones disponibles.
        patch                   Instalar parches necesarios.
        list-patches, lp        Listar parches necesarios.
        dist-upgrade, dup       Realizar una actualización de la distribución.
        patch-check, pchk       Verificar la existencia de parches.
 
     Consultas:
        search, se              Busca paquetes que coincidan con un patrón.
        info, if                Muestra información completa de los paquetes especificados.
        patch-info              Muestra información completa de los parches especificados.
        pattern-info            Muestra información completa de los patrones especificados.
        product-info            Muestra información completa de los productos especificados.
        patches, pch            Enumera todos los parches disponibles.
        packages, pa            Enumera todos los paquetes disponibles.
        patterns, pt            Enumera todos los patrones disponibles.
        products, pd            Enumera todos los productos disponibles.
        what-provides, wp       Enumera los paquetes que proporcionan la característica especificada.
 
     Bloqueos de paquetes:
        addlock, al             Añade un bloqueo al paquete.
        removelock, rl          Elimina un bloqueo del paquete.
        locks, ll               Enumera los bloqueos actuales.
        cleanlocks, cl          Eliminar bloqueos sin usar.
 
     Otros comandos:
        versioncmp, vcmp        Comparar dos cadenas de versión.
        targetos, tos           Imprimir el ID del sistema operativo destino.
        licenses                Imprimir reporte de licencias y EULA de
                                los paquetes instalados.
 
Teclee 'zypper help ' para obtener ayuda de un comando concreto.




