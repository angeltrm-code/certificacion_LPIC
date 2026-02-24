#!/bin/bash

#Limpiamos la pantalla.

clear

#Capturamos el valor de una variable

echo "Introduce tu nombre"

read nombre

echo "Introduce tu apellido"

read apellido


if [ -z $nombre ] ; then
        echo "No has introducido ningún Nombre."
        echo "Saliendo..."
        exit 0
else

        if [ -z $apellido ] ; then
        echo "No has introducido ningún Apellido."
        echo "Saliendo..."
        exit 0
else
echo "Hola "$nombre $apellido"."



echo "Elige un número del 1 al 10"

read num

if [ -z $num ] ; then
        echo "No has introducido ningún número."
        echo "Saliendo..."
        exit 0
else
        if  [[ $num -gt "10" || $num -lt "1" ]] ; then
                echo "El número elegido ("$num") no es válido."
                echo "El rango es entre 1 y 10."
        else
                echo "El número que has elegido es el: "$num
        fi
    fi
 fi
fi
