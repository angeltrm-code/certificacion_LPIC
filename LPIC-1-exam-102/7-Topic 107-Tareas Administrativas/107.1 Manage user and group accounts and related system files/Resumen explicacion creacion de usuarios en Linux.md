**Tema 107: Tareas administrativas
107.1 Administrar cuentas de usuario y de grupo y los archivos de sistema relacionados con ellas

##Tareas Administrativas
Manual LINUX - Preparación a la certificación LPIC-1.pdf -->Pagina 344

¿Qué diferencia hay?
.bash_profile → usado principalmente en Red Hat, Rocky, CentOS y otros sistemas tipo RHEL.
.profile → usado por Debian, Ubuntu y derivados cuando se inicia sesión con un shell de login (como bash o sh).

##Explicacion .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

####Explicacion

# Get the aliases and functions → Indica que lo que se quiere es cargar los alias y funciones que tengas definidos en ~/.bashrc.

if [ -f ~/.bashrc ]; then

Comprueba si el archivo ~/.bashrc existe y es un archivo regular (-f).

. ~/.bashrc

El . (punto) es equivalente a source.

Esto ejecuta el contenido de ~/.bashrc en el entorno actual de la shell (no en un subproceso).

fi

Cierra la condición if.


###useradd vs adduser
useradd es un comando que ejecuta un binario del sistema, mientras que adduser es un script en perl que utiliza el binario useradd.

La mayor ventaja del comando adduser es que crea el directorio home (/home/usuario/) del usuario de manera automática, cosa que no hace useradd (hay que usar la opción -m). Sin embargo, como no es un comando del core de GNU/Linux, es posible que no funcione bien en todas las distribuciones que uses.

##Crear un usuario:
adduser operador
passwd operador
Password,092


adduser -g informatica -G sistemas -s /sbin/nologin usu1
passwd usu1


#Crear un usuario y forzar el cambio de contraseña en el primer inicio de session:
adduser operador
passwd operador

#Fuerza el cambio de contraseña en el próximo inicio de sesión del usuario operador
chage -d 0 operador
passwd -e operador

Password,018

## Para forzar el cambio de comtraseña, expire inmediatamente:
passwd -e berto
chage -l berto


passwd -S berto
berto PS 2024-10-18 0 99999 7 -1 (Password set, SHA512 crypt.)

##Bloquear y desbloquear un usuario
usermod --help
usermod -L berto
passwd -S berto
usermod -U berto

##Cambiar el password a un ususario de forma automatica con passwd:
echo 123456 |passwd --stdin user
echo 000000 |passwd --stdin operador

echo "berto:000000" | sudo chpasswd

##Explicación para debian no tiene --stdin:

#chpasswd
El comando chpasswd se usa para cambiar contraseñas de usuarios en lote (de forma no interactiva).
Es muy útil en scripts, automatización o administración masiva de usuarios.

chpasswd lee líneas en formato usuario:contraseña.

#Aplica directamente los cambios en /etc/shadow.
Es la forma correcta y no interactiva en Debian.


#gpasswd
El comando gpasswd permite agregar o eliminar un usuario de un grupo. Los usuarios y los grupos deben existir

gpasswd -d user grupo # elimina el usuario del grupo
gpasswd -a user grupo # ingresa el usuario al grupo

gpasswd -a operador mircroinformatica # ingresa el usuario al grupo


#Explicación de gpasswd -A
gpasswd → Administra grupos en Linux.
-A berto → Especifica que berto será el administrador del grupo.
informatica → Nombre del grupo en el que berto tendrá privilegios de administración.

Esto significa que berto podrá:
✅ Agregar y eliminar miembros del grupo con gpasswd -a usuario informatica o gpasswd -d usuario informatica.

gpasswd -A berto informatica


Opción	                     Descripción
-a usuario grupo	         Agrega un usuario a un grupo.
-d usuario grupo	         Elimina un usuario de un grupo.
-A usuario1,usuario2 grupo	 Asigna administradores del grupo (sustituye los anteriores).
-M usuario1,usuario2 grupo	 Define la lista de miembros del grupo (sustituye los anteriores).
-r grupo	                 Elimina la contraseña del grupo.
-R grupo	                 Restringe el acceso al grupo solo a sus miembros.
-Q grupo	                Elimina la restricción de acceso al grupo.
grupo (sin opciones)	Permite cambiar la contraseña del grupo interactivamente.


##Eliminar administradores del grupo
Para eliminar a berto como administrador del grupo informatica, usa:
gpasswd -A "" informatica

Las comillas "" indican que no se asigna ningún administrador.



##¿Qué es /etc/gshadow?
Es el archivo que almacena información sensible de los grupos en Linux.
Contiene la lista de administradores y miembros del grupo.
Solo puede ser leído por el superusuario (root).

cat /etc/gshadow
sistemas:!:berto:operador,vagran


#Uso de una contraseña en un grupo con gpasswd
El comando gpasswd permite asignar una contraseña a un grupo, lo que permite a los usuarios unirse temporalmente a ese grupo sin intervención de un administrador.

gpasswd nombregrupo

#¿Cómo usar una contraseña de grupo?
Un usuario normal puede unirse temporalmente a un grupo usando la contraseña con:

newgrp nombregrupo

#Si el usuario no pertenece al grupo, se le pedirá la contraseña:
Password:

#Después de ingresar la contraseña correcta, el usuario cambiará a un shell donde pertenece a ese grupo.
id

#Esto permite al usuario acceder a archivos y directorios que requieren pertenencia al grupo sin cambiar la configuración permanentemente.

##¿Cómo eliminar la contraseña de un grupo?
Si ya no deseas que el grupo tenga una contraseña, usa:
sudo gpasswd -r grupo

¿Cuándo usar una contraseña de grupo?
✅ Para permitir acceso temporal a un grupo sin modificar /etc/group.
✅ En entornos multiusuario donde no quieres depender de root para cambiar membresías.
✅ Para facilitar colaboración en archivos protegidos por grupos sin intervención de administradores.


#Diferencias entre gpasswd y usermod -aG
Comando	¿Qué hace?	Requiere root
gpasswd	Asigna una contraseña temporal para acceder a un grupo con newgrp.	❌ No (los usuarios pueden unirse con contraseña).
usermod -aG grupo usuario	Agrega permanentemente un usuario a un grupo.	✅ Sí (solo root puede ejecutarlo


##Si el usuario operador esta en otro grupo por ejemplo sistemas, para añadirlo al grupo informatica y no quitarlo del groupo sistemas:

usermod -aG informatica operador

##Opciones

usermod → modifica la configuración de un usuario.
-a → (append) añade el usuario a los grupos especificados, sin quitarlo de los que ya tenía.
-G informatica → indica el grupo adicional al que se añadirá el usuario.
operador → es el nombre del usuario que se va a modificar.




Adduser y useradd agregan usuarios al sistema, pero adduser automáticamente crea carpetas de inicio y configura otras opciones, mientras que useradd solo crea el usuario. Deluser y groupdel eliminan usuarios y grupos con opciones para eliminar directorios, mientras que userdel y groupdel solo eliminan la entrada.


##adduser:
Es un script: adduser es un script más amigable e interactivo, que automatiza la creación de un usuario, disponible en muchas distribuciones Linux, especialmente las basadas en Debian (como Ubuntu).
Interfaz interactiva: Durante su ejecución, te guiará a través de un asistente interactivo que te pedirá información, como el nombre del usuario, la contraseña, y otros detalles opcionales.
Automatiza la configuración: Crea automáticamente el directorio personal del usuario, asigna un shell de inicio predeterminado, y añade al usuario a grupos predeterminados.
Amigable para administradores: Es ideal para administradores de sistemas que desean una forma rápida y fácil de añadir usuarios con configuraciones por defecto.


## useradd:
Es un binario: useradd es una herramienta más básica que forma parte del núcleo de las utilidades del sistema y ofrece un control más granular sobre el proceso de creación de usuarios.
No es interactivo: No proporciona un asistente ni interacción. Todo se configura a través de opciones que debes pasar al comando.
Configuración manual: No crea el directorio personal automáticamente ni asigna un shell de inicio, a menos que se lo indiques con opciones como -m (crear directorio personal) o -s (asignar shell).
Más flexible: Ofrece mayor control para scripts o situaciones en las que se necesita un manejo más detallado de la creación del usuario.

##Comparación directa:
##Característica	adduser	                useradd
Tipo	Script más amigable e interactivo.	Comando básico del sistema, no interactivo.
Interactividad	Asistente interactivo que pide detalles.	Sin interacción, requiere opciones adicionales.
Directorio personal	Lo crea automáticamente.	No lo crea a menos que uses -m.
Shell de inicio	Asigna uno por defecto (normalmente /bin/bash).	No asigna uno por defecto, se debe usar -s.
Solicitud de contraseña	Solicita la contraseña del usuario al crearlo.	No solicita contraseña, debes establecerla por separado.
Complejidad	Simplificado para uso general.	Requiere configuraciones más detalladas.
Uso común	Administradores que buscan facilidad y rapidez.	Control detallado y scripts de automatización.

---------------------------------------------------------------------------------------------------------------
##El comando su –
Hay otra forma de cambiar al usuario root, y sería ejecutando el comando su -:

El comando su y su - en Linux se utilizan para cambiar de usuario en el sistema, pero tienen comportamientos diferentes en cuanto al entorno del usuario al que se cambia. A continuación, te explico las diferencias clave entre ambos:

#su (sin guion):
Cambia de usuario sin cargar completamente el entorno de inicio de sesión del nuevo usuario.
Mantiene el entorno actual del usuario que ejecuta el comando (variables de entorno, directorio actual, etc.).
El directorio de trabajo permanece siendo el directorio del usuario desde el que ejecutaste su.

#su - (con guion):
Cambia de usuario y carga completamente el entorno de inicio de sesión del nuevo usuario (como si hubieras iniciado sesión directamente como ese usuario).
Carga el entorno completo del nuevo usuario, incluyendo las variables de entorno, el directorio de inicio, y archivos de configuración como .bashrc o .profile.
El directorio de trabajo cambia al directorio personal (home) del nuevo usuario.

#¿Cuándo usar uno u otro?
su: Útil cuando solo quieres cambiar de usuario para ejecutar algunos comandos, pero no necesitas el entorno completo del nuevo usuario. Ideal para cambiar rápidamente de usuario mientras mantienes tu contexto actual.

su -: Útil cuando necesitas cambiar de usuario y quieres cargar completamente el entorno de ese usuario, especialmente cuando trabajas como root. Es el equivalente a iniciar sesión como ese usuario directamente.

#Resumen:
su: Cambia de usuario pero mantiene el entorno y el directorio del usuario anterior.
su -: Cambia de usuario y carga completamente el entorno de inicio del nuevo usuario, incluyendo el directorio home y las configuraciones del shell.

#sudo
El comando sudo su en Linux se utiliza para cambiar al usuario root o a otro usuario, obteniendo los privilegios de superusuario (root) a través de sudo. A diferencia de sudo -i, no carga el entorno completo del usuario root o del usuario especificado, pero te otorga una sesión con los permisos de root.

#¿Qué hace sudo su?
sudo: Ejecuta comandos con privilegios de superusuario.
su: Significa "substitute user" (sustituir usuario) y permite cambiar de usuario en el sistema. Si no especificas un usuario, por defecto cambia a root.

El comando sudo su te da acceso a una sesión como root, pero sin cargar completamente el entorno de inicio de sesión del usuario root. En lugar de cargar el entorno completo de root (como las configuraciones definidas en /root/.bashrc, /root/.profile, etc.), simplemente cambia de usuario a root, manteniendo gran parte del entorno actual.

Al ejecutar el comando con sudo, solo tendremos que introducir la contraseña de usuario. Una vez hecho esto, el comando su se ejecutará como root, lo que significa que no se requiere de ninguna contraseña.

#Tedriamos que utilizar:
sudo su -

El comando sg (substitute group) es idéntico a su, pero emplea un nombre de grupo como argumento.

El comando sudo -i en Linux se utiliza para abrir una sesión de shell como el usuario root (o un usuario especificado), accediendo a un entorno de inicio completo, similar a cuando inicias sesión directamente como ese usuario.

#¿Qué hace sudo -i?
sudo: Ejecuta comandos con privilegios de superusuario (root).
-i: Activa el entorno de inicio de sesión completo (login shell) del usuario especificado, que por defecto es el usuario root.



###Monitorizar usuarios en Linux:

##Registro de conexiones al servidor a traves de ssh o local:

##Redhat
tail -f /var/log/secure

##Debian y derivados:
tail -f /var/log/auth.log

------------------------------------------------------------------------------------------------
#Averiguar la ultima conexion del usario root y vagrant
lastlog --user root
lastlog --user operador

#Averiguar los logs fallidos en el sistema
• btmp: log que almacena un registro de los accesos fallidos al sistema
• wtmp: log que almacena un registro de los accesos al sistema

utmpdump /var/log/btmp
utmpdump /var/log/wtmp

##Comandos para ver usuarios conetados en el sistema linux:

who	Muestra los usuarios actualmente conectados.
w	Muestra usuarios conectados y sus actividades actuales.
last	Muestra el historial de inicios de sesión.
lastlog	Muestra el último inicio de sesión de cada usuario.
whoami	Muestra el nombre del usuario actual.
id	Muestra el UID, GID y grupos del usuario actual.
finger	Muestra información detallada sobre un usuario.
uptime	Muestra el tiempo de actividad del sistema y el número de usuarios conectados.
ps aux	Muestra todos los procesos del sistema, incluyendo los de los usuarios.
watch	Ejecuta un comando repetidamente para monitorear en tiempo real.
pkill -KILL -u	Termina todos los procesos de un usuario específico.


#loginctl
loginctl  es una herramienta utilizada en sistemas Linux que usan systemd para interactuar y gestionar las sesiones de usuarios, asientos y otros elementos relacionados con el inicio de sesión. Es muy útil para monitorear y administrar las sesiones de usuarios en sistemas que emplean systemd-logind, el servicio que se encarga de gestionar el inicio y cierre de sesiones

#getent
El comando getent se utiliza para consultar bases de datos administradas por la biblioteca del sistema, como las bases de datos de usuarios, grupos, hosts, servicios y más. Aquí te explico cómo usarlo:

getent passwd usuario
getent group grupo


