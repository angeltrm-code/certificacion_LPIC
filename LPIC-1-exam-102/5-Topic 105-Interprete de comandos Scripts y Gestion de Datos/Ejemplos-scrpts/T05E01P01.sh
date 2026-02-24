#!/bin/bash

# Script generador de ficheros.

## Pide un nombre de archivo:
read -p "Introducir nombre de archivo: " fname;

### Verifica que se haya introducido un nombre
[[ -z $fname ]] && echo "El nombre de archivo no puede estar en blanco!" && exit 2;

## Pide una ruta de acceso:
read -p "Directorio de destino: " pname;

### Verifica que se haya introducido una ruta
[[ -z $pname ]] && echo "La ruta del archivo no puede estar en blanco!" && exit 2;

# La ruta debe terminar sin la barra invertida final
pname=$(realpath -m $pname);

## Pide el número de ficheros
read -p "Número de copias: " nfiles;

### Verifica que se haya introducido un número válido
[[ ! $nfiles =~ ^[0-9]+$ ]] && echo "Debe introducir un número válido" && exit 2;
# y que sea mayor que cero
[[ $nfiles -le 0 ]] && echo "El número debe ser mayor que cero" && exit 2;

## Crea ese número de ficheros, con el nombre especificado seguido de un número, en la ruta especificada

### La ruta indicada existe, pero no es un directorio
if [[ -e ${pname} ]] && [[ ! -d ${pname} ]] 
then
    echo "La ruta especificada (\"${pname}\") existe, pero no es un directorio";
    exit 1;
fi

### La ruta indicada no existe. 
if [[ ! -d ${pname} ]]
then
    #### Intenta crear el directorio indicado
    echo "Intentando crear directorio \"${pname}\"...";
    mkdir -p ${pname};
    if [[ $? -eq 0 ]]
    then
        echo "Directorio \"${pname}\" creado correctamente";
    else
        echo "No ha sido posible crear el directorio \"${pname}\"";
        exit 1;
    fi
fi


## Crea el número de archivos indicado en la ruta especificada
echo "Intentando crear ${nfiles} archivos en ${pname}...";

eval touch "${pname}/${fname}-{1..${nfiles}}";

### Verificando operación
if [[ $? -eq 0 ]]
then
    echo "${nfiles} archivos creados correctamente";
    exit 0;
else
    echo "Se ha producido un error intentando crear los archivos";
    exit 1;
fi



