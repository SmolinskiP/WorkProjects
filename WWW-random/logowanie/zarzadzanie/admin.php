<?php
require "config.php";
$db = new mysqli($host, $bazalogin, $bazahaslo, $baza);
mysqli_set_charset($db,"utf8");
#echo $_SESSION['fname'];
if ($db->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
###############################################DANE SESJI
$user = $_SESSION['fname'];
$login = $user;
echo "Zalogowany użytkownik: $login";
$get_mac_sql = "SELECT max(komputery.mac) FROM przypisanieip LEFT JOIN komputery ON komputery.id = przypisanieip.komputer LEFT JOIN pracownicy ON pracownicy.id = przypisanieip.pracownik WHERE pracownicy.unixlogin = '$user' ORDER BY przypisanieip.idstanowiska";
$get_mac = $db->query($get_mac_sql);
$mac = $get_mac->fetch_assoc();
$mac = $mac["max(komputery.mac)"];
$get_ip_sql = "SELECT max(przypisanieip.ip) FROM przypisanieip LEFT JOIN pracownicy ON pracownicy.id = przypisanieip.pracownik WHERE pracownicy.unixlogin = '$user' ORDER BY przypisanieip.idstanowiska";
$get_ip = $db->query($get_ip_sql);
$ip = $get_ip->fetch_assoc();
$ip = $ip["max(przypisanieip.ip)"];
if ($ip[7] = "."){
    $port = "33".$ip[6].$ip[-2].$ip[-1];
    $port2 = "59".$ip[6].$ip[-2].$ip[-1];
    }
else{
    $port = "33".$ip[-3].$ip[-2].$ip[-1];
    $port2 = "59".$ip[-3].$ip[-2].$ip[-1]; 
    }


#$port = "33".$ip[6].$ip[-2].$ip[-1];
###############################################


echo '<table border=2>';
if (($_SESSION['fname'] == "patryk") or ($_SESSION['fname'] == "rafal") or ($_SESSION['fname'] == "jerzy") or ($_SESSION['fname'] == "krystian" ) or ($_SESSION['fname'] == "iwona")){
    $pytanie = "SELECT przypisanieip.idstanowiska, pracownicy.id, pracownicy.imie, pracownicy.nazwisko, stanowisko.stanowisko, pracownicy.uprawnienia, przypisanieip.ip, komputery.mac FROM pracownicy LEFT JOIN stanowisko on pracownicy.stanowisko = stanowisko.id LEFT JOIN przypisanieip ON pracownicy.id = przypisanieip.pracownik LEFT JOIN komputery ON komputery.id = przypisanieip.komputer where pracownicy.lokalizacja = 1 AND komputery.mac IS NOT null ORDER BY pracownicy.imie asc";
}
elseif ($_SESSION['fname'] == "d"){
    $pytanie = "SELECT przypisanieip.idstanowiska, pracownicy.id, pracownicy.imie, pracownicy.nazwisko, stanowisko.stanowisko, pracownicy.uprawnienia, przypisanieip.ip, komputery.mac FROM pracownicy LEFT JOIN stanowisko on pracownicy.stanowisko = stanowisko.id LEFT JOIN przypisanieip ON pracownicy.id = przypisanieip.pracownik LEFT JOIN komputery ON komputery.id = przypisanieip.komputer where pracownicy.lokalizacja = 1 AND komputery.mac IS NOT null AND (pracownicy.stanowisko = 1 OR pracownicy.stanowisko = 27 OR pracownicy.stanowisko = 33 OR pracownicy.stanowisko = 32) ORDER BY pracownicy.imie asc";
}
elseif ($_SESSION['fname'] == "c"){
    $pytanie = "SELECT przypisanieip.idstanowiska, pracownicy.id, pracownicy.imie, pracownicy.nazwisko, stanowisko.stanowisko, pracownicy.uprawnienia, przypisanieip.ip, komputery.mac FROM pracownicy LEFT JOIN stanowisko on pracownicy.stanowisko = stanowisko.id LEFT JOIN przypisanieip ON pracownicy.id = przypisanieip.pracownik LEFT JOIN komputery ON komputery.id = przypisanieip.komputer where pracownicy.lokalizacja = 1 AND komputery.mac IS NOT null AND (pracownicy.stanowisko = 25 OR pracownicy.stanowisko = 21 OR pracownicy.stanowisko = 5) ORDER BY pracownicy.imie asc";
}
elseif ($_SESSION['fname'] == "b"){
    $pytanie = "SELECT przypisanieip.idstanowiska, pracownicy.id, pracownicy.imie, pracownicy.nazwisko, stanowisko.stanowisko, pracownicy.uprawnienia, przypisanieip.ip, komputery.mac FROM pracownicy LEFT JOIN stanowisko on pracownicy.stanowisko = stanowisko.id LEFT JOIN przypisanieip ON pracownicy.id = przypisanieip.pracownik LEFT JOIN komputery ON komputery.id = przypisanieip.komputer where pracownicy.lokalizacja = 1 AND komputery.mac IS NOT null AND (pracownicy.stanowisko = 20 OR pracownicy.stanowisko = 24) ORDER BY pracownicy.imie asc";
}
elseif ($_SESSION['fname'] == "a"){
    $pytanie = "SELECT przypisanieip.idstanowiska, pracownicy.id, pracownicy.imie, pracownicy.nazwisko, stanowisko.stanowisko, pracownicy.uprawnienia, przypisanieip.ip, komputery.mac FROM pracownicy LEFT JOIN stanowisko on pracownicy.stanowisko = stanowisko.id LEFT JOIN przypisanieip ON pracownicy.id = przypisanieip.pracownik LEFT JOIN komputery ON komputery.id = przypisanieip.komputer where pracownicy.lokalizacja = 1 AND komputery.mac IS NOT null AND (pracownicy.id = 71 OR pracownicy.id = 15 OR pracownicy.id = 77 OR pracownicy.id = 72 OR pracownicy.id = 18 OR pracownicy.id = 61 OR pracownicy.id = 78 OR pracownicy.id = 12) ORDER BY pracownicy.imie asc";
}

else{
    echo "Wystąpił jakiś błąd";
}
$wynik = $db->query($pytanie);
$counter = 1;
while ($r = $wynik->fetch_assoc()) 
{
    $id=$r['id'];
    $imie=$r['imie'];
    $nazwisko=$r['nazwisko'];
    $stanowisko=$r['stanowisko'];
    $uprawnienia=$r['uprawnienia'];
    $mac_pracownik=$r['mac'];
    $ip_pracownik=$r['ip'];
    
    $idstanowiska=$r['idstanowiska'];
    $rzad = $idstanowiska[1];
    $miejsce = $idstanowiska[2];
    if ($idstanowiska[0] == "S"){
	$pomieszczenie = "Serwis";
    }
    elseif ($idstanowiska[0] == "L"){
	$pomieszczenie = "Logistyka";
    }
    elseif ($idstanowiska[0] == "M"){
	$pomieszczenie = "Magazyn";
    }
    elseif ($idstanowiska[0] == "B"){
	$pomieszczenie = "Biuro";
    }
    elseif ($idstanowiska[0] == "K"){
	$pomieszczenie = "Kadry";
    }
    else{
	$pomieszczenie = "Error 666";
    }


    if ($ip_pracownik[7] = "."){
	$port_pracownik = "33".$ip_pracownik[6].$ip_pracownik[-2].$ip_pracownik[-1];
    }
    else{
	$port_pracownik = "33".$ip_pracownik[-3].$ip_pracownik[-2].$ip_pracownik[-1];
    }


    echo "
    
    <tr>
    <td colspan=10>$counter</td>
    <td>ID w bazie:$id</td>
    <td>$imie $nazwisko</td>
    <td>$stanowisko</td>
    <td><form action='poweron.php' method='post'>
    <input type='hidden' name='ip_pracownik' value='$ip_pracownik'>
    <input type='hidden' name='mac_pracownik' value='$mac_pracownik'>
    <input type='hidden' name='port_pracownik' value='$port_pracownik'>
    <input type='hidden' name='choice' value=1>
    <button type='submit' class='poweronbtn' name='abc'>Włącz komputer pracownika</button></form>
    <form action='poweron.php' method='post'>
    <input type='hidden' name='ip_pracownik' value='$ip_pracownik'>
    <input type='hidden' name='mac_pracownik' value='$mac_pracownik'>
    <input type='hidden' name='port_pracownik' value='$port_pracownik'>
    <input type='hidden' name='choice' value=2>
    <button type='submit' class='poweronbtn2' name='abc'>Zamknij porty</button></form>
    </td>


    <td><form action='uprawnienia.php' method='post'><label for='uprawniania'><b>Uprawnienia</b></label>
    <input type='hidden' name='idpracownika' value='$id'><input type='number' placeholder=$uprawnienia name='uprawnienia' required></td>
    <td><button type='submit' class='poweronbtn3' name='b'>Zmień u pracownika</button></form></td>
    <td>VNC: $ip_pracownik<br><a href='https://p.pdaserwis.pl/logowanie/zarzadzanie/vnc.vnc?ip=$ip_pracownik' download>PLIK DO VNC<br></a>Port: $port_pracownik</td>
    <td>Pomieszczenie: $pomieszczenie<br>Rząd: $rzad<br>Miejsce: $miejsce</td></div></form>
";
$counter++;
}


################################################################################################NAGLOWEK
$css = file_get_contents($_SERVER['DOCUMENT_ROOT']."/functions/main.css");
echo $css;
echo '<html>';
echo '<head>';
echo '</head>';
echo '<body>';
echo '<br>';
echo "<form action='passchange.php' method='post'>
  <div class='imgcontainer'>
    <img src='../pda.png' alt='Avatar' class='avatar'>
  </div>

  <div class='container'>
    <label for='haslo'><b>Zmień hasło</b></label>
    <input type='password' placeholder='$user' name='passs' required><input type='hidden' name='login' value='$login'>
    <button type='submit'>Zmień</button><br>
  </div>
</form>
<form action=index.php method='get'>
    <div id='outer'>
      <div class='inner'><button name='a' type='submit' class='cancelbtn' value='Wlacz_komputer'>Włącz mój komputer</button><br></div>
      <div class='inner'><button name='a' type='submit' class='cancelbtn2' value='Zamknij_porty'>Zakończ pracę i zamknij porty</button><br></div>
      <div class='inner'><button name='a' type='submit' class='cancelbtn3' value='Przeladuj_uprawnienia'>Przeładuj uprawnienia użytkowników</button><br></div>

    <br><br><br>
  </div>

</form>
<form action='blokady.php' method='post'>
<div id='outer'>
       <div class='inner'><button name='a' type='submit' class='cancelbtn4' value='abcd'>--->Lista blokowanych stron dla danych uprawnień<---</button><br></div><br><br><br>
</form>
<form action='index.php' method='get'>
       <div class='inner'><button name='a' type='submit' class='poweronbtn2' value='Przelaczsiec'>Przełącz sieć na GSM<br>OSTROŻNIE!!!<br>!!!</button><br></div><br>
       <div class='inner'><button name='a' type='submit' class='poweronbtn' value='Przelaczsiec2'>Przełącz sieć z powrotem<br></button><br></div><br><br><br><br>

</form>
";
######################################################################################################





#$mac = 'D4:81:D7:D9:A1:9C';
#$mac = escapeshellarg($mac);
#$ipad = '10.0.10.89';
#$ipad = escapeshellarg($ipad);
#$port = '33089';
#$port = escapeshellarg($port);





###############################################SKRYPT WŁĄCZ WYŁĄCZ
if ($_GET['a']=='Wlacz_komputer')
    {
	$choice = '1';
	$choice = escapeshellarg($choice);
	$mac = escapeshellarg($mac);
	$ip = escapeshellarg($ip);
	$port = escapeshellarg($port);
	$port2 = escapeshellarg($port2);
	exec("sudo sh /etc/skrypty/poweronoff.sh $mac $ip $port $choice $port2");
	echo "Wykonano skrypt z parametrami $mac $ip $port $choice $port2";
    }
elseif ($_GET['a']=='Zamknij_porty')
    {
	$choice = '2';
	$choice = escapeshellarg($choice);
	$mac = escapeshellarg($mac);
	$ip = escapeshellarg($ip);
	$port = escapeshellarg($port);
	$port2 = escapeshellarg($port2);

	exec("sudo sh /etc/skrypty/poweronoff.sh $mac $ip $port $choice $port2");
	echo "Wykonano skrypt z parametrami $mac $ip $port $choice $port2";
    }
elseif ($_GET['a']=='Przeladuj_uprawnienia')
    {
	exec("sudo sh /etc/skrypty/IPtables.sh");
	echo "Wykonano skrypt przeladowania";
    }
elseif ($_GET['a']=='abcd')
    {
	header("Location: http://$host$url/zarzadzanie/blokady.php");
    }
elseif ($_GET['a']=='Przelaczsiec')
    {
	exec("sudo sh /etc/skrypty/checkweb/firewall_gsm.sh");
	echo "Przelaczono siec na GSM";
    }
elseif ($_GET['a']=='Przelaczsiec2')
    {
	exec("sudo sh /etc/skrypty/checkweb/firewall.sh");
	echo "Przelaczono siec na kabel";
    }



#$choice = escapeshellarg($choice);
#exec("sudo sh /etc/skrypty/poweronoff.sh $mac $ip $port $choice");
#echo $user;
#################################################################

if (($_SESSION['fname'] == "patryk") or ($_SESSION['fname'] == "jerzy")){
    $pytanie2 = "SELECT przypisanieip.ip, przypisanieip.idstanowiska, przypisanieip.komputer, komputery.mac, komputery.komentarz FROM przypisanieip LEFT JOIN komputery ON komputery.id = przypisanieip.komputer WHERE przypisanieip.pracownik = 0 AND komputery.mac IS NOT null";
}
$wynik2 = $db->query($pytanie2);
while ($r = $wynik2->fetch_assoc()){
    $ip=$r['ip'];
    $idstanowiska=$r['idstanowiska'];
    $mac = $r['mac'];
    $komentarz = $r['komentarz'];
    $choice = 1;
    if ($ip[7] = "."){
	$port = "33".$ip[6].$ip[-2].$ip[-1];
    }
    else{
	$port = "33".$ip[-3].$ip[-2].$ip[-1];
    }

    echo "<tr><td colspan=10>$ip</td><td>$idstanowiska</td><td> $mac</td><td> $komentarz</td>
    <td><form action='poweron.php' method='post'>
    <input type='hidden' name='ip_pracownik' value='$ip'>
    <input type='hidden' name='mac_pracownik' value='$mac'>
    <input type='hidden' name='port_pracownik' value='$port'>
    <input type='hidden' name='choice' value='$choice'>
    <button type='submit' class='poweronbtn' name='abc'>Włącz komputer</button></form></td>
</tr>";
}

?>


