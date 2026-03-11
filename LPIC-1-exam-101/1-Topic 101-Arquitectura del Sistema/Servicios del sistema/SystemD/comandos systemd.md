# Comandos systemd

Documento de referencia rapido con los comandos mas habituales de `systemctl` para gestionar servicios, targets y snapshots.

## Gestion basica de servicios

Comandos habituales para detener, iniciar y consultar servicios:

```bash
systemctl stop nombreservicio.service
systemctl start nombreservicio.service
systemctl status nombreservicio.service
```

## Habilitar y deshabilitar servicios

Habilitar un servicio para que arranque automaticamente:

```bash
systemctl enable httpd.service
```

Ejemplo de salida al habilitar:

```text
Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service
```

Deshabilitar y comprobar el estado de activacion:

```bash
systemctl disable httpd.service
systemctl is-enabled httpd.service
```

## Listado de unidades

```bash
systemctl list-unit-files --all
systemctl --type=service
```

## Targets principales

- `multi-user.target`: equivalente aproximado al runlevel 3.
- `graphical.target`: equivalente aproximado al runlevel 5.

## Consultar y cambiar el target por defecto

Ver el target por defecto actual:

```bash
systemctl get-default
```

Definir un target por defecto:

```bash
systemctl set-default TARGET.target
```

Ejemplo:

```bash
systemctl get-default
systemctl set-default graphical.target
```

## Cambiar de target en caliente

Para cambiar temporalmente al target indicado sin reiniciar:

```bash
systemctl isolate multi-user.target
```

## Trabajar con snapshots

Ejemplo de gestion de snapshots:

```bash
systemctl isolate actualizacion.snapshot
systemctl --type=snapshot
systemctl delete actualizacion.snapshot
```
