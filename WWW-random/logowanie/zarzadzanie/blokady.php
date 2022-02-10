<?php
require "config.php";
$db = new mysqli($host, $bazalogin, $bazahaslo, $baza);
mysqli_set_charset($db,"utf8");

if ($db->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}


###############################################DANE SESJI
$counterr = 10;
while ($counterr > 0){
    $pytanie = "SELECT * FROM uprawnienia where poziomuprawnien='$counterr'";
    $wynik = $db->query($pytanie);
#    $counterr = $counterr - 1;
    echo "Strony blokowane dla osób z uprawnieniami ".$counterr.":";
    echo "<br>";
    while ($r = $wynik->fetch_assoc())
    {
	$ip_pracownik=$r['strony'];
	echo $ip_pracownik;
	echo "<br>";
    }
    echo "PLUS wszystkie z uprawnień powyżej";
    echo "<br>";
    echo "<br>";
    $counterr = $counterr - 1;
}
?>


