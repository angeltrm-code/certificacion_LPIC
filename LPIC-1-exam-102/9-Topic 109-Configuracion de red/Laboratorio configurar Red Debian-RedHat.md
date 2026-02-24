##Para entornos de RedHat:
ens33
192.168.1.5
255.255.255.0
GW 192.168.1.1
dns1 8.8.8.8
dns2 8.8.4.4

hostname servidor1.curso.local
domain curso.local
--------------------------------------------------------------------------------------------------------
ip a show 
vi /etc/sysconfig/network-scripts/ifcfg-ens33
HWADDR=00:0C:29:2D:F8:77
TYPE=Ethernet
BOOTPROTO=none
DNS1=8.8.8.8
DNS2=8.8.4.4
ONBOOT=yes
IPADDR=192.168.1.5
PREFIX=24
#NETMASK=255.255.255.0
GATEWAY=192.168.1.1

systemctl restart NetworkManager


vi  /etc/resolv.conf
search localdomain curso.local 
nameserver 8.8.8.8
nameserver 8.8.4.4
domain curso.local


hostnamectl
# hostnamectl set-hostname servidor1.curso.local
systemctl restart systemd-hostnamed

cat /etc/hostname
servidor1.curso.local

hostnamectl

# vi /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.1.5     servidor1.curso.local    servidor1

-------------------------------------------------------------------------------
##Para Debian:
ens33
 vi/etc/network/interfaces
 auto lo ens33 
 iface lo inet loopback 
 
 iface ens33 inet static 
 address 192.161.1.5
 netmask 255.255.255.0 
 broadcast 192.168.1.255 
 gateway 192.168.1.1 
 
service networking  restart
 

vi  /etc/resolv.conf
search localdomain curso.local 
nameserver 8.8.8.8
nameserver 8.8.4.4
domain curso.local

hostnamectl
# hostnamectl set-hostname servidor1.curso.local
systemctl restart systemd-hostnamed

cat /etc/hostname
servidor1.curso.local

hostnamectl

# vi /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.1.5     servidor1.curso.local    servidor1




