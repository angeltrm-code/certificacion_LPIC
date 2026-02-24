mpiamos la pantalla.
clear
#Capturamos el valor de una variable
echo "Introduce tu nombre"
read nombre
while [ -z $nombre ] ; do
echo "No has introducido nombre"
echo "Introduce tu nombre"
read nombre
done
echo "Introduce tu apellido"
read apellido
while [ -z $apellido ] ; do
echo "No has introducido apellido"
echo "Introduce tu apellido"
read apellido
done
echo "Hola "$nombre $apellido"."
echo "Elige un numero del 1 al 10"
read num
if [ -z $num ] ; then
echo "No has introducido ningun numero."
echo "Saliendo..."
exit 0
else
if [[ $num -gt "10" || $num -lt .1. ]] ; then
echo "El numero elegido ("$num") no es valido."
echo "El rango es entre 1 y 10."
else
echo "El numero que has elegido es el: "$num
fi
fi
