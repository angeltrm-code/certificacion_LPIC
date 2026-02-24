**108.2 Registros del sistema

#Logrotate
Logrotate es un estándar en sistemas Linux. Con esta herramienta, podremos especificar todo tipo de parámetros a la hora de administrar nuestros logs, para rotarlos.

logrotate es una herramienta en sistemas Linux utilizada para la gestión y rotación de archivos de registro (logs). Su objetivo principal es archivar, comprimir, eliminar o enviar archivos de registro antiguos para mantener el almacenamiento bajo control y garantizar que los archivos de log no crezcan indefinidamente.

#¿Por qué usar logrotate?
Gestión de espacio en disco: Evita que los archivos de log ocupen todo el almacenamiento.
Automatización: Realiza la rotación, compresión y eliminación de logs automáticamente.
Mantenimiento de históricos: Guarda archivos antiguos comprimidos para referencia futura.
Flexibilidad: Soporta configuraciones personalizadas para diferentes aplicaciones y servicios.

#Arquitectura de logrotate
logrotate utiliza archivos de configuración para definir:

#Frecuencia de rotación:
Diario, semanal, mensual, etc.
Cantidad de archivos a retener.
Compresión de logs.
Acciones posteriores (como reiniciar servicios).


/var/log

/etc/logrotate.conf	Archivo de configuración global.
/etc/logrotate.d/	Directorio que contiene configuraciones específicas por servicio.

El archivo /etc/logrotate.conf es la configuración principal de logrotate en sistemas Linux. Define directivas globales y puede incluir archivos adicionales (como los de /etc/logrotate.d/).

logrotate
cat /etc/logrotate.conf
ls -l /etc/logrotate.d/

cat /etc/logrotate.d/httpd
/var/log/httpd/*log {
    missingok
    notifempty
    sharedscripts
    delaycompress
    postrotate
        /bin/systemctl reload httpd.service > /dev/null 2>/dev/null || true
    endscript
}




/var/log/httpd/*log
Indica que todos los archivos de logs dentro de /var/log/httpd/ que terminen en log serán rotados.

2. missingok
No muestra errores si los archivos de log no existen.

3. notifempty
No rota el archivo si está vacío.

4. sharedscripts
Ejecuta los scripts solo una vez por rotación, sin importar cuántos archivos de log se hayan rotado.

5. delaycompress
No comprime los logs inmediatamente después de la rotación.

La compresión se hace en la siguiente rotación (útil si el servicio aún escribe en el log después de la rotación).

6. postrotate / endscript

systemctl reload httpd.service → Recarga Apache (httpd) para que comience a escribir en los nuevos archivos de log.
> /dev/null 2>/dev/null → Silencia la salida estándar y los errores.
|| true → Evita que un fallo en el comando detenga logrotate.



cat /etc/logrotate.conf
## Rotación global
weekly               # Rotar semanalmente
rotate 4             # Mantener 4 archivos de respaldo
create                # Crear un nuevo archivo de log vacío después de rotar
compress             # Comprimir logs rotados con gzip
include /etc/logrotate.d/ # Incluir configuraciones adicionales


##Modificamos el syslog, que trabaja con los logs, rotamos diariamente y a un tamaño:
cat /etc/logrotate.d/syslog

/var/log/cron /var/log/maillog /var/log/messages /var/log/secure /var/log/spooler /var/log/supervisamem.log {
        missingok
        sharedscripts
        postrotate
        /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
        endscript
        maxsize 100M
}



###Con esto debe generar un archivo compreso en la carpeta /var/log/ (si es que no cambiamos la ruta de los log).

logrotate -f /etc/logrotate.conf


##Ejemplos:
cat /etc/logrotate.d/httpd

/var/log/httpd/*log {
    missingok
    notifempty
    sharedscripts
    delaycompress
    postrotate
        /bin/systemctl reload httpd.service > /dev/null 2>/dev/null || true
    endscript
}

#Descripción del bloque:
/var/log/httpd/*log: Especifica que la configuración de rotación de logs se aplicará a todos los archivos de log de Apache ubicados en el directorio /var/log/httpd/, como access_log o error_log.

missingok: Si no se encuentra el archivo de log, no se genera un error, lo que evita problemas si algún archivo no existe en el momento de la rotación.

notifempty: No rota los archivos de log si están vacíos. Esto evita la rotación innecesaria de logs que no contienen datos.

sharedscripts: Asegura que los scripts (como el de post-rotación) se ejecuten solo una vez por ciclo de rotación, sin importar cuántos archivos de log se roten en ese momento.

delaycompress: Retrasa la compresión de los archivos de log hasta el siguiente ciclo de rotación. Esto significa que el archivo recién rotado no será comprimido inmediatamente, sino en la próxima rotación. Esto es útil cuando se necesita acceder a los archivos recién rotados sin compresión.

postrotate: Define un bloque de comandos que se ejecutan después de que se roten los archivos de log.

/bin/systemctl reload httpd.service > /dev/null 2>/dev/null || true: Este comando recarga el servicio de Apache HTTPD. Esto es necesario para que Apache deje de escribir en los archivos de log rotados y comience a escribir en los nuevos archivos de log. El redireccionamiento > /dev/null 2>/dev/null asegura que cualquier salida (estándar y de error) se descarte, y || true garantiza que el script continúe incluso si el comando falla.
endscript: Indica el final del bloque de postrotate.


logrotate es una herramienta en Linux que gestiona la rotación y compresión de logs para evitar que crezcan demasiado. Los parámetros size, minsize y maxsize controlan cuándo se debe rotar un archivo de log según su tamaño.

#size (Tamaño Exacto para Rotar)
Define el tamaño mínimo que un archivo debe alcanzar para rotarse.
No se basa en la frecuencia (diario, semanal, etc.), solo en el tamaño.

Formato: size <valor> (puede ser KB, MB o GB).
/var/log/app.log {
    size 10M
    rotate 5
    compress
}
Se rotará cuando app.log alcance 10MB, sin importar el tiempo transcurrido.


#minsize (Tamaño Mínimo, pero con Frecuencia)
Similar a size, pero considera la frecuencia (daily, weekly, monthly).
Se rotará solo si el tamaño supera minsize en el periodo definido.
Ejemplo:
/var/log/app.log {
    daily
    minsize 5M
    rotate 7
    compress
}

🔹 El log se rotará si tiene al menos 5MB al finalizar el día.
🔹 Si no alcanza 5MB, se espera al siguiente día.


#maxsize (Tamaño Máximo Absoluto)
Forza la rotación cuando el log supera un tamaño determinado.
Ignora la frecuencia (daily, weekly, etc.) y se ejecuta en la próxima verificación.

/var/log/app.log {
    weekly
    maxsize 50M
    rotate 7
    compress
}
El log se rotará automáticamente si supera 50MB, incluso antes de cumplirse la semana.


##Conclusión
Usa size si solo quieres rotar logs basado en su tamaño.
Usa minsize si quieres combinar tamaño + frecuencia.
Usa maxsize para limitar el tamaño máximo sin esperar la frecuencia.

/var/log/logpath/*.log {
    maxsize 50M
    hourly
    missingok
    rotate 8
    compress
    notifempty
    nocreate
}



##Tamaño o día lo que ocurra primero rotara los archivos:
vi /etc/logrotate.d/tomcat

/tomcat-9/logs/*.log {
        daily
        missingok
        copytruncate
        rotate 7
        missingok
        compress
        size 50M
}


##Descripción de las opciones:
/tomcat-9/logs/*.log: Aplica la configuración a todos los archivos de log en el directorio /tomcat-9/logs/ que terminen con .log.

daily: Realiza la rotación diariamente, es decir, al final de cada día, los logs serán rotados.

missingok: Si alguno de los archivos de log no existe, logrotate no mostrará un error, simplemente pasará al siguiente archivo.

copytruncate: Hace una copia del archivo actual y luego lo trunca (lo vacía) en lugar de renombrarlo y crear uno nuevo. Esto es útil cuando no quieres reiniciar el servicio o cuando el servicio sigue escribiendo en el mismo archivo.

rotate 7: Conserva los últimos 7 archivos de log rotados. Los archivos más antiguos serán eliminados después de la séptima rotación.

compress: Comprime los archivos rotados para ahorrar espacio en disco. Por defecto, se usa gzip.

size 50M: Si el archivo de log alcanza los 50MB antes de que se cumpla el ciclo diario, se rotará el archivo. Esto asegura que los logs no crezcan demasiado entre rotaciones.

#Funcionamiento en conjunto:
Este bloque de configuración rotará los archivos de log de Tomcat diariamente o cuando el archivo alcance 50MB, lo que ocurra primero. Mantendrá los últimos 7 archivos rotados y comprimidos, eliminando los más antiguos. Además, el uso de copytruncate permite que el archivo de log sea truncado sin tener que reiniciar el servicio de Tomcat, lo cual es útil para no interrumpir el servicio mientras se realiza la rotación.

##Para ver que la configuracion anterior funciona:
logrotate -f /etc/logrotate.d/tomcat


Este comando se utiliza para forzar la rotación manual de los archivos de log según la configuración especificada en el archivo /etc/logrotate.conf. El flag -f significa "force" y obliga a que la rotación se realice incluso si los archivos no cumplen con los criterios habituales (como la fecha o el tamaño).

logrotate -f /etc/logrotate.conf


El flag -d (o --debug) en logrotate se utiliza para ejecutar una simulación de rotación sin realizar ninguna acción real. Es decir, no rota los archivos, no los comprime ni los elimina, sino que muestra en pantalla qué haría si se ejecutara normalmente.

logrotate -d -v /etc/logrotate.conf
logrotate -d -v /etc/logrotate.d/tomcat

#¿Cuándo usar logrotate -d?
Verificar la Configuración: Para comprobar si el archivo de configuración de logrotate está correcto.
Depuración de Problemas: Si los archivos de log no se están rotando correctamente, puedes usar el modo de depuración para ver qué está pasando.
Simulación de Rotación: Útil para entender cómo se comportará el sistema antes de hacer cambios permanentes.

###Salida de Ejemplo:
reading config file /etc/logrotate.conf
including /etc/logrotate.d
reading config file nginx
reading config info for /var/log/nginx/*.log
logrotate debug: state file /var/lib/logrotate/status reads:
logrotate debug: keyword 'weekly' seen in config file
logrotate debug: keyword 'rotate' seen in config file
logrotate debug: keyword 'compress' seen in config file
logrotate debug: keyword 'delaycompress' seen in config file
logrotate debug: keyword 'missingok' seen in config file
logrotate debug: keyword 'notifempty' seen in config file
logrotate debug: keyword 'create' seen in config file
logrotate debug: keyword 'postrotate' seen in config file
logrotate debug: keyword 'endscript' seen in config file

considering log /var/log/nginx/access.log
  log needs rotating (log has been rotated at Mon Mar 17 00:00:00 2024, rotation count 7)


##Consejos Útiles
Siempre probar antes de ejecutar realmente: Utiliza -d para verificar configuraciones nuevas o modificadas antes de realizar rotaciones forzadas.

Evita ejecuciones en producción sin verificar: El uso de -d reduce el riesgo de rotar accidentalmente archivos importantes.

Combínalo con -v para mayor detalle: La combinación de -d y -v proporciona el máximo nivel de información para depuración.


olddir /opt/copias

Esta directiva hace que solo los archivos rotados (por ejemplo catalina.log.1, catalina.log.2.gz, etc.) se muevan automáticamente al directorio indicado.


tomcat-9/logs/*.log {
        daily
        missingok
        copytruncate
        rotate 7
        compress
        size 50M
        olddir /opt/copias
}

mkdir -p /opt/copias
chown root:root /opt/copias
chmod 755 /opt/copias

#Restricción importante:
olddir solo funciona si los ficheros rotados y el directorio destino están en el mismo filesystem.

Ejemplo:
/tomcat-9/logs → ext4
/opt/copias → ext4

Funciona.
Pero si:
/tomcat-9/logs → ext4
/opt/copias → NFS, XFS, LVM separado, etc.
entonces no funcionará, porque logrotate usa un simple rename() y este no permite mover entre sistemas de ficheros distintos.



Con copytruncate funciona sin problema
copytruncate copia el archivo y lo trunca antes de moverlo a /opt/copias, así que no hay conflictos con Tomcat.
Los logs seguirán apareciendo así en /opt/copias:
catalina.log.1
catalina.log.2.gz
catalina.log.3.gz

/tomcat-9/logs/*.log {

        # Revisa estos logs cada día
        daily

        # No da error si el log no existe
        missingok

        # Copia el log y trunca el original para que Tomcat siga escribiendo
        copytruncate

        # Mantiene 7 rotaciones del log
        rotate 7

        # Comprime las rotaciones (gzip)
        compress

        # Solo rota si el log pesa al menos 50 MB
        size 50M

        # Mueve los logs rotados a /opt/copias
        # (debe ser mismo filesystem y el directorio debe existir)
        olddir /opt/copias
}


Ejemplo Script ejecutado después de rotar los logs  postrotate, para mover los logs rotados a otro filesystem

/tomcat-9/logs/*.log {

        # Revisar estos logs cada día
        daily

        # No mostrar error si no existe el log
        missingok

        # Copiar el log y truncarlo para que Tomcat siga escribiendo
        copytruncate

        # Mantener 7 rotaciones
        rotate 7

        # Comprimir con gzip las rotaciones
        compress

        # Solo rotar si el log pesa al menos 50 MB
        size 50M

        # Script ejecutado después de rotar los logs
        postrotate
                # Esperar un momento para que logrotate termine de crear los .1 y .gz
                sleep 1

                # Mover todos los archivos rotados (*.1 y *.gz) a /opt/copias
                # Esto mueve SOLO los logs rotados, no el log activo
                /bin/mv -f /tomcat-9/logs/*.1 /opt/copias/ 2>/dev/null || true
                /bin/mv -f /tomcat-9/logs/*.gz /opt/copias/ 2>/dev/null || true

                # Si quieres mover logs con extensiones específicas, podrías usar:
                # /bin/mv -f /tomcat-9/logs/*log-* /opt/copias/ 2>/dev/null || true
        endscript
}





En logrotate, el archivo de marca de tiempo es utilizado para registrar la última vez que se rotaron los logs. Este archivo permite que logrotate decida si debe realizar una nueva rotación basándose en la configuración especificada (como diaria, semanal o mensual).

##Ubicación del Fichero de Marca de Tiempo
El archivo de marca de tiempo por defecto se encuentra en:
/var/lib/logrotate/status
/var/lib/logrotate/logrotate.status


Este archivo contiene la información sobre la última rotación de cada archivo de log gestionado por logrotate.

Formato del Archivo de Marca de Tiempo

#El contenido del archivo status tiene el siguiente formato:
logrotate state -- version 2
"/var/log/nginx/access.log" 2025-03-23-03:15:01
"/var/log/nginx/error.log" 2025-03-23-03:15:01
"/var/log/syslog" 2025-03-23-03:15:01
"/var/log/auth.log" 2025-03-23-03:15:01
"/var/log/cron.log" 2025-03-23-03:15:01


##Explicación:
Ruta del archivo de log: Entre comillas dobles.
Marca de tiempo: Fecha y hora de la última rotación en formato AAAA-MM-DD-HH:MM:SS.


##Eliminar el Archivo de Marca de Tiempo
#Si deseas forzar que todos los logs se roten la próxima vez que se ejecute logrotate, puedes eliminar el archivo de estado:

rm -rf  /var/lib/logrotate/logrotate.status

#Luego, ejecuta manualmente:
logrotate -f /etc/logrotate.conf


#Cambiar la Ubicación del Archivo de Estado
#Puedes cambiar la ubicación del archivo de estado en el archivo de configuración global: 

vi /etc/logrotate.conf
statefile /var/lib/logrotate/mi_estado

#¿Qué pasa si se borra el archivo de estado?
Si el archivo de estado es eliminado:
Logrotate rotará todos los archivos en la próxima ejecución, ya que no tiene registros previos.

Se creará un nuevo archivo de estado después de la rotación.
Esto puede provocar rotación doble si se ejecuta manualmente poco después de una rotación automática.