---
layout: post
title: Steps for upgrading Ubuntu Linux from 14.04 to 20.04 version?
date: 2021-11-21
categories: ['Linux', 'Administration']
---

To upgrade Ubuntu to the latest version, follow this sequential upgrade path: 
14.04 ➔ 16.04 
16.04 ➔ 18.04 
18.04 ➔ 20.04

**NOTE: **
Based on my experience with OS upgrades, it's advisable not to rely solely on LDAP logins. I recommend ensuring the presence of a local admin user on the server beforehand. This precaution allows for access in case of any LDAP login issues post-upgrade, enabling resolution through the local admin user login.

                                                                                                                                                                                                           .                                                                                                                                                                                                 

## **Steps for upgrading ubuntu (from 14.04 -> 16.04,  16.04 -> 18.04,  18.04 -> 20.04)**

- 

apt-get update

- 

apt-get upgrade

- 

apt-get dist-upgrade

- 

do-release-upgrade

Regarding the steps involving "**apt-get update**," "**apt-get upgrade**," and "**apt-get dist-upgrade**," I've previously written an article explaining these commands. Here's the [link if you'd like to understand their functionality.

Now, let's talk about the "**do-release-upgrade**" command. This command facilitates the upgrade of the operating system to the next available LTS release directly from the command line. For instance, if the server's current version is 14.04, the next LTS release would be 16.04. Similarly, for 16.04, it would be 18.04, and for 18.04, the next would be 20.04. If no further LTS release is available, it indicates that the OS is already running the latest LTS release.

To execute unattended upgrades (without the OS requesting user input or confirmation), use the following command:

**do-release-upgrade -f DistUpgradeViewNonInteractive**

                                                                                                                                                         
**Issues faced:**

**Issue1:**

When upgrading from 18.04 to 20.04, I encountered an error during the "**do-release-upgrade**" step. The problem appeared to stem from the /boot partition being full. To address this, I needed to remove old, unused Linux kernels and then rerun the "**do-release-upgrade**" command.

```
Error 24 : Write error : cannot write compressed block  
E: mkinitramfs failure cpio 141 lz4 -9 -l 24 
update-initramfs: failed for /boot/initrd.img-5.4.0-84-generic with 1. 
dpkg: error processing package initramfs-tools (--configure): 
installed initramfs-tools package post-installation script subprocess returned error exit status 1 
Errors were encountered while processing: 
initramfs-tools 
E: Sub-process /usr/bin/dpkg returned an error code (1)
```

**Issue2:**

Following the successful upgrade from 16.04 to 18.04, I encountered an issue with my LDAP login. To resolve this, I booted the system into rescue mode and created a local administrator user with full sudo privileges.
