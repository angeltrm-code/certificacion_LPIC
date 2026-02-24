#Fecha: 31.12.2014
#Autor: Autor
#Proposito: Evaluando IF THEN ELIF

#CODIGO
read -p "Introduce un numero del 1 al 9: " NUMERO

if [[ $NUMERO -eq 0 ||  $NUMERO -eq 5 ]]
then
	echo "El numero introducido es IGUAL a 0 o  5"
else
	echo "El numero diferente a  5"
fi

#FIN
