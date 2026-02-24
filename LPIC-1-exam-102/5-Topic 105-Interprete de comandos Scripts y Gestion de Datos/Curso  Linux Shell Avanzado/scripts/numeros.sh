#Autor: Autor
#Proposito: Evaluando IF THEN ELIF

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
