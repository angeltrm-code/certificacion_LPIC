read -p "Ingresa La ruta de tu directorio " ruta

if [ -d $ruta ]
then
     echo " "
     echo "hey, ya tienes creado tu directorio, tal vez necesites usar otra opcion"
     continue
elif [ $ruta != '^/[a-zA-Z]$' ]
then
   echo""
echo "No has ingresado una ruta valida, recuerda que la ruta inicia con /"
                continue
fi
