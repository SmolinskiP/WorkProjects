$Message = new-object Net.Mail.MailMessage 

$smtp = new-object Net.Mail.SmtpClient("xxx", 587) 
$smtp.Credentials = New-Object System.Net.NetworkCredential("xxx@yy.pl", "xxx"); 
$smtp.EnableSsl = $true 
$smtp.Timeout = 400000  

$Today = Get-Date -Format "yyyy/MM/dd"
$Title = $Today.ToString() + " - Raport dyskow WAPRO - W11"

$C_Disk = Get-Volume -DriveLetter C
$D_Disk = Get-Volume -DriveLetter D
$E_Disk = Get-Volume -DriveLetter E

#COLORS - Disk Operational Status
if ($C_Disk.OperationalStatus -eq "OK"){
	$C_DiskOperationalStatusColor = '<b><span style="color:green;">'
}
else{
	$C_DiskOperationalStatusColor = '<b><span style="color:red;">'
}
if ($D_Disk.OperationalStatus -eq "OK"){
	$D_DiskOperationalStatusColor = '<b><span style="color:green;">'
}
else{
	$D_DiskOperationalStatusColor = '<b><span style="color:red;">'
}
if ($E_Disk.OperationalStatus -eq "OK"){
	$E_DiskOperationalStatusColor = '<b><span style="color:green;">'
}
else{
	$E_DiskOperationalStatusColor = '<b><span style="color:red;">'
}

#COLORS - Disk Health Status
if ($C_Disk.HealthStatus -eq "Healthy"){
	$C_DiskHealthStatusColor = '<b><span style="color:green;">'
}
else{
	$C_DiskHealthStatusColor = '<b><span style="color:red;">'
}
if ($D_Disk.HealthStatus -eq "Healthy"){
	$D_DiskHealthStatusColor = '<b><span style="color:green;">'
}
else{
	$D_DiskHealthStatusColor = '<b><span style="color:red;">'
}
if ($E_Disk.HealthStatus -eq "Healthy"){
	$E_DiskHealthStatusColor = '<b><span style="color:green;">'
}
else{
	$E_DiskHealthStatusColor = '<b><span style="color:red;">'
}

#COLORS - Disk Size Remaining
$C_DiskSizeRemainingPercent = $C_Disk.SizeRemaining/$C_Disk.Size*100
$D_DiskSizeRemainingPercent = $D_Disk.SizeRemaining/$D_Disk.Size*100
$E_DiskSizeRemainingPercent = $E_Disk.SizeRemaining/$C_Disk.Size*100
#DYSK C
if ($C_DiskSizeRemainingPercent -gt 50){
	$C_DiskSizeRemainingColor = '<b><span style="color:green;">'
}
elseif ($C_DiskSizeRemainingPercent -gt 15){
	$C_DiskSizeRemainingColor = '<b><span style="color:orange;">'
}
elseif ($C_DiskSizeRemainingPercent -le 15){
	$C_DiskSizeRemainingColor = '<b><span style="color:red;">'
}
#DYSK D
if ($D_DiskSizeRemainingPercent -gt 50){
	$D_DiskSizeRemainingColor = '<b><span style="color:green;">'
}
elseif ($D_DiskSizeRemainingPercent -gt 15){
	$D_DiskSizeRemainingColor = '<b><span style="color:orange;">'
}
elseif ($D_DiskSizeRemainingPercent -le 15){
	$D_DiskSizeRemainingColor = '<b><span style="color:red;">'
}
#DYSK E
if ($E_DiskSizeRemainingPercent -gt 50){
	$E_DiskSizeRemainingColor = '<b><span style="color:green;">'
}
elseif ($E_DiskSizeRemainingPercent -gt 15){
	$E_DiskSizeRemainingColor = '<b><span style="color:orange;">'
}
elseif ($E_DiskSizeRemainingPercent -le 15){
	$E_DiskSizeRemainingColor = '<b><span style="color:red;">'
}


$MessageBody = "<!DOCTYPE html><html lang='pl'><head><meta http-equiv='Content-Language' content='pl'><meta charset='UTF-8'></head><body>

PARAMETRY DYSKU C (OS):<br>
_______________________________________<br>
Wolne miejsce: " + $C_DiskSizeRemainingColor + [math]::round($C_Disk.SizeRemaining/1GB,2) + "GB</span></b> z calkowitej pojemnosci: <b>" + [math]::round($C_Disk.Size/1GB,2) + "GB<br></b>
Zdrowie dysku wedlug Billa Gatesa - " + $D_DiskHealthStatusColor + $C_Disk.HealthStatus + "<br></span></b>
Typ systemu plikow  - <b>" + $C_Disk.FileSystemType + "<br></b>
Status operacyjny, co by to nie bylo - " + $C_DiskOperationalStatusColor + $C_Disk.OperationalStatus + "<br></span></b>
_______________________________________<br>
<br><br>
PARAMETRY DYSKU D (SQL):<br>
_______________________________________<br>
Wolne miejsce: " + $D_DiskSizeRemainingColor + [math]::round($D_Disk.SizeRemaining/1GB,2) + "GB</span></b> z calkowitej pojemnosci: <b>" + [math]::round($D_Disk.Size/1GB,2) + "GB<br></b>
Zdrowie dysku wedlug Billa Gatesa - " + $D_DiskHealthStatusColor + $D_Disk.HealthStatus + "<br></span></b>
Typ systemu plikow  - <b>" + $D_Disk.FileSystemType + "<br></b>
Status operacyjny, co by to nie bylo - " + $D_DiskOperationalStatusColor  + $D_Disk.OperationalStatus + "<br></p></span></b>
_______________________________________<br>
<br><br>
PARAMETRY DYSKU E (Backupy):<br>
_______________________________________<br>
Wolne miejsce: " + $E_DiskSizeRemainingColor + [math]::round($E_Disk.SizeRemaining/1GB,2) + "GB</span></b> z calkowitej pojemnosci: <b>" + [math]::round($E_Disk.Size/1GB,2) + "GB<br></b>
Zdrowie dysku wedlug Billa Gatesa - " + $D_DiskHealthStatusColor + $E_Disk.HealthStatus + "<br></span></b>
Typ systemu plikow  - <b>" + $E_Disk.FileSystemType + "<br></b>
Status operacyjny, co by to nie bylo - " + $E_DiskOperationalStatusColor  + $E_Disk.OperationalStatus + "<br></span></b>
_______________________________________
</p></body></html>"

$MessageBody
$Message.IsBodyHTML = $true
$Message.From = "xxx@yy.pl" 
$Message.To.Add("xxx@yy.pl") 
#$Message.To.Add("xxx@yy.pl")
$Message.Body = $MessageBody
$Message.Subject = $Title

$smtp.Send($Message)
