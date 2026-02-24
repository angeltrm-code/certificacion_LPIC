**El Shell y los comandos GNU pagina 112 pdf del manual curso

###Procesar secuencias de texto usando filtros
cat
cut
head
less
md5sum
nl
od
paste
sed
sha256sum
sha512sum
sort
split
tail
tr
uniq
wc


##Utilizamos el archivo empleados.csv
cd /lpic-1

# 1. Ver contenido del archivo
cat empleados.csv

# 2. Extraer columnas específicas
cut -d ";" -f 1 empleados.csv | head
cut -d ";" -f 2 empleados.csv | tail

# 3. Mostrar primeras y últimas líneas
head -5 empleados.csv
tail -5 empleados.csv

# 4. Numerar líneas del archivo
nl empleados.csv | less
nl -s ". " empleados.csv | head

# 5. Convertir caracteres
cat empleados.csv | tr '[:lower:]' '[:upper:]' | head
cat empleados.csv | tr '[:upper:]' '[:lower:]' | head
cat empleados.csv | tr -d ";" | head

# 6. Ordenar datos
sort empleados.csv | head
cut -d ";" -f 1 empleados.csv | sort | uniq

# 7. Filtrar texto con sed
sed 's/;/ | /g' empleados.csv | head
sed -n '2,6p' empleados.csv
sed '/Grace/d' empleados.csv | head

# 8. Unir columnas con paste
cut -d ";" -f 1 empleados.csv > nombres.txt
cut -d ";" -f 2 empleados.csv > correos.txt
paste nombres.txt correos.txt | head

# 9. Partir el archivo en partes pequeñas
split -l 10 empleados.csv parte_
ls parte_*

# 10. Contar palabras, líneas y caracteres
wc -l empleados.csv
wc -w empleados.csv
wc -c empleados.csv

# 11. Ver contenido en formato binario o hexadecimal
od -c empleados.csv | head
od -x empleados.csv | head

# 12. Verificar integridad del archivo con md5sum, sha256sum, sha512sum
md5sum empleados.csv
sha256sum empleados.csv
sha512sum empleados.csv


*Exactamente, la diferencia principal entre paste y join en Linux radica en cómo combinan los archivos:

paste → Combina líneas por posición
Se usa cuando ambos archivos tienen el mismo número de líneas.
Une líneas de los archivos horizontalmente.
No necesita que los archivos tengan un campo en común.

##Ejemplos:

$ cat file1.txt
A
B
C

$ cat file2.txt
1
2
3

$ paste file1.txt file2.txt
A   1
B   2
C   3


#join → Une archivos por un campo en común
Se usa cuando los archivos tienen un campo en común.
Une líneas basándose en la coincidencia de valores de una columna.
Los archivos deben estar ordenados por la columna clave.

$ cat nombres.txt
1 Ana
2 Juan
3 Maria

$ cat edades.txt
1 25
2 30
3 22

$ join nombres.txt edades.txt
1 Ana 25
2 Juan 30
3 Maria 22


##Diferencias clave
Comando	Uso principal	                Requisito
paste	Une líneas horizontalmente   	Los archivos deben tener el mismo número de líneas
join	Une líneas por un campo común	Los archivos deben estar ordenados por la clave


#Comando tee en Linux
El comando tee se utiliza para dividir la salida de un comando, enviándola simultáneamente a la terminal y a uno o más archivos.

comando | tee archivo

1. Guardar la salida de ls en un archivo y verla en la terminal
ls -l | tee salida.txt
La salida de ls -l se mostrará en pantalla y se guardará en salida.txt.

2. Añadir salida a un archivo sin sobrescribir (-a)
df -h | tee -a espacio.txt
Se añade información sobre el espacio en disco a espacio.txt, sin borrar el contenido previo.


3. Redirigir la salida de dmesg y analizar con grep
Redirigir la salida de dmesg y analizar con grep
dmesg | tee log.txt | grep "error"
Guarda los logs del sistema en log.txt y muestra solo las líneas que contienen "error".

4. Ejecutar un script y guardar el resultad
./script.sh | tee resultado.log
✔️ Se ejecuta script.sh, mostrando su salida en pantalla y guardándola en resultado.log.


##Usos avanzados de tee
Opción	                     Descripción
-a	                         Añade la salida al archivo en lugar de sobrescribirlo.
tee archivo1 archivo2	     Guarda la salida en varios archivos simultáneamente.



#El comando xargs en Linux y sistemas Unix se utiliza para construir y ejecutar comandos utilizando los argumentos proporcionados desde la entrada estándar o desde la salida de otro comando. Es muy útil cuando deseas pasar un conjunto de argumentos a un comando que no puede manejar entradas estándar de forma directa.

Eliminar archivos: ls /var/log/*.log | xargs rm -rf
Eliminar archivos: find /  -type f -name "*.tmp" | xargs rm -rf


Buscar y eliminar archivos: find . -name "*.txt" | xargs rm

Mover archivos listados en un archivo: cat lista.txt | xargs mv -t /ruta/destino/

Contar líneas de archivos .txt: find . -name "*.txt" | xargs wc -l

Ejecutar con límite de argumentos (2 por vez): ls | xargs -n 2 echo

Usar marcador de posición: echo archivo1 archivo2 | xargs -I {} mv {} /ruta/destino/

Confirmación antes de ejecutar: echo archivo1 archivo2 | xargs -p rm

Eliminar archivos con nombres que contienen espacios: find . -name "*.txt" -print0 | xargs

##Busca archivos con extesion log y que los cuente:
find / -type f  -name "*.log" | xargs -I {} echo {} |wc -l

| xargs -I {} echo {}: Usa xargs para procesar cada archivo encontrado, pasando su nombre a echo, lo cual permite generar una lista de nombres de archivo.


El comando xargs -I {} en Linux se usa para ejecutar un comando sobre cada entrada proporcionada. Permite personalizar la posición del argumento en el comando que se ejecuta

comando_que_generara_datos | xargs -I {} otro_comando {}

-I {} → Define {} como un marcador de posición que será reemplazado por cada línea de la entrada.
comando_que_generara_datos → Genera una lista de valores o archivos.
otro_comando {} → Se ejecuta usando cada valor como argumento.

1. Crear directorios a partir de una lista
echo "dir1 dir2 dir3" | xargs -I {} mkdir {}
Crea los directorios dir1, dir2 y dir3.

2. Mover archivos a un directorio
ls *.txt | xargs -I {} mv {} /ruta/destino/
✔️ Mueve todos los archivos .txt al directorio /ruta/destino/.

3. Buscar y eliminar archivos
find . -name "*.log" | xargs -I {} rm {}
Busca y elimina todos los archivos .log en el directorio actual.

#Buscar archivos y cambiar permisos
find /ruta -type f -name "*.sh" | xargs -I {} chmod +x {}
✔️ Hace ejecutables todos los archivos .sh en /ruta/.


5. Renombrar archivos añadiendo un prefijo
ls *.jpg | xargs -I {} mv {} nuevo_{}
✔️ Renombra foto.jpg a nuevo_foto.jpg y así con todos los archivos .jpg.

6. Buscar texto dentro de archivos encontrados con find
find . -name "*.log" | xargs -I {} grep "ERROR" {}
✔️ Busca la palabra "ERROR" en todos los archivos .log.

xargs -I {} es útil cuando necesitas procesar elementos individualmente en comandos que no admiten múltiples argumentos a la vez.




