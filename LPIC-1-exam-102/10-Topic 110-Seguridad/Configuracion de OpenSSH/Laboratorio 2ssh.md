# Laboratorio 2 SSH

Documento práctico sobre Laboratorio 2 SSH. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Configurar el servicio de ssh:

### Cambiar el puerto al 52741

### el usuario root no se puede conectar

### No permitimos el renvio de las X

### Solo se puede conectar el usuario lunes9

Copiar el archivo /lpic1/access_log al servidor 192.168.33.10 con el usuario operador.

---

```bash
cp /etc/ssh/sshd_config /root
```

### adduser lunes9

```bash
passwd lunes9
```

### Configurar el servicio ssh:

```bash
vi /etc/ssh/sshd_config
```

### No se permite la conexion al root

```conf
PermitRootLogin no
```

### El puerto por defecto es el 52341

```conf
Port 52741
```

Solo se pueden conectar el usuario lunes9, lo añadimos al final del archivo /etc/ssh/sshd_config

```conf
AllowUsers lunes9
```

### No se prermite resolucion inversa

### UseDNS no

### No permitimos el renvio de las X

```conf
X11Forwarding no
```

## Tras finalizar la configuracion reinicio el servicio

```bash
systemctl restart sshd
systemctl status sshd
```

### Copiar un fiechor desde nuesrtro windows  al servidor 192.168.2.5 con el usuario lunes9

```bash
scp -P 52741  -p fichero lunes9@192.168.2.5:/home/lunes9
```

---

En el lab comprobar que no puedo conectarme a traves de ssh como root.

### Solo puedo entrar como usuario lunes9

## Restauramos el servicio de sshd:

```bash
cp  /root/sshd_config  /etc/ssh/
systemctl restart sshd
```
