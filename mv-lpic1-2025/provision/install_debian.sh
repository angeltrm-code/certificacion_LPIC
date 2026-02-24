#!/bin/bash

sudo apt update -y
sudo apt install -y rsyslog bash-completion chrony apache2 dnsutils pciutils  build-essential procps psmisc mc locales
sudo apt install zip unzip p7zip-full  rar unrar tar gzip bzip2 xz-utils lz4 zstd -y
sudo apt install console-setup keyboard-configuration -y
sudo apt install passwd login adduser -y
sudo systemctl enable --now rsyslog
sudo systemctl disable ufw

sudo timedatectl set-timezone "Europe/Madrid"
sudo timedatectl

##un comando para listar y modificar la configuración de localización/mapa del teclado.
sudo localectl
sudo localectl set-locale LANG=es_ES.utf8
sudo localectl set-keymap es
sudo localectl

#Sobrescribir /etc/hosts con las nuevas entradas
cat <<EOL | sudo tee /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.33.10  rockylinux8.curso.local rockylinux8
192.168.33.11  debian.curso.local debian
EOL
