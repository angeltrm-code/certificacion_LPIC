###En las maquinas virutales Rockylinux8 y debian12 deberiamos de utilizar chrony:

##Configuring NTP using chrony
yum install chrony
apt install chrony

# systemctl start chronyd
# systemctl enable chronyd

# vi  /etc/chrony.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst


# systemctl start chronyd
# systemctl enable chronyd
--------------------------------------------------------------------------------------------------------------
##En Rockylinux8
timedatectl set-timezone "Europe/Madrid"

localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es




##En debian12
apt-get update -y
apt-get install chrony -y
timedatectl set-timezone "Europe/Madrid"

localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es

vi /etc/chrony/chrony.conf
server 0.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 3.es.pool.ntp.org iburst

sudo systemctl restart chrony
sudo systemctl enable chrony

