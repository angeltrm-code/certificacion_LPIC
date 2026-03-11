# Laboratorio practico - Martes 10 (resuelto)

## 1) Muestra todas las variables de entorno usando dos comandos

```bash
env
printenv
```

## 2) Muestra unicamente las variables que contengan HOME

```bash
env | grep HOME
printenv | grep HOME
```

## 3) Crear la variable CURSO con el valor LPIC1 sin persistirla

```bash
export CURSO=LPIC1
echo "$CURSO"
```

## 4) Crear directorio scripts (`~/scripts`) y anadirlo al PATH

```bash
mkdir -p ~/scripts
export PATH="$HOME/scripts:$PATH"
```

Persistente para tu usuario:

```bash
echo 'export PATH="$HOME/scripts:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## 5) Personalizar history para excluir todos los comandos ls, cd y exit

```bash
export HISTIGNORE='ls*:cd*:exit'
```

Persistente para tu usuario:

```bash
echo "export HISTIGNORE='ls*:cd*:exit'" >> ~/.bashrc
source ~/.bashrc
```

## 6) Personalizar history para no registrar comandos con espacio inicial y mostrar fecha/hora

```bash
export HISTCONTROL=ignorespace
export HISTTIMEFORMAT='%F %T '
```

Persistente para tu usuario:

```bash
echo "export HISTCONTROL=ignorespace" >> ~/.bashrc
echo "export HISTTIMEFORMAT='%F %T '" >> ~/.bashrc
source ~/.bashrc
```

Ejemplo (comando con espacio inicial no se guarda en history):

```bash
 ls -la
history
```
