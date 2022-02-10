#!/bin/bash

YEAR=`date +"%Y"`
MONTH=`date +"%m"`
DAY=`date +"%d"`
PLATNIK="PLATNIK"$YEAR-$MONTH-$DAY"asd.mdb"

    ftp -pinv nasw.pdaserwis.pl 6666<<EOF
        user asd asd
	cd Home
        put /mnt/md11/samba/WAPip10/Platnik/Platnik/asd.mdb $PLATNIK
        bye
    EOF
exit 0
