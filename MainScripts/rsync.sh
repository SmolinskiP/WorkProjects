#!/bin/sh

#login asd
#haslo asd
#dsa
#/volume1/home/plonsk/
YEAR=`date +"%Y"`
MONTH=`date +"%m"`
DAY=`date +"%d"`

PLATNIK="PLATNIK"$YEAR-$MONTH-$DAY"asd.mdb"

date +"%Y-%m-%d %H:%M:%S" >> /home/patryk/logi/rsync.txt
echo "Kopiuje baze danych Platnika" >> /home/patryk/logi/rsync.txt
#sshpass -p "asd" rsync -a /mnt/md11/samba/WAPip10/Platnik/Platnik/asd.mdb sa@asd.asd.pl:/volume1/home/patryktest/$PLATNIK
rsync -a /mnt/md11/samba/WAPip10/Platnik/Platnik/asd.mdb /mnt/md11/backupy/platnik/$PLATNIK
echo "Skonczylem kopiowac baze danych platnika" >> /home/patryk/logi/rsync.txt
date +"%Y-%m-%d %H:%M:%S" >> /home/patryk/logi/rsync.txt
echo "Kopiuje folder Wspolny" >> /home/patryk/logi/rsync.txt
rsync -a /mnt/md11/samba/WAPip10/wspolny/ /mnt/md11/backupy/wspolny/
echo "Skonczylem kopiowac folder Wspolny" >> /home/patryk/logi/rsync.txt
date +"%Y-%m-%d %H:%M:%S" >> /home/patryk/logi/rsync.txt


