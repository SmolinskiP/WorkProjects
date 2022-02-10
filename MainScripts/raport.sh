#! /bin/bash

df -h | grep '/dev/md' > /etc/skrypty/temporary.txt
input="/etc/skrypty/temporary.txt"


echo ---===RAPORT ZAJETOSCI DYSKOW===--- > /etc/skrypty/raport.txt
while IFS= read -r line
do
    number=$(echo $line | grep -b -o v/md | awk 'BEGIN {FS=":"}{print $1}')
    pos1=$(( number + 3))
    pos2=$(( number + 6))
    var1=$(echo -n $line | cut -c$pos1-$pos2)
    number2=$(echo $line | grep -b -o % | awk 'BEGIN {FS=":"}{print $1}')
    pos3=$(( number2 + 3))
    pos4=$(( number2 + 15))
    pos5=$(( number2 - 1))
    pos6=$(( number2))
    var2=$(echo -n $line | cut -c$pos3-$pos4)
    var3=$(echo -n $line | cut -c$pos5-$pos6)
    printf "Zajetosc dysku $var1 zamontowanego na $var2 wynosi $var3 procent\n" >> /etc/skrypty/raport.txt
    echo $line >> /etc/skrypty/raport.txt
    echo "" >> /etc/skrypty/raport.txt
done < "$input"

echo ---===RAPORT TEMPERATUR===--- >> /etc/skrypty/raport.txt

cpu0tem=$(sensors | grep 'Core 0')
cpu1tem=$(sensors | grep 'Core 1')
cpu2tem=$(sensors | grep 'Core 2')
cpu3tem=$(sensors | grep 'Core 3')
echo -=Procesor:=- >> /etc/skrypty/raport.txt
echo $cpu0tem | cut -c1-15 >> /etc/skrypty/raport.txt
echo $cpu1tem | cut -c1-15 >> /etc/skrypty/raport.txt
echo $cpu2tem | cut -c1-15 >> /etc/skrypty/raport.txt
echo $cpu3tem | cut -c1-15 >> /etc/skrypty/raport.txt
echo " " >> /etc/skrypty/raport.txt

echo -=ISA adapter=- >> /etc/skrypty/raport.txt
isa0tem=$(sensors | grep 'temp1')
isa1tem=$(sensors | grep 'temp2')
isa2tem=$(sensors | grep 'temp3')
tem0=$(echo $isa0tem | cut -c1-15)
tem1=$(echo $isa1tem | cut -c1-15)
tem2=$(echo $isa2tem | cut -c1-15)
sen0=$(echo $isa0tem | cut -c61-71)
sen1=$(echo $isa1tem | cut -c61-75)
sen2=$(echo $isa2tem | cut -c61-70)
printf "$tem0 pobrane z sensora: $sen0\n$tem1 pobrane z sensora: $sen1\n$tem2 pobrane z sensora:  $sen2\n" >> /etc/skrypty/raport.txt

echo ""  >> /etc/skrypty/raport.txt
echo -=DYSKI=- >> /etc/skrypty/raport.txt
sda=$(sudo hddtemp /dev/sda)
sdc=$(sudo hddtemp /dev/sdc)
sdd=$(sudo hddtemp /dev/sdd)
sde=$(sudo hddtemp /dev/sde)
sdf=$(sudo hddtemp /dev/sdf)
echo -n Dysk SDA:  >> /etc/skrypty/raport.txt
echo $sda | cut -c11-70 >> /etc/skrypty/raport.txt
echo -n Dysk SDC: >> /etc/skrypty/raport.txt
echo $sdc | cut -c11-70 >> /etc/skrypty/raport.txt
echo -n Dysk SDD: >> /etc/skrypty/raport.txt
echo $sdd | cut -c11-70 >> /etc/skrypty/raport.txt
echo -n Dysk SDE: >> /etc/skrypty/raport.txt
echo $sde | cut -c11-70 >> /etc/skrypty/raport.txt
echo -n Dysk SDF: >> /etc/skrypty/raport.txt
echo $sdf | cut -c11-70 >> /etc/skrypty/raport.txt

