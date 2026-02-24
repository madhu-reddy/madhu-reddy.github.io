---
layout: post
title: VMware PowerCLI update root password in all ESXi Hosts?
date: 2021-05-18
categories: ['VMware', 'General']
---

## 
Script to change a common password of all the ESXIs in a vCenter:  

```
#need to enter the current root password at command line
$rootpswd = read-host "Please enter the current root password"

#need to enter the new root password at command line 
$newpass = read-host "Please enter the new root password"

#vCenter you are working in, enter the vCenter name at the command line
$vcenter = read-host "Please enter the name of the vCenter you will be working in"

#connect to the VC (**At this step, you will be prompted to enter the vcenter credentials)**
connect-viserver $vcenter

#creates your list of ESXI hosts from the vCenter.
$vihosts = get-vmhost

#loops through your hosts  
foreach ($vihost in $vihosts){

       Connect-VIServer $vihost -User root -Password $rootpswd -ErrorAction SilentlyContinue -ErrorVariable ConnectError | Out-Null

       if ($ConnectError) {
               Write-host "failed to connect to $vihost...trying next host..." -foregroundcolor Yellow
               Write-output "$vihost" | out-file -Append -filepath "/home/madhu/failed_to_connect.txt"
                           }
       Else {
       Set-VMHostAccount -UserAccount root -Password $newpass | Out-Null
       Disconnect-VIserver -server $defaultVIServer -confirm:$false -Force
       Write-Host "Password changed for $vihost...moving to next host..." -foregroundcolor Yellow
               }
}

Write-Host "Script complete....check /home/madhu/failed_to_connect.txt for failed hosts" -foregroundcolor white

```

 

 

## Script to change a common password in a list of ESXi not in a vCenter

```
#need to enter the current root password at command line
$rootpswd = read-host "Please enter the current root password"

#need to enter the new root password at command line 
$newpass = read-host "Please enter the new root password"

#list of ESXIs
$vihosts = @('myesxi1','myesxi2','myesxi3','myesxi4','myesxi5','myesxi6','myesxi7','myesxi8','myesxi9')

#loops through your hosts  
foreach ($vihost in $vihosts){

       Connect-VIServer $vihost -User root -Password $rootpswd -ErrorAction SilentlyContinue -ErrorVariable ConnectError | Out-Null

       if ($ConnectError) {
               Write-host "failed to connect to $vihost...trying next host..." -foregroundcolor Yellow
               Write-output "$vihost" | out-file -Append -filepath "/home/madhu/failed_to_connect.txt"
                           }
       Else {
       Set-VMHostAccount -UserAccount root -Password $newpass | Out-Null
       Disconnect-VIserver -server $defaultVIServer -confirm:$false -Force
       Write-Host "Password changed for $vihost...moving to next host..." -foregroundcolor Yellow
               }
}

Write-Host "Script complete....check /home/madhu/failed_to_connect.txt for failed hosts" -foregroundcolor white

```

 

 

## $defaultVIServer

When you connect to a vCenter/ESXI using the **Connect-VIServer** cmdlet, the DefaultVIServer variable is configured to the name of that vCenter/ESXI.

Consequently, when you execute PowerCLI cmdlets (such as **Set-VMHostAccount** in our script) without utilizing the **-Server** parameter and the target vCenter/ESXI cannot be determined, the cmdlet defaults to using the vCenter/ESXI specified in the **DefaultVIServer** variable for the query.

Upon disconnecting from the vCenter using **Disconnect-VIServer**, the **DefaultVIServer** variable becomes empty.

## $defaultVIServers

We have the ability to connect to multiple ESXI/vCenter servers by utilizing the '**Connect-VIServer**' command. Each connection gets stored in an array variable along with previously connected servers, unless the NotDefault parameter is specified.

This array variable is denoted as **$DefaultVIServers**, and its initial value is an empty array.

The **NotDefault** parameter allows exclusion of the connected server from the **$DefaultVIServers** variable.

When executing a cmdlet (such as **Set-VMHostAccount** in our script) and the target servers cannot be identified from the specified parameters, the cmdlet operates against all servers stored in the array variable.

To remove a server from the **$DefaultVIServers** variable, there are two methods: either use **Disconnect-VIServer** to close all active connections to the server, or manually modify the value of** $DefaultVIServers**.
