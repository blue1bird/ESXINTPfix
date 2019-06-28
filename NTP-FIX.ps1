#Script by Abhishek.B
#Yeah this doesn't comply with any standards but it gets the job done.    
#This is by no means perfect. This is the first working version of the script   
#Fixes NTP configuration of the ESXI hosts. 
#   
#6/27/2019   
Add-PSSnapin VMware.VimAutomation.core

$tgtClusterName="< Cluster Name >"

$vcuser="< VC user name >"
$vc="< VC Name >"
$vcpwdTxt = Get-Content " < Full path of the VC user password file >"
$vcpassword= $vcpwdTxt | ConvertTo-SecureString -AsPlainText -Force
$VCcred = New-Object System.Management.Automation.PSCredential -ArgumentList $vcuser, $vcpassword


Write-Output "######################### CLUSTER : $tgtClusterName #########################"

Connect-VIServer $vc -Protocol https -Credential $VCcred

Write-Output "######################### Current NTP status of the HOSTS before fix #########################"
Get-Datacenter < DC name > | Get-VMHost | Sort Name | Format-Table -Property Name, @{N="NTPServer";E={$_ |Get-VMHostNtpServer}}, @{N="ServiceRunning";E={(Get-VmHostService -VMHost $_ | Where-Object {$_.key-eq "ntpd"}).Running}}

Write-Output "######################### Fixing NTP for the HOSTS now . . . . . . . . .  #########################"
Get-Datacenter < DC name > | Get-VMHost | Add-VMHostNtpServer -NtpServer ntpunix1,ntpunix2,ntpunix3
Get-Datacenter < DC name > | Get-VMHost | Get-VMHostService | Where-Object {$_.key -eq "ntpd" } | Start-VMHostService |Set-VMHostService -policy "On"
