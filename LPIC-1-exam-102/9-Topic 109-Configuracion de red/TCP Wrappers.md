# TCP Wrappers

Documento de referencia sobre TCP Wrappers con formato Markdown homogéneo y navegación más clara.

> Resumen manual de LPIC-1 pagina 484

## TCP Wrappers (En servidores actuales esta deprecado):

TCP Wrappers es un mecanismo clásico de control de acceso a servicios de red en sistemas Unix/Linux. Permite permitir o denegar conexiones basándose en la IP, hostname o red de origen, antes de que el servicio procese la conexión.

```
[root@sercentos7 ~]# strings -f /usr/sbin/sshd | grep hosts_access
/usr/sbin/sshd: hosts_access
```

Si no se devuelve ninguna línea, el programa no utiliza las tcp_wrappers. Entre los servicios que utilizan las tcp_wrappers, encontramos:

- sendmail (incluyendo postfix);
- sshd (ssh);
- xinetd (y por lo tanto de manera indirecta todos los servicios asociados);
- vsftpd (ftp);
- portmap (y por lo tanto nis, nfs);
- in.telnetd (telnet), así como la mayoría de los servicios soportados por xinetd;

## La comprobación de acceso a un servicio embebido TCP se hace en tres etapas:

- ¿se autoriza el acceso de manera explícita?
- si no es el caso, ¿se prohíbe el acceso de manera explícita?
- si no es el caso, por defecto, se autoriza el acceso.

Para verificar una regla, el sistema lee primero /etc/hosts.allow, luego /etc/hosts.deny. La búsqueda se detiene en la primera correspondencia encontrada. Una línea en hosts.allow autoriza la conexión. Una línea en hosts.deny prohíbe la conexión. Si no se deniega de manera explícita el acceso, se autoriza: la petición no corresponde a ningún criterio.

Los archivos de configuración son /etc/hosts.allow y /etc/hosts.deny. La sintaxis es común:

## En el ejemplo siguiente:

- Sólo los miembros de la subred 192.168.1.0 tienen permiso para conectarse al servidor ftp (prohibido para todos los demás).
- Los anfitriones puesto 1 y puesto 2 tienen acceso a telnet y portmap.
- Los anfitriones de baddominio.org, excepto trusted, no tienen conexión alguna posible.
- Se prohíbe el servicio pop/imap a todos los de la red 192.168.0.0, salvo 192.168.1.5.

```bash
/etc/hosts.allow
```

vsftpd: 192.168.1. in.telnetd, portmap: puesto1, puesto2

```bash
/etc/hosts.deny
```

ALL: .baddominio.org except trusted.baddominio.org UNKNOWN vsftpd,in.telnetd,portmap: ALL dovecot : 192.168.1. EXCEPT 192.168.1.5

## La lista de clientes admite una sintaxis avanzada:

- ALL: correspondencia sistemática.
- LOCAL: todos los anfitriones cuyo nombre no contiene punto (puesto1, puesto2, etc.).
- UNKNOWN: anfitrión cuyo nombre no se puede resolver.
- KNOWN: anfitrión cuyo nombre se puede resolver.
- PARANOID: anfitrión cuyo nombre no se puede resolver o cuyo IP no tiene resolución inversa.
- EXCEPT: permite excluir ciertos anfitriones.
