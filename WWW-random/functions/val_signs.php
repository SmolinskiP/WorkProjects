<?php
function val_signs($passw)
{
$passwordlength= strlen($passw);
if ((preg_match("/^[A-Za-z0-9 !@#$%&()_\[\]:;\"',.\?\/-]+$/", $passw) && ($passwordlength > "6") && ($passwordlength < "13")) == true)return true;
else return false;
}

?>
