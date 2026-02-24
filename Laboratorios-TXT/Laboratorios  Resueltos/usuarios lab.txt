systemctl get-default
systemctl set-default multi-user.target
hwclock

usuario1
usuario2
usuario3
informatica
sistemas

groupadd informatica
groupadd sistemas

El usuario1 no tienes shell y pertenece al grupo secundarios sistemas y primarios informatica
adduser -s /sbin/nologin  -G sistemas -g informatica usuario1
passwd usuario1

El usuario2 tiene la cuenta bloqueada
adduser usuario2
usermod -L usuario2

El usuario3 grupo primario informatica y en el 1 inicio de sesion tiene que cambiar el pass

adduser -g informatica usuario3
passwd usuario3
chage -d 0 usuario3
passwd -n 0 usuario3

usermod -d /nuevo/dir/home usuario

https://wiki.archlinux.org/index.php/Change_username_(Espa%C3%B1ol)

