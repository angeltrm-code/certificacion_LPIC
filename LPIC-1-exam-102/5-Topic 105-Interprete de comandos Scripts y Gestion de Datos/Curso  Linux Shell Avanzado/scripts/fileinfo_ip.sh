#!/bin/bash
# fileinfo.sh

FILES="/root/access_log" 

echo


while [  -e "$FILES" ]      
do
    
   
     echo "Salida ordenada de los ficheros access_log NASA y Apache access_log"
      grep -Eo '^[a-z0-9]{1,8}\.[a-z0-9]{1,8}\.[a-z0-9]{1,8}\.[a-z0-8]{1,3}' $FILES |sort -n  
  
done  

