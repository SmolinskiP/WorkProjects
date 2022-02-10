#!/bin/sh

sudo iptables -D FORWARD -s 10.0.11.27/32 -p tcp -m tcp --dport 443 -m string --string "youtube.pl" --algo kmp --from 52 --to 300 -j DROP
sudo iptables -D FORWARD -s 10.0.11.27/32 -p tcp -m tcp --dport 443 -m string --string "youtube.com" --algo kmp --from 52 --to 300 -j DROP
