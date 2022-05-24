#Connect-MsolService

$Results = @();
$Users = Get-MsolUser | Where-Object {($_.licenses).AccountSkuId -match "O365_BUSINESS" -or "TEAMS"} | Select-Object UserPrincipalName | Where-Object {$_.UserPrincipalName -match "pdaserwis.eu"}

foreach($User in $Users){
	if ('EXCLUDE MAILBOXES HERE BY SPACE'.contains($User.UserPrincipalName)){
		continue
	}
	else{
		$Results += $User.UserPrincipalName
	}
}

$i = 1

foreach($User in $Results){
	$ProgressBar = $i/$Results.Length*100
	$ProgressBarInt = [int]$ProgressBar
	$output = $i.ToString() + " - " + $User
	Write-Output $output
	Write-Progress -Activity "Executing command" -Status "$ProgressBarInt% complete - processing $User" -PercentComplete $ProgressBarInt
	Start-Sleep -Milliseconds 150
	$ProgressPreference='Stop'
  ## ENTER HERE ANY COMMAND, SET AUTORESPONDER, FORWARDING, ANYTHING FOR WHOLE ORGANIZATION
	$i += 1
}

