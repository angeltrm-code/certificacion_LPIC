mkdir /opt/scripts
cp /tmp/supervisamem /opt/scripts
cp /tmp/iniciar-supervisamem /etc/init.d
cd /opt/scripts
chmod 700 supervisamem
./supervisamem
tail -f /var/log/supervisamem.log
--------------------------------------------------------
chmod 700 /etc/init.d/iniciar-supervisamem
service iniciar-supervisamem start
tail -f /var/log/supervisamem.log
service iniciar-supervisamem stop
ps -ef |grep supervisamem
---------------------------------------------------------
chkconfig --level 35 iniciar-supervisamem on
Tendremos que tener:

vi /etc/init.d/iniciar-supervisamem
#!/bin/bash
# chkconfig: - 99 10
# description: Supervisamem

cd /etc/rc3.d
cd /etc/rc5.d
ls -l
S99iniciar-supervisamem --> /etc/init.d/iniciar-supervisamem

