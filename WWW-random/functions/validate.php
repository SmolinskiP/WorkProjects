 <?php
function user_check($user, $pass)
{
    $userName=$user;
    $userPasswd=$pass;
    $passwdFile='/etc/shadow';
    $users=file($passwdFile);
    if ($user == "admin")
    {
	echo "Wrong password!";
    }
    if (!$user=preg_grep("/^$userName/",$users))
    {
	#echo "Error 01";
        echo preg_grep("/^$userName/",$users);
	#echo $passwdFile;
	#echo $users;
	return false;
    }
    else
    {
	list(,$passwdInDB)=explode(':',array_pop($user));
	if (crypt($userPasswd,$passwdInDB) == $passwdInDB)
	{
	    #echo "Poszlo";
	    return true;
	}
	else
	{
	    #echo "Error02";
	    return false;
	}
    }
}

?>
