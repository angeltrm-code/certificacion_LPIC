#PS1 es una variable de entorno que define cómo se ve el prompt (la línea donde escribes comandos) en Bash.
 
vi /root/.bash_profile
 export PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
 
 
| Código | Significado                        |
| ------ | ---------------------------------- |
| `\u`   | Usuario actual                     |
| `\h`   | Hostname (corto)                   |
| `\H`   | Hostname completo                  |
| `\w`   | Directorio actual completo         |
| `\W`   | Solo nombre del directorio actual  |
| `\d`   | Fecha                              |
| `\t`   | Hora (HH:MM:SS)                    |
| `\$`   | `$` si usuario normal, `#` si root |


| Código | Color    |
| ------ | -------- |
| 31     | Rojo     |
| 32     | Verde    |
| 33     | Amarillo |
| 34     | Azul     |
| 35     | Magenta  |
| 36     | Cyan     |
