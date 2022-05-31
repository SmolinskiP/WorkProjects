$UserEmail = Read-Host "Wprowadź adres e-mail użytkownika, któremu chcesz ustawić Autoresponder i przekierowanie."
$ForwardingEmail = Read-Host "Wprowadź adres e-mail użytkownika, na którego chcesz przekierować pocztę / podać w autoresponderze."


$ForwardingQuestion = Read-Host "Czy chcesz ustawić przekierowanie? (y/n)"
if ($ForwardingQuestion -eq "y"){
    Set-Mailbox $UserEmail -ForwardingsmtpAddress $ForwardingEmail -DeliverToMailboxAndForward $True
    Write-Host "Ustawiono przekierowanie z $UserEmail nad $ForwardingEmail"
    }

$AutoresponderQuestion = Read-Host "Czy chcesz ustawić autoresponder? (y/n)"
if ($AutoresponderQuestion -eq "y"){
    $AutoresponderDate = Read-Host "Podaj datę: (format DD.MM - DD.MM.YYYY)"
    $UserData = Get-MsolUser -UserPrincipalName $UserEmail
    $ForwardingUserData = Get-MsolUser -UserPrincipalName $ForwardingEmail
    $UserFnameLname = $UserData.FirstName + " " + $UserData.LastName
    $ForwardingUserFnameLname = $ForwardingUserData.FirstName + " " + $ForwardingUserData.LastName

    $AutoresponderBody = "<html><head></head><body><p>Szanowni Państwo,<br>
Dziękuję za wiadomość.<br>
Uprzejmie informuję, iż w dniach $AutoresponderDate jestem nieobecny/a.<br>
Korespondencja automatycznie zostanie przekierowana do $ForwardingUserFnameLname, który/a mnie zastępuje.<br>
Pozdrawiam<br>
$UserFnameLname <br>
----------------------------------------------------------------------------------------------------------------------------<br>
Dear Sir/ Madam, <br>
Thank you for your email.<br>
I’m out of the office on $AutoresponderDate.<br>
Correspondence will be automatically forwarded to the person who is replacing me: $ForwardingUserFnameLname<br>
Best regards, <br>
$UserFnameLname <br>
</p></body></html>"
    Set-MailboxAutoReplyConfiguration -Identity $UserEmail -AutoReplyState Enabled -InternalMessage $AutoresponderBody -ExternalMessage $AutoresponderBody
    Write-Host "Ustawiono Autoresponder o treści:
    $AutoresponderBody
    dla użytkownika $UserFnameLname"
    }

$DeleteForwardingQuestion = Read-Host "Czy chcesz usunąć przekierowanie i autoresponder? (y/n)"
if ($DeleteForwardingQuestion -eq "y"){
    Set-Mailbox $UserEmail -ForwardingsmtpAddress $Null -DeliverToMailboxAndForward $True
    Set-Mailbox $UserEmail -ForwardingAddress $Null -DeliverToMailboxAndForward $True
    Set-MailboxAutoReplyConfiguration -Identity $UserEmail -AutoReplyState Disabled
    Write-Host "Skasowano wszystkie przekierowania i autorespondery"
    }
