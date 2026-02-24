#!/bin/bash
#Fecha: 05.01.2015
#Autor: Autor
#Proposito: Usando CASE
#CODIGO
echo "Buscar pacientes por hospitales madrid barcelona:"
read DISTRO

        case $DISTRO in 
	[mM]adrid)
           echo "Estos son los pacientes del Hospital de Madrid:"; 
		   grep  -Ei '^madrid' origenes.txt ;;
    [Bb]arcelona )
		   echo "Estos son los pacientes del Hospital de Barcelona:";
           grep  -Ei '^barcelona' origenes.txt ;;
     * )
		echo "No se reconoce Hospital" ;;
        esac

#END

