# Laboratorio supervisamem system v

Documento práctico sobre Laboratorio supervisamem system v. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Para realizar este laboratorio tengo que clonar el repo del formador donde los encotraremos los archivos para el lab:

### supervisamem

### iniciar-supervisamem

## En la documentacion de la formacion los scripts tambien se encuentran:

\Material Alumnos LPIC-1-2025\LPIC-1-exam-101\1-Topic 101-Arquitectura del Sistema\Servicios del sistema\03_Arranque

### supervisamem

### iniciar-supervisamem

## Comenzamos el laboratorio, clonando el repositorio del formador:

## Instalar git para maquinas redhat

```bash
yum install git -y
```

## Instalar git para maquinas debian

```bash
apt install git -y
```

```bash
cd /
git clone https://github.com/agarciafer/lpic1.git
```

```bash
cd /lpic1
```

## El comando dos2unix es una  herramienta para convertir saltos de línea en un archivo de texto de formato Unix a formato DOS y viceversa.

## Cuando ejecutemo el comando ./supervisamem &, fallara por la codificacion, lo solucionamos con:

## Instalar git para maquinas redhat

```bash
yum install dos2unix -y
```

## Instalar git para maquinas debian

```bash
apt install dos2unix -y
```

---

```bash
mkdir /opt/scripts
cd /opt/scripts
cp /lpic1/supervisamem /opt/scripts
```

### dos2unix /opt/scripts/supervisamem

```bash
chmod 700 supervisamem
./supervisamem &
```

### tail -f /var/log/supervisamem.log

### killall supervisamem

---

## El comando service en redhat y derivados lo podemos utilizar para parar y arrancar una aplicion.

## Arrancamos en systemv el servicio iniciar-supervisamem

```bash
cp /lpic1/iniciar-supervisamem /etc/init.d
cd  /etc/init.d
chmod 700 /etc/init.d/iniciar-supervisamem
service iniciar-supervisamem start
```

## Para arrancarlo en debian:

```bash
/etc/init.d/iniciar-supervisamem start
```

## Podemos ver el log que va generando nuestra aplicacion:

tail -f /var/log/supervisamem.log

## Paramos el servicio

```bash
service iniciar-supervisamem stop
```

## Para paralo en debian:

```bash
/etc/init.d/iniciar-supervisamem stop
```

---

## Ponemos al inicio, para que arranque con nuestro servidor nuestra aplicacion iniciar-supervisamem:

```bash
chkconfig --level 3 iniciar-supervisamem on
```

## Tendremos que tener para el correcto funcionamiento  del comando anterior. Ya esta creado por el formador no MODIFICAR:

```bash
cat /etc/init.d/iniciar-supervisamem
```

## !/bin/bash

## chkconfig: - 99 10

## El comando anterior podemos comprobar que la ejecucion del comando anterior a creado el archivo S99iniciar-supervisamem:

```bash
cd /etc/rc3.d
ls -l
```

S99iniciar-supervisamem --> /etc/init.d/iniciar-supervisamem

---

## Para quitar el servicio del inicio de nuestro servidor:

```bash
chkconfig --level 3 iniciar-supervisamem off
```

## El comando anterior creara lo siguiente:

```bash
cd /etc/rc3.d
ls -l
```

k10iniciar-supervisamem --> /etc/init.d/iniciar-supervisamem

---

## En debian o cualquier linux si queremos poner al inicio nuestro service de supervisamem, en el runlevel 3:

ln -s /etc/init.d/iniciar-supervisamem /etc/rc3.d/S99iniciar-supervisamem

## En debian para elimnarlo del inicio:

```bash
rm -rf /etc/rc3.d/S99iniciar-supervisamem
```

### o

ln -s /etc/init.d/iniciar-supervisamem /etc/rc3.d/K10iniciar-supervisamem
