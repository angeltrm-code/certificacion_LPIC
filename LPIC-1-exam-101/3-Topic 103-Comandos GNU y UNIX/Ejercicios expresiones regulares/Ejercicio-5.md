# Ejercicio 5

Conjunto de ejercicios de `grep`, `sed` y expresiones regulares para practicar filtrado de texto sobre los ficheros del laboratorio.

## Preparacion del entorno

En la maquina virtual Linux:

```bash
cd /lpic1
```

## Ejercicios con `grep` y `sed`

1. Averiguar con `grep` las veces que te ha visitado `gateway.ps.net` en el archivo `access_log`.
2. Averiguar con `grep` las veces que te han visitado `pwch3s01` y `204.251.93.247` en `access_log`.
3. Buscar las IP que han visitado `/var/log/httpd/access_log`, excluyendo la IP `192.168.1.14`.
4. Buscar `www.thyssen.com` en `access_log` y mostrar tambien las 5 lineas posteriores al criterio de busqueda.
5. Buscar `www.thyssen.com` en `access_log` y mostrar 1 linea anterior al criterio.
6. Visualizar la linea 58 completa del archivo `/etc/passwd` con `sed`.
7. Buscar la palabra `root` en `/var/log/` y mostrar en que fichero aparece.
8. Buscar la palabra `root` en `/var/log/` sin mostrar el nombre del fichero.
9. Buscar todo lo que comience por `root` en `/etc/passwd` y mostrar el numero de linea.
10. Buscar todo lo que comience por `root` en todos los archivos de `/var/log` y mostrar el numero de linea.
11. Visualizar la linea 1 completa del archivo `/etc/passwd` con `sed`.

## Ejercicios de expresiones regulares

12. Mostrar todo lo que comience por `www` en el archivo `access_log`.
13. Mostrar todo lo que sea `www.` y finalice con `.com.mx` en `access_log`.
14. Mostrar las lineas cuyo segundo caracter sea `u` o `8` en `access_log`.
15. Mostrar los nombres que contengan 3 caracteres en `nombres.txt`.
16. Ver todo lo que comience por `w` y por `n` en `access_log`.
17. Mostrar todo lo que comience por el rango entre `1` y `2` en `access_log`.
18. Negar lineas que no comiencen ni con `w` ni con `a` en `access_log`.
19. Buscar todas las lineas que contienen un solo caracter con `grep`.
20. Buscar todas las lineas que solamente tengan un punto con `grep`.
21. Seleccionar con `grep` las lineas que tengan al menos una letra, mayuscula o minuscula.
22. Indicar que opcion hay que usar para habilitar expresiones regulares extendidas con `grep`.

## Ejercicios con rangos y cuantificadores

23. Dado el fichero `números.txt`, identificar numeros de 1 a 4 digitos.
24. Mostrar solo los numeros menores de 100, es decir, de uno o dos digitos.
25. Filtrar solo las IP del archivo `access_log`.
26. Buscar en `test1` un patron que comience por `b`, contenga `an` y obligue a que la ultima letra sea `a`.
27. Buscar numeros de exactamente tres digitos en `numeros.txt`.
28. Buscar numeros de entre dos y tres digitos en `numeros.txt`.
29. Buscar numeros de tres digitos o mas en `numeros.txt`.

## Interpretacion de expresiones

Analiza que hacen las siguientes expresiones:

```bash
grep -E "^[0-9] ([0-9] [0-9])?$" números.txt
grep -E "^([0-9]|[0-9] {3})$" números.txt
egrep "^([0-9]|[0-9] {3})$" números.txt
```

## Ejercicios de sustitucion y limpieza

30. Cambiar el año de `2014` a `2018` con `sed` en el archivo `empresa.txt`, en todas las ubicaciones.
31. Visualizar en un fichero las lineas sin espacios o lineas vacias.
32. Resolver el ejercicio anterior utilizando `sed`.
33. Explicar que realiza un comando de limpieza o sustitucion dado.
34. Con `sed`, realizar una copia de seguridad `empresa.txt.original` antes de modificar `empresa.txt`.

## Ordenacion y agregacion

35. Ordenar el fichero `ips.txt`, contar las veces que se repite el acceso de una IP, volver a ordenarlo de forma numerica, guardarlo en un fichero y mostrar el resultado por pantalla.
36. Explicar la diferencia cuando en el ejercicio anterior se usa `tee` para añadir contenido al fichero en lugar de sobrescribirlo.
