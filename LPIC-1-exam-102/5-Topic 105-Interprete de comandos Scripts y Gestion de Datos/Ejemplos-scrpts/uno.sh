#!/bin/bash

echo "En que directorio estoy"
echo $PWD
echo "En que fecha estoy"
FECHA=`date +%F\ %r`
echo "Cual es el nombre del equipo"
echo $HOSTNAME $FECHA
