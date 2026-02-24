---
layout: post
title: No Boot Device Available issue in Dell Servers?
date: 2022-02-28
categories: ['Sysadmin', 'Hardware']
---

After replacing the 2 failed INTEL SSD drives with 2 new Samsung SSD drives and configuring RAID-1, I proceeded to install Ubuntu 20.04 on that Virtual Disk (VD).

## I saw the following error,
**"No boot device available"**

![No Boot Device Available Dell Server]({{site.baseurl}}/assets/img/2022/02/no-boot-device.png)

Despite ensuring that the RAID Controller card (PERC) was set as the primary boot device and confirming both PD drives showed as '**Online**' in the Raid Controller Configuration utility, the system still failed to boot.

Then I suspected something was wrong with my OS installation or some issue with the utility (Unetbootin) I used to create the bootable USB, So I tried to install the OS (ubuntu 20.04) again using a different utility (other than Unetbootin) on the same VD.

Still no luck with server boot? **yes!!!**

So I found this nice article from the Dell portal,
[https://www.dell.com/support/kbdoc/en-us/000142265/dell-poweredge-no-boot-device-available-is-displayed-during-startup

Going through the article everything looked perfect and it was the same way I had been troubleshooting the issue until I came across 2 lines that saved my day,

1) When the RAID is managing multiple VD,** it is important to select which VD has to be presented when the server tries to boot on the raid controller**.

2) The bootable Virtual Disk can be selected on the last tab "**CTRL Mgmt**". It is important to select the VD where the operating system is installed.

Since my server comprised three Virtual Drives (VD), with two designated as data VDs and one as the OS VD, I realized that the VD presented to the server wasn't the bootable VD.
Upon selecting the correct VD as the bootable VD in the Raid Controller, my server successfully booted.
