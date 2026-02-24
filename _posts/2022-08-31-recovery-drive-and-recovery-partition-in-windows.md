---
layout: post
title: Recovery drive and Recovery Partition in Windows?
date: 2022-08-31
categories: ['Sysadmin', 'Windows']
---

**About Recovery Drive** 
If you encounter OS booting issues on your Windows PC or need to perform a factory reset or start-up repairs, having a recovery drive proves incredibly helpful.

## **[Process for creating a recovery drive** 
1.  Open the search box and type in 'Recovery.' Select the app from the search results.

2. Ensure '`Backup system files to the recovery drive`' is checked, then proceed by selecting 'Next.' This option is crucial; if unchecked, you won't be able to reinstall the OS or perform a factory reset on your PC.

![]({{site.baseurl}}/assets/img/2022/08/image-9.png)

3. Choose a USB thumb drive or an external drive to use as your recovery drive. Make sure to connect it to your PC before clicking '**Next**.'

4. Once ready, proceed to create the recovery drive by clicking '**Create**'.

In the event that your PC is unable to boot the Windows OS and you opt to reinstall Windows or troubleshoot OS recovery issues, you'll need to boot the PC from the 'recovery drive' previously created. You'll be presented with several options, as shown below. Select the appropriate option based on the action you wish to perform.

![]({{site.baseurl}}/assets/img/2022/08/image-11.png)

        .

**Recovery partition** 
1. If Windows was preinstalled on your computer as an OEM copy, you would have a recovery partition on your hard disk.

![]({{site.baseurl}}/assets/img/2022/08/image-10.png)

2. The recovery partition is used for reinstalling the OS, performing a factory reset, or conducting advanced system startup repairs.

 3. With a recovery partition, there's no need for external drives, unlike when creating a recovery drive.

4. If your PC encounters booting issues or fails to start correctly, it prompts an 'Automatic Repair' dialog box. This allows various actions like OS reinstallation and startup repairs, facilitated by the recovery partition.

![This image has an empty alt attribute; its file name is image-14.png]({{site.baseurl}}/assets/img/2022/08/image-14.png)

![This image has an empty alt attribute; its file name is image-13.png]({{site.baseurl}}/assets/img/2022/08/image-13.png)

**NOTE:**
Occasionally, the graphical user interface (GUI) method for resetting the PC may fail inexplicably. In such cases, using the command-line option through the Windows Command Prompt (cmd) has proven to be effective for initiating a factory reset. The command '**systemreset --factoryreset**' executed from the command line triggers the factory reset process for the Windows PC.
