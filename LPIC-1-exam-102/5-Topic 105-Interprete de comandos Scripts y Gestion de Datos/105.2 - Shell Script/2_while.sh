#! /bin/bash
report () { 
cd /usr/share/doc
echo "Document directory usage report" > /tmp/report 
date >> /tmp/report 
pwd >> /tmp/report 
du -sh . >> /tmp/report 
cd ~ 
}
VAR=1

until [ $VAR -gt 5 ] 
do
  let VAR=VAR+1
  echo $VAR
done
