#Generate password for new user - FUNCTION
Function GenerateStrongPassword ([Parameter(Mandatory=$true)][int]$PasswordLenght)
{
	Add-Type -AssemblyName System.Web
	$PassComplexCheck = $false
	do {
		$newPassword=[System.Web.Security.Membership]::GeneratePassword($PasswordLenght,1)
		If ( ($newPassword -cmatch "[A-Z\p{Lu}\s]") `
		-and ($newPassword -cmatch "[a-z\p{Ll}\s]") `
		-and ($newPassword -match "[\d]") `
		-and ($newPassword -match "[^\w]")
		)
			{
			$PassComplexCheck=$True
			}
		} While ($PassComplexCheck -eq $false)
	return $newPassword
}

#Ask admin for all required information
$First_Name = Read-Host "Podaj imiê"
$Second_Name = Read-Host "Podaj nazwisko"
$Title_Temp = Read-Host "Podaj stanowisko`n1 - Handlowiec`n2 - Serwisant`n3 - Magazynier`n"

#Create rest of variables based on INPUT
$Display_Name = $First_Name + " " + $Second_Name
$Username = $First_Name.SubString(0,1) + "." + $Second_Name + '@domenka.xyz'
$ContactName = $First_Name.SubString(0,1) + "." + $Second_Name + '@domenka.xyz'
$Username = $Username.ToLower()
$Username = $Username.Replace('¹', 'a').Replace('æ', 'c').Replace('ê', 'e').Replace('³', 'l').Replace('ñ', 'n').Replace('ó', 'o').Replace('œ', 's').Replace('Ÿ', 'z').Replace('¿', 'z')
$ContactName = $ContactName.ToLower()
$ContactName = $ContactName.Replace('¹', 'a').Replace('æ', 'c').Replace('ê', 'e').Replace('³', 'l').Replace('ñ', 'n').Replace('ó', 'o').Replace('œ', 's').Replace('Ÿ', 'z').Replace('¿', 'z')

#Check the title of new Employee - assign variables basing of titles
if ($Title_Temp -eq 1){ #HANDLOWCY
	$City = "Some variable"
	$Country = "Some variable"
	$Department = "Some variable"
	$PostalCode = "02-Some variable"
	$State = "Some variable"
	$StreetAddress = "Some variable Some variable/Some variable"
	$Title = "Some variable"
	$UsageLocation = "Some variable"
	$License = "Some variable"
}
elseif ($Title_Temp -eq 2){ #SERWIS
	$City = "Some variable"
	$Country = "Some variable"
	$Department = "Some variable"
	$PostalCode = "09Some Some variable"
	$State = "Some variable"
	$StreetAddress = "Some variable"
	$Title = "Some variable"
	$UsageLocation = "PL"
}
elseif ($Title_Temp -eq 3){ #MAGAZYN
	$City = "Some variable"
	$Country = "Some variable"
	$Department = "Some variable"
	$PostalCode = "Some variable"
	$State = "Some variable"
	$StreetAddress = "Some variable"
	$Title = "Some variable"
	$UsageLocation = "Some variable"
}
#Create variables NOT based on INPUT
$Password = GenerateStrongPassword(7)
$Password = $Password + "4"

#Print all variables to accept and ask for confirmation
echo ("Wyœwietlana nazwa -				" + $Display_Name)
echo ("Login -						" + $Username)
echo ("Has³o -						" + $Password)
echo ("Miasto -					" + $City)
echo ("Kraj -						" + $Country)
echo ("Dzial -						" + $Department)
echo ("Kod pocztowy	-				" + $PostalCode)
echo ("Województwo -					" + $State)
echo ("Ulica -						" + $StreetAddress)
echo ("Stanowisko -					" + $Title)
echo ("Przydzielona licencja -				" + $License)
$AreYouSure = Read-Host "CZY PODANE DANE NA PEWNO S¥ POPRAWNE I CHCESZ DODAÆ U¯YTKOWNIKA DO Office365? (yes/no)"

#Connect to MSOnline and add new user if yes, quit otherwise
if ($AreYouSure -eq "yes"){
	Connect-MsolService
	New-MsolUser -UserPrincipalName $Username -DisplayName $Display_Name -FirstName $First_Name -LastName $Second_Name -UsageLocation $UsageLocation -City $City -Country $Country -Department $Department -PostalCode $PostalCode -State $State -StreetAddress $StreetAddress -Title $Title -LicenseAssignment $License
	echo ("Dodano u¿ytkownika do Office 365. Sprawdzam, czy trzeba dodaæ dodatkowy kontakt do Exchange.")

	#If user will not have mailbox in Exchange, add his contact and add this contact to Distribution Group
	if ($Title_Temp -eq 2 -or $Title_Temp -eq 3){
		echo ("Dodajê kontakt do Exchange, przypisujê go do odpowiednich grup.")
		Import-Module ExchangeOnlineManagement
		Connect-ExchangeOnline
		New-MailContact -Name $Display_Name -ExternalEmailAddress $ContactName -FirstName $First_Name -LastName $Second_Name
		Add-DistributionGroupMember -Identity $Department -Member $ContactName
		if ($Title_Temp -eq 3){
			Add-DistributionGroupMember -Identity "Some variable" -Member $ContactName
		}
	}
	echo ("Dodano kontakt do Exchange. Koñczê skrypt...")
	Start-Sleep -s 5
}
else{
	echo ("Koñczê program bez dodawania nowego u¿ytkownika")
	Start-Sleep -s 5
}

$AreYouSure = Read-Host "Czy chcesz dodaæ u¿ytkownika do CRM z powy¿szymi danymi? (yes/no)"
if ($AreYouSure -eq "yes"){
	$workingPath = 'C:\selenium'
	if (($env:Path -split ';') -notcontains $workingPath) {
		$env:Path += ";$workingPath"
	}
	Add-Type -Path "$($workingPath)\WebDriver.dll"
	Add-Type -Path "$($workingPath)\WebDriver.Support.dll"
	$ChromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver
	$ChromeDriver.Navigate().GoToURL('Some variable')
	Start-Sleep -s 2
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::Id("login")).SendKeys('Some variable')
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::Id("password")).SendKeys('Some variable')
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="form"]/footer/button')).Click()
	Start-Sleep -s 2
	$ChromeDriver.Navigate().GoToURL('Some variable')
	Start-Sleep -s 2
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="active"]')).Click()
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="is_searchable"]')).Click()
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="firstname"]')).SendKeys($First_Name)
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="surname"]')).SendKeys($Second_Name)
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="city"]')).SendKeys($City)
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="street"]')).SendKeys($StreetAddress)
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="zip_code"]')).SendKeys($PostalCode)
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="password"]')).SendKeys($Password)
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="password2"]')).SendKeys($Password)

	if ($Title_Temp -eq 1){ #HANDLOWIEC
		$CRMTitle = 'Some variable'
		$CRMDepartment = 'Some variable'
		$CRMDuties = "Some variable"

		#Click User Roles
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[24]/div/div/button'))
		Start-Sleep -s 1
		#Select User Roles
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[24]/div/div/div/ul/li[3]/label')) #HANDLOWIEC
		#Close User Roles
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[24]/div/div/button'))

		#Click User Modules
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/button'))
		Start-Sleep -s 1
		#Select User Modules
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[2]/label')) #DOSTÊP DO KALENDARZA
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[3]/label')) #DOSTÊP DO OFERT
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[4]/label')) #DOSTÊP DO SKRZYNKI WTB/WTS
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[5]/label')) #DOSTÊP DO PO
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[6]/label')) #DOSTÊP DO SPRZEDA¯Y I ZAKUPU
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[7]/label')) #DOSTÊP DO KLIENTÓW
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[8]/label')) #DOSTÊP DO TOWARÓW
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[12]/label')) #RAPORTY SPRZEDA¯OWE
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[14]/label')) #RAPORTY FINANSOWE
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[16]/label')) #ZMIANA OPIEKUNA KLIENTA
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[17]/label')) #RAPORTY KLIENTÓW
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[19]/label')) #OBS£UGA MAGAZYNU
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[20]/label')) #PO£O¯ENIE W SKRZYNKACH
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[22]/label')) #DOSTÊP DO BAZY WIEDZY
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[28]/label')) #EDYCJA I DOSTÊP DO MODU£U SERWISOWEGO
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[31]/label')) #ZARZ¥DZANIE CENNIKAMI
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[34]/label')) #EDYCJA % MAR¯Y
		#Close User Modules
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/button'))

		#Active Sales Person
		$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="active_seller"]')).Click()
	}
	elseif ($Title_Temp -eq 2){ #SERWISANT
		$CRMTitle = 'Some variable'
		$CRMDepartment = 'Some variable'
		$CRMDuties = 'Some variable'
		$Username = $ContactName

		#Click User Roles
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[24]/div/div/button'))
		Start-Sleep -s 1
		#Select User Roles
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[24]/div/div/div/ul/li[2]/label')) #SERWISANT
		#Close User Roles
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[24]/div/div/button'))

		#Click User Modules
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/button'))
		Start-Sleep -s 1
		#Select User Modules
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[2]/label')) #DOSTÊP DO KALENDARZA
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[9]/label')) #DOSTÊP DO SERWISU
		#Close User Modules
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/button'))
	}
	elseif ($Title_Temp -eq 3){ #MAGAZYNIER
		$CRMTitle = 'Some variable'
		$CRMDepartment = 'Some variable'
		$CRMDuties = 'Some variable'
		$Username = $ContactName

		#Click User Roles
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[24]/div/div/button'))
		Start-Sleep -s 1
		#Select User Roles
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[24]/div/div/div/ul/li[2]/label')) #SERWISANT
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[24]/div/div/div/ul/li[4]/label')) #MAGAZYNIER
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[24]/div/div/div/ul/li[8]/label')) #TELEWIZOR
		#Close User Roles
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[24]/div/div/button'))

		#Click User Modules
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/button'))
		Start-Sleep -s 1
		#Select User Modules
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[2]/label')) #DOSTÊP DO KALENDARZA
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[5]/label')) #DOSTÊP DO PO
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[7]/label')) #DOSTÊP DO KLIENTÓW
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[8]/label')) #DOSTÊP DO TOWARÓW
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[9]/label')) #DOSTÊP DO SERWISU
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[11]/label')) #RAPORTY MAGAZYNOWE
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[19]/label')) #OBS£UGA MAGAZYNU
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[20]/label')) #PO£O¯ENIE W SKRZYNKACH
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[22]/label')) #DOSTÊP DO BAZY WIEDZY
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/div/ul/li[30]/label')) #OTRZYMYWANIE POWIADOMIEÑ O ZAMÓWIENIACH NA CZÊŒCI
		#Close User Modules
		Invoke-SeClick -Element $ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('/html/body/div[1]/div[3]/div[4]/div[2]/form/div/div[1]/div[25]/div/div/button'))
	}

	#Rest of Variables depending on title
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="login"]')).SendKeys($Username)
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="admin_position_id"]')).SendKeys($CRMTitle)
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="department_id"]')).SendKeys($CRMDepartment)
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="responsibilities"]')).SendKeys($CRMDuties)
	$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('//*[@id="submit"]')).Click()
}
$FileName = $First_Name + " " + $Second_Name + ".txt"
$FileContent = $First_Name + " " + $Second_Name + "`n`nLogin O365/CRM: " + $Username + "`nHas³o O365/CRM: " + $Password + "`n`nStanowisko - " + $Title

New-Item -Path "Some variable" -Name $FileName -ItemType "file" -Value $FileContent

Read-Host -Prompt "Some variable"

<# BADZIEW DO KOPIOWANIA
$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('')).Click()
$ChromeDriver.FindElement([OpenQA.Selenium.By]::XPath('')).SendKeys('')
#>