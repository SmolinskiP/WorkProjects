#!/bin/sh

#################################################################################FIREWALL


mysql -u guest -p'aa' -h xx.xx.xx.xx -P 3306 -D asd -N -C -e "SELECT * FROM mmddata" >> /home/patryk/chinese5.txt


