# Laboratorio usuarios

Documento práctico sobre Laboratorio usuarios. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

useradd es un comando que ejecuta un binario del sistema, mientras que adduser es un script en perl que utiliza el binario useradd.

La mayor ventaja del comando adduser es que crea el directorio home (/home/usuario/) del usuario de manera automática,

cosa que no hace useradd (hay que usar la opción -m).

## Probar sobre la mv el usu1, usu3 y usu5

## Crear los grupos sistema informatica y micro

```bash
groupadd informatica
groupadd sistema
groupadd micro
```

## Crear del usu1 al usu5

## El usu1 no tiene shell y grupo primario informatica

### adduser -s /sbin/nologin  -g informatica usu1

```bash
passwd usu1
```

## El usu2 grupo secundario sistema y micro grupo primario

### adduser -G sistema -g micro usu2

```bash
passwd usu2
```

## El usu3 en el primer inicio de sesion tiene que cambiar el password

### adduser usu3

```bash
passwd usu3
```

### chage -d 0 usu3

Password,259

## El usu4 le caduca la cuenta el 14/12/2025

### adduser -e 2025-12-14 usu4

```bash
passwd usu4
```

chage -l usu4

## El usu5 grupo primario informatica grupo secundario sistema

## Tiene la variable JAVA_HOME=/usr/jdk.1.8

## Tiene el alias de comando borrar tiene que pedirle confirmacion

## Y el alias listar es un ls pero tiene que dar los permisos largos y el numero de inodo

### adduser -g informatica -G sistema usu5

```bash
passwd usu5
```

```bash
vi /home/usu5/.bash_profile
JAVA_HOME=/usr/jdk.1.8
PS1="\[\e[31m\][\[\e[m\]\[\e[38;5;172m\]\u\[\e[m\]@\[\e[38;5;153m\]\h\[\e[m\] \[\e[38;5;214m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$"
```

```bash
export JAVA_HOME PS1
```

```bash
vi /home/usu5/.bashrc
alias borrar='rm -i'
alias listar='ls -li'
```

## Para comprobar el usu5, qu iniciar session con dicho usuario y ejecutando el comando:

```bash
alias
```

## y veriamos el prontuario en colores variable PS1

```bash
echo $JAVA_HOME
```

env |grep -e  JAVA_HOME -e PS1
