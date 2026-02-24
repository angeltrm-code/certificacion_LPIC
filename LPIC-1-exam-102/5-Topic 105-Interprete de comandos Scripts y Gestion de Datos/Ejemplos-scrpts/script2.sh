#!/bin/bash

echo Pon el primer numero:
read num1
echo Pon el segundo numero:
read num2
if [ $num1 -eq $num2 ]; then
        echo "Son iguales!"
else
        echo "Son diferentes!"
fi
