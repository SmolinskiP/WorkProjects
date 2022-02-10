<?php

$data = array_slice(file('unknown.txt'), -50);

foreach ($data as $line) {
    echo $line;
    echo "<br>";
}
?>

