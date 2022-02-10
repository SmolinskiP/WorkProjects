<?php

function login($cookie)
{
    $usercookie = crypt($cookie);
    setcookie("login", $usercookie);
    return $_COOKIE['login'];
}
?>
