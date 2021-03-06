function inventory {
$obj = New-Object PSObject
$wmi = gwmi win32_computersystem
$wmi2 = gwmi win32_operatingsystem
$obj | Add-Member noteproperty  Manufacturer ($wmi.Manufacturer)
$obj | Add-Member noteproperty  Model ($wmi.model)
$obj | Add-Member noteproperty  ComputerName ($wmi.name)
$obj | Add-Member noteproperty  Build ($wmi2.buildnumber)
$obj | Add-Member noteproperty  OS ($wmi2.caption)
$obj | Add-Member noteproperty  SP ($wmi2.csdversion)

Write-Output $obj
}

"localhost" | inventory  | ft -auto