---
layout: post
title: Update Bios and other system components firmware in Dell servers?
date: 2022-08-30
categories: ['Sysadmin', 'Hardware']
---

There are various methods to update BIOS and firmware associated with Raid Controllers, IDRAC, Life Cycle Controllers, etc.

**One method involves using the Support Live Image:** Support Live Image 3.0 is a CentOS image that includes a collection of utilities and diagnostic tools specifically designed for Dell PowerEdge servers.

For PowerEdge 12G to 14G servers, you can access the ISO image via this link: [SLI_3.0.0_A00.iso. For PowerEdge 9G to 11G servers, use this link: [SLI22_A00.iso.

After downloading the ISO image, it needs to be burned onto a USB/DVD drive. Once booted into this Live Image, you can proceed to copy the BIOS (.BIN format) and other firmware update files (.BIN format) and install them accordingly.

## **Example steps to update BIOS version from 6.4.0 to 6.6.0 using Support Live Image**

```

1) Boot the Dell PowerEdge server from the Live ISO USB

2) Plug in the data USB with the .bin file related to latest BIOS version. 

3) Copy the .bin file from the data USB  (“/home/media/sliuser”) over to “/tmp”

4) Run “chmod +x  /tmp/BIOS-6.6.0.bin”

5) Run “sudo ./BIOS-6.6.0.bin”
```

Dell Documentation ([https://www.dell.com/support/kbdoc/en-us/000128194/updating-firmware-and-drivers-on-dell-emc-poweredge-servers) provides several alternative methods for updating BIOS and other firmware versions.

**Few Examples:**

**Platform-Specific Bootable ISO**
With a 'Platform-Specific Bootable ISO,' all system components for a 12G, 13G, or 14G Dell EMC PowerEdge server are automatically updated. These updates occur automatically upon starting the server using the self-bootable ISO.

[**LifeCycle Controller**
Dell Lifecycle Controller is an advanced embedded systems management technology that enables remote server management. Using Lifecycle Controller, you can update BIOS or update firmware using a local or Dell-based firmware repository.

[**Dell EMC Repository Manager (DRM)**
Dell Repository Manager provides a searchable interface that is used to create custom software collections that are known as bundles and repositories of Dell Update Packages (DUPs).
A DUP is an executable that contains firmware for a single component. 

[**Integrated Dell Remote Access Controller (iDRAC)**
An embedded systems management tool available on PowerEdge servers, iDRAC allows remote access to perform various systems management tasks, such as updating firmware. Certain additional features may necessitate an iDRAC Enterprise license.

[**Dell EMC System Update (DSU)**
The Command Line Interface (CLI) optimized deployment tool is designed for customers who prefer scripted management of updates. To utilize this tool, first, install the package "dell-system-update," then execute the command "dsu" along with specific options to upgrade the system firmware.

[**OpenManage Enterprise (OM Enterprise)**
The OpenManage Enterprise systems management console streamlines, intelligently automates, and consolidates various IT infrastructure management functions. Among these functions is the ability to update multiple components simultaneously.
