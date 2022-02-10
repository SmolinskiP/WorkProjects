<?php
$css = file_get_contents($_SERVER['DOCUMENT_ROOT']."/functions/main.css");
echo $css;

exec("sudo sh /etc/skrypty/DHCP-leases2");
$data = array_slice(file('unknown.txt'), -50);
$mac_adr = file_get_contents('mac_list.txt');
echo "<table border=1>";
foreach ($data as $line) {
    $ip = substr($line, 3, (strpos($line, ')'))-3);
    $mac = substr($line, (strpos($line, 'at ')+3), 17);
    if (substr($mac, 2, 1)!="n"){
	if (strpos($mac_adr, strtoupper(substr($mac, 0, 8))) !== FALSE)
	{
	    $start_string = strpos($mac_adr, strtoupper(substr($mac, 0, 8)));
	    $owner = substr($mac_adr, $start_string+8, strpos($mac_adr, PHP_EOL, $start_string+8) - $start_string-8);
	}
    echo '<tr><td>'.$ip.'</td><td>'.strtoupper($mac).' '.'</td><td>'.$owner.'</tr>';
}

#    echo substr($mac, 2, 1);
#    echo strpos($line, ')');
#    echo $ip;
#    echo "<br>";
#    echo $line;
}
echo "</table>";
?>

