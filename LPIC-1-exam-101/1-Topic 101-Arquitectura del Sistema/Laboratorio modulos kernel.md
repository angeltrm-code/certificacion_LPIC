#Manual LINUX - Preparación a la certificación LPIC-1.pdf -->Pagina 306


Cargar el modulo vfat a traves de los comandos insmod y descargarlo de la memoria con el comando rmmod

#insmod:
Inserta (carga) un módulo en el kernel a partir de un archivo .ko.
No resuelve dependencias automáticamente, por lo que es necesario cargar previamente otros módulos de los que dependa.
Requiere permisos de superusuario.

#rmmod:
Elimina (descarga) un módulo ya cargado en el kernel.
Puede fallar si el módulo está siendo utilizado por otros módulos o procesos.
También necesita permisos de superusuario.

Estos comandos permiten gestionar manualmente los módulos del kernel, siendo útiles para pruebas y diagnósticos avanzados en entornos Linux.

##Comenzamos el laboratorio:
modinfo vfat
modinfo fat

##Tendremos que controlar la dependecia ya que el comando insmod no gestiona dependencias:
modinfo vfat

filename:       /lib/modules/3.10.0-1160.15.2.el7.x86_64/kernel/fs/fat/vfat.ko.xz
author:         Gordon Chaffee
description:    VFAT filesystem support
license:        GPL
alias:          fs-vfat
retpoline:      Y
rhelversion:    7.9
srcversion:     A3254796A3CD9815ABDDC94
depends:        fat


lsmod |grep vfat

modinfo fat

##El comando insmod no gestiona dependencias del modulo.
insmod /lib/modules/3.10.0-327.el7.x86_64/kernel/fs/fat/fat.ko
insmod /lib/modules/3.10.0-327.el7.x86_64/kernel/fs/fat/vfat.ko

lsmod |grep vfat

##El comando rmmod descarga el modulo dado. Se trata del contrario de insmod y, al igual que este rmmod no gestiona las dependencias.

rmmod /lib/modules/3.10.0-327.el7.x86_64/kernel/fs/fat/vfat.ko
rmmod /lib/modules/3.10.0-327.el7.x86_64/kernel/fs/fat/fat.ko

lsmod |grep vfat

##El comando modprobe gestiona dependencias de un modulo.
modprobe vfat
lsmod |grep vfat

##Quitar el modulo de memoria.
modprobe -r vfat
lsmod |grep vfat
