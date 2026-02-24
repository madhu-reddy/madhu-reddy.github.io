---
layout: post
title: "Parted Magic (Pmagic) magical way to backup and restore data in a hard drive?"
date: 2021-11-21
categories: ['Sysadmin', 'Backup']
---

[Parted Magic is a software that allows one to take a complete backup of a hard drive and restore the backup to the hard drive when needed. It can also be used to do some low-level formatting of the hard disk.

## **Backup disk using Parted Magic to an NFS server:**

1) Boot the system using Pmagic bootable USB.

2) Next click on the “Disk Cloning” icon present on the desktop.

3) Next click on “device-image”.

4) Next click on nfs_server.

5) Next choose the NFS server version.

6) Next provide the IP address / DNS name for the backup server.

7) Next provide the location (Ex: **/home/usersbackup**), where the backup image will be stored inside the NFS server.

8) Next choose the default option(Beginner).

9) Next select the “savedisk” option to save the backup as an image.

10) Next provide a name for the backup image.

11) Next choose which disk has to be backed up.

12) Next choose a few default options.

- 

-sfsck

- 

yes, check the saved image

- 

-senc Not to encrypt the image

                                       .

13)  Next choose the action to perform after the backup is completed.

                                                                                                                                              .

**Restore the backup image in the NFS server to the Disk:**

1) Boot the system using Pmagic bootable USB.

2) Next click on the “disk cloning” icon present on the desktop.

3) Next click on “device-image”.

4) Next click on nfs_server.

5) Next choose the NFS server version.

6) Next provide the IP address / DNS name for the NFS server.

7) Next provide the directory path where the backup image is stored.

8) Next choose the default option (Beginner).

9) Now select “restoredisk” & click “ok”.

10) Select the image file to restore.

11) Now select the Target disk to which the image has to be restored. 

12) Verify the image before restoring.

13) Choose what to do after the restore is completed.
****
