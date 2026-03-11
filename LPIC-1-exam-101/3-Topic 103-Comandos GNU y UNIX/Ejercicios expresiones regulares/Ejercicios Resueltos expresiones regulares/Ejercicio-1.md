# Ejercicio 1

Conjunto de ejercicios sobre Ejercicio 1, reorganizado para facilitar la práctica y la revisión.

## Obtener la MAC del interface eth0 el archivo a consultar es ifcfg-eth0:

```bash
cat /etc/sysconfig/network-scripts/ifcfg-eth0 | grep HWADDR |  cut -c 8-24
ifconfig eth0 | grep -oiE '([0-9A-F]{2}:){5}[0-9A-F]{2}'
```

## Clonar repositorio formador:

```bash
dnf install git unzip -y
cd /
git clone https://github.com/agarciafer/lpic1.git
cd /lpic1
unzip access_log.zip
```

```bash
cd /lpic1/
```

## Mostrar la hora actual, solamente la hora:

```bash
date
date | cut -c12-19
date |cut -d" " -f4
date |tr -s " " |cut -d" " -f4
```

## Con el comando TR cambiar las minus a mayus de la palabra Hola:

```bash
echo "Hola" | tr 'a-z' 'A-Z'
```

## Mostrar el contenido de /etc/passwd sustituyendo los dos puntos “:” por espacios “ ”

```bash
cat /etc/passwd | tr : " "
```

## Líneas que contiene la cadena de caracteres vagrant en el fichero /etc/passwd

```bash
grep vagrant /etc/passwd
grep -w ^vagrant /etc/passwd
grep -w bash$ /etc/passwd
```

## Líneas que terminan por bash en el fichero /etc/passwd

```bash
grep bash$ /etc/passwd
```

## Muestra los campos 1, 3 y 7 del fichero /etc/passwd

cut -d: -f1,3,7 /etc/passwd

## Muestra los campos del 3 al 5 del fichero /etc/passwd

cut -d: -f3-5 /etc/passwd

## Muestra a partir del tercer campo del fichero /etc/passwd

### cut -d: -f3- /etc/passwd

Uso de tuberías(pipes). Muestra el nombre de usuario, el UID y el shell del usuario vagrant . Sustituye el delimitador “:” por un espacio.

```bash
grep vagrant /etc/passwd | cut -d: -f1,3,7 --output-delimiter=" "
 cat /etc/passwd |grep -w operador |cut -d: -f1,3,7 |tr : " "
```

## Número de líneas y de palabras del fichero /etc/passwd

### wc -l -w /etc/passwd

Utilizando tuberías(pipes). Número de usuarios del sistema que utilizan /bin/bash como shell:

```bash
grep /bin/bash$ /etc/passwd | wc -l
```

## Muestra el fichero /etc/passwd en orden inverso con el comando sort

```bash
sort -r /etc/passwd
```

Utilizando tuberías. Muestra por orden numérico el UID, el GID y el shell de la información contenida en /etc/passwd

cut -d: -f3,4,7 /etc/passwd | sort -n

## Pasar las vocales a mayúsculas de la palabra murcielago

```bash
echo murcielago | tr aeiou AEIOU
```

## Mostrar el contenido de /etc/passwd sustituyendo los dos puntos “:” por espacios “ ”

```bash
cat /etc/passwd | tr : " "
```

## Mostrar el contenido de la carpeta actual en formato largo eliminando los espacios duplicados

```bash
ls -l | tr -s " "
```

## Buscar todas las palabras que comiencen por a en  archivo:

```bash
grep "^a*" archivo
```

Mostrar por pantalla, las líneas que contienen comentarios en el archivo /boot/grub/menu.lst:

```bash
grep "#" /boot/grub2/grub.cfg
```

## Enviar a un fichero las líneas del archivo  /boot/grub2/grub.cfg que no son comentarios:

```bash
grep -v "#"  /boot/grub2/grub.cfg > fichero-salida
```

## Mostrar las líneas de un fichero que contienen la palabra BADAJOZ o HUELVA:

```bash
grep -e “BADAJOZ” -e “HUELVA” archivo
```

Mostrar las líneas de un fichero que contienen la palabra BADAJOZ o HUELVA, numerando las líneas de salida:

```bash
 grep -n -e "BADAJOZ" -e "HUELVA" archivo
 grep -w -n -e "berto" -e "vagrant" -e "oracle"  /etc/passwd
```

Mostrar los ficheros que contienen la palabra TOLEDO en el directorio actual y todos sus subdirectorios:

```bash
grep -r "TOLEDO" *
```

## Obtener la dirección MAC de la interfaz de red eth0 de nuestra máquina:

```bash
ifconfig eth0 | grep -oiE '([0-9A-F]{2}:){5}[0-9A-F]{2}'
```

## Explicacion:

### Sacamos la dirección MAC de la interfaz eth0 de nuestra máquina haciendo un:

```bash
ifconfig eth0
```

## Y aplicando el filtro grep:

```bash
grep -oiE ‘([0-9A-F]{2}:){5}[0-9A-F]{2}’
```

## Las opciones que he usado en grep son:

-o Indica que la salida del comando debe contener sólo el texto que coincide con el patrón, en lugar de toda la línea, como es lo habitual.

-i Lo he usado para que ignore la distinción entre mayúsculas y minúsculas.

-E Indica que vamos a usar una expresión regular extendida.

## En cuanto a la expresión regular, podemos dividirla en dos partes:

([0-9A-F]{2}:){5} Buscamos 5 conjuntos de 2 carateres seguidos de dos puntos

[0-9A-F]{2} seguido por un conjunto de dos caracteres.

Como las direcciones MAC se representan en hexadecimal, los caracteres que buscamos son los números del 0 al 9 y las letras desde la A a la F.

Averiguar lo que ocupa los directorios personales de todos los usuarios que comiencen por una o que tengamos en el sistema:

```
cat   /etc/passwd | grep ^o |cut -d: -f7 |xargs du -h
```

Buscar en el directorio /etc/httpd/conf/ todos los ficheros que tengan la palabra listen tendremos que difernciar mayu y minus, no nos tienen que aparecer las lineas que tengan comentarios:

```bash
grep -iR  listen /etc/httpd/conf* |grep -v '#'
```

## Ordenar listado de ips:

```bash
 sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 addresses.txt
```

-k 1,1 -k 2,2 -k 3,3 -k 4,4    Ordena por cada octeto de la dirección IP, de izquierda a derecha.

## Ordenando por la ultima columna en este caso por el ultimo octeto de la direccion ip:

```bash
sort -n -t .  -k 4,4 ipsorcenadas
```

```bash
 alias ips='grep -Eo "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" /lpic1/access_log'
```

---

========================

### Explicación Detallada - Comandos Linux (Ejercicio LPIC1)

========================

## 1. Obtener MAC address de eth0

---

```bash
cat /etc/sysconfig/network-scripts/ifcfg-eth0 | grep HWADDR | cut -c 8-24
```

- `cat`: muestra el contenido del archivo.
- `grep HWADDR`: filtra solo la línea que contiene "HWADDR".
- `cut -c 8-24`: extrae los caracteres desde la posición 8 a la 24 (donde está la MAC).

```bash
ifconfig eth0 | grep -oiE '([0-9A-F]{2}:){5}[0-9A-F]{2}'
```

- `ifconfig eth0`: muestra la información de red de la interfaz eth0.
- `grep -o`: muestra solo el texto que coincide.
- `-i`: ignora mayúsculas/minúsculas.
- `-E`: activa expresiones regulares extendidas.
- `'([0-9A-F]{2}:){5}[0-9A-F]{2}'`: busca una dirección MAC en formato hexadecimal.

## 2. Instalar git, clonar repositorio y descomprimir

---

```bash
dnf install git unzip -y
```

- `dnf install`: instala paquetes.
- `git unzip`: nombres de los paquetes a instalar.
- `-y`: responde "sí" automáticamente a las confirmaciones.

```bash
git clone https://github.com/agarciafer/lpic1.git
```

- `git clone`: clona un repositorio remoto.

```bash
unzip access_log.zip
```

- `unzip`: extrae archivos de un archivo ZIP.

## 3. Mostrar solo la hora actual

---

```bash
date | cut -c12-19
```

- `cut -c12-19`: extrae los caracteres del 12 al 19, que corresponden a la hora.

```bash
date | cut -d" " -f4
```

- `-d" "`: usa espacio como delimitador.
- `-f4`: muestra el cuarto campo (la hora).

```bash
date | tr -s " " | cut -d" " -f4
```

- `tr -s " "`: comprime múltiples espacios en uno solo.

## 4. Cambiar minúsculas a mayúsculas

---

```bash
echo "Hola" | tr 'a-z' 'A-Z'
```

- `tr`: convierte letras minúsculas en mayúsculas.

## 5. Sustituir ":" por espacios en /etc/passwd

---

```bash
cat /etc/passwd | tr : " "
```

- `tr : " "`: reemplaza dos puntos por espacios.

## 6. Buscar líneas específicas en /etc/passwd

---

```bash
grep vagrant /etc/passwd
```

- Busca cualquier línea que contenga "vagrant".

```bash
grep -w ^vagrant /etc/passwd
```

- `-w`: busca coincidencia exacta de palabras.
- `^`: ancla al inicio de línea.

```bash
grep -w bash$ /etc/passwd
```

- `$`: ancla al final de línea (líneas que terminan en "bash").

## 7. Extraer campos de /etc/passwd

---

### cut -d: -f1,3,7 /etc/passwd

- `-d:`: usa ":" como delimitador.
- `-f1,3,7`: muestra los campos 1 (usuario), 3 (UID) y 7 (shell).

### cut -d: -f3-5 /etc/passwd

- `-f3-5`: muestra del campo 3 al 5.

### cut -d: -f3- /etc/passwd

- `-f3-`: muestra desde el campo 3 hasta el final.

## 8. Pipes con cut y grep

---

```bash
grep vagrant /etc/passwd | cut -d: -f1,3,7 --output-delimiter=" "
```

- `--output-delimiter=" "`: reemplaza ":" por espacio en la salida del cut.

```bash
cat /etc/passwd | grep -w operador | cut -d: -f1,3,7 | tr : " "
```

- Igual que el anterior, pero usando `tr` para reemplazar ":" por espacio.

## 9. Contar líneas y palabras

---

### wc -l -w /etc/passwd

- `-l`: cuenta líneas.
- `-w`: cuenta palabras.

## 10. Contar usuarios con shell /bin/bash

---

```bash
grep /bin/bash$ /etc/passwd | wc -l
```

- `grep /bin/bash$`: busca líneas que terminan en "/bin/bash".
- `wc -l`: cuenta cuántas líneas hay (usuarios con ese shell).

## 11. Ordenar contenido

---

```bash
sort -r /etc/passwd
```

- `-r`: orden inverso (de Z a A o de mayor a menor).

### cut -d: -f3,4,7 /etc/passwd | sort -n

- `-n`: ordena numéricamente por la primera columna (UID).

## 12. Cambiar vocales a mayúsculas

---

```bash
echo murcielago | tr aeiou AEIOU
```

- `tr`: cambia las vocales minúsculas a mayúsculas.

## 13. Mostrar directorio actual sin espacios duplicados

---

```bash
ls -l | tr -s " "
```

- `tr -s " "`: reemplaza múltiples espacios seguidos por uno solo.

## 14. Buscar palabras por letra inicial

---

```bash
grep "^a*" archivo
```

- `^a*`: líneas que comienzan con cero o más letras "a".

## 15. Comentarios en GRUB y salida a archivo

---

```bash
grep "#" /boot/grub2/grub.cfg
```

- Busca líneas con el carácter "#".

```bash
grep -v "#" /boot/grub2/grub.cfg > fichero-salida
```

- `-v`: invierte la búsqueda, muestra líneas que NO contienen "#".
- `>`: redirige la salida al archivo "fichero-salida".

## 16. Buscar múltiples palabras con grep

---

```bash
grep -e "BADAJOZ" -e "HUELVA" archivo
```

- `-e`: permite definir múltiples patrones de búsqueda.

```bash
grep -n -e "BADAJOZ" -e "HUELVA" archivo
```

- `-n`: numera las líneas de salida.

```bash
grep -w -n -e "berto" -e "vagrant" -e "oracle" /etc/passwd
```

- `-w`: búsqueda exacta de palabra.
- `-n`: muestra número de línea.

## 17. Búsqueda recursiva

---

```bash
grep -r "TOLEDO" *
```

- `-r`: busca recursivamente en subdirectorios.

## 18. Tamaño de homes de usuarios que empiezan por "o"

---

```bash
cat /etc/passwd | grep ^o | cut -d: -f7 | xargs du -h
```

- `cut -f7`: obtiene el directorio home.
- `xargs du -h`: pasa cada directorio a `du -h` para mostrar su tamaño.

## 19. Buscar palabra 'listen' sin comentarios

---

```bash
grep -iR listen /etc/httpd/conf* | grep -v '#'
```

- `-i`: ignora mayúsculas/minúsculas.
- `-R`: búsqueda recursiva.
- `grep -v '#'`: excluye líneas con comentarios.

## 20. Ordenar direcciones IP

---

```bash
sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 addresses.txt
```

- `-n`: orden numérico.
- `-t .`: usa punto como delimitador.
- `-k`: ordena por cada octeto.

```bash
sort -n -t . -k 4,4 ipsorcenadas
```

- Ordena solo por el último octeto.

## 21. Alias para extraer IPs

---

```bash
alias ips='grep -Eo "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" /lpic1/access_log'
```

- `-E`: expresiones regulares extendidas.
- `-o`: solo muestra coincidencias.
- `"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"`: busca direcciones IP.
