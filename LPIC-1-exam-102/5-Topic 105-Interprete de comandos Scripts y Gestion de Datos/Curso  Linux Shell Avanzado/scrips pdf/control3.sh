#!/bin/bash
#Limpiamos la pantalla.
clear
#Capturamos el valor de una variable
echo "Introduce tu nombre"
read nombre
if [ -z "$nombre" ] ; then
	echo "No has introducido ningun nombre."
	echo "Saliendo..."
	exit 0
else
	echo "Introduce tu apellido"
	read apellido
		if [ -z "$apellido" ] ; then
		echo "No has introducido ningun apellido."
		echo "Saliendo..."
		exit 0
		else	
		echo "Hola "$nombre $apellido"."
		fi
fi
echo "Elige un nú del 1 al 10"
read num
if [ -z $num ] ; then
echo "No has introducido ningúmero."
echo "Saliendo..."
exit 0
else
if [[ $num -gt "10" || $num -lt "1" ]] ; then
echo "El nú elegido ("$num") no es vádo."
echo "El rango es entre 1 y 10."
else
echo "El nú que has elegido es el: "$num
fi
fi
