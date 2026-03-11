# Equivalente de `yum whatprovides` en Debian y Ubuntu

Documento breve para identificar que paquete contiene un archivo en sistemas basados en Debian o Ubuntu.

## Uso de `apt-file`

`apt-file` permite buscar que paquete contiene un archivo, incluso cuando ese paquete no esta instalado en el sistema. Es util cuando se conoce el nombre de un binario o de una libreria, pero no se sabe que paquete debe instalarse.

### Instalacion y actualizacion del indice

```bash
sudo apt-get update
sudo apt install apt-file
sudo apt-file update
```

### Busqueda de archivos

Ejemplo de consulta:

```bash
sudo apt-file search lspci
```
