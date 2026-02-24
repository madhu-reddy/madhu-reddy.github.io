---
layout: post
title: "How do you upgrade vCenter appliance 6.7 to 7.0?"
date: 2021-04-14
categories: ['VMware', 'vCenter']
---

**1)** Download the vCSA 7.0 ISO and mount it on any Windows system.

**2)** Once the ISO is mounted, navigate to '**vcsa-ui-installer**' -> '**win32**,' double-click '**installer.exe**,' and select '**Upgrade**.'

**3)** Proceed by clicking '**Next**' (Introduction) and '**Next**' (EULA).

**4)** Enter the following details and click '**Next**':

       **Appliance FQDN or IP address: **myvcenter.mylearningsguru.com

       **SSO Username:** [administrator@vsphere.local

**       SSO Password:** administratorpassword

**       Appliance (OS) root password:** appliance root password

**       ESXi host or vCenter Server:** ESXi name

**       HTTPS port:** 443

**       Username:** root

**       Password:** ESXi root password"

**Example:**

**5)** Click '**YES**' (Certificate Warning).

**6)** In the Appliance Deployment Target, enter the following details and click '**Next**':

       **ESXi host or vCenter Server:** ESXi host IP

       **HTTPS port:** 443

       **Username:** root

      **Password:** enter the password

**7)** Click 'YES' (Certificate Warning).

**8)** Under '**Setup Target Appliance VM**,' enter the following details and click '**Next**':

        **VM Name:** vCenter Server Appliance (ensure it's different from the source if deploying on the same ESXi)

        **Set root password:** password

       **Confirm root password:** password

**9)** Under '**Select Deployment Size**,' choose the following options and click '**Next**':

        **Deployment size:** Small (depends on the VMs in your infrastructure)

        **Storage size:** Default

**10)** Select the Datastore and check the box for '**Enable Thin Disk Mode**.'

**11) **Configure temporary network settings and click '**Next**.'

**12)** Now, you're ready to complete Stage 1 (click '**FINISH**').

**13) **Wait for the temporary vCSA appliance to deploy.

**14)** Once Stage 1 is completed, proceed to Stage 2 (click '**CONTINUE**').

**15)** Click '**Next**' (Stage 2 Introduction).

**16) **After the pre-upgrade checks are done, you can proceed with the upgrade.

**17)** Several warnings might appear. Read them carefully, and if there are no major issues, click on '**CLOSE**.'

**18)** Choose what data to copy from the old vCenter Server Appliance. 
    Select the **3rd **option: '*Configuration & historical data (events, tasks & performance metrics).*'

**19)** Choose whether you want to participate in CEIP (Customer Experience Improvement Program). Uncheck or check the '**Join**' box and click '**NEXT**.'

**20)** The final stage involves confirming that we have a backup and reviewing the summary.

**21)** Please wait a few minutes for the data copying process.

**22)** You will receive the final message indicating completion before the upgrade concludes.

**23) **The upgrade should be completed with this step.

**24)** After completion, you should be able to connect to [https://myvcenter.mylearningsguru.com, log in to the web client, and verify that version 7.0 is visible.

### **ISSUES FACED:**

#### **Problem1:**

The pre-upgrade check has failed, and the error message is as follows:

`The machine SSL certificate in the VMware Endpoint Certificate Store (VECS) does not,`
`correspond with the service registration in the VMware Directory Service (vmdir)`

****

#### **Solution1: **

Navigate to the directory using the command: "**cd /usr/lib/vmidentity/tools/scripts**" and then execute the following two commands:

**1)** **python ls_ssltrust_fixer.py -f scan**
**2)** **python ls_ssltrust_fixer.py -f fix**

                                                                                                                                                                                                               .

#### 
**Problem2:**       
  `  Insufficient space on the source export partition ‘/’`

****

#### **Solution2:**

Successfully increased the disk space allocated for /.
Initially, deleted the snapshot (*since increasing the virtual disk size is not possible if a snapshot is present*), then adjusted the virtual disk size for / from 12G to 20G, and finally recreated the snapshot.
Afterwards, executed the "**autogrow.sh**" script.

####
