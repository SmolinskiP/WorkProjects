#! /bin/sh

### BEGIN INIT INFO
# Provides: firewall
# Required-Start: $local_fs $remote_fs
# Required-Stop: $local_fs $remote_fs
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start daemon at boot time
# Description: Enable service provided by daemon.
### END INIT INFO

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -F
iptables -F -t nat
iptables -t mangle -F
iptables -X

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A FORWARD -o lo -j ACCEPT

iptables -A INPUT -p tcp -i enp6s0 --dport 80 -j ACCEPT		#HTTP
iptables -A INPUT -p tcp -i enp6s0 --dport 443 -j ACCEPT	#HTTPS

iptables -A INPUT -p tcp -i enp6s0 --dport 20 -j ACCEPT
iptables -A INPUT -p tcp -i enp6s0 --dport 21 -j ACCEPT
iptables -A INPUT -p tcp -i enp6s0 --dport 55000:60000 -j ACCEPT
iptables -A INPUT -p tcp -i enp6s0 --dport 4224 -j ACCEPT	#SSH

iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT -m limit --limit 1/sec

iptables -A INPUT -i enp3s0f0 -j ACCEPT
iptables -A FORWARD -i enp3s0f0 -j ACCEPT


iptables -t nat -I POSTROUTING -m policy --pol ipsec --dir out -j ACCEPT

#iptables -t nat -A POSTROUTING -o enp6s0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o enp4s0f1 -j MASQUERADE

iptables -A INPUT -j ACCEPT -m state --state ESTABLISHED,RELATED
iptables -A FORWARD -j ACCEPT -m state --state ESTABLISHED,RELATED

ip route del default
ip route add default via 192.168.108.1