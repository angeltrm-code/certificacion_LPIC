#!/bin/bash
#Fecha: 05.01.2015
#Autor: Autor
#Proposito: 

#VARIABLE
PARAMERROR=165

#CODIGO
if [ $# != 2 ]
then
        echo "El script necesita 2 argumentos para ejecutarse satisfactoriamente"
        echo "Usted ingreso $# parametros"
        exit $PARAMERROR
fi

seq $1 $2 

#FIN

