vi /etc/sysconfig/network-scripts/ifcfg-eth0
/etc/sysconfig/network-scripts/ifcfg-eth1
setup
service network restart
systemctl restart NetworkManager
ifconfig -a
ip addr show

cat  /etc/sysconfig/network
HOSTNAME=trasgu

cat /etc/hostname
sercentos7.curso.esp
 hostnamectl set-hostname servi1.miempresa.com
 systemctl restart systemd-hostnamed

vi /etc/resolv.conf
nameserver 192.168.1.254
nameserver 192.168.1.253
domain miempresa.com
serach miempresa.com valencia.miempresa.com asturias.miempresa.com

cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.1.5     sercentos7.curso.esp    sercentos7


Alias de red
cd /etc/sysconfig/network-scripts
 cp ifcfg-eth0 ifcfg-eth0:1
 vi ifcfg-eth0:1
# Advanced Micro Devices [AMD] 79c970 [PCnet32 LANCE]
DEVICE=eth0:1
ONBOOT=yes
HWADDR=00:0c:29:6e:20:fd
NETMASK=255.255.255.0
IPADDR=192.168.1.155
GATEWAY=192.168.1.1
TYPE=Ethernet
