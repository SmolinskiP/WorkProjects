<?php
require "config.php";
#require "admin.php";
$conn = new mysqli($host, $rootlogin, $roothaslo, $baza);
mysqli_set_charset($conn,"utf8");

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$idpracownika = $_POST['idpracownika'];
$uprawnienia = $_POST['uprawnienia'];

$get_command = "UPDATE `siec`.`pracownicy` SET `uprawnienia`=$uprawnienia WHERE `id`=$idpracownika";
$command = $conn->query($get_command);
#$execute = $command->fetch_assoc();
#echo $execute;

#echo $idpracownika;
#echo $uprawnienia;

$host = $_SERVER['HTTP_HOST'];
$url = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');

header("Location: http://$host$url/");

?>

