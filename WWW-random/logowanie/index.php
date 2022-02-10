<?php
require rtrim($_SERVER['DOCUMENT_ROOT']."/functions/validate.php");
require rtrim($_SERVER['DOCUMENT_ROOT']."/functions/logincookie.php");
$css = file_get_contents($_SERVER['DOCUMENT_ROOT']."/functions/main.css");
echo $css;

echo '<h2>Zaloguj się do swojego konta</h2>';

echo '<form action="index.php" method="post">
  <div class="imgcontainer">
    <img src="pda.png" alt="Avatar" class="avatar">
  </div>

  <div class="container">
    <label for="fname"><b>Użytkownik</b></label>
    <input type="text" placeholder="Wpisz nazwę użytkownika" name="fname" required>

    <label for="haslo"><b>Hasło</b></label>
    <input type="password" placeholder="Wpisz hasło" name="haslo" required>
        
    <button type="submit">Login</button>
    <label>
      <input type="checkbox" checked="checked" name="remember"> Pamiętaj mnie
    </label>
  </div>

  <div class="container" style="background-color:#f1f1f1">
    <button type="button" class="cancelbtn">Anuluj</button>
    <span class="psw">Zapomniałeś <a href="">hasła?</a></span>
  </div>
</form>

</body>
</html>';

$host = $_SERVER['HTTP_HOST'];
$url = rtrim(dirname($_SERVER['PHP_SELF']), '/\\');
$userr = $_POST['fname'];

if(user_check($_POST['fname'], $_POST['haslo']))
{
    header("Location: http://$host$url/zarzadzanie");
    session_start();
    $_SESSION['fname'] = $userr;
}
?>

