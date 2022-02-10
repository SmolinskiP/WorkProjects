<?php
exec("python3 /var/www/html/rcp/rcpexcel.py");

header('Location: Obecnosc.xlsx');
?>

