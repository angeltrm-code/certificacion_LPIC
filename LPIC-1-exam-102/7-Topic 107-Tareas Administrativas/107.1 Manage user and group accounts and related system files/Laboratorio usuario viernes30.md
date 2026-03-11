# Laboratorio usuario viernes 30

Documento práctico sobre Laboratorio usuario viernes 30. Conserva los comandos, comprobaciones y notas técnicas del material original con una estructura más clara.

## Desarrollo

### Crear los grupo sistemas informatica y micro

```bash
groupadd sistemas
groupadd informatica
groupadd micro
```

### Crear el usario1 grupo primario informatica y no tiene shell

### adduser -g informatica -s /sbin/nologin usuario1

```bash
passwd usuario1
```

### Crear el usuario2 y la cuenta le caduca mañana

### adduser -e 2020-11-02 usuario2

```bash
passwd usuario2
```

### chage -l usuario2

### Crear el usuario3 y que en el primer inicio de session le pida el cambio de password

### adduser usuario3

```bash
passwd usuario3
```

### chage -d 0 usuario3

### Crear el usuario4

tiene que tener el alias de comando listar y sea un ls com permisos largos y ordene los ficheros por fecha de modificacion

Tiene instalado java en el directorio /usr/local/jdk1.7 tiene que esta la varible JAVA_HOME

### adduser usuario4

```bash
passwd usuario4
```

```bash
vi  /home/usuario4/.bashrc
alias listar='ls -lrta'
```

```bash
vi  /home/usuario4/.bash_profile
JAVA_HOME=/usr/local/jdk1.7
export JAVA_HOME
```

---

### env

```bash
echo $JAVA_HOME
echo $PATH
alias
```
