<?php
require "config.php";
$db = new mysqli($host, $bazalogin, $bazahaslo, $baza);
mysqli_set_charset($db,"utf8");
if ($db->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
$pytanie = "SELECT pracownicy.uprawnienia, pracownicy.unixlogin, pracownicy.dzial FROM pracownicy WHERE uprawnienia IS NOT NULL AND unixlogin != ''";
$wynik = $db->query($pytanie);
while ($r = $wynik->fetch_assoc())
{
    $unixlogin=$r['unixlogin'];
    $uprawnienia=$r['uprawnienia'];
    $dzial=$r['dzial'];
    echo "sudo mount --rbind /mnt/md11/samba/Public /mnt/md11/home/$unixlogin/==Public==/";
    echo "<br>";
}
?>