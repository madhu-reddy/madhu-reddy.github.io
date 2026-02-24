---
layout: post
title: How to get info about VMs in vCenter/ESXi with a VMware PowerCLI script?
date: 2021-05-18
categories: ['VMware', 'General']
---

## 
**1) VMware PowerCLI Script using Linux PowerShell (pwsh-preview)****,**** which has the **"VMware.PowerCLI" module installed.

```
Connect-VIServer -Server myvcenter.mylearningsguru.com -User username -Password password

New-VIProperty -Name VMToolsStatus -ObjectType VirtualMachine ` -ValueFromExtensionProperty 'Guest.ToolsStatus' ` -Force

New-VIProperty -Name CORESPERSOCKET -ObjectType VirtualMachine ` -ValueFromExtensionProperty 'config.Hardware.NumCoresPerSocket' ` -Force

New-VIProperty -Name GuestOS -ObjectType VirtualMachine ` -ValueFromExtensionProperty 'config.GuestFullName' ` -Force

$VMs =  Get-VM  | Select Name,GuestOS,VMHost,NumCPU,CORESPERSOCKET,PowerState,MemoryMB,
VMToolsStatus,@{N="Datastore"; E={$_ | Get-Datastore}},@{N='DNSHostname';E={$_.guest.hostname}},@{N="IP";E={@($_.Guest.IPAddress -match "192.168." -join ',') }}  ##To get all IPs which start with 192.168

$result = @()
foreach ($vm in $VMs) {
$result += $vm
}

$result | Export-Csv -path "/home/user/vcenterdetails.csv"

```

## 

Output:

```
Name	GuestOS	VMHost	NumCpu	CORESPERSOCKET	PowerState	MemoryMB	VMToolsStatus	Datastore	DNSHostname	IP

myserver1	Ubuntu Linux (64-bit)	myesxi1	4	1	PoweredOn	8192	toolsOk	datastore1	myserver1.test.net	192.168.1.10

myserver2	Ubuntu Linux (64-bit)	myesxi2	4	4	PoweredOn	2048	toolsOk	datastore1	myserver2.test.net	192.168.1.11

myserver3	Ubuntu Linux (64-bit)	myesxi3	4	1	PoweredOn	2048	toolsOk	datastore1	myserver3.test.net	192.168.1.12
```

## Check the PowerCLI module installed version in the PowerShell

```
Get-Module VMware.PowerCLI -ListAvailable
```

![]({{site.baseurl}}/assets/img/2021/05/powercli-1.png)

# NOTE: 

***From VMware PowerCLI 10.0 version, we no need to do,***
***Add-PSSnapin "VMware.VimAutomation.Core", which otherwise is required if the PowerCLI or PowerShell has to recognise any PowerCLI cmdlets.***

## 

 

 

## **2) VMware PowerCLI Script (PowerCLI version **< 10.0)

```
function LoadSnapin{
  param($PSSnapinName)
  if (!(Get-PSSnapin | where {$_.Name   -eq $PSSnapinName})){
    Add-pssnapin -name $PSSnapinName
  }
}
# Load PowerCLI snapin
LoadSnapin -PSSnapinName   "VMware.VimAutomation.Core"

Connect-VIServer -Server myvcenter.mylearningsguru.com -User username -Password password

New-VIProperty -Name VMToolsStatus -ObjectType VirtualMachine ` -ValueFromExtensionProperty 'Guest.ToolsStatus' ` -Force

New-VIProperty -Name CORESPERSOCKET -ObjectType VirtualMachine ` -ValueFromExtensionProperty 'config.Hardware.NumCoresPerSocket' ` -Force

New-VIProperty -Name GuestOS -ObjectType VirtualMachine ` -ValueFromExtensionProperty 'config.GuestFullName' ` -Force

$VMs =  Get-VM  | Select Name,GuestOS,VMHost,NumCPU,CORESPERSOCKET,PowerState,MemoryMB,
VMToolsStatus,@{N="Datastore"; E={$_ | Get-Datastore}},@{N='DNSHostname';E={$_.guest.hostname}},@{N="IP";E={@($_.Guest.IPAddress -match "192.168." -join ',') }}  ##To get all IPs which start with 192.168

$result = @()

foreach ($vm in $VMs) {
$result += $vm
}
$result | Export-Csv -path c:\powerclioutput\vmdetails.csv

```

## Output:

```
Name	GuestOS	VMHost	NumCpu	CORESPERSOCKET	PowerState	MemoryMB	VMToolsStatus	Datastore	DNSHostname	IP

myserver1	Ubuntu Linux (64-bit)	myesxi1	4	1	PoweredOn	8192	toolsOk	datastore1	myserver1.test.net	192.168.1.10

myserver2	Ubuntu Linux (64-bit)	myesxi2	4	4	PoweredOn	2048	toolsOk	datastore1	myserver2.test.net	192.168.1.11

myserver3	Ubuntu Linux (64-bit)	myesxi3	4	1	PoweredOn	2048	toolsOk	datastore1	myserver3.test.net	192.168.1.12
```
