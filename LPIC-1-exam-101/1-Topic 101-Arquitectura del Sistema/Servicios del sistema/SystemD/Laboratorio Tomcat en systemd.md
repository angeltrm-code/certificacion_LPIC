## Instalar tomcat 9.0.112 de forma manual y trabajar con system-v y system-d

## He descagado:
cd /root
dnf install wget -y
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.112/bin/apache-tomcat-9.0.112.tar.gz

tar xvfz  apache-tomcat-9.0.112.tar.gz  -C /
ls -l /apache-tomcat-9.0.112
mv /apache-tomcat-9.0.112 /tomcat-9

## Lo he descomprimido en el / de la maquina de linux con este nombre:
ls -ld /tomcat-9

## Damos permisos de ejecucion:
chmod 700 /tomcat-9/bin/*.sh

## Tenemos que tener java (jdk)  openjdk instalado en el servidor, en este ejemplo:
java -version
openjdk version "1.8.0_292"


## Iniciarlo y pararlo de forma manual:
/tomcat-9/bin/startup.sh
/tomcat-9/bin/shutdown.sh

## Compromabos que esta iniciado:
netstat -putan |grep 8080
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      1170/java

## Para averiguar la ip de nuestro servidor:
ip a
http://192.168.33.10:8080


### SystemD

## Lo he descomprimido en el / de la maquina de linux con este nombre:
/tomcat-9


vi /etc/systemd/system/tomcat.service

[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking
ExecStart=/tomcat-9/bin/startup.sh
ExecStop=/tomcat-9/bin/shutdown.sh
# Límite duro de memoria: si se supera, el kernel puede matar el proceso
MemoryMax=512M


[Install]
WantedBy=multi-user.target




## Le decimos a systemd que tenemos una nueva unit de tipo service:
systemctl daemon-reload
systemctl start tomcat.service


## Comprobamos que esta iniciado:
netstat -putan |grep 8080
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      1170/java

http://192.168.33.10:8080

## Paro el tomcat 
systemctl stop tomcat.service

netstat -putan |grep 8080
http://192.168.33.10:8080



## Lo ponemos al inicio, para cuando arranque mi servidor:
systemctl enable tomcat.service
systemctl disable tomcat.service


