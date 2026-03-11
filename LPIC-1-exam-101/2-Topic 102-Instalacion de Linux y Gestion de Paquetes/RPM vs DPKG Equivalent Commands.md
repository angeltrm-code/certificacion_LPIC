# RPM vs DPKG Equivalent Commands

Documento de referencia sobre RPM vs DPKG Equivalent Commands con formato Markdown homogéneo y navegación más clara.

## Command Details        ##RPM Command                       ##DPKG Command

```bash
Install a package    rpm -i {package.rpm}                   dpkg -i {file.deb}
```

### Update package    rpm -U {file.rpm}                           dpkg -i {file.deb}

### Remove an installed package    rpm -e {package}               dpkg -r {package}

### List all installed packages    rpm -qa     php                   dpkg -l php

### List files in an installed package    rpm -ql {package}       dpkg -L {package}

### Show information about installed package    rpm -qi           dpkg -p {package}

### Show information about package file    rpm -qpi {file.rpm}       dpkg -I {file.deb}

List files in a package file    rpm -qpl {file.rpm}           dpkg -c {file.deb}

## Comando   RPM        Descripción           Comando DPKG/Apt

```bash
rpm -i paquete.rpm    Instalar un paquete RPM    dpkg -i paquete.deb
```

```bash
rpm -e paquete    Eliminar un paquete    dpkg -r paquete o apt remove paquete
```

```bash
rpm -U paquete.rpm    Actualizar o instalar un paquete    dpkg -i paquete.deb o apt install paquete
```

```bash
rpm -F paquete.rpm    Actualizar solo si el paquete ya está instalado    No tiene equivalente directo, usar apt upgrade si aplica
```

```bash
rpm -qa    Listar todos los paquetes instalados    dpkg -l o apt list --installed
```

```bash
rpm -q paquete    Mostrar información sobre un paquete instalado    dpkg -s paquete o apt show paquete
```

```bash
rpm -ql paquete    Listar los archivos instalados por un paquete    dpkg -L paquete
```

```bash
rpm -qc paquete    Listar archivos de configuración de un paquete    dpkg -L paquete (y buscar archivos en /etc/)
```

```bash
rpm -qi paquete    Mostrar información detallada de un paquete    dpkg -s paquete o apt show paquete
```

```bash
rpm -qf /ruta/archivo    Mostrar qué paquete instaló un archivo    dpkg -S /ruta/archivo
```

```bash
rpm -V paquete    Verificar los archivos de un paquete    debsums -c paquete (si debsums está instalado)
```

```bash
rpm --import clave.gpg    Importar una clave GPG    apt-key add clave.gpg (aunque apt-key está en desuso)
```

```bash
rpm -K paquete.rpm    Verificar la integridad de un paquete RPM    dpkg-sig --verify paquete.deb
```

```bash
rpm -rebuilddb    Reconstruir la base de datos de RPM    No tiene equivalente directo en dpkg
```

```bash
yum search paquete    Buscar un paquete en los repositorios    apt search paquete
```

```bash
yum install paquete    Instalar un paquete desde repositorios    apt install paquete
```

```bash
yum remove paquete    Eliminar un paquete desde repositorios    apt remove paquete
```

```bash
yum update    Actualizar todos los paquetes del sistema    apt upgrade
```

```bash
yum list installed    Listar todos los paquetes instalados    apt list --installed
```

```bash
yum info paquete    Mostrar información detallada de un paquete    apt show paquete
```
