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
  border: 1px solid white;
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

Wybierz datę:
<div style="background-image: url('strona2.png');"> 
<! --- <img src="pp.png" alt="Logo" align="right"> --->
<form action="admin.php" method="post">

<input type="date" id="data2" name="data2" value="<?php echo date('Y-m-d'); ?>">
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
<a href="download.php">
   <button class="myButton">Wygeneruj Excela</button>
</a>
<br>
<br>
<a href="spoznienia.php">
   <button class="myButton">Stronka ze spoznieniami</button>
</a>

<br><br>
<?php

if (strval($_SERVER['PHP_AUTH_USER']) != 'patryk' and $_SERVER['PHP_AUTH_USER'] != jerzy and $_SERVER['PHP_AUTH_USER'] != kasia and $_SERVER['PHP_AUTH_USER'] != rafal and $_SERVER['PHP_AUTH_USER'] != marcin)
    header('Location: https://google.pl/rcp/');

$db = new mysqli('localhost', 'rcp', 'rcp', 'RFID');
mysqli_set_charset($db,"utf8");
$dzial=$_POST['dzialy'];
if (!isset($dzial)){$dzial=5;}

$get_table = "SELECT pracownicy.imie, pracownicy.nazwisko, obecnosc.time, obecnosc.action FROM obecnosc LEFT JOIN pracownicy ON obecnosc.pracownik = pracownicy.id LEFT JOIN _dzial ON pracownicy.dzial = _dzial.id WHERE pracownicy.dzial = ".$dzial." ORDER BY pracownicy.nazwisko, obecnosc.action";
$result = $db->query($get_table);

//$html_day = $_POST['dzien'];
//$html_month = $_POST['miesiac'];
//$html_year = $_POST['rok'];
$html_data2 = $_POST['data2'];
if ($html_data2 == "")
	$html_data2 = date('Y-m-d');
echo "<font size=5>".$html_data2."</font><br><br>";
//echo $html_data2;
//echo gettype($html_data2);
$user_input = $html_year."-".$html_month."-".$html_day;
//echo $user_input;

while ($r = $result->fetch_assoc())
{
	$imie=$r['imie'];
	$nazwisko=$r['nazwisko'];
	$time=$r['time'];
	$action=$r['action'];
//	echo gettype($time);
//	echo $time;
	$data = substr($time, 0, 10);
	$czas = substr($time, 10, 10);
        if ($action > 4)
            $czas = "";
//	echo "<br>";
//	echo $data;
	if ($action == 1)
		$action = "Wejscie";
	elseif ($action == 2)
		$action = "Wylogowanie";
	elseif ($action == 3)
		$action = "Przerwa";
	elseif ($action == 4)
		$action = "Koniec przerwy";
        elseif ($action > 4)
                $action = "URLOP/ZWOLNIENIE";
	if ($data == $html_data2)
		echo "<table><tr>
		<td colspan=10>$nazwisko</td>
		<td>$imie</td>
		<td>$czas</td>
		<td>$action</td>
		</tr></table>";
}

echo "</body>";
echo "</html>";
?>
<br><br><br><br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>

</body>
