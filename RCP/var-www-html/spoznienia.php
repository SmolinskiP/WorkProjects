<!DOCTYPE html>
<html>
<style>
body, head, html {
  height: 100%;
}

.bg {
  /* The image used */
  background-image: url("strona2.png");
  background:"black"
  /* Full height */
  height: 100%;

  /* Center and scale the image nicely */
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}
</style>
<head>
<link rel="stylesheet" href="bg.css">
<title>Lista obecności</title>
</head>
<style>
table{
  border: 1px solid white;
  width: 51%;
  border-collapse: collapse;
  float: left;
}
tr{
    background-color: rgba(0, 0, 0, 0.0) !important;
}
th, td{
  border: 1px solid black;
  border-collapse: collapse;
  width: 25%;
}
caption{
  border: 3px solid black;
  border-collapse: collapse;
}
tr:nth-of-type(odd){
  background-color:#ccc;
}
</style>
<body>
<style>
  .hide { position:absolute; top:-1px; left:-1px; width:1px; height:1px; }
</style>
<iframe name="hiddenFrame" class="hide"></iframe>


Wybierz datę:
<! ---<img src="pp.png" alt="Logo" align="right"> --- >
<form action="spoznienia.php" method="post">
OD: <input type="date" id="data2" name="data2" value="<?php echo date('Y-m-01'); ?>">
DO: <input type="date" id="data3" name="data3" value="<?php echo date('Y-m-t', strtotime(date('Y-m-01'))); ?>">

<label for="dzialy">Wybierz dzial:</label>
        <select name="dzialy" id="dzialy">
                <option value="1"<?php if($_POST['dzialy'] == '1'){ php?>selected<?php } php?>>Kadry i Ksiegowosc</option>
                <option value="2"<?php if($_POST['dzialy'] == '2'){ php?>selected<?php } php?>>Biuro</option>
                <option value="3"<?php if($_POST['dzialy'] == '3'){ php?>selected<?php } php?>>Magazyn</option>
                <option value="4"<?php if($_POST['dzialy'] == '4'){ php?>selected<?php } php?>>Logistyka</option>
                <option value="5"<?php if($_POST['dzialy'] == '5'){ php?>selected<?php } php?>>Serwis</option>
        </select>

<br><br>
<button type="submit" class="myButton">Przeladuj strone</button></form>
<br>


<?php
$db = new mysqli('localhost', 'rcp', 'rcp', 'RFID');
mysqli_set_charset($db,"utf8");
if ($_SERVER['PHP_AUTH_USER'] == 'a')
    $dzial = 5;
elseif ($_SERVER['PHP_AUTH_USER'] == 'b')
    $dzial = 4;
elseif ($_SERVER['PHP_AUTH_USER'] == 'c')
    $dzial = 3;
elseif ($_SERVER['PHP_AUTH_USER'] == 'd')
    $dzial = 2;
elseif ($_SERVER['PHP_AUTH_USER'] == 'e')
    $dzial = 2;
elseif ($_SERVER['PHP_AUTH_USER'] == 'f')
    $dzial = 1;
else
    $dzial = 5;
$get_table = "SELECT pracownicy.nazwisko, pracownicy.imie, obecnosc.time, obecnosc.action FROM obecnosc LEFT JOIN pracownicy ON pracownicy.id = obecnosc.pracownik  LEFT JOIN _dzial ON pracownicy.dzial = _dzial.id WHERE pracownicy.dzial = ".$dzial." AND action = 1 ORDER BY pracownicy.nazwisko, obecnosc.time";
if ($_SERVER['PHP_AUTH_USER'] == 'g')
    $get_table = "SELECT pracownicy.imie, pracownicy.nazwisko, obecnosc.time, obecnosc.action FROM obecnosc LEFT JOIN pracownicy ON obecnosc.pracownik = pracownicy.id LEFT JOIN _dzial ON pracownicy.dzial = _dzial.id WHERE pracownicy.teamleader = 1 ORDER BY pracownicy.nazwisko, obecnosc.action";
elseif ($_SERVER['PHP_AUTH_USER'] == 'h')
    $get_table = "SELECT pracownicy.imie, pracownicy.nazwisko, obecnosc.time, obecnosc.action FROM obecnosc LEFT JOIN pracownicy ON obecnosc.pracownik = pracownicy.id LEFT JOIN _dzial ON pracownicy.dzial = _dzial.id WHERE pracownicy.teamleader = 2 ORDER BY pracownicy.nazwisko, obecnosc.action";
elseif ($_SERVER['PHP_AUTH_USER'] == 'i')
    $get_table = "SELECT pracownicy.imie, pracownicy.nazwisko, obecnosc.time, obecnosc.action FROM obecnosc LEFT JOIN pracownicy ON obecnosc.pracownik = pracownicy.id LEFT JOIN _dzial ON pracownicy.dzial = _dzial.id WHERE pracownicy.teamleader = 3 ORDER BY pracownicy.nazwisko, obecnosc.action";
elseif ($_SERVER['PHP_AUTH_USER'] == 'j')
    $get_table = "SELECT pracownicy.imie, pracownicy.nazwisko, obecnosc.time, obecnosc.action FROM obecnosc LEFT JOIN pracownicy ON obecnosc.pracownik = pracownicy.id LEFT JOIN _dzial ON pracownicy.dzial = _dzial.id WHERE pracownicy.teamleader = 4 ORDER BY pracownicy.nazwisko, obecnosc.action";
$result = $db->query($get_table);
echo "<font size=5>Wyświetlam wyniki od: ";
$html_data2 = $_POST['data2'];
if ($html_data2 == "")
        $html_data2 = date('Y-m-01');
echo $html_data2;
echo " do ";
$html_data3 = $_POST['data3'];
if ($html_data3 == "")
        $html_data3 = date('Y-m-t', strtotime(date('Y-m-01')));
echo $html_data3."</font>";
echo "<br>";

$month_start = intval(substr($html_data2, 5, 2));
$day_start = intval(substr($html_data2, 8, 2));

$month_end = intval(substr($html_data3,5, 2));
$day_end = intval(substr($html_data3, 8, 2));

while ($r = $result->fetch_assoc())
{
        $imie=$r['imie'];
        $nazwisko=$r['nazwisko'];
	$time=$r['time'];
        $action=$r['action'];

        $data = substr($time, 0, 10);
        $czas = substr($time, 10, 10);
	$spoznienie = intval(substr($time, 14, 2));
	$godzina = intval(substr($time, 12, 2));

	$month = intval(substr($time, 5, 2));
	$day = intval(substr($time, 8, 2));

	if ($month_start==$month_end)
		for ($i = $day_start; $i <= $day_end; $i++){
			if ($day == $i)
				if ($spoznienie > 0 && $spoznienie < 25 && $godzina != 6)
					echo "<table><tr>
			                <td colspan=10>$nazwisko</td>
			                <td>$imie</td>
		        	        <td>$data</td>
			                <td><font color=#FF7F7F>$czas<font></td>
			                </tr></table>";
		}
	elseif ($month_start!=$month_end)
		echo "Prace nad wyciaganiem danych dla roznych miesiecy trwaja";
//		break;
//        if ($action == 1)
//                $action = "Wejscie";

//        elseif ($action == 2)
//                $action = "Wylogowanie";
//        elseif ($action == 3)
//                $action = "Przerwa";
//        elseif ($action == 4)
//                $action = "Koniec przerwy";
//        if ($data == $html_data2)
//                echo "<table><tr>
//                <td colspan=10>$imie</td>
//                <td>$nazwisko</td>
//                <td>$czas</td>
//                <td>$data</td>
//                </tr></table>";
}
?>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</body>
</html>

