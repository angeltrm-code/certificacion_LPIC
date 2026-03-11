# VC-10-03-2026-13 | Laboratorio guiado: Advanced Shell Features

## Qué es
Laboratorio práctico guiado basado en el **Lab 1: Advanced Shell Features** del PDF, que comienza en la **página 29, paso 1.1 Step 1**.

## Para qué sirve
- Practicar variables locales y de entorno.
- Crear y probar scripts Bash sencillos.
- Entender `PATH`, `PS1`, alias, funciones y listas.
- Modificar archivos de inicio de Bash de forma segura.
- Comprobar cómo `/etc/skel` afecta a usuarios nuevos.

---

## Datos del laboratorio original
El laboratorio original usa una máquina **CentOS** y trabaja primero con un usuario normal y después con `root`. El PDF indica cuentas de ejemplo como `sysadmin` y `root`, y usa archivos de inicio Bash, alias, funciones, scripts y `/etc/skel`.

---

## 1) Variables locales y de entorno

## 1.1 Paso 1 — Mostrar todas las variables con `set`
**Objetivo**: ver variables locales + de entorno.

```bash
set
```

**Qué debes observar**
- aparecen muchas variables como `BASH`, `HOME`, `PATH`, `HISTFILE`, `COLUMNS`, `USER`
- `set` muestra más información que `env`

## 1.2 Paso 2 — Mostrar solo variables de entorno con `env`
**Objetivo**: distinguir variables exportadas.

```bash
env
```

**Qué debes observar**
- salen variables como `HOSTNAME`, `SHELL`, `TERM`, `USER`, `PATH`
- salen menos elementos que con `set`

## 1.3 Paso 3 — Diferenciar local vs entorno
**Objetivo**: comparar `set` y `env`.

```bash
set | less
env | less
```

**Idea clave**
- `set` → shell completa
- `env` → solo entorno exportado

## 1.4 Paso 4 — Cambiar `PS1` para mostrar número de historial
**Objetivo**: personalizar el prompt.

```bash
PS1='\# \$ '
ls /
ls
```

**Qué debes observar**
- el prompt muestra número de historial
- el símbolo del prompt será `$`

## 1.5 Paso 5 — Cambiar `PS1` para mostrar usuario, host y directorio
**Objetivo**: usar secuencias típicas de prompt.

```bash
PS1='\u@\h \w \$ '
```

**Qué debes observar**
- aparece usuario, hostname, directorio actual y símbolo final

## 1.6 Paso 6 — Ver el efecto de `COLUMNS`
**Objetivo**: comprobar el ancho de salida de `ls`.

```bash
ls /bin
```

**Qué debes observar**
- la salida ocupa muchas columnas
- el ancho por defecto suele ser 80

## 1.7 Paso 7 — Exportar `COLUMNS=60`
**Objetivo**: convertir la variable en variable de entorno.

```bash
export COLUMNS=60
```

## 1.8 Paso 8 — Ver de nuevo `ls /bin`
**Objetivo**: comprobar el efecto del nuevo ancho.

```bash
ls /bin
```

**Qué debes observar**
- la salida usa menos columnas por línea

## 1.9 Paso 9 — Mostrar una variable concreta
**Objetivo**: consultar el valor de `COLUMNS`.

```bash
echo $COLUMNS
```

**Idea clave**
- para mostrar una variable se usa `$VARIABLE`
- para asignarla no se usa `$`

## 1.10 Paso 10 — Mostrar `PATH`
**Objetivo**: ver la ruta de búsqueda de comandos.

```bash
echo $PATH
```

---

## 2) Crear y probar un script simple

## 2.1 Paso 11 — Crear directorio `scripts`
**Objetivo**: preparar una carpeta para scripts personales.

```bash
mkdir scripts
ls
```

## 2.2 Paso 12 — Crear el script `today`
**Objetivo**: construir un script mínimo con redirecciones.

```bash
echo '#!/bin/bash' > scripts/today
echo 'echo Today is $(date +%D)' >> scripts/today
cat scripts/today
```

**Qué debes observar**
- `>` crea o sobrescribe
- `>>` añade al final

## 2.3 Paso 13 — Ejecutar el script con `bash`
**Objetivo**: ejecutarlo sin permiso de ejecución.

```bash
bash scripts/today
```

## 2.4 Paso 14 — Probar ejecución directa y ver el error
**Objetivo**: comprobar que todavía no es ejecutable.

```bash
scripts/today
```

**Resultado esperado**
- error tipo `Permission denied`

## 2.5 Paso 15 — Ver permisos del archivo
**Objetivo**: comprobar por qué falla.

```bash
ls -l scripts/today
```

**Qué debes observar**
- faltan permisos `x`

## 2.6 Paso 16 — Dar permiso de ejecución
**Objetivo**: hacer el script ejecutable.

```bash
chmod a+rx scripts/today
ls -l scripts/today
```

## 2.7 Paso 17 — Ejecutarlo con rutas relativas y absolutas
**Objetivo**: probar distintas formas válidas.

```bash
scripts/today
cd scripts
./today
/home/$USER/scripts/today
~/scripts/today
```

**Qué debes observar**
- todas las formas funcionan si el archivo es ejecutable y la ruta es válida

## 2.8 Paso 18 — Probar a ejecutar solo por nombre
**Objetivo**: ver que falla si el directorio no está en `PATH`.

```bash
today
```

**Resultado esperado**
- error tipo `command not found`

## 2.9 Paso 19 — Añadir `~/scripts` al `PATH` temporalmente
**Objetivo**: modificar `PATH` en la sesión actual.

```bash
echo $PATH
PATH=$PATH:$HOME/scripts
echo $PATH
```

## 2.10 Paso 20 — Ejecutar el script solo por nombre
**Objetivo**: comprobar que ahora Bash lo encuentra.

```bash
today
cd
today
```

---

## 3) Persistencia de PATH con `.bash_profile`

## 3.1 Paso 21 — Salir y volver a la sesión
**Objetivo**: demostrar que los cambios temporales no persisten.

```bash
exit
```

**Qué debes observar**
- al volver, el cambio manual de `PATH` ya no está

## 3.2 Paso 22 — Verificar el `PATH` original
**Objetivo**: confirmar que se perdió el cambio temporal.

```bash
echo $PATH
```

## 3.3 Paso 23 — Revisar `.bash_profile`
**Objetivo**: localizar dónde se ajusta `PATH` para el usuario.

```bash
cat -n ~/.bash_profile
```

**Qué debes observar**
- la línea típica: `PATH=$PATH:$HOME/.local/bin:$HOME/bin`

## 3.4 Paso 24 — Editar `.bash_profile`
**Objetivo**: preparar el cambio persistente.

```bash
nano ~/.bash_profile
```

## 3.5 Paso 25 — Añadir `:$HOME/scripts` al `PATH`
**Objetivo**: dejar la ruta persistente.

Deja la línea así:

```bash
```

## 3.6 Paso 26 — Guardar cambios en nano
**Objetivo**: salir sin perder la edición.

```text
Ctrl+X
y
Enter
```

## 3.7 Paso 27 — Recargar el archivo sin cerrar sesión
**Objetivo**: probar el cambio de forma segura.

```bash
source ~/.bash_profile
```

También es válido:

```bash
. ~/.bash_profile
```

## 3.8 Paso 28 — Verificar que `PATH` ya incluye `scripts`
**Objetivo**: confirmar el cambio.

```bash
echo $PATH
```

---

## 4) `/etc/skel` y nuevos usuarios

## 4.1 Paso 29 — Ver contenido de `/etc/skel`
**Objetivo**: identificar los archivos que se copian a usuarios nuevos.

```bash
ls -a /etc/skel
```

**Qué debes observar**
- suelen aparecer `.bash_logout`, `.bash_profile`, `.bashrc`

## 4.2 Paso 30 — Cambiar a root
**Objetivo**: obtener privilegios para modificar `/etc/skel`.

```bash
su -
```

## 4.3 Paso 31 — Copiar el `.bash_profile` personalizado a `/etc/skel`
**Objetivo**: que usuarios nuevos reciban ese archivo.

```bash
cp ~sysadmin/.bash_profile /etc/skel
```

## 4.4 Paso 32 — Crear usuario de prueba
**Objetivo**: verificar el efecto de `/etc/skel`.

```bash
useradd testuser
```

## 4.5 Paso 33 — Revisar el `.bash_profile` del usuario nuevo
**Objetivo**: comprobar que se copió automáticamente.

```bash
cat ~testuser/.bash_profile
```

**Qué debes observar**
- debe incluir `:$HOME/scripts` al final de la línea `PATH=...`

## 4.6 Paso 34 — Entender diferencia entre `.bash_profile` y `.bashrc`
**Objetivo**: ubicar bien cada tipo de configuración.

```bash
cat ~testuser/.bash_profile
cat /etc/skel/.bashrc
```

**Idea clave**
- `.bash_profile` → login shell, variables de entorno y arranque
- `.bashrc` → cada nueva shell interactiva, alias y funciones

---

## 5) Alias en Bash

## 5.1 Paso 35 — Ver alias actuales
**Objetivo**: conocer los alias ya definidos.

```bash
alias
```

## 5.2 Paso 36 — Crear alias `lt`
**Objetivo**: crear un alias que liste en orden inverso por tiempo.

```bash
alias lt='ls -lrt'
alias
```

## 5.3 Paso 37 — Probar el alias `lt`
**Objetivo**: confirmar que funciona.

```bash
lt /var
```

## 5.4 Paso 38 — Eliminar el alias
**Objetivo**: practicar `unalias`.

```bash
unalias lt
alias
```

---

## 6) Funciones en Bash

## 6.1 Paso 39 — Ver funciones actuales
**Objetivo**: listar funciones definidas en la shell.

```bash
declare -f
```

## 6.2 Paso 40 — Crear función `lS`
**Objetivo**: definir una función que liste en orden inverso por tamaño.

```bash
lS() { ls -lrS $@; }
declare -f
```

**Importante**
- el nombre es `lS`: letra `l` minúscula + `S` mayúscula

## 6.3 Paso 41 — Probar la función
**Objetivo**: verificar que acepta argumentos.

```bash
lS /var
```

## 6.4 Paso 42 — Borrar la función
**Objetivo**: practicar `unset` aplicado a funciones.

```bash
unset lS
declare -f
```

---

## 7) Persistir alias y función en `/etc/skel/.bashrc`

## 7.1 Paso 43 — Editar `/etc/skel/.bashrc`
**Objetivo**: dejar definiciones para usuarios nuevos.

```bash
nano /etc/skel/.bashrc
```

## 7.2 Paso 44 — Añadir alias y función al final del archivo
**Objetivo**: hacer persistentes ambas definiciones.

Añade estas líneas:

```bash
alias lt='ls -lrt'
lS() { ls -lrS $@; }
```

## 7.3 Paso 45 — Guardar cambios
**Objetivo**: cerrar nano correctamente.

```text
Ctrl+X
y
Enter
```

## 7.4 Paso 46 — Probar el archivo con `source`
**Objetivo**: validar sin reiniciar sesión.

```bash
source /etc/skel/.bashrc
```

**Qué debes hacer si falla**
- volver a editar el archivo
- corregir sintaxis
- repetir `source /etc/skel/.bashrc`

## 7.5 Paso 47 — Verificar alias y función cargados
**Objetivo**: confirmar que quedaron definidos.

```bash
alias
declare -f
```

**Qué debes observar**
- debe aparecer `alias lt='ls -lrt'`
- debe aparecer la función `lS()`

---

## Buenas prácticas

- Usa `source` o `.` para probar cambios antes de cerrar sesión.
- Separa bien qué va en `.bash_profile` y qué va en `.bashrc`.
- Prueba alias y funciones primero en shell interactiva.
- Usa `/etc/skel` solo cuando quieras afectar a usuarios nuevos.
- Verifica cada cambio con `echo $PATH`, `alias`, `declare -f` y `cat`.

## Evita / si puedes

- No edites archivos de inicio sin probar con `source`.
- No confundas `PATH=$PATH` con un cambio real si no añades una ruta nueva.
- No olvides dar permisos de ejecución a scripts.
- No asumas que cambiar `/etc/skel` afecta a usuarios ya existentes.
- No borres funciones con `unset VARIABLE` sin saber qué estás quitando.

---

## Probar y validar sin reiniciar (clave)

## Comandos de verificación
```bash
set
env
echo $COLUMNS
echo $PATH
cat scripts/today
ls -l scripts/today
today
cat -n ~/.bash_profile
source ~/.bash_profile
ls -a /etc/skel
cat ~testuser/.bash_profile
alias
declare -f
source /etc/skel/.bashrc
```

## Nota de seguridad
Si falla, corrige antes de reiniciar o cerrar sesión. En especial, si rompes `.bash_profile` o `.bashrc`, valida con `source` antes de salir.

---

## Errores típicos / trampas

- Crear el script con `>` dos veces y sobrescribir la primera línea.
- Olvidar `chmod` antes de intentar ejecutarlo directamente.
- Añadir `~/scripts` al `PATH` de forma temporal y creer que quedará persistente.
- Editar `.bash_profile` y no recargarlo con `source`.
- Confundir `.bash_profile` con `.bashrc`.
- Creer que `/etc/skel` modifica usuarios ya existentes.
- Escribir mal la función `lS()` por la diferencia entre `l` y `S`.
- Usar `unset lS` sin comprobar luego con `declare -f`.

---

## Resumen mínimo del laboratorio

```bash
set
env
PS1='\# \$ '
PS1='\u@\h \w \$ '
export COLUMNS=60
echo $COLUMNS
echo $PATH
mkdir scripts
echo '#!/bin/bash' > scripts/today
echo 'echo Today is $(date +%D)' >> scripts/today
bash scripts/today
chmod a+rx scripts/today
PATH=$PATH:$HOME/scripts
today
cat -n ~/.bash_profile
source ~/.bash_profile
ls -a /etc/skel
su -
cp ~sysadmin/.bash_profile /etc/skel
useradd testuser
cat ~testuser/.bash_profile
alias
alias lt='ls -lrt'
unalias lt
declare -f
lS() { ls -lrS $@; }
unset lS
nano /etc/skel/.bashrc
source /etc/skel/.bashrc
```

---

## Base del laboratorio en el PDF

Este laboratorio corresponde al **Lab 1: Advanced Shell Features**, que empieza en la página 29 con **1.1 Step 1** y continúa hasta la comprobación final de alias y función en `/etc/skel/.bashrc` y usuarios nuevos.
