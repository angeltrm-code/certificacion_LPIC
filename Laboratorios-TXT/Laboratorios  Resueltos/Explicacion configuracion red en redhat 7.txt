vi /etc/sysconfig/network-scripts/ifcfg-eth0
systemctl restart NetworkManager

vi /etc/hostname
hostnamaclt 
hostnamectl set-hostname servidor1.curso.es
systemctl restart systemd-hostnamed

Versiones anteriores a rh7
/etc/sysconfig/network
HOSTNAME=servidor1

/etc/resolv.conf
nameserver 192.168.1.25
nameserver 192.168.1.26
domain curso.es
search curso.es madrid.curso.es asturias.curso.es

 vi /etc/NetworkManager/NetworkManager.conf
 [main]
 dns=none
 
 cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.1.5     sercentos7      sercentos7.curso.esp

ip link set eth0 down
ip link set eth0 up

 ifdown eth0
 ifup eth0


