<?php
$login = $_POST['login'];
$passs = $_POST['passs'];
require rtrim($_SERVER['DOCUMENT_ROOT']."/functions/val_signs.php");

if (val_signs($passs)){
    exec("sudo echo -e '$passs\n$passs' | sudo passwd $login");
    exec("sudo echo -e '$passs\n$passs' | sudo smbpasswd $login");
    $host = $_SERVER['HTTP_HOST'];
    $url = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
    echo "Haslo zostalo zmienione.";
#    header("Location: http://$host$url/");
}
else{
    echo "Error 507 - niedozwolone znaki lub zła długość hasła. Spróbuj jeszcze raz.";
}

#$host = $_SERVER['HTTP_HOST'];
#$url = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
#header("Location: http://$host$url/");

?>

