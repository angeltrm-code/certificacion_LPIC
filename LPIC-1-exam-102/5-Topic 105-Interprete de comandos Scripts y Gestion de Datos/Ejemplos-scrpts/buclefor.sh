#!/bin/bash
#Fecha: 31.12.2014
#Autor: Autor
#Proposito: Evaluando el bucle FOR pasandole un fichero para extraer las ips
#CODIGO
read -p "Introduce la ruta del fichero para filtrar las IPs:" FICHERO
for fichero in $( grep -Eo '^[a-z0-9]{1,8}\.[a-z0-9]{1,8}\.[a-z0-9]{1,8}\.[a-z0-8]{1,3}' $FICHERO |sort -n )
do
echo $fichero
done
