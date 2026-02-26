RedHat6
setup
/etc/sysconfig/network-scripts/ifcfg-eth3
 /etc/sysconfig/network
 /etc/resolv.conf
  /etc/hosts
  service network restart
  
Redhat 7
  
  nmtui
  /etc/sysconfig/network-scripts/ifcfg-eth0
  /etc/resolv.conf
  /etc/hosts
  systemctl restart network 
  /etc/hostname
  hostnamectl
  
  service NetworkManager start
  systemctl start NetworkManager