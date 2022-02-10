<?php
require rtrim($_SERVER['DOCUMENT_ROOT']."/functions/val_signs.php");
$host = $_SERVER['HTTP_HOST'];
session_start();
if($_SESSION['fname'] == ''){
    header("Location: http://$host/logowanie/");
    die();
}
$user = $_SESSION['fname'];
if (($_SESSION['fname'] == "patryk") or ($_SESSION['fname'] == "rafal") or ($_SESSION['fname'] == "jerzy") or ($_SESSION['fname'] == "krystian")){
    require "/var/www/html/logowanie/zarzadzanie/admin.php";
}
elseif ($_SESSION['fname'] == "a"){
    require "/var/www/html/logowanie/zarzadzanie/admin.php";
}
elseif ($_SESSION['fname'] == "b"){
    require "/var/www/html/logowanie/zarzadzanie/admin.php";
}
elseif ($_SESSION['fname'] == "c"){
    require "/var/www/html/logowanie/zarzadzanie/admin.php";
}
elseif ($_SESSION['fname'] == "d"){
    require "/var/www/html/logowanie/zarzadzanie/admin.php";
}
elseif ($_SESSION['fname'] == "e"){
    require "/var/www/html/logowanie/zarzadzanie/teamleader.php";
}
elseif ($_SESSION['fname'] == "f"){
    require "/var/www/html/logowanie/zarzadzanie/otheruser2.php";
}


else{
    require "/var/www/html/logowanie/zarzadzanie/otheruser.php";
}
?>


