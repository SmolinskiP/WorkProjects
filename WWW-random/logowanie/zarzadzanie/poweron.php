<?php
require "config.php";

$mac_pracownik = $_POST['mac_pracownik'];
$ip_pracownik = $_POST['ip_pracownik'];
$port_pracownik = $_POST['port_pracownik'];
$choice = $_POST['choice'];
echo $_POST['choice'];
$choice = escapeshellarg($choice);
$mac_pracownik = escapeshellarg($mac_pracownik);
$ip_pracownik = escapeshellarg($ip_pracownik);
$port_pracownik = escapeshellarg($port_pracownik);


exec("sudo sh /etc/skrypty/poweronoff.sh $mac_pracownik $ip_pracownik $port_pracownik $choice");
#echo "sudo sh /etc/skrypty/poweronoff.sh $mac_pracownik $ip_pracownik $port_pracownik $choice";
$host = $_SERVER['HTTP_HOST'];
$url = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');

header("Location: http://$host$url/");

?>

