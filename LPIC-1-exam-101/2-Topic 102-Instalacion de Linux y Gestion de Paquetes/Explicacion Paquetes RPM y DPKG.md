# Explicación de paquetes RPM y DPKG

> Referencia del manual del curso:
> - Debian Package: página 75.
> - Red Hat Package Manager: página 63.

## 1) Debian Package (`.deb`)

### 1.1) Conceptos base

- Base de datos de `dpkg`: `/var/lib/dpkg`
- Ejemplo de paquete local: `/root/webmin.deb`

El comando `dpkg` es el gestor de paquetes de bajo nivel en sistemas basados en Debian.
Permite instalar, eliminar, consultar y reconfigurar paquetes `.deb`.

`apt` y `apt-get` usan `dpkg` internamente para la gestión final del paquete.

**Importante:** `dpkg` no resuelve dependencias automáticamente.

### 1.2) Comandos esenciales de `dpkg`

| Comando | Descripción |
|---|---|
| `dpkg -i paquete.deb` | Instalar un paquete `.deb`. |
| `dpkg -r paquete` | Eliminar un paquete sin borrar configuración. |
| `dpkg --purge paquete` | Eliminar paquete y configuración. |
| `dpkg -l` | Listar paquetes instalados. |
| `dpkg -s paquete` | Ver información de un paquete instalado. |
| `dpkg -L paquete` | Listar archivos instalados por un paquete. |
| `dpkg -S /ruta/al/archivo` | Indicar qué paquete instaló un archivo. |

### 1.3) `dpkg-reconfigure` (pregunta típica de certificación)

Se usa para volver a ejecutar el asistente de configuración de un paquete ya instalado.

```bash
dpkg-reconfigure paquete
```

### 1.4) Opciones avanzadas de `dpkg`

| Comando | Uso |
|---|---|
| `dpkg --force-depends -i paquete.deb` | Instalar ignorando dependencias. |
| `dpkg -l 'paquete*'` | Listar paquetes por patrón. |
| `dpkg --audit` | Mostrar problemas de instalación. |
| `dpkg --contents paquete.deb` | Ver archivos dentro de un `.deb`. |
| `dpkg --remove paquete` | Eliminar paquete parcialmente instalado. |
| `dpkg --configure -a` | Reparar paquetes pendientes/rotos. |
| `dpkg --add-architecture i386` | Añadir arquitectura secundaria. |
| `dpkg -V paquete` | Verificar integridad del paquete. |
| `dpkg-deb -x paquete.deb directorio` | Extraer un `.deb` sin instalar. |
| `dpkg-deb --info paquete.deb` | Ver metadatos de un `.deb`. |

### 1.5) Resumen extendido de `dpkg`

```bash
dpkg -i package.deb
dpkg -R directorio
dpkg -l
dpkg -c package.deb
dpkg -L paquete
dpkg -S /ruta/al/archivo
dpkg -r paquete
dpkg -P paquete
dpkg --get-selections
dpkg --configure --pending
dpkg --info paquete.deb
dpkg --version
dpkg --unpack nombre_paquete.deb
dpkg -R --install /ruta/a/deb-files/
sudo dpkg --help
dpkg --force-all --purge nombre_del_paquete
```

## 2) APT y APT-GET (Debian/Ubuntu)

### 2.1) Archivos importantes

- Lista de repositorios: `/etc/apt/sources.list`

### 2.2) Qué hace `apt`

`apt` (Advanced Package Tool) es la interfaz de alto nivel para gestionar paquetes en Debian/Ubuntu.
Permite instalar, actualizar, eliminar y consultar paquetes, resolviendo dependencias automáticamente.

### 2.3) Comandos principales de `apt-get`

| Comando | Descripción |
|---|---|
| `apt-get install paquete` | Instalar paquete. |
| `apt-get --reinstall install paquete` | Reinstalar paquete. |
| `apt-get remove paquete` | Eliminar paquete (mantiene config). |
| `apt-get remove --purge paquete` | Eliminar paquete y configuración. |
| `apt-get update` | Actualizar índice local de paquetes. |
| `apt-get upgrade` | Actualizar paquetes instalados. |
| `apt-get dist-upgrade` | Actualización completa (puede instalar/eliminar dependencias). |

### 2.4) Herramientas y comandos útiles de APT

| Comando | Descripción |
|---|---|
| `apt-cache search paquete` | Buscar paquetes por nombre. |
| `apt list` | Listar paquetes y actualizaciones disponibles. |
| `apt show paquete` | Mostrar detalles de un paquete. |
| `apt-cache show paquete` | Mostrar metadatos del paquete. |
| `apt-cache showpkg paquete` | Detalle extendido (dependencias/información). |
| `apt-cache depends paquete` | Ver dependencias de un paquete. |
| `apt autoremove` | Eliminar dependencias no necesarias. |
| `apt edit-sources` | Editar lista de repositorios. |
| `apt satisfy 'dependencia'` | Satisfacer una dependencia manualmente. |

### 2.5) Ejemplos prácticos con `apt-get` y utilidades relacionadas

```bash
sudo apt-get update
sudo apt-get check
sudo apt-get install paquete1 paquete2
sudo apt-get --reinstall install paquete
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get remove paquete
sudo apt-get remove --purge paquete
sudo apt-get -f install
sudo dpkg --configure -a
sudo apt-get clean
sudo apt-get autoclean
sudo apt-cache search paquete
sudo apt-get source paquete
sudo apt-get build-dep paquete
sudo apt-get dselect-upgrade
sudo apt-show-versions -u
sudo apt-cache show paquete
sudo apt-cache showpkg paquete
sudo apt-cache depends paquete
sudo apt-file search archivo
sudo apt-file list paquete
sudo apt-file update
sudo apt-get autoremove
sudo apt-get check
sudo apt-cache unmet
sudo apt-cache pkgnames
```

### 2.6) Opciones frecuentes en APT

| Opción | Significado |
|---|---|
| `-s` | Simular una acción. |
| `-d` | Solo descargar. |
| `-y` | Asumir "sí" a todo. |
| `-u` | Mostrar paquetes actualizados. |
| `-h` | Ayuda. |
| `-q` | Menos salida. |
| `-qq` | Salida mínima, salvo errores. |
| `-f` | Intentar corregir dependencias rotas. |
| `-m` | Continuar si faltan archivos descargables. |
| `-b` | Construir paquete fuente tras obtenerlo. |
| `-V` | Mostrar versiones detalladas. |
| `-c=archivo` | Usar archivo de configuración alternativo. |
| `-o=clave=valor` | Definir opción de configuración arbitraria. |

### 2.7) Nota sobre `apt` vs `apt-get`

Desde Ubuntu 14.04 se popularizó el uso de `apt` como frontend más simple.
`apt-get` sigue siendo válido y muy usado en scripts.

### 2.8) Buscar qué paquete instala un comando

```bash
sudo apt-get update
sudo apt install apt-file
sudo apt-file search lspci
```

## 3) Conversión de paquetes con `alien`

La herramienta `alien` permite convertir entre formatos RPM y DEB.

```bash
# Convierte de .rpm a .deb (parámetro por defecto -d)
alien -d lgtoclnt-7.4-1.i686.rpm

# Convierte de .deb a .rpm
alien -r lgtoclnt-7.4-1.i686.deb
```

## 4) Red Hat Package Manager (`rpm`)

### 4.1) Conceptos base

`rpm` es el gestor de paquetes de bajo nivel en RHEL, Rocky, CentOS y Fedora.
Permite instalar, actualizar, eliminar y consultar paquetes `.rpm`.

**Importante:** `rpm` no resuelve dependencias automáticamente.

- Base de datos RPM: `/var/lib/rpm`

### 4.2) Reparar base de datos RPM

```bash
rpm --rebuilddb
```

Regenera la base de datos RPM y corrige inconsistencias si está corrupta.
No altera los paquetes instalados; solo reconstruye metadatos.

### 4.3) Instalación, eliminación y actualización con `rpm`

```bash
# Instalar
rpm -ivh paquete.rpm

# Eliminar
rpm -evh paquete

# Forzar (usar con precaución)
rpm -ivh --nodeps paquete.rpm
# Opciones relacionadas: --nodeps, --force

# Actualizar
rpm -U paquetev2.rpm
rpm -F paquetev2.rpm
```

### 4.4) Verificación de integridad (`rpm -V`)

```bash
rpm -V php
```

Interpretación de códigos comunes:

- `S`: tamaño modificado.
- `5`: checksum MD5 distinto.
- `T`: fecha de modificación distinta.
- `U`: propietario distinto.
- `G`: grupo distinto.
- `L`: enlace simbólico distinto.
- `M`: permisos o tipo de archivo distinto.
- `D`: dispositivo (major/minor) distinto.

### 4.5) Consultas con `rpm`

```bash
rpm -qa php
rpm -qa 'httpd*'
rpm -qi paquete
rpm -ql php
rpm -qf /etc/passwd
rpm -qp --requires joomla-1.0.15-2.9.el5.al.noarch.rpm
```

### 4.6) Ejemplo local con Webmin

```bash
yum -y localinstall /root/webmin-1.955-1.noarch.rpm
service webmin start
service webmin status
netstat -tan | grep -i listen
ss -tan
# Acceso web: https://192.168.2.5:10000/
```

## 5) Gestión de paquetes con `yum`/`dnf`

### 5.1) Archivos y rutas importantes

- `/etc/yum.conf`
- `/etc/dnf/dnf.conf`
- `/etc/yum.repos.d/*.repo`
- `/var/log/yum.log`
- `/var/log/dnf.log`

### 5.2) Comandos frecuentes

```bash
yum install paquete1 paquete2 -y
yum remove paquete1 -y
yum erase paquete
yum info php
yum update
yum upgrade
```

### 5.3) Buscar qué paquete provee un archivo/comando

```bash
yum provides '*/netstat'
yum provides lspci
yum install net-tools -y
```

### 5.4) Filtros típicos de listado en YUM/DNF

- `all`: primero instalados y luego disponibles.
- `available`: disponibles para instalar.
- `updates`: actualizables.
- `installed`: instalados.
- `obsoletes`: obsoletos.
- `recent`: añadidos recientemente.
- `repolist`: repositorios configurados.

### 5.5) Limpieza, logs y exclusiones

```bash
yum clean all
tail -f /var/log/yum.log
yum check-update
```

Ejemplo de exclusión en configuración:

```ini
# /etc/yum.conf
[main]
exclude=php* kernel*
```

Ejemplo puntual por comando:

```bash
yum --exclude=php* --exclude=kernel* update
yum update php
```

### 5.6) Descargar sin instalar

`yum` dispone de `--downloadonly` para descargar paquetes y dependencias sin instalarlos.

```bash
yum install --downloadonly --downloaddir=/root mc
```

Ruta típica de caché:

`/var/cache/yum/x86_64/<version_distro>/<repositorio>/packages`

### 5.7) Instalar RPM local resolviendo dependencias

```bash
yum --nogpgcheck localinstall /root/nginx-1.12.2-2.el7.x86_64.rpm
```

Qué hace:

- Detecta que es un archivo local.
- Lo instala.
- Si faltan dependencias, las descarga desde repositorios configurados.

En Debian/Ubuntu, el equivalente es:

```bash
apt install ./xxx.deb
```

En Red Hat:

```bash
yum localinstall /root/webmin-1.955-1.noarch.rpm
```

### 5.8) Historial de transacciones

```bash
yum history list
yum history info 29

# Rehacer
yum history redo 23

# Deshacer
yum history undo 23
```

### 5.9) Configurar proxy corporativo

```ini
# /etc/yum.conf o /etc/dnf/dnf.conf
[main]
proxy=http://<Proxy-Server-IP-Address>:<Proxy_Port>
proxy_username=<Proxy-User-Name>
proxy_password=<Proxy-Password>
```

## 6) Zypper (openSUSE / SUSE)

`zypper` es el gestor de paquetes de openSUSE y SUSE Linux Enterprise (SLE).
Trabaja con paquetes RPM y repositorios del sistema.

Equivalente aproximado:

- Debian/Ubuntu: `apt`
- RHEL/Rocky/Fedora: `dnf`

Sintaxis general:

```bash
zypper [opciones-globales] [comando] [opciones-comando] [argumentos]
```

### 6.1) Opciones globales destacadas

- `--help`, `-h`: ayuda.
- `--version`, `-V`: versión.
- `--config`, `-c`: usar archivo de configuración alternativo.
- `--quiet`, `-q`: salida mínima.
- `--verbose`, `-v`: más detalle.
- `--no-abbrev`, `-A`: no abreviar tablas.
- `--table-style`, `-s`: estilo de tabla.
- `--rug-compatible`, `-r`: compatibilidad rug.
- `--non-interactive`, `-n`: no preguntar.
- `--xmlout`, `-x`: salida XML.
- `--reposd-dir`, `-D`: directorio alternativo de repositorios.
- `--cache-dir`, `-C`: directorio alternativo de caché.
- `--raw-cache-dir`: caché raw alternativo.
- `--solv-cache-dir`: caché solv alternativo.
- `--pkg-cache-dir`: caché de paquetes alternativo.

### 6.2) Opciones de repositorio

- `--no-gpg-checks`: ignorar fallos de verificación GPG.
- `--gpg-auto-import-keys`: importar claves automáticamente.
- `--plus-repo`, `-p`: usar repositorio adicional.
- `--disable-repositories`: no leer metadatos de repositorios.
- `--no-refresh`: no refrescar repositorios.
- `--no-cd`: ignorar repositorios CD/DVD.
- `--no-remote`: ignorar repositorios remotos.

### 6.3) Opciones de destino

- `--root`, `-R`: usar raíz alternativa.
- `--disable-system-resolvables`: no leer paquetes instalados.

### 6.4) Comandos principales

#### Generales

- `help`, `?`: mostrar ayuda.
- `shell`, `sh`: ejecutar múltiples comandos.

#### Repositorios

- `repos`, `lr`: listar repositorios.
- `addrepo`, `ar`: añadir repositorio.
- `removerepo`, `rr`: eliminar repositorio.
- `renamerepo`, `nr`: renombrar repositorio.
- `modifyrepo`, `mr`: modificar repositorio.
- `refresh`, `ref`: actualizar repositorios.
- `clean`: limpiar cachés.

#### Servicios

- `services`, `ls`: listar servicios.
- `addservice`, `as`: añadir servicio.
- `modifyservice`, `ms`: modificar servicio.
- `removeservice`, `rs`: eliminar servicio.
- `refresh-services`, `refs`: actualizar servicios.

#### Gestión de software

- `install`, `in`: instalar paquetes.
- `remove`, `rm`: eliminar paquetes.
- `verify`, `ve`: verificar integridad de dependencias.
- `update`, `up`: actualizar paquetes.
- `dist-upgrade`, `dup`: actualización de distribución.
- `source-install`, `si`: instalar fuentes y dependencias de build.
- `install-new-recommends`, `inr`: instalar nuevas recomendaciones.

#### Gestión de actualizaciones

- `update`, `up`: actualizar paquetes instalados.
- `list-updates`, `lu`: listar actualizaciones disponibles.
- `patch`: instalar parches requeridos.
- `list-patches`, `lp`: listar parches necesarios.
- `dist-upgrade`, `dup`: actualización de distribución.
- `patch-check`, `pchk`: comprobar parches pendientes.

#### Consultas

- `search`, `se`: buscar paquetes.
- `info`, `if`: información completa de paquetes.
- `patch-info`: información de parches.
- `pattern-info`: información de patrones.
- `product-info`: información de productos.
- `patches`, `pch`: listar parches disponibles.
- `packages`, `pa`: listar paquetes disponibles.
- `patterns`, `pt`: listar patrones disponibles.
- `products`, `pd`: listar productos disponibles.
- `what-provides`, `wp`: qué paquete provee una característica.

#### Bloqueos

- `addlock`, `al`: añadir bloqueo.
- `removelock`, `rl`: eliminar bloqueo.
- `locks`, `ll`: listar bloqueos.
- `cleanlocks`, `cl`: limpiar bloqueos sin uso.

#### Otros

- `versioncmp`, `vcmp`: comparar versiones.
- `targetos`, `tos`: mostrar ID del SO destino.
- `licenses`: informe de licencias y EULA.

Para ayuda de un comando concreto:

```bash
zypper help <comando>
```
