sudo iptables -D INPUT -p tcp -i enp6s0 --dport 33089 -j ACCEPT
sudo iptables -D INPUT -p udp -i enp6s0 --dport 33089 -j ACCEPT
sudo iptables -D FORWARD -p tcp -d 10.0.11.089 --dport 3389 -j ACCEPT
sudo iptables -t nat -D PREROUTING -p tcp -i enp6s0 -d 0/0 --dport 33089 -j DNAT --to-destination 10.0.11.089:3389
sudo iptables -D FORWARD -p udp -d 10.0.11.089 --dport 3389 -j ACCEPT
sudo iptables -t nat -D PREROUTING -p udp -i enp6s0 -d 0/0 --dport 33089 -j DNAT --to-destination 10.0.11.089:3389
