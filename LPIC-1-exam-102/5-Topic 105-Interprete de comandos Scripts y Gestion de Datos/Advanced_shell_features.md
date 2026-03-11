# VC-10-03-2026-12 | Listas en Bash

## Qué es
En Bash, una **lista** es una secuencia de uno o varios comandos separados por operadores de control como `;`, `&&`, `||` o `&`.

Sirven para encadenar órdenes y decidir si el siguiente comando debe ejecutarse siempre, solo si el anterior tuvo éxito, si falló, o en segundo plano.

## Para qué sirve
- Encadenar varios comandos en una sola línea.
- Controlar ejecución condicional en scripts y terminal.
- Lanzar procesos en segundo plano.
- Resolver preguntas típicas de examen sobre `;`, `&&`, `||` y `&`.

## 1) Lista simple con `;`
El punto y coma `;` separa comandos y hace que se ejecuten **uno detrás de otro**, independientemente de si el anterior tuvo éxito o error.

**Comandos**
```bash
pwd; date; whoami
```

**Ejemplo**
```bash
cd /tmp; ls; uname -r
```

**Idea clave**
- ejecuta el siguiente comando siempre
- no depende del código de salida del anterior

## 2) Lista condicional con `&&`
`&&` ejecuta el segundo comando **solo si el primero terminó correctamente**.

**Comandos**
```bash
mkdir /tmp/prueba && cd /tmp/prueba
```

**Ejemplo**
```bash
touch fichero && ls -l fichero
```

**Explicación breve**
- si `mkdir` funciona, entonces hace `cd`
- si `mkdir` falla, no ejecuta `cd`

## 3) Lista condicional con `||`
`||` ejecuta el segundo comando **solo si el primero falla**.

**Comandos**
```bash
cd /directorio/inexistente || echo "No existe"
```

**Ejemplo**
```bash
grep root /tmp/archivo || echo "No encontrado"
```

**Explicación breve**
- si el primer comando da error, se ejecuta el segundo
- muy útil para control de errores

## 4) Combinación de `&&` y `||`
Se pueden encadenar para construir lógica simple.

**Comandos**
```bash
grep root /etc/passwd && echo "Existe" || echo "No existe"
```

**Ejemplo**
```bash
test -f /etc/fstab && echo "Archivo presente" || echo "Archivo ausente"
```

**Explicación breve**
- si la condición se cumple, muestra un mensaje
- si falla, muestra otro

**Cuidado**
No siempre sustituye perfectamente a un `if`, sobre todo si el comando intermedio puede fallar por otra razón.

## 5) Lista en background con `&`
El operador `&` ejecuta un comando en **segundo plano**.

**Comandos**
```bash
sleep 60 &
```

**Ejemplo**
```bash
tar -czf copia.tar.gz /etc &
```

**Comprobación**
```bash
jobs
ps -ef | grep sleep
```

## 6) Diferencia rápida entre operadores
### `;`
Ejecuta siempre el siguiente comando.

false; echo "se ejecuta"

### `&&`
Ejecuta el siguiente solo si el anterior tuvo éxito.

```bash
true && echo "se ejecuta"
false && echo "no se ejecuta"
```

### `||`
Ejecuta el siguiente solo si el anterior falló.

```bash
false || echo "se ejecuta"
true || echo "no se ejecuta"
```

### `&`
Ejecuta el comando en segundo plano.

```bash
sleep 30 &
```

## 7) Código de salida y listas
Las listas con `&&` y `||` dependen del **código de retorno** del comando anterior.

**Comandos**
```bash
true
echo $?
false
echo $?
```

**Idea clave**
- `0` → éxito
- distinto de `0` → error o condición falsa

Esto es clave:
- `&&` reacciona ante `0`
- `||` reacciona ante valor distinto de `0`

## 8) Uso práctico típico
### Crear directorio y entrar
```bash
mkdir proyecto && cd proyecto
```

### Intentar entrar y avisar si falla
cd /datos || echo "No se pudo entrar"

### Ejecutar varias órdenes pase lo que pase
```bash
date; whoami; pwd
```

### Lanzar una tarea en segundo plano
```bash
find / -name "*.log" 2>/dev/null &
```

## 9) Agrupación con listas
Puedes agrupar comandos para ejecutarlos de forma conjunta.

Con llaves:

```bash
{ date; whoami; pwd; }
```

**Ejemplo**
```bash
{ echo "Inicio"; ls /tmp; echo "Fin"; }
```

Con paréntesis:

```bash
( cd /tmp; pwd )
```

**Explicación breve**
- `{ ...; }` ejecuta en la shell actual
- `( ... )` ejecuta en una subshell

## Buenas prácticas
- Usa `&&` para continuar solo si el paso anterior salió bien.
- Usa `||` para gestionar errores simples.
- Usa `;` cuando realmente quieras ejecutar todo pase lo que pase.
- Comprueba procesos en background con `jobs`.
- Usa listas cortas y claras.

## Evita / si puedes
- No abuses de cadenas largas de `&&` y `||` si un `if` sería más claro.
- No confundas `;` con `&&`.
- No lances procesos en background sin controlarlos luego.
- No olvides que `||` depende del código de salida, no del texto mostrado.
- No mezcles demasiados operadores en una sola línea sin necesidad.

## Probar y validar sin reiniciar (clave)
**Comandos de verificación**
```bash
pwd; date; whoami
mkdir -p /tmp/lista1 && cd /tmp/lista1 && pwd
cd /noexiste || echo "Directorio no disponible"
sleep 60 &
jobs
true
echo $?
false
echo $?
```

**Nota de seguridad**
Si falla, corrige antes de seguir; si lanzas procesos con `&`, verifica que realmente siguen en ejecución y contrólalos con `jobs`, `ps` o `kill`.

## Errores típicos / trampas
- Usar `;` pensando que actúa como `&&`.
- Usar `&&` y no entender por qué no se ejecuta el segundo comando.
- No comprobar `echo $?` al estudiar listas condicionales.
- Lanzar procesos con `&` y olvidarse de ellos.
- Pensar que `||` se basa en si el comando muestra error en pantalla, cuando en realidad depende del código de salida.
- Hacer cadenas complejas de operadores que se vuelven difíciles de leer.

## Comandos mínimos a memorizar
```bash
comando1 ; comando2
comando1 && comando2
comando1 || comando2
comando1 &
echo $?
jobs
```

## Trampas de examen muy típicas
- `;` → ejecuta siempre el siguiente.
- `&&` → ejecuta el siguiente solo si hubo éxito.
- `||` → ejecuta el siguiente solo si hubo fallo.
- `&` → ejecuta en segundo plano.
- `echo $?` → muestra el código de salida del último comando.
