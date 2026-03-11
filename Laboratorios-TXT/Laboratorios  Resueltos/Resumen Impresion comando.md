# Resumen Impresion comando

Resumen de estudio sobre Resumen Impresion comando con jerarquía Markdown consistente y bloques técnicos normalizados.

## Contenido

### SYSTEM v BSD  FEDERADOR

```bash
/etc/printcap queue
```

SystemV lp -dimpresora -ncifra fichero lpstat -d -s -t-p  Informacion relatica a la impresio -d muestra el nombre de la impresora -s estado o resumen de la cola -t totalidad informacion de los estado de trabajo -p informacion sobre impresoras incluida en la lista

```
cancel  suprime las tareas de impresion -e suprime todos los trabajos de impresion, solo lo puede ejecutar el administrador
```

### El demonio ldp

lpadmin permite administrar los serviceio de impresion con las cola en esprea, etc... lpadmin -x fila suprimir una cola en espera lpsdmin -d define cola de espera por defecto lpadmin -p fila -u deny:lista  prohibicion de imprimir a usuario lpmove permite transferir peticion de impresion de una cola a otra clola

### BSD

lpr -d impresora -#copia  fichero lpq -P impresora, indica el estado y los trabajos de una impresora lprm permite suprimir tabajos de impresion lpc especie de shell permite controlar la impresora y trabajos Servicicio se llama lpd
