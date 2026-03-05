**108.4 Gestión de la impresión y de las impresoras

# En el manual del curso en la pagina 365 La impresión# 
https://www.openprinting.org/printers

# SYSTEM-v BSD  FEDERADOR# 

# Impresión en Linux (General)
En los sistemas Linux modernos, la impresión generalmente se maneja a través de:

CUPS (Common Unix Printing System): Es el sistema de impresión más utilizado en distribuciones modernas.
LPR/LPD (Line Printer Daemon): Utilizado principalmente en sistemas antiguos o sistemas que siguen el modelo BSD.

# Impresión en System V
System V es una familia de sistemas UNIX que influyó fuertemente en la forma en que los sistemas Linux gestionan las impresoras.
Características de Impresión en System V:
Utiliza el comando lp para imprimir.

El demonio de impresión se llama lp o lpsched

# Los comandos de gestión de las colas de espera e impresiones con System V son los siguientes:
lp -dimpresora -ncifra fichero1
lp -dimpresora -n1 fichero1

lpstat -d -s -t -p  Informacion relativa a la impresion
-d muestra el nombre de la impresora
-s estado o resumen de la cola
-t totalidad informacion de los estado de trabajo
-p informacion sobre impresoras incluida en la lista

# cancel  suprime las tareas de impresion -e suprime todos los trabajos de impresion, solo lo puede ejecutar el administrador

cancel -e -->solo root

# El demonio ldp
El demonio suele llevar el nombre de lpd (line printer daemon) o lpsched (line printer scheduler).

lpadmin permite administrar los serviceio de impresion con las cola en esprea, etc...
lpadmin -x fila suprimir una cola en espera
lpsdmin -d define cola de espera por defecto
lpadmin -p fila -u deny:lista  prohibicion de imprimir a usuario 
lpmove permite transferir peticion de impresion de una cola a otra cola 

# BSD
Impresión en BSD (Berkeley Software Distribution)
El estilo BSD utiliza el protocolo LPR/LPD (Line Printer Remote/Daemon) y es común en sistemas UNIX derivados de BSD.

# Características de Impresión en BSD:
El comando principal es lpr.
El demonio de impresión es lpd.

lpr -d impresora -# copia  fichero 
lpq -P impresora, indica el estado y los trabajos de una impresora
lprm permite suprimir tabajos de impresion
lpc especie de shell permite controlar la impresora y trabajos
Servicicio se llama lpd


# fmt
El comando fmt visualiza el fichero como máximo históricamente un fichero en Linux el limite de
 caracteres de ancho es 80 y de número de líneas 25
#  fmt -w 80 access_log |more


# pr  
El comando pr se usa para formatear texto para impresión o visualización paginada.
Su función principal es preparar archivos de texto con:
- Encabezados
- Numeración de líneas
- Paginación
- Columnas
- Fechas

pr access_log |more

# Para sustituir en la cabecera el nombre del archivo por el mensaje que le queramos poner.
pr -h "ACCESSOS A MI SERVIDOR WEB" access_log |more

pr -h "ACCESSOS A MI SERVIDOR WEB" access_log |lp -dcoladeimpresora -n1


# Impresión Federada
La impresión federada hace referencia a la integración de múltiples servicios de impresión en una sola infraestructura, típicamente usando CUPS como backend para unificar tanto métodos System V como BSD.

# Características de la Impresión Federada:
Utiliza CUPS para gestionar tanto impresiones BSD como System V.



Comparación de System V, BSD y Federado (CUPS)
===============================================

| Característica            | System V         | BSD            | Federado (CUPS)                    |
|-------------------------- |----------------- |----------------|------------------------------------|
| Demonio de impresión      | lpsched          | lpd            | cupsd                              |
| Archivo de configuración  | /etc/lp/printers | /etc/printcap  | /etc/cups/cupsd.conf               |
| Comando de impresión      | lp               | lpr            | lp, lpr                            |
| Cancelación de trabajos   | cancel           | lprm           | cancel                             |
| Visualización de cola     | lpstat           | lpq            | lpstat                             |
| Interfaz web              | No               | No             | Sí (http://localhost:631)          |
| Compatibilidad            | UNIX System V    | UNIX BSD       | Linux y sistemas UNIX modernos     |




------------------------------------------------------------------------------------------
# CUPS 
CUPS (Common Unix Printing System) es un sistema de impresión para Unix y Linux que permite configurar y administrar impresoras en sistemas operativos basados en Unix, como Linux y macOS. CUPS actúa como un servidor de impresión que facilita la impresión de documentos en impresoras locales o remotas utilizando una interfaz web y el Protocolo de Impresión de Internet (IPP).

CUPS se compone de una cola de impresión con un planificador, un sistema de filtros para convertir los datos a formatos que puedan utilizar las impresoras, y un sistema que permite enviar estos datos hacia la impresora. 

Permite además utilizar cualquier equipo como servidor de impresión, a través del protocolo IPP, utilizando el puerto 631/TCP.


El protocolo IPP (Internet Printing Protocol) es un protocolo de red estándar utilizado para la administración y transmisión de trabajos de impresión en entornos de red. Es el protocolo principal utilizado por CUPS (Common Unix Printing System) y es compatible con la mayoría de las impresoras modernas, tanto locales como en red.

# En RockyLinux8 en los repositorios  no esta el paquete cups-pdf

# Archivos y directorios de configuración CPUS.

/etc/cups/cupsd.conf se utiliza para configurar las directivas y el control de acceso del servicio cups.
/etc/cups/printers.conf se utiliza para guardar la configuración de las colas de impresión.
/etc/cups/lpoptions se utiliza para guardar las opciones de configuración específicas para cada cola de impresión.
/etc/cups/ppd/ corresponde al directorio donde se guardan los archivos *.ppd correspondientes a cada cola de impresión.
/var/spool/cups/ corresponde al directorio utilizado para la cola de procesamiento de impresión. 
Aquí se encuentran todos los trabajos de impresión.

# Archivos de logs para controlar CUPS
/var/log/cups/access_log se utiliza para almacenar la bitácora de actividad del servicio cups.
/var/log/cups/error_log se utiliza para almacenar la bitácora de errores del servicio cups. Cuando hay problemas con la configuración o el funcionamiento del servicio, este es el archivo indicado para buscar la información necesaria para hacer diagnósticos.
/var/log/cups/page_log se utiliza para almacenar la bitácora de trabajos de impresión.


# Para ver los logs del servicio CUPS utilizando el sistema de registros de systemd.
journalctl -u cups.service -e

# Explicacion del comando:
journalctl: Muestra los registros del sistema almacenados en el journal de systemd.

-u cups.service: Filtra los registros específicamente para el servicio CUPS.

-e: Muestra los registros más recientes y automáticamente desplaza hasta el final del archivo (similar a tail -f).
---------------------------------------------------------------------------------------------------------------
**Laboratorio CUPS y cups-pdf, la impresora que montamos es cups-pdf utilizamos mv Rocky Linux:

# Instalamos:
dnf install epel-release -y
dnf -y install cups cups-pdf

# En Debian:
sudo apt install cups cups-pdf -y

# Ahora reiniciaremos el servicio:

systemctl start cups
systemctl status cups

netstat -putan |grep -w 631 
tcp        0      0 127.0.0.1:631       0.0.0.0:*               LISTEN      31876/cupsd

 

En el caso que sea necesario, CUPS dispone de una interfaz de administración, basada sobre HTTP,
disponible inmediatamente después de iniciar el servicio cups, a través de 
http://localhost:631/admin

# Para activar cups a traves de nuestra ip del servidor y no del localhost: 

ip a

vi /etc/cups/cupsd.conf
Listen 192.168.33.10:631

systemctl restart cups
netstat -putan |grep -w 631
tcp        0      0 192.168.33.10:631       0.0.0.0:*               LISTEN      31876/cupsd

http://192.168.33.150:631/

http://192.168.33.10:631/admin

# En debian damos al usuario vagrant permisos al grupo lpadmin y nos validamos en la web con el usuario vagrant:
sudo gpasswd -aG vagrant lpadmin 

# En las mv de redhat utilizamos el usuario root.


# En los Location añadimos la directiva Allow from all # 
cp /etc/cups/cupsd.conf /root

vi /etc/cups/cupsd.conf

#  Restrict access to the server...
<Location />
  Order allow,deny
  Allow from all # Directiva que añadimos
</Location>

#  Restrict access to the admin pages...
<Location /admin>
  Order allow,deny
   Allow from all # Directiva que añadimos
</Location>

#  Restrict access to configuration files...
<Location /admin/conf>
  AuthType Default
  Require user @SYSTEM
  Order allow,deny
  Allow from all # Directiva que añadimos
</Location>


# Ahora reiniciaremos el servicio:
 systemctl restart cups

netstat -putan |grep -w 631
tcp        0      0 192.168.33.10:631       0.0.0.0:*               LISTEN      31876/cupsd
 
# Ya podriamos conectarnos desde el admin de la web de CUPS:
  
https://192.168.33.10:631/admin/ 

# Importante si estamos en maquinas Redhat desactivar selinux y firewalld:

vi /etc/sysconfig/selinux

#  This file controls the state of SELinux on the system.
#  SELINUX= can take one of these three values:
#      enforcing - SELinux security policy is enforced.
#      permissive - SELinux prints warnings instead of enforcing.
#      disabled - No SELinux policy is loaded.
SELINUX=disabled


systemctl status firewalld
systemctl stop firewalld
systemctl disabled firewalld


# Cuando añadimos la impresora a traves de CUPS via web, utilizamos el driver en la pagina 5 Laboratorio Gestion_Impresoras.pdf:
Generic CUPS-PDF Printer y no el Generic PDF Printer


# Enumere todas las impresoras junto con el conjunto de impresoras predeterminado
lpstat -s
lpstat -a -d

destino predeterminado del sistema: Cups-PDF
dispositivo para Cups-PDF: cups-pdf:/

# Configure la impresora CUPS-PDF como predeterminada.
Utilizo lpoptions -d "Cups-PDF"

# Verifique que se muestre como predeterminado y muestre las opciones de la impresora para esa impresora
lpoptions -l

# Mandamos a imprimir a la cola Cups-PDF, el fichero en formato pdf se crea en el /home del usuario, en este ejeplo
# /root/ips-ordenadas.pdf

lp -dcups-pdf -n1 /lpic1/origenes.txt
lp -dcups-pdf -n1 /etc/passwd

lp -dVirtual_PDF_Printer -n1 /etc/passwd

/root/passwd-job_1.pdf
find /root  -name "*.pdf"


# Esta orden con la impresora cups-pdf no funciona 
Lo que ocurre es que la impresora CUPS-PDF tiene una configuración predeterminada que guarda los archivos PDF en un directorio específico, como /root/Escritorio o ~/PDF. Para redirigir la impresión al directorio /tmp, puedes seguir uno de estos métodos:

sudo vi  /etc/cups/cups-pdf.conf

# Busca la línea que especifica el directorio de salida:
Out ${HOME}/PDF


lp -d Cups-PDF /lpic1/origenes.txt -o outputfile=/tmp/origenes.pdf 

-o outputfile=/tmp/origenes.pdf: Redirige la salida de la impresión al archivo

# Tendriamos que moverlo nosotros a traves de un comando:
lp -d Cups-PDF -n1 /lpic1/origenes.txt && mv ~/Escritorio/origenes.pdf /tmp/

 find /root  -name *.pdf

ls -l /root/orignenes.pdf

/root/Escritorio/passwd.pdf
/root/Escritorio/ips-ordenadas.pdf


lpstat -s
system default destination: Virtual_PDF_Printer
device for Virtual_PDF_Printer: cups-pdf:/

# Imprimimos el archivo /etc/passwd:

lp -dVirtual_PDF_Printer -n1 /etc/passwd
request id is Virtual_PDF_Printer-1 (1 file(s))

find /  -name passwd.pdf

# Si lo lanzamos como usuario root pues la impresion del pdf quedara en /root, si tengo entorno grafico instalado pued quedara los pdf impresos en el dicrectorio /root/Escritorio
/root/passwd.pdf
/root/Escritorio/ips-ordenadas-job_2.pdf

lpstat -s
destino predeterminado del sistema: PDF
dispositivo para PDF: cups-pdf:/
dispositivo para PDFprint: cups-pdf:/

lp -d PDF /etc/passwd

# Si solo tengo una impresora y esta de forma predeterminada no es necesario -d 
Si tienes más de una impresora y quieres especificar, usa -d
lp   -n1 /etc/passwd


find /  -name passwd*.pdf
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Explicacion del archivo printers.conf, con la impresora creada en nuestro laboratorio:
printers.conf es el archivo de configuración donde el sistema de impresión CUPS guarda la definición de las impresoras configuradas en el sistema.

cat /etc/cups/printers.conf

<Printer Cups-PDF>                      #  Inicio de la definición de la impresora llamada "Cups-PDF"

UUID urn:uuid:417b6fd9-5dc8-3e57-51a1-82473fe6a120   #  Identificador único permanente de esta impresora

Info Cups-PDF                           #  Nombre descriptivo que aparece en interfaces gráficas / web CUPS

MakeModel Generic CUPS-PDF Printer (no options)   #  Driver y modelo asociados; define PPD y opciones del filtro

DeviceURI cups-pdf:/                    #  Backend utilizado; "cups-pdf:/" indica que genera PDFs en lugar de imprimir

State Idle                              #  Estado actual de la cola: Idle = sin trabajos, lista para imprimir

StateTime 1740075981                    #  Marca de tiempo Unix (epoch) del último cambio de estado

ConfigTime 1740075203                   #  Marca de tiempo Unix de la última modificación de esta configuración

Type 8450124                            #  Número interno de CUPS que especifica capacidades/flags de la impresora

Accepting Yes                           #  Indica si la impresora acepta trabajos (Yes/No)

Shared Yes                              #  Indica si la impresora está compartida en la red a través de CUPS

JobSheets none none                     #  Define las páginas de portada inicial y final; aquí desactivadas ("none")

QuotaPeriod 0                           #  Periodo de cuotas (0 = sin cuotas)

PageLimit 0                             #  Límite de páginas (0 = sin límite)

KLimit 0                                #  Límite de kilobytes impresos (0 = sin límite)

OpPolicy default                        #  Política de operación: reglas de permisos y acceso

ErrorPolicy stop-printer                #  Qué hacer ante un error: "stop-printer" = detener la impresora

</Printer>                              #  Fin de la definición de la impresora
