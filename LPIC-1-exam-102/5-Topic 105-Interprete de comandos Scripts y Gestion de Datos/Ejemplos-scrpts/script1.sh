#!/bin/bash
#Fecha: 24.12.2014
#Autor: Autor
#Proposito: Script Hola Mundo con Variables
#VARIABLES
#Añadimos la entrada para que nos muestre la fecha y hora actual
FECHA=`date +%F\ %r`
VAR1="Hola Mundo"
VAR2="Este es mi primer script."
#CODIGO
date +%F\ %r
echo $VAR1
echo $VAR2
echo "La fecha y ejecutcion de la realizacion del scripts es:$FECHA"
