Function Get-DisksSpace ($Servername, $unit= "GB")
{
$measure = "1$unit"

Get-WmiObject -computername $serverName -query "
select SystemName, Name, DriveType, FileSystem, FreeSpace, Capacity, Label
  from Win32_Volume
 where DriveType = 2 or DriveType = 3" `
| select SystemName `
        , Name `
        , @{Label="SizeIn$unit";Expression={"{0:n2}" -f($_.Capacity/$measure)}} `
        , @{Label="FreeIn$unit";Expression={"{0:n2}" -f($_.freespace/$measure)}} `
        , @{Label="PercentFree";Expression={"{0:n2}" -f(($_.freespace / $_.Capacity) * 100)}} `
        ,  Label
}#Get-DisksSpace
<# Here are some ways that you could use this script
...  PS Nic Cain says this won't work on Windows 2000 or XP.
Since I don't have any machines that old I'll have to take 
his word for it :-p

Get-DisksSpace Win7NetBook | Out-GridView

Get-DisksSpace "Win7NetBook", "LocalHost" "GB" | where{$_.PercentFree -lt 40} | Out-GridView

Get-DisksSpace "Win7NetBook" "MB" | ft

Get-DisksSpace "Win7NetBook" | where{$_.PercentFree -lt 20} | Format-Table
#>
