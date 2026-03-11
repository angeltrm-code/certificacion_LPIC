# Ejercicio 2

Conjunto de ejercicios sobre Ejercicio 2, reorganizado para facilitar la práctica y la revisión.

Conjunto de ejercicios sobre Ejercicio 2, reorganizado para facilitar la práctica y la revisión.

## Desarrollo

## Utilizando el comando echo para salto de linea:

## Utilizando el comando echo para que muestre un tabulador :

## Con el comando echo que nos muestre  la variable del sistema $USER con un salto de linea:

## Para ver los 10 primeros usuarios del sistema /etc/passwd:

## Para ver los 10 utlimos usuarios del sistema /etc/passwd:

Para visualizar el numero de línea que quiero en este caso el primer usuario, en este caso una linea /etc/passwd:

## Para el comando tail mostraría el ultimo usuario creado:

## Para ver las ultimas 7 entradas en el archivo acces_log:

Para ver en todos los ficheros logs, las 5 primeras líneas, y me muestra el nombre de los ficheros y las 5 primeras líneas.

## Si queremos eliminar el nombre de los ficheros y realizar una búsqueda genérica con head:

## Para ver el 1 carácter de cada línea del archivo access_log:

## Para ver desde el caracter1 al caracter18 del archivo acces_log:

## Para seleccionar el carácter 1 y el 18 del archivo access_log:

## Para ver logs rangos desde el cararcter1 al 18 el 15 y el 2 del archivo access_log:

Buscando por el delimitador espacio en blanco en el archivo acces_log, nombre de maquina y fecha:

Buscar del archivo /etc/passwd que nos muestre el nombre se usuario y el shell del usuario:

## Sacar los 10 primeros caracteres de un fichero access_log:

## El primer carácter de un fichero acess_log:

```
Obtener  del archivo access_log, que contenga la palabra skylab 31/Aug 1995:23:46 y nos de el número de línea:
```

## En el archivo /etc/passwd obtener lo que coincidan con el patrón oper

De todos los archivos log del directorio /var/log, que se muestren en que ficheros ha encontrado la palabra root

Para ver la información de las lines que contengan la palabra root del /var/log/*.log, nos daría tanto el nombre del fichero encontrado como la línea del log.

## Para buscar usuarios o grupos del sistema que tengan el identificacador 100:

Con grep para que nos muestre el numero de línea donde encuentra el patrón que le pasamos root:

## Con grep , que no diferencia mayúsculas de minúsculas, para buscar root

## Para que nos muestre la cantida de líneas encontradas con este patrón A:

Buscaremos de forma recursiva en un directorio /var/log todos los archivos *.log el patron root:

## Para que solo sea root:
