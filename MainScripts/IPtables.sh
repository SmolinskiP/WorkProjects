#!/bin/sh

#################################################################################FIREWALL

echo '#! /bin/sh

### BEGIN INIT INFO
# Provides: firewall
# Required-Start: $local_fs $remote_fs
# Required-Stop: $local_fs $remote_fs
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start daemon at boot time
# Description: Enable service provided by daemon.
### END INIT INFO

' > /etc/skrypty/IPtabblock.sh

mysql --user=asd --password=asd --database=asd -N -e "SELECT concat_ws('','iptables -I FORWARD -s ',przypisanieip.ip,' -p tcp -m tcp --dport 443 -m string --string ',uprawnienia.strony,' --algo kmp --from 52 --to 300 -j DROP -w') FROM pracownicy left JOIN uprawnienia ON pracownicy.test = uprawnienia.test left join przypisanieip ON przypisanieip.pracownik = pracownicy.id WHERE przypisanieip.ip IS NOT NULL AND pracownicy.uprawnienia <= uprawnienia.poziomuprawnien ORDER by length(przypisanieip.ip), przypisanieip.ip ASC" >> /etc/skrypty/IPtabblock.sh


sh /etc/init.d/firewall
echo 'Przeladowuje firewall'
sh /etc/skrypty/IPtabblock.sh
echo 'Przeladowuja blokowanie konkretnych osob'