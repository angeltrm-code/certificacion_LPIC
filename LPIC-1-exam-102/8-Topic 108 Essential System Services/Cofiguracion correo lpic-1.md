**108.3 Conceptos básicos del Agente de Transferencia de Correo

# Correo electrónico pagina 441 pdf manual del curso:

SMTP (Simple Mail Transfer Protocol) es un protocolo estándar para el envío de correos electrónicos a través de Internet. Se utiliza para transferir mensajes de correo electrónico entre servidores de correo y también desde un cliente de correo (como Outlook o Thunderbird) hacia un servidor de correo. SMTP trabaja en conjunto con otros protocolos como IMAP o POP3 para la recepción de correos electrónicos.

(postfix, sendmail, exim, qmail) 
25 smtp
465 SMTPS (SMTP sobre SSL).

POP3 110  Dovecot
IMAP 143 

# Tenemos una tarea programada y queremos que la envie por correo
0 3 * * * /scripts/backup.sh 2>&1 |mail -s "Backup servidorA" usuario@empresa.es oracle
0 3 * * * usuario1  /scripts/backup.sh 2>&1 |mail -s "Backup servidorA"  berto alberto@rootdesdezero.com


# SMART_HOST
El término SMART_HOST Relay hace referencia a la configuración de un servidor de correo que redirige o retransmite los correos salientes a través de un servidor de correo intermedio, conocido como Smart Host. Esta técnica se utiliza comúnmente en situaciones donde el servidor de correo interno no puede entregar correos directamente a los destinatarios finales, o cuando deseas que el correo saliente pase por un servidor SMTP externo.

# ¿Qué es un Smart Host?
Un Smart Host es un servidor SMTP externo o intermedio que acepta correos electrónicos de un servidor de correo interno y luego los retransmite al servidor de destino final. Esto es útil en varias situaciones:

ISP Bloquea el Puerto 25: Algunos proveedores de Internet bloquean el puerto 25 para evitar el spam. Al usar un Smart Host en el puerto 587 o 465 (SMTP con autenticación y cifrado), puedes eludir este bloqueo.
Filtros de correo saliente: Algunas empresas prefieren que todos los correos pasen por un servidor de correo externo para aplicar políticas de seguridad, como filtrado de spam o archivado.

Mejora de la entrega de correo: Un Smart Host puede tener mejores relaciones con otros servidores de correo, lo que aumenta la probabilidad de que los correos no se marquen como spam.

# Instalar sendmail para configurarlo como  SMART_HOST Relay, sin autenticacion:

yum install -y sendmail sendmail-cf
apt install -y sendmail sendmail-cf

# Configurando senmail como SMART_HOST Relay, en la line 26 de fichero quitar el dnl que es comentario:
vi /etc/mail/sendmail.mc

# Descomentamos la linea quitando en dnl define(`SMART_HOST', `smtp.miempresa.com')dnl

define(`SMART_HOST', `smtp.miempresa.com')dnl

make -C /etc/mail
# El comando make -C /etc/mail, pasa los cambios del archivo /etc/mail/sendmail.mc  a /etc/mail/sendmail.cf

# Tener resuelto nustra mv de linux 192.168.33.10:
vi /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.33.10 centos7.curso.local centos7


systemctl restart sendmail
systemctl status sendmail
systemctl enable sendmail

 netstat -ptan |grep  -w 25
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      2700/sendmail: acce
------------------------------------------------------------------------------------------------------

# /etc/aliases
El archivo /etc/aliases se usa para crear alias de correo local en el sistema.

# Permite redirigir emails enviados a un usuario local hacia:
Otro usuario
Varios usuarios
Una dirección externa
Un programa

# Se usa junto con servidores de correo como:
Postfix
Sendmail

# Este archivo permite crear alias de correo y listas de correo, ejemplo:
vi /etc/aliases
root:           usuariolocal
operador:        berto
sorporte:		berto
informatica:    berto, usu1, usu2, alberto@rootdesdezero.com, usuario@gmail.com
barcelona:      berto, root, vagrant


# newaliases
El comando newaliases se utiliza en sistemas que emplean Sendmail o Postfix para actualizar o reconstruir la base de datos de aliases de correo electrónico a partir del archivo de configuración de aliases, comúnmente ubicado en /etc/aliases.

# Para aplicar los cambios en el archivo /etc/aliases:
newaliases

Pasa los cambios del fichero /etc/aliases a /etc/aliases.db

# Para mandar un correo a la lista:
mail barcelona


**Para montar listas de correo electronico a nivel profesional utilizaramos en linux mailman.
--------------------------------------------------------------------------------------------------------
# El comando mailq permite ver las colas del correo electronico por si los correos estan encolados:
mailq
/var/spool/mqueue is empty

tail -f /var/log/maillog




# Tenemos una tarea programada y queremo que la envie por correo
0 3 * * * /scripts/backuporacle.sh 2>&1 |mail -s "Backup oracle database empresa"  oracle


# ~/.forward en Linux

El archivo ~/.forward (dentro del home de un usuario) se usa para redirigir el correo local de ese usuario a otra dirección.

Es una alternativa personal a /etc/aliases, pero afecta solo a ese usuario.

Este archivo se crea en el home del usuario local (/etc/passwd) y se pone un correo al que renviar los correos entrantes del usuario local de linux.
~/.forward

# Ejemplo, para el oracle
vi /home/oracle/.forward
usuario1@gmail.com

El símbolo ~ se utiliza comúnmente en sistemas Unix y Linux para representar el directorio personal del usuario actual. Es un atajo conveniente en la línea de comandos para acceder a tu home directory sin tener que escribir la ruta completa.

------------------------------------------------------------------
# Tenemos una tarea programada y queremos que la envie por correo
0 3 * * * /scripts/backup.sh 2>&1 |mail -s "Backup servidorA" usuario@empresa.es oracle
0 3 * * * usuario1  /scripts/backup.sh 2>&1 |mail -s "Backup servidorA"  berto alberto@rootdesdezero.com


# Utilizar el cliente mail

El comando mail en Linux se usa para enviar y recibir correos electrónicos desde la terminal. Es una herramienta simple que depende de un servidor de correo (como Sendmail, Postfix o Exim) para el envío de mensajes.

yum install mailx -y


# Para enviar correo a usuarios locales del sistema operativo /etc/passwd
mail usuario1
mail usuario1@gmail.com

# Para visualizar nuestro correo
mail

# Para visualizar todos los correos dentro del cliente mail:
mail
f*


# Para comprobar si mi smtp (sendmail), esta enviado correos:
tail -f /var/log/maillog


# Para enviar correo a ususario externos, tener configurado en servidor SMART_HOST Relay con Officce 365 o gmail:
https://medium.com/@iced_burn/office365-as-a-smart-host-with-postfix-84d2e8e7b688
mail ususario@correo.es

# Para enviar correos
mail usuario
Subject
Escribimos el cuerpo del mensaje
.     # El . es para finalizar el correo


tail -f /var/log/maillog
-------------------------------------------------------------------------------------------------------
# Crearme una lita de correo con aliases
 vi /etc/aliases
sistemas:        berto, usuario1, usuario@gmail.com
administrador:	berto	

# Pasa los cambios del fichero /etc/aliases a /etc/aliases.db
newaliases

# Envio el correo:
mail sistemas

# Ahora el usuario berto tendria que ver que le llega el correo
su - berto
mail


---------------------------------------------------------------------------------------------------------------
# Ejemplo SMART_HOST relay en Postfix utilizando Office 365 NO REALIZAR ES ESTE CURSO:

Configurar un SMART_HOST relay en Postfix utilizando Office 365 como servidor de correo saliente en Rocky Linux 8, sigue estos pasos:

sudo dnf install postfix cyrus-sasl-plain mailx -y


vi /etc/postfix/main.cf
#  Configuración básica
myhostname = mail.tudominio.com
mydomain = tudominio.com
myorigin = $mydomain
inet_interfaces = 127.0.0.1
inet_protocols = ipv4
mydestination = $myhostname, localhost.$mydomain, localhost
relayhost = [smtp.office365.com]:587

#  Autenticación con Office 365
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_sasl_tls_security_options = noanonymous
smtp_tls_CAfile = /etc/ssl/certs/ca-bundle.crt
smtp_use_tls = yes

#  Soporte para nombres completos en encabezados
smtp_header_checks = regexp:/etc/postfix/header_checks



# Configuración de Autenticación SASL
vi /etc/postfix/sasl_passwd
[smtp.office365.com]:587  usuario@tudominio.com:password

# Cambiar los permisos del archivo:
sudo chmod 600 /etc/postfix/sasl_passwd

# Generar el archivo hash:
sudo postmap /etc/postfix/sasl_passwd

# Configuración de Encabezados (Opcional)
Algunos encabezados pueden causar problemas con Office 365. Configura la eliminación de encabezados conflictivos:

vi /etc/postfix/header_checks
/^Received:/ IGNORE
/^X-Originating-IP:/ IGNORE
/^X-Mailer:/ IGNORE
/^Mime-Version:/ IGNORE


# Compilar el archivo:
sudo postmap /etc/postfix/header_checks

# Habilitar y Reiniciar Postfix
sudo systemctl enable postfix
sudo systemctl restart postfix

# Correo de Prueba:
echo "Correo de prueba desde Postfix con Office 365" | mail -s "Prueba Postfix" destinatario@dominio.com

sudo tail -f /var/log/maillog


# Solución de Problemas Comunes
# Error de Autenticación:
Si encuentras errores relacionados con la autenticación (Relay access denied o 5.7.57 Client not authenticated):
Verifica el nombre de usuario y la contraseña en /etc/postfix/sasl_passwd.
Verifica la configuración de seguridad de tu cuenta en Office 365.

# Errores de TLS:
Si el log muestra problemas de TLS:
Asegúrate de que tu certificado raíz está en /etc/ssl/certs/ca-bundle.crt.
Verifica que el paquete cyrus-sasl-plain esté instalado.

# Resumen
Instala Postfix y las dependencias necesarias.
Configura main.cf para utilizar Office 365 como relayhost.
Configura la autenticación SASL con el archivo sasl_passwd.
Habilita el uso de TLS y ajusta los encabezados si es necesario.
Prueba el envío y verifica los registros para confirmar el funcionamiento.