#!/bin/sh

FILE=iftop.txt
NAME=${FILE%.*}
EXT=${FILE#*.} 
DATE=`date +%d-%m-%y`         
NEWFILE=${NAME}_${DATE}.${EXT}
sudo touch /var/log/pda/$NEWFILE
sudo iftop  -P -L 2000000 -B -o source -i enp3s0f0 -t -s 32400 > /var/log/pda/$NEWFILE