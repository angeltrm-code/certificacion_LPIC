#!/bin/bash
#Fecha: 05.01.2015
#Autor: Autor
#Proposito: Script usando SELECT para ver logs

PS3='Elegir una opcion: '

#VARIABLE
LISTA="Sistema Pacientes-Hospital-Barcelona  Salir"

#CODIGO
select i in $LISTA
        do
  if [ $i = "Sistema" ]
then
  tail /var/log/messages

elif   [ $i = "Pacientes-Hospital-Barcelona" ]
then
    grep --color -Ei '^barcelona' origenes.txt 



elif [ $i = "Salir" ]
         then
                        exit
                fi
        done
#FIN

