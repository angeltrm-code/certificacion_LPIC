#!/bin/bash

# Script que muestra una lista completa y recursiva del contenido
# de cualquier directorio que se le indique como argumento.


# En caso de no recibir argumentos, muestra un mensaje
# de ayuda con el uso correcto de la apliación.
if [[ -z ${1} ]] 
then
    echo -en \
    "Falta un argumento.\n" \
    "Uso: \n" \
    "${0} directorio\n" >&2;
    exit 1;
fi

# Si la ruta indicada no existe, muestra un error.
[[ ! -e ${1} ]] && \
    echo -e "La ruta indicada, \"${1}\", no existe." >&2 && \
    exit 1;

# Mostrará un mensaje de error si el argumento no es un directorio.
[[ -e ${1} ]] && [[ ! -d ${1} ]] && \
    echo -e "La ruta indicada, \"${1}\", no es un directorio." >&2 && \
    exit 1;

# Se mostrará un error en caso de no disponer 
# de permisos de lectura sobre el directorio.
[[ ! -r ${1} ]] && \
    echo -e "No dispone de permisos para mostrar el contenido de \"${1}\"" >&2 && \
    exit 1;

# Intenta mostrar la lista recursiva del directorio indicado
ls -lRh ${1};

# Finalización correcta
exit 0;
