# Resumen trabajar con modulos del kernel

Resumen de estudio sobre Resumen trabajar con modulos del kernel con jerarquía Markdown consistente y bloques técnicos normalizados.

**Los módulos del kernel (kernel modules) son piezas de código cargables dinámicamente que amplían al kernel de Linux sin reiniciar: controladores de dispositivos, sistemas de archivos, protocolos de red, cifrado, filtros de paquetes, etc.

Son ficheros *.ko que el kernel puede cargar/descargar bajo demanda (udev, modprobe) según el hardware o las funciones que necesites.

¿Para qué sirven? Drivers: e1000e (NIC Intel), iwlwifi (Wi-Fi), usb_storage, nvme. Sistemas de archivos: ext4, xfs, vfat, nfs, fuse. Red y seguridad: nf_tables, ip_tables, wireguard, xt_*. Virtualización: kvm, kvm_intel/kvm_amd, virtio_*. Otros: loop (loop devices), dm_crypt, zram.

## Dónde están y cómo saber los que hay

Instalados: /lib/modules/$(uname -r)/ (índice de dependencias: modules.dep). Cargados ahora: /sys/module/ o con lsmod

## Visualización de módulos cargados en memoria:

```bash
lsmod
 lsmod |grep vfat
```

## El comando modinfo provee toda la información necesaria sobre un modulo:

- El nombre del fichero correspondiente
- una descripción del modulo
- su autor
- su licencia
- sus dependencias
- sus parámetros
- sus alias

```bash
modinfo vfat
modinfo fat
```

## El comando insmod carga un modulo dado sin gestionar las dependencias

```bash
insmod /lib/modules/2.6.18-8.el5/kernel/fs/fat/fat.ko
insmod  /lib/modules/2.6.18-8.el5/kernel/fs/vfat/vfat.ko
lsmod |grep vfat
```

## El comando rmmod descarga el modulo dado. Se trata del contrario de insmod y, al

## igual que este rmmod no gestiona las dependencias.

```bash
rmmod /lib/modules/2.6.18-8.el5/kernel/fs/vfat/vfat.ko
rmmod /lib/modules/2.6.18-8.el5/kernel/fs/fat/fat.ko
```

## lsmod |grep -i vfat

## El comando modprobe carga el modulo dado, así como todas sus dependencias

-r permite descargar un modulo y los que dependen de el (si no están en uso).

## modprobe vfat

## lsmod |grep -i vfat

## modprobe -r  vfat

## lsmod |grep -i vfat
