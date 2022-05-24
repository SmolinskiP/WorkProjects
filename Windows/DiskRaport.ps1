$Message = new-object Net.Mail.MailMessage 

$smtp = new-object Net.Mail.SmtpClient("xxx", 587) 
$smtp.Credentials = New-Object System.Net.NetworkCredential("xxx@yyy.zz", "qwerty"); 
$smtp.EnableSsl = $true 
$smtp.Timeout = 400000  

$Today = Get-Date -Format "yyyy/MM/dd"
$Today = $Today.ToString() + " - Raport dyskow WAPRO"

$C_Disk = Get-Volume -DriveLetter C
$D_Disk = Get-Volume -DriveLetter D
$MessageBody = "

PARAMETRY DYSKU C:
_______________________________________
Wolne miejsce: " + [math]::round($C_Disk.SizeRemaining/1GB,2) + "GB z calkowitej pojemnosci: " + [math]::round($C_Disk.Size/1GB,2) + "GB
Zdrowie dysku wedlug Billa Gatesa - " + $C_Disk.HealthStatus + "
Typ systemu plikow  - " + $C_Disk.FileSystemType + "
Status operacyjny, co by to nie bylo - " + $C_Disk.OperationalStatus + "
_______________________________________

PARAMETRY DYSKU D:
_______________________________________
Wolne miejsce: " + [math]::round($D_Disk.SizeRemaining/1GB,2) + "GB z calkowitej pojemnosci: " + [math]::round($D_Disk.Size/1GB,2) + "GB
Zdrowie dysku wedlug Billa Gatesa - " + $D_Disk.HealthStatus + "
Typ systemu plikow  - " + $D_Disk.FileSystemType + "
Status operacyjny, co by to nie bylo - " + $D_Disk.OperationalStatus + "
_______________________________________
"

$MessageBody
$Message.From = "xxx@yyy.zz" 
$Message.To.Add("xxx@yyy.zz") 
$Message.To.Add("xxx@yyy.zz")
$Message.Body = $MessageBody
$Message.Subject = $Today

$smtp.Send($Message)
