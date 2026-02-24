#!/bin/bash

dnf update -y
dnf install bash-completion rsyslog chrony httpd bind-utils pciutils   procps-ng psmisc mc glibc-langpack-en glibc-langpack-es glibc-common  -y
sudo dnf install zip unzip p7zip p7zip-plugins rar unrar tar gzip bzip2 xz lz4 zstd -y
sudo dnf groupinstall "Development Tools" -y
sudo dnf install kbd -y
systemctl enable --now rsyslog
sudo dnf install shadow-utils -y
sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
systemctl stop firewalld
systemctl disable firewalld
timedatectl set-timezone "Europe/Madrid"
timedatectl

##un comando para listar y modificar la configuración de localización/mapa del teclado.
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
localectl

#Sobrescribir /etc/hosts con las nuevas entradas
cat <<EOL | sudo tee /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.33.10  rockylinux8 .curso.local rockylinux8
192.168.33.11  debian.curso.local debian
EOL


