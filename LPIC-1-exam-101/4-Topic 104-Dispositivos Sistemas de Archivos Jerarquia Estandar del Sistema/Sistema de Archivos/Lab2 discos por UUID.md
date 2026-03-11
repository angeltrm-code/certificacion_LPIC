# Lab 2 discos por UUID

Documento práctico sobre Lab 2 discos por UUID. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Laboratorio disco /dev/sdc

### Crear una particion /dev/sdc1

### formatearla a ext4

### Montarla en el directorio /datos

### Persistirlo en el fstab a traves de montaje por UUID

---

```bash
fdisk /dev/sdc
/dev/sdc1
```

```bash
mkfs.ext4 /dev/sdc1
mkdir /datos
mount /dev/sdc1  /datos
df -h
```

```bash
umount /datos
df -h
```

### blkid /dev/sdc1

```bash
/dev/sdc1: UUID="be1671ac-e150-4a1b-84aa-da00070e8a10" TYPE="ext4"
```

```bash
vi /etc/fstab
```

```
UUID=be1671ac-e150-4a1b-84aa-da00070e8a10               /datos        ext4     defaults 0 0
```

```bash
mount /datos
df -h
```
