#!/bin/bash
case $1 in
ips)
  grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /root/access_log
  ;;
esac
