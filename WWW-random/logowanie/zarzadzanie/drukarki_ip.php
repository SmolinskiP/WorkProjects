<!DOCTYPE html>
<html>

   <head>
      <title>a a</title>
   </head>
   <body>
	<form action="action_page.php" method="post">

<!--	<label for="fpart">Wpisz adres IP drukarki:</label>
	<input type="number" id="fpart" name="fpart" size="3" maxlength="3">-->

	<label for="fpart">Wpisz adres IP drukarki:</label>
	<select name="fpart" id="fpart">
	    <option value=192>192</option>
	    <option value=172>172</option>
	    <option value=10>10</option>
	</select>

	<label for="spart"></label>
	<input type="number" id="spart" name="spart" size="3" maxlength="3">

	<label for="tpart"></label>
	<input type="number" id="tpart" name="tpart" size="3" maxlength="3">

	<label for="fopart"></label>
	<input type="number" id="fopart" name="fopart" size="3" maxlength="3">

	<input type="submit" value="Submit">
</form> 
   </body>
</html>
<?php
echo "<br>";
$file = file("drukarki_ip_log.txt");
for ($i = max(0, count($file)-5); $i < count($file); $i++) {
  echo $file[$i];
  echo "<br>";
}
?>