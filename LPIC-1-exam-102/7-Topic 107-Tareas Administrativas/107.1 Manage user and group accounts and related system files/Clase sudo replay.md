# Clase sudo replay

Apuntes de clase sobre Clase sudo replay, reorganizados para facilitar la consulta rápida y el repaso.

## Clase Sudo:

El comando sudo (Superuser Do) permite a un usuario ejecutar comandos con privilegios elevados sin necesidad de cambiar a la cuenta root. Es una herramienta fundamental para la administración segura del sistema.

## ¿Cómo funciona sudo? Cuando un usuario ejecuta: sudo comando

sudo verifica si el usuario está en la lista de usuarios permitidos en /etc/sudoers. Si el usuario tiene permisos, ejecuta el comando con privilegios de root.

Si es la primera vez en la sesión, pedirá la contraseña del usuario (no la de root). La autenticación se almacena temporalmente (por defecto 5 minutos) antes de volver a solicitar la contraseña.

```bash
yum install httpd -y
```

### tail -f /var/log/secure ##  en Redhat

tail -f  /var/log/auth.log ##  in Debian

## La opción NOEXEC

La opción NOEXEC en las configuraciones de sudoers se utiliza para impedir que un usuario ejecute programas adicionales desde un comando que se haya permitido con sudo. En otras palabras, si a un usuario se le concede permiso para ejecutar un comando con sudo con la opción NOEXEC, ese usuario no podrá lanzar otros programas desde el comando que se le permitió.

Por ejemplo, si un usuario tiene permiso para usar sudo para abrir un editor de texto como vim, sin la opción NOEXEC, podría desde allí ejecutar un shell como bash y obtener acceso a comandos adicionales con privilegios de superusuario. Con la opción NOEXEC, este comportamiento se bloquea.

¿Cómo funciona? Si un usuario ejecuta un programa con privilegios elevados usando sudo y ese programa intenta ejecutar otro programa, la opción NOEXEC previene esa acción. Esto es útil para evitar que los usuarios escapen a un shell interactivo o ejecuten otros programas cuando tienen acceso limitado a ciertos comandos con sudo.

## Sintaxis básica de una regla en sudoers:

```
usuario  HOSTS=(USUARIOS) COMANDOS
```

## Explicacion:

usuario: El nombre del usuario o grupo de usuarios (precedido por % si es un grupo) al que se le aplicará la regla. HOSTS: Indica en qué hosts (máquinas) se aplica esta regla. Normalmente, esto es ALL si se aplica en cualquier máquina donde esté disponible el archivo sudoers. USUARIOS: Los usuarios que pueden ser sustituidos al ejecutar el comando con sudo. Normalmente es ALL si puede ejecutar el comando como cualquier usuario, incluido root. COMANDOS: Los comandos que el usuario o grupo puede ejecutar con sudo. ALL indica que puede ejecutar cualquier comando.

### juan ALL=(ALL:ALL) ALL

juan: El usuario. ALL: Se aplica en cualquier host. (ALL:ALL): El usuario puede ejecutar los comandos como cualquier usuario y cualquier grupo (incluyendo root). ALL: El usuario puede ejecutar cualquier comando.

## El usuario operador con todos los privilegios

### operador ALL=(ALL) ALL

operador: Nombre del usuario. ALL: Permite a operador usar sudo desde cualquier host. (ALL): Permite ejecutar comandos como cualquier usuario. ALL: Permite ejecutar cualquier comando.

## Para nuestro laboratorio# :

visudo es el comando utilizado en sistemas Linux para editar de forma segura el archivo /etc/sudoers, que controla qué usuarios pueden ejecutar comandos con privilegios de superusuario.

### visudo

** /etc/sudoers se edita con visudo

## Al final del archivo añadimos las reglas:

```
operador  ALL = (ALL)  /bin/vi /etc/httpd/conf/httpd.conf, /usr/bin/systemctl restart httpd, /usr/bin/less,  /usr/bin/passwd [A-z]*, !/usr/bin/passwd root
```

operador ALL = (ALL)  NOEXEC: /bin/vi /etc/httpd/conf/httpd.conf, /usr/bin/systemctl restart httpd,/usr/bin/less, /bin/rm

## EJEMPLOS PARA PRODUCCION:

operador ALL = (ALL) ALL, !/bin/bash, !/bin/su, !/usr/sbin/visudo, !/usr/bin/passwd root, !/usr/bin/sudo, NOEXEC: /bin/more, /bin/vi, /usr/bin/less, /usr/bin/vim

De ser posible, evite definir ALL —todos los programas y aplicaciones del sistema— y sólo permita la ejecución de programas específicos.

## Puede definir todos los que quiera. Ejemplo:

operador ALL = (ALL) /bin/cat, /usr/bin/chgrp, /usr/bin/chmod, /usr/bin/chown, /sbin/depmod, /usr/sbin/edquota, /usr/sbin/groupadd, /usr/bin/htpasswd, /sbin/ip, /usr/bin/openssl, /usr/bin/systemctl, /usr/bin/tail, /usr/sbin/useradd, /usr/bin/passwd [A-z]*, !/usr/bin/passwd root, NOEXEC: /bin/more, /bin/vi, /usr/bin/less, /usr/bin/vim

## Como usuario para ver los permisos puedo utilizar:

sudo -l

## Comprobar la configuracion del /etc/sudoers

-c, --check              check-only mode visudo --help visudo -c

## Esta regla permite al usuario operador todos los permisos menos cambiar el password a root

operador ALL=(ALL:ALL) ALL, !/usr/bin/passwd root, !/bin/bash -c 'exec su -'

## Al grupo vagrant tiene todos los privilegios:

%vagrant ALL=(ALL) NOPASSWD: ALL vagrant ALL=(ALL) NOPASSWD: ALL

La línea %vagrant ALL=(ALL) NOPASSWD: ALL otorga a todos los usuarios del grupo vagrant permisos para ejecutar cualquier comando con sudo sin ser solicitados para ingresar su contraseña, lo que es útil en entornos automatizados o de desarrollo, pero debe aplicarse con cuidado en entornos de producción debido a posibles riesgos de seguridad.

## Diferencia entre wheel (RHEL) y sudo (Debian)

```
Distribución           Grupo de administración                      Propósito
```

Red Hat / CentOS       wheel                                       Usuarios en este grupo pueden usar sudo. Debian / Ubuntu           sudo                                           Usuarios en este grupo pueden usar sudo.

---

## Sudoreplay

El comando sudoreplay en Linux es una herramienta que se utiliza para reproducir y visualizar sesiones de comandos que fueron ejecutadas con sudo, siempre que la grabación de comandos esté habilitada en el archivo de configuración de sudoers. Esto es útil para auditorías y revisiones de seguridad, ya que permite ver exactamente qué comandos se ejecutaron y cómo interactuaron los usuarios con el sistema a través de sudo.

¿Cómo funciona sudoreplay? Cuando se habilita la grabación de sesiones de sudo en el archivo sudoers, cada vez que un usuario ejecuta un comando con sudo, se guarda un registro detallado de la sesión. Este registro incluye la salida de los comandos, así como las entradas del usuario.

El comando sudoreplay te permite reproducir esas sesiones grabadas para revisarlas posteriormente.

Puedes reproducir esas sesiones y ver que acciones han ejecutado en sudo por los usuarios:

## Activarlo en la linea 51 del archivo /etc/sudoers:

## en el vi para activar numero de lineas:

:set nu

## Tenemos que añadir el la linea 51 Defaults log_output

visudo :51

```conf
Defaults log_output
```

## Si da el error al ejecutar el comando sudoreplay -l

### sudoreplay: unable to open /var/log/sudo-io: No existe el fichero o el directorio

You need to go and create the directory as root.

```bash
mkdir -m 750 /var/log/sudo-io
```

Para visualizar la grabación que queremos reproducir sólo hemos de especificar el TSID, por ejemplo: sudoreplay -l

oct 30 19:33:44 2023 : operador : TTY=/dev/pts/7 ; CWD=/home/operador ; USER=root ; TSID=00035N ; COMMAND=/bin/vi /etc/httpd/conf/httpd.conf

sudoreplay 00035N

## En centos8:

sudo sudoreplay -l

## Pero también podemos filtrar por usuario, en este caso el usuario es operador:

sudoreplay -l user operador

## Por comando, pongamos como ejemplo nano:

sudoreplay -l command rm

## Por usuario y comando:

sudoreplay -l user operador command rm sudoreplay -l user operador -l command rm

## A partir de una fecha, en ese caso usaremos fromdate y el MES/DÍA/AÑO:

sudoreplay -l fromdate 03/11/2022 sudoreplay -l todate 03/11/2022

Pero también podemos combinarlos todos la vez, listando todos los archivos del usuario operador que haya ejecutado el comando nano a partir del 29/08/2012:

### sudoreplay -l user fer command nano fromdate 08/29/2012

Cuando no nos interese seguir grabando estas sesiones de sudo, deberemos volver a editar el archivo /etc/sudoers y volver a comentar la línea que descomentamos ó añadimos antes.

visudo

## Defaults log_output
