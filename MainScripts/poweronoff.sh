#! /bin/bash
mac=$1
ipad=$2
port=$3
choice=$4
port2=$5

if [ $choice -eq 1 ];
then
sudo etherwake -i enp3s0f0 $mac
sudo iptables -D INPUT -p tcp -i enp6s0 --dport $port -j ACCEPT
sudo iptables -D INPUT -p udp -i enp6s0 --dport $port -j ACCEPT
sudo iptables -D FORWARD -p tcp -d $ipad --dport 3389 -j ACCEPT
sudo iptables -t nat -D PREROUTING -p tcp -i enp6s0 -d 0/0 --dport $port -j DNAT --to-destination $ipad:3389
sudo iptables -D FORWARD -p udp -d $ipad --dport 3389 -j ACCEPT
sudo iptables -t nat -D PREROUTING -p udp -i enp6s0 -d 0/0 --dport $port -j DNAT --to-destination $ipad:3389

sudo iptables -A INPUT -p tcp -i enp6s0 --dport $port -j ACCEPT
sudo iptables -A INPUT -p udp -i enp6s0 --dport $port -j ACCEPT
sudo iptables -I FORWARD -p tcp -d $ipad --dport 3389 -j ACCEPT
sudo iptables -t nat -I PREROUTING -p tcp -i enp6s0 -d 0/0 --dport $port -j DNAT --to-destination $ipad:3389
sudo iptables -I FORWARD -p udp -d $ipad --dport 3389 -j ACCEPT
sudo iptables -t nat -I PREROUTING -p udp -i enp6s0 -d 0/0 --dport $port -j DNAT --to-destination $ipad:3389

sudo etherwake -i enp3s0f0 $mac
sudo iptables -D INPUT -p tcp -i enp6s0 --dport $port2 -j ACCEPT
sudo iptables -D INPUT -p udp -i enp6s0 --dport $port2 -j ACCEPT
sudo iptables -D FORWARD -p tcp -d $ipad --dport 5902 -j ACCEPT
sudo iptables -t nat -D PREROUTING -p tcp -i enp6s0 -d 0/0 --dport $port2 -j DNAT --to-destination $ipad:5902
sudo iptables -D FORWARD -p udp -d $ipad --dport 5902 -j ACCEPT
sudo iptables -t nat -D PREROUTING -p udp -i enp6s0 -d 0/0 --dport $port2 -j DNAT --to-destination $ipad:5902

sudo iptables -A INPUT -p tcp -i enp6s0 --dport $port2 -j ACCEPT
sudo iptables -A INPUT -p udp -i enp6s0 --dport $port2 -j ACCEPT
sudo iptables -I FORWARD -p tcp -d $ipad --dport 5902 -j ACCEPT
sudo iptables -t nat -I PREROUTING -p tcp -i enp6s0 -d 0/0 --dport $port2 -j DNAT --to-destination $ipad:5902
sudo iptables -I FORWARD -p udp -d $ipad --dport 5902 -j ACCEPT
sudo iptables -t nat -I PREROUTING -p udp -i enp6s0 -d 0/0 --dport $port2 -j DNAT --to-destination $ipad:5902
fi

if [ $choice -eq 2 ];
then
sudo iptables -D INPUT -p tcp -i enp6s0 --dport $port -j ACCEPT
sudo iptables -D INPUT -p udp -i enp6s0 --dport $port -j ACCEPT
sudo iptables -D FORWARD -p tcp -d $ipad --dport 3389 -j ACCEPT
sudo iptables -t nat -D PREROUTING -p tcp -i enp6s0 -d 0/0 --dport $port -j DNAT --to-destination $ipad:3389
sudo iptables -D FORWARD -p udp -d $ipad --dport 3389 -j ACCEPT
sudo iptables -t nat -D PREROUTING -p udp -i enp6s0 -d 0/0 --dport $port -j DNAT --to-destination $ipad:3389

sudo iptables -D INPUT -p tcp -i enp6s0 --dport $port2 -j ACCEPT
sudo iptables -D INPUT -p udp -i enp6s0 --dport $port2 -j ACCEPT
sudo iptables -D FORWARD -p tcp -d $ipad --dport 5902 -j ACCEPT
sudo iptables -t nat -D PREROUTING -p tcp -i enp6s0 -d 0/0 --dport $port2 -j DNAT --to-destination $ipad:5902
sudo iptables -D FORWARD -p udp -d $ipad --dport 5902 -j ACCEPT
sudo iptables -t nat -D PREROUTING -p udp -i enp6s0 -d 0/0 --dport $port2 -j DNAT --to-destination $ipad:5902
fi
