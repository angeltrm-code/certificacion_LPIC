# Ejercicio 6

Conjunto de ejercicios sobre Ejercicio 6, reorganizado para facilitar la práctica y la revisión.

```bash
cd /
git clone https://github.com/agarciafer/lpic1.git
```

```bash
cd /lpic1
```

### Dado el siguiente archivo:

```
cat  bienvenidos.txt
```

### BIENVENIDOOS AA ASTURIASy

### Convierte los caracteres aeiou en minúsculas con tr:

### Con el ejemplo anterior para cambiar todo el alfabeto  de mayus a minus  utilizar rangos:

Con tr -s ao elimina del texto todas las a y o que encuentre duplicadas.

### Para elminar un carácter en este caso la y podemos utilizar el comando:

### tr -d y

Con el comando xargs cuántas líneas tiene cada fichero:

```bash
cat ficheros.txt
```

```bash
/etc/passwd
/etc/fstab
```

Repita el comando anterior,si le ponemos el comando echo a xargs veremos que comando se esta utilizando:

Si queremos que por cada argumento ejecute un comando le pasamos el parámetro -i con  {}, con este comando podre ver que no me da los totales porque lanza los 4 comandos del wc -l por cada fichero.

Buscar todos los ficheros .conf del directorio /etc que contengan la palabra root dentro de su contenido…

utilizar el comando find (Para buscar todos los ficheros de /etc que terminen en .conf), y luego con ese resultado utilizamos xarg en conjunto con grep (xarg):

### Con el comando echo ver el valor de la variable $USER:

### Buscar todas las palabras que comiencen por a en un archivo:

Mostrar por pantalla, las líneas que contienen comentarios en el archivo /boot/grub/menu.lst:

### Enviar al  fichero1 las líneas del archivo /boot/grub/menu.lst que no son comentarios:

Contar el número de interfaces buscamos por iface, que tenemos definidos en el fichero /etc/network/interfaces:

### Mostrar las líneas de un fichero que contienen la palabra BADAJOZ o HUELVA:

Mostrar las líneas de un fichero que contienen la palabra BADAJOZ o HUELVA, numerando las líneas de salida:

Mostrar los ficheros que contienen la palabra TOLEDO en el directorio actual y todos sus subdirectorios:

## Laboratorio grep con expresiones regulares####:

### Obtener la dirección MAC de la interfaz de red eth0 de nuestra máquina:

### Extraer la lista de direcciones de correo electrónico de un archivo fichero.txt:

Obtener la dirección IP de la interfaz de red eth0 de nuestra máquina utilizamos ifconfig y grep:

```
Explique  la expresión regular:
```

‘([0-9]{1,3}\.){3}[0-9]{1,3}’

### Con expresiones regulares si queremos representar un caracter entre la a y la z,:

### Si lo que queremos es representar identificar un número o una letra:

### Representar un número que se compone de cero o más dígitos:

### Representar un número que se compone de uno o más dígitos:

### Representar cualquier caracter menos los dígitos:

### Representar un número de 5 dígitos:

### Y si quisiéramos representar una palabra que tiene entre dos y cuatro caracteres:

### Comando con grep para nos devuelva  todas las líneas del fichero que comienzan por La

Camando con grep para que nos devuelve todas las líneas del fichero que comienzan por cualquier número de espacios seguido de La.

Comando con grep que nos devuelve todas las líneas del fichero que comienzan por punto y tienen cualquier número de caracteres.

Comando con grep que nos devuelve la lista de ficheros que comienzan por un espacio seguido de un punto y cualquier número de caracteres, es decir, la lista de ficheros ocultos.

Comando grep que  nos devuelve la lista de ficheros que comienzan por d, es decir, la lista de directorios

### Comparar dos ficheros, ignorando los espacios en blanco, utilizaremos el parámetro -w:

Comparar dos ficheros queremos es que no nos muestre las diferencias, sino que tan sólo nos informe de si son diferentes o no:

Comparar dos ficheros, queremos que nos muestre la salida con las diferencias marcadas a dos columnas:

### Para borrar con sed la linea 1 de fichero.txt

### Para borrar con sed el intervalo de lines del 3 al 5 de fichero:

### Para borrar con sed desde la linea 3 en adelante en fichero:

### Parar borrar con sed las lineas en blanco de un fichero:

### Para sustituir con sed cadena1 por cadena2 en fichero:

### Para sustituir con sed cadena1 por cadena2 en todo el fichero:

### Para sustituir con sed en la linea 5 USUARIO por usuario en todo el fichero:

### Buscar con sed el  patrón cadena en un fichero:

### Buscar con se AAA o BBB o CCC en fichero:

### Buscar con sed AAA y BBB y CCC en fichero:

### Añadir con sed  una línea antes o despues del final de un fichero ($=última línea):

### Ver las primeras 10 líneas de un fichero con sed:

Ver las primeras 10 líneas de /etc/passwd con sed y que numeres las lines y lo envie a fichero2:

### Ver desde las  líneas 2 a la 5 de /etc/passwd con sed y que numeres las lineas:

### Con sed mostrar la 1 linea del archivo /etc/passwd:

### Eliminar con sed  desde una línea 2 hasta el final del fichero:

Eliminar con sed la línea que comiencen por borrar:
