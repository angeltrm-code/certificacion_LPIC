##Explicacion pagina 419 Manual del curso LPIC-1
yum install xinetd -y
yum install  telnet-server -y
/etc/xinetd.d

vi /etc/xinetd.d/telnet
# default: on
# description: The telnet server serves telnet sessions; it uses \
#       unencrypted username/password pairs for authentication.
service telnet
{
        flags           = REUSE
        socket_type     = stream
        wait            = no
        user            = root
        server          = /usr/sbin/in.telnetd
        log_on_failure  += USERID
        disable         = no
}





systemctl restart xinetd

# netstat -putana |grep -w 23
tcp6       0      0 :::23                   :::*                    LISTEN      15851/xinetd

------------------------------------------------------------------------------------
La primera línea de comentario, default, tiene una importancia particular.
 No la interpreta xinetd, sino ntsysv o chkconfig, para determinar si el servicio está activo. 
 • service: nombre del servicio que corresponde a un servicio definido en /etc/services.
 • flags: atributos para la conexión. REUSE indica que se volverá a utilizar el socket para una conexión telnet. 
 • socket_type: especifica el tipo de socket. 
En general, stream (tcp) o dgram (udp). Una conexión directa IP se hace por raw.

• wait: indica si el servidor es single-threaded (yes) o multi-threaded (no). 
• user: con qué cuenta de usuario se iniciará el servicio. • server: ruta del ejecutable que se debe iniciar. 
• log_on_failure: el += indica que se añade la opción asociada al archivo de traza, además de las opciones por defecto. Aquí: el login. • disable: indica si el servicio está activo o no. Algunas opciones pueden mejorar las condiciones de acceso y la seguridad: 
• only_from: permite el acceso únicamente a los anfitriones especificados.
• no_access: impide el acceso a los anfitriones especificados (p. ej.: 172.16.17.0/24).
• access_times: autoriza el acceso únicamente en una franja horaria dada (p.ej.: 09:00-18:30).


