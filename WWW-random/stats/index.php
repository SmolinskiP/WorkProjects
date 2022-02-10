<style>
table {
  width: 49%;
}
</style>

<?php
session_start();

function nazwa($adres){
//echo ' I '.$adres.' I ';

    $file1=file('/etc/hosts');
    for ($p='1'; $file1[$p]; $p++){
//echo $file1[$p].'<br>';
//echo substr($file1[$p], 0, strpos($file1[$p], ' ', 0));
    if (substr($file1[$p], 0, strpos($file1[$p], ' ', 0))==$adres){
        $imie_nazw=substr($file1[$p], strpos($file1[$p], ' ', 0), strlen($file1[$p]));
        echo " <b>".$imie_nazw."</b>";
        }
    }
}

function wypisz(){
    echo '<TABLE border="1"  cellspacing="0" cellpadding="1" align="left" style="font-size:8pt">';
    $file=file('status.txt');
    $suma=0;
    $suma2=0;
    $a=0;
    $b=0;
    $c=0;
    $t=0;
    for ($r='0'; $file[$r]; $r++){
    $tmp=trim($file[$r]);
    $siec=substr($tmp, 0, 1);
//    $siec++;
    switch ($siec) {
    case 'a':
	$kolor="bgcolor=#ffffff";
	$a++;
	$t=$a;
	break;
    case 'g':
	$kolor="bgcolor=#00fafa";
	$b++;
	$t=$b;
	break;
    case 'w':
	$kolor="bgcolor=#fff6d5";
	$c++;
	$t=$c;
	break;
    default:
	$kolor="bgcolor=#ffffff";
	$t="";
    }
    if (strlen($tmp) >= '2'){
	echo "<tr><td>".$t."</td><td $kolor width=.\"300.\">";
        echo substr($tmp, 0, strpos($tmp, ' ', 0));

	if (substr($tmp, 0, 2)==ad){
	    $aadres="10.0.1";
	    }
	if (substr($tmp, 0, 2)==wy){
	    $aadres="10.100.10";
	    }
	if (substr($tmp, 0, 2)==go){
	    $aadres="192.168.1";
	    }
	if (substr($tmp, -6, 4)==ffic && substr($tmp, 0, 2)==ul){
	    echo '</table><table border="1"  cellspacing="0" cellpadding="1" align="right" style="font-size:8pt">';
	    echo '<td></td><td>ul</td>';
            }
	$aadres=$aadres . substr($tmp, 2, 1) . "." . substr($tmp,  strpos($tmp, '_', 0)+1, strpos($tmp, ' ', 0)-strpos($tmp, '_', 0)-1);


//echo $aadres;
//        echo substr($tmp, 0, 2);
//echo ' a a a ';
//        echo substr($tmp, 2, 1);
//echo '.';
//        echo substr($tmp,  strpos($tmp, '_', 0)+1, strpos($tmp, ' ', 0)-strpos($tmp, '_', 0)-1);
//        echo strpos($tmp, '(', 0);
//        echo strpos($tmp, '(', 0);
//        echo strpos($tmp, ' ', 0);


//	nazwa(substr($tmp, 0, strpos($tmp, ' ', 0)));
	nazwa($aadres);
	echo "</td><td $kolor width=.\"200.\" align=\"center\">";
	echo substr($tmp, strpos($tmp, ' ', 0)+1, (strpos($tmp, '( ', 0)-strpos($tmp, ' ', 0)-1));
        echo "</td><td $kolor width=.\"200.\" align=\"right\">";
	echo substr($tmp, strpos($tmp, '( ', 0)+1, strpos($tmp, ' )', 0)-strpos($tmp, '( ', 0)-1);
//	echo substr($tmp, strpos($tmp, ')', 0)+1, strlen($tmp)-1);
        echo '</td></tr>';
        if (substr($tmp, strpos($tmp, '(', 0)+1, (strpos($tmp, ')', 0)-strpos($tmp, '(', 0)-6)) >= '0'){
//    	    $suma=$suma+substr($tmp, strpos($tmp, '(', 0)+1, (strpos($tmp, ')', 0)-strpos($tmp, '(', 0)-6));
	    }
        if (substr($tmp, -12, 6) >= '0'){
//    	    $suma2=$suma2+substr($tmp, -12, 6);
	    }
	}
    }
echo '</table>';
/*
$t=$a+$b+$c;
echo "Wszyscy: $t <br>";
echo "Administracja: $a <br>";
echo "Wolny internet: $b <br>";
echo "Bursowicze: $c <br>";
echo "Suma: $suma <br>";
echo "Suma2: $suma2 <br>";
*/
}

function stan($kto){
    echo '<TABLE border="1">';
    $file=file('stats.txt');
    $tmp=trim($file[0]);
	echo "<tr><td $kolor width=.\"300.\">";
        echo substr($tmp, 0, strpos($tmp, ' ', 0));
	nazwa(substr($tmp, 0, strpos($tmp, ' ', 0)));
	echo "</td><td $kolor width=.\"200.\">";
	echo substr($tmp, strpos($tmp, ' ', 0)+1, (strpos($tmp, ')', 0)-strpos($tmp, ' ', 0)+1));
        echo "</td><td $kolor width=.\"200.\">";
	echo substr($tmp, strpos($tmp, ')', 0)+1, strlen($tmp)-1);
        echo '</td></tr>';
    for ($r='0'; $file[$r]; $r++){
    $tmp=trim($file[$r]);
    $siec=substr($tmp, 0, +$dlugosc_addr);
    if (substr($tmp, 0, strpos($tmp, ' ', 0)) === $kto){
	echo "<tr><td $kolor width=.\"300.\">";
        echo substr($tmp, 0, strpos($tmp, ' ', 0));
	nazwa(substr($tmp, 0, strpos($tmp, ' ', 0)));
	echo "</td><td $kolor width=.\"200.\">";
	echo substr($tmp, strpos($tmp, ' ', 0)+1, (strpos($tmp, ')', 0)-strpos($tmp, ' ', 0)+1));
        echo "</td><td $kolor width=.\"200.\">";
	echo substr($tmp, strpos($tmp, ')', 0)+1, strlen($tmp)-1);
        echo '</td></tr>';
	}
    }
echo '</table>';
}

function adres(){
stan ($_SERVER['REMOTE_ADDR']);
}

/////////////////////////////////////////////////////////////////////////////////////
echo '<html>';
echo '<head>';

if (isset($_SESSION['uzyt'])) {
        echo '<META HTTP-EQUIV="refresh" content="5">';
        echo '</head>';
        echo '<body>';
        wypisz();
    }else{
	if (isset($_POST['user'])){
	if ($_POST['user']=="df"){
	    $_SESSION['uzyt']=isset($HTTP_POST_VARS['user']);
	    echo '<META HTTP-EQUIV="refresh" content="1">';
	    echo '</head>';
	    echo '<body>';
	    wypisz();
	    }
	    }else{
		echo '<META HTTP-EQUIV="refresh" content="5">';
	        echo '</head>';
       		echo '<body>';
        wypisz();

	    }
	}
?>
</body>
</html>
