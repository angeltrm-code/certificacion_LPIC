# xinetd telnet

Documento de referencia para instalar y configurar el servicio `telnet` mediante `xinetd`.

> Referencia del manual del curso LPIC-1: pagina 419.

## Instalacion

```bash
yum install xinetd -y
yum install telnet-server -y
```

Directorio habitual de configuracion:

```text
/etc/xinetd.d
```

## Configuracion del servicio `telnet`

Archivo de configuracion:

```bash
vi /etc/xinetd.d/telnet
```

Contenido de ejemplo:

```conf
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
```

## Reinicio y verificacion

```bash
systemctl restart xinetd
netstat -putana |grep -w 23
```

```text
tcp6       0      0 :::23                   :::*                    LISTEN      15851/xinetd
```

## Significado de los parametros principales

La primera linea de comentario, `default`, tiene una importancia especial. No la interpreta `xinetd`, sino herramientas como `ntsysv` o `chkconfig`, que la usan para determinar si el servicio esta activo.

- `service`: nombre del servicio definido en `/etc/services`.
- `flags`: atributos de la conexion. `REUSE` indica que el socket se reutilizara para nuevas conexiones.
- `socket_type`: tipo de socket utilizado. Lo habitual es `stream` para TCP o `dgram` para UDP.
- `wait`: indica si el servidor es monohilo (`yes`) o multihilo (`no`).
- `user`: cuenta de usuario con la que se iniciara el servicio.
- `server`: ruta del ejecutable que se pondra en marcha.
- `log_on_failure`: el operador `+=` anade informacion al registro, por ejemplo el login del usuario.
- `disable`: determina si el servicio queda activo o desactivado.

## Restricciones de acceso

Algunas opciones permiten reforzar el control de acceso y la seguridad:

- `only_from`: autoriza el acceso solo desde los anfitriones indicados.
- `no_access`: deniega el acceso a los anfitriones especificados, por ejemplo `172.16.17.0/24`.
- `access_times`: limita el acceso a una franja horaria concreta, por ejemplo `09:00-18:30`.
