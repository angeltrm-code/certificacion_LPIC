#!/bin/bash

# En este archivo guardaremos la lista de tareas
ARCHIVO_TAREAS=tareas.txt

# En este otro tendremos la lista de usuarios con acceso a Bash
USUARIOS_BASH=usuariosBash.txt

# Si el archivo de tareas existe, borrarlo primero
if [ -f $ARCHIVO_TAREAS ]; then
    rm $ARCHIVO_TAREAS
fi

# Guardar la lista de usuarios con acceso a Bash en usuariosBash.txt
grep bash /etc/passwd | cut -d: -f1 > $USUARIOS_BASH

# Examinar cuenta por cuenta
while read CUENTA
do
    # Mostrar un mensaje por cada usuario. Leer la respuesta desde la terminal
    read -p "Quitar acceso a Bash a $CUENTA? [s/n]: " QUITAR < /dev/tty
        case $QUITAR in
            [sS])
                # Si la respuesta es Sí [sS], agregar mensaje al archivo
                echo "Quitar acceso a Bash a $CUENTA" >> $ARCHIVO_TAREAS
                usermod -s /sbin/nologin $CUENTA
                 #sed -i -e '/${CUENTA}/r' -e "s/${CUENTA}/bash/false"  /etc/passwd

                 #grep -w $CUENTA /etc/passwd |cut -d: -f 7 | sed -i -e 's/bin\/bash/sbin\/nologuin/' 
                ;;
            [nN])
                # De otra manera, mostrar mensaje por pantalla
                echo "Eligió no quitar el acceso a Bash a $CUENTA."
                ;;
        esac
# Usar el archivo usuariosBash.txt como entrada del bucle
done < $USUARIOS_BASH
