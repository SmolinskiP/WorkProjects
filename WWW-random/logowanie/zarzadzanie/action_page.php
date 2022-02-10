<?php

$fpart=$_POST['fpart'];
$spart=$_POST['spart'];
$tpart=$_POST['tpart'];
$fopart=$_POST['fopart'];
if ($fopart<=5){$fopart=$fopart+5;}
else {$fopart=$fopart-5;}

function check_browser(){
    $fpart=$_POST['fpart'];
    $spart=$_POST['spart'];
    $tpart=$_POST['tpart'];
    $fopart=$_POST['fopart'];
    if ($fopart>=5){$fopart=$fopart-5;}
    else {$fopart=$fopart+5;}

    $browser = "Z przeglądarki: ".$_SERVER['HTTP_USER_AGENT'];
    $ip_add = "Dokonana przez: ".$_SERVER['REMOTE_ADDR'];
    if($_SERVER['REMOTE_ADDR']=="10.0.10.89"){$ip_add="Dokonana przez: <b>Patryk</b>";}
    elseif($_SERVER['REMOTE_ADDR']=="10.0.11.31"){$ip_add="Dokonana przez: <b>Czaro</b>";}
    elseif($_SERVER['REMOTE_ADDR']=="10.0.11.13"){$ip_add="Dokonana przez: <b>Bartek</b>";}
    elseif($_SERVER['REMOTE_ADDR']=="10.0.11.37"){$ip_add="Dokonana przez: <b>Jaca</b>";}
    elseif($_SERVER['REMOTE_ADDR']=="10.0.10.98"){$ip_add="Dokonana przez: <b>Jerzy</b>";}
    elseif($_SERVER['REMOTE_ADDR']=="10.0.10.98"){$ip_add="Dokonana przez: <b>Jerzy</b>";}
    else{$ip_add = "Dokonana przez: ".$_SERVER['REMOTE_ADDR'];}
    $log_date="Ostatnia zmiana: <b>".date("Y-m-d H:i:s")."</b>";
    $zmiana="IP zmieniono na: <b>".$fpart.".".$spart.".".$tpart.".".$fopart."</b>";
    $fp = fopen('drukarki_ip_log.txt', 'a');
    fwrite($fp, $log_date."\n");
    fwrite($fp, $ip_add."\n");
    fwrite($fp, $browser."\n");
    fwrite($fp, $zmiana."\n\n");
}



if ($fpart!=192 && $fpart!=172 && $fpart!=10){echo "Pierwsza część musi wynosić 192, 172 lub 10!";}
elseif ($spart>255 || $tpart>255 || $fopart>255){echo "Maksymalna wartość to 255!";}
elseif ($fpart<0 || $spart<0 || $tpart<0 || $fopart<0){echo "Nie wygłupiaj się";}
elseif ($fpart==192 && $spart!=168){echo "Po 192 musi być 168!";}
elseif ($fpart==172 && ($spart<16 || $spart>31)){echo "Dla 172 druga część adresu musi być pomiędzy 16 a 32";}
elseif ($fpart==10 && $spart==0 && ($tpart==10 || $tpart==11)){echo "To nasza sieć panie kochany";}
else{
check_browser();
echo "Zmieniono IP na: ".$fpart.".".$spart.".".$tpart.".".$fopart;

$txt="# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug enp6s0
#iface enp6s0 inet dhcp

auto enp6s0
iface enp6s0 inet static
    address 85.128.76.162
    netmask 255.255.255.248
    gateway 85.128.76.161
##	network 85.128.76.160
##	broadcast 85.128.76.168


allow-hotplug enp3s0f0
#auto enp3s0f0
iface enp3s0f0 inet static
    address 10.0.10.1
    netmask 255.255.254.0
    network 10.0.10.0
    broadcast 10.0.11.255

allow-hotplug enp3s0f1
#auto enp3s0f1
iface enp3s0f1 inet static
    address ".$fpart.".".$spart.".".$tpart.".".$fopart."
    netmask 255.255.255.0
    network ".$fpart.".".$spart.".".$tpart.".0
    broadcast ".$fpart.".".$spart.".".$tpart.".255

allow-hotplug enp4s0f0
#auto enp4s0f0
iface enp4s0f0 inet static
    address 192.16.11.1
    netmask 255.255.255.0
    network 192.16.11.0
    broadcast 192.16.11.255


allow-hotplug enp4s0f1
iface enp4s0f1 inet static
    address 192.168.108.101
    netmask 255.255.255.0
    gateway 192.168.108.1
    network 192.168.108.0
    broadcast 192.168.108.255";
#echo $txt;
$myfile = fopen("/etc/network/interfaces", "w") or die("Unable to open file!");
fwrite($myfile, $txt);
fclose($myfile);

exec("sudo ifdown enp3s0f1");
exec("sleep 5");
exec("sudo ifup enp3s0f1");

}


?>