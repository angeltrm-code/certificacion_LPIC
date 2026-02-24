systemctl stop nombreservicio.service
systemctl start nombreservicio.service
systemctl status nombreservicio.service



systemctl enable httpd.service
Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service

systemctl disable httpd.service
 systemctl is-enabled httpd.service


systemctl list-unit-files --all
systemctl --type=service


# multi-user.target: analogous to runlevel 3
# graphical.target: analogous to runlevel 5
#
# To view current default target, run:
# systemctl get-default
#
# To set a default target, run:
# systemctl set-default TARGET.target


systemctl get-default
systemctl set-default graphical.target

systemctl isolate multi-user.target


systemctl isolate actualizacion.snapshot
systemctl --type=snapshot
systemctl delete actualizacion.snapshot


