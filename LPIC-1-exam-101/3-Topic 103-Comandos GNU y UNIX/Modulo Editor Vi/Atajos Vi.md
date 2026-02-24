###Editor Vi###

vi es un editor de texto en modo consola, muy ligero y presente en prácticamente cualquier sistema Unix/Linux.
En muchos sistemas modernos, vi es en realidad un enlace a vim (Vi IMproved).

###1  Movimiento del Cursor
Los siguientes comandos van al lugar indicado:
Espaciador 	Un caracter hacia adelante
nl 	n caracteres a la derecha
nh 	n caracteres a la izquierda
nj 	n líneas abajo
nk 	n lineas arriba
n| 	n lineas a la derecha, empezando desde el inicio de línea
  	 
nw 	n palabras a la dcha. (primera letra)
nW 	n palabras* a la dcha. (primera letra)
nb 	n palabras a la izda. (primera letra)
nB 	n palabras* a la izda. (primera letra)
  	 
###Retorno 	Al principio de la siguiente línea
0 	Al principio de la línea actual
$ 	Al final de la línea actual
  	 
( 	Al principio de la frase actual
) 	Al principio de la siguiente frase
{ 	Al principio del párrafo actual
} 	Al principio del párrafo siguiente
  	 
H 	Al extremo izdo. de la línea superior de la pantalla
M 	Al extremo izdo. de la línea media de la pantalla
L 	Al extremo izdo de la línea inferior de la pantalla
  	 
nfc 	Hacia adelante, hasta la nsima aparición de c
nFc 	Hacia atrás, hasta la nsima aparición de c
ntc 	Hacia adelante, hasta un caracter antes de la nsima aparición de c
nTc 	Hacia atrás, hasta un caracter antes de la nsima aparición de c
  	 
G 	A la última línea del documento
nG 	A la línea n del documento
1G   A la primera línea  del documento
  	 

###Los siguientes comandos mueven el cursor al lugar indicado:

Ctrl-U 	Media pantalla hacia arriba
Ctrl-D 	Media pantalla hacia abajo
Ctrl-F 	Una pantalla completa hacia adelante
Ctrl-B 	Una pantalla hacia detrás

###2  Insertar Texto
Los siguientes comandos permiten insertar texto en el lugar indicado:

i 	Delante del cursor
I 	Delante del primer carácter de la línea
a 	Tras el cursor
A 	Al final de la línea
o 	En la línea inferior, tras abrirla
O 	En la línea superior, tras abrirla

###3  Borrar Texto
3.1  Borrar en modo Edición
Ctrl-H o Retroceso permiten retroceder para sobre-escribir.

3.2  Borrar en modo Comando
Los siguientes comandos borran el texto indicado:

nx 	n caracteres a la dcha.
nX 	n caracteres a la izda.
  	 
ndw 	n palabras a la dcha del cursor)
ndW 	n palabras* a la derecha del cursor)
ndb 	n palabras a la izda. del cursor
ndB 	n palabras* a la izda. del cursor
  	 
d-Retorno 	La línea actual y la siguiente
ndd 	n líneas empezando desde la actual
d0 	Hasta el principio de la línea
d$ 	Hasta el final de la línea
  	 
ndfc 	Hacia adelante, hasta la nsima aparicion del caracter c
ndFc 	Hacia atrás, hasta la nsima aparicion del caracter c
ndtc 	Hacia adelante, hasta el caracter anterior a la nsima aparicion del caracter c
ndTc 	Hacia atrás, hasta el caracter anterior a la nsima aparicion del caracter c
  	 
d) 	Hasta el final de la frase
d( 	Hasta el principio de la frase
d} 	Hasta el final del párrafo
d} 	Hasta el principio del párrafo
  	 

Expresión general: d/RE+Return: Borra hacia adelante, hasta la 'Regular expresion' RE.

Expersión general: d?RE+Return: Borra hacia atrás, hasta la 'Regular expression' RE.


3.3  Deshacer Borrados
u deshace última correción en la líinea

U deshace todas las correciones de la última líinea modificada

###4  Sustituir Texto
Los siguientes comandos susituyen el texto indicado por el escrito después de ejecutar dicho comando.
nr 	Sobre el cursor, n veces un carácter
R 	Desde el cursor hasta pulsar esc
  	 
cw 	Desde el cursor hasta el final de la palabra
cW 	Desde el cursor hasta el final de la palabra*
cb 	Desde el comienzo de la palabra hasta el cursor
cB 	Desde el comienzo de la palabra* hasta el cursor
  	 
ncc 	n líneas desde la actual
c0 	desde el principio de la línea hasta el cursor
c$ 	desde el cursor al final de la línea
  	 
c) 	Desde el cursor hasta el final de la frase
c( 	Desde el principio de la frase hasta el cursor
c} 	Desde el cursor hasta el final del párrafo
c{ 	Desde el principio del párrafo hasta el cursor
  	 

###5  Localización de Cadenas
5.1  Comandos

/cadena-Retorno 	Busca hacia abajo la cadena indicada
?/cadena-Retorno 	Busca hacia arriba la cadena indicada
n 	Repite la búsqueda en la misma dirección
N 	Repite la búsqueda en la dirección contraria

    Las cadenas especificadas no pueden tener caracteres especiales como *,?,$,etc., a no ser que esté activada la opción set nomagic.
    La busqueda es 'case-sensitive' a no ser que esté activada la opción set ignorecase


5.2  Modificadores
La cadena admite modificadores a efectos de especificar o generalizar la búsqueda. Los modificadores que se indican tienen el significado siguiente:

gorro 	Principio de línea (escrito antes de la cadena)
$ 	Final de línea (escrito después de la cadena)
. 	Un carácter cualquiera (escrito en cualquier parte de la cadena)
[,,,] 	Cualquiera de los caracteres que se escriban en la lista entre corchetes
  	(escrito en cualquier parte de la cadena)
  	 

5.3  Búsqueda con Sustitución
El comando para realizar búsqueda con sustitución es:


dirección s/cadena-búsqueda/cadena-sustitución/[g/c]

    dirección indica sobre qué parte del documento se realizan los cambios.
    g es opcional e indica si el cambio debe tener efecto una sola vez en cada línea o todas las veces (si fuese el caso)
    c es opcional e indica que se pida confirmación para que el cambio tenga efecto

La dirección se indica mediante dos símbolos separados por una coma. El primer símbolo indica desde donde empieza a tener efecto la sustitución, mientras que el segundo indica hasta donde tiene efecto.


Los siguientes símbolos tienen el sentido indicado:

n 	n es un número que simboliza una línea del documento
. 	Lugar actual del documento
$ 	La línea final del documento
+n 	n líneas hacia abajo
-n 	n líneas hacia arriba
% 	Todo el documento

###6  Marcando y Copiando Texto
6.1  Marcando en el buffer por defecto
Los siguientes comandos guardan en memoria el fragmento de texto indicado:

nyw 	n palabras comenzando desde la posición del cursor
nyW 	n palabras* comenzando desde la posición del cursor
nyb 	n palabras desde la posición del cursor al principio de la línea
nyB 	n palabras* desde la posición del cursor al principio de la línea
  	 
y+Retorno 	La línea actual y la siguiente
nyy 	n líneas desde la actual
y0 	Desde el cursor hasta el principio de la línea
  	 
y$ 	Desde el cursor hasta el final de la línea
y) 	Desde el cursor hasta el final de la frase
y( 	Desde el cursor hasta el principio de la frase
y} 	Desde el curosr hasta el final de párrafo
y{ 	Desde el cursor hasta el principio del párrafo