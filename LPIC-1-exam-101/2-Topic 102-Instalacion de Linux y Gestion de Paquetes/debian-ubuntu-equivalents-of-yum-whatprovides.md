
#apt-file en Debian / Ubuntu
apt-file sirve para buscar qué paquete contiene un archivo, incluso si el paquete NO está instalado 
Es muy útil cuando sabes el nombre de un binario o librería, pero no sabes qué paquete instalar.

sudo apt-get update
sudo apt install apt-file
sudo apt-file search lspci
sudo apt-file update
sudo apt-file search lspci