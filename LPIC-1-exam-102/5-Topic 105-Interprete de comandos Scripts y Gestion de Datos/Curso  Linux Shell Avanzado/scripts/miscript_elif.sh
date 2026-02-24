#!/bin/bash
#Fecha: 31.12.2014
#Autor: Autor
#Proposito: Evaluando IF THEN ELIF COMPARAMOS LOS NUMEROS 5 0 MENOR QUE Y MAYOR QUE 0

#CODIGO
read -p "Introduce un numero del 1 al 9: " NUMERO

if [ $NUMERO -eq 5 ]
then
	echo "El numero introducido es IGUAL que 5"

elif [ $NUMERO -eq 0 ]
then
        echo "El numero introducido es 0"


elif [ $NUMERO -lt 5 ] 
then
	echo "El numero introducido es MENOR que 5"

else
	echo "El numero introducido es MAYOR que 5"
fi

#FIN
