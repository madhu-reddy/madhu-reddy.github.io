---
layout: post
title: Parted Magic (Pmagic) magical way to backup and restore data in a hard drive?
date: 2021-11-21
categories: ['Sysadmin', 'Backup']
---

[Parted Magic is a software that allows one to take a complete backup of a hard drive and restore the backup to the hard drive when needed. It can also be used to do some low-level formatting of the hard disk.

## **Backup disk using Parted Magic to an NFS server:**

1) Boot the system using Pmagic bootable USB.

2) Next click on the “Disk Cloning” icon present on the desktop.

![image]({{site.baseurl}}/assets/img/2021/11/zYmcWpMT0VgG2SFjM6d6jPK71sMhGJZWID8XiX6qsC2nZhcv4IaktARdGse7EXiyx_l_gtA3OESfzMmZzpGRkBAJ4e3C8hqRbGMkcZVA5JFEObgBEh4s918VCAnz3xqu-HIzCx4)

3) Next click on “device-image”.

![image]({{site.baseurl}}/assets/img/2021/11/BZR4QrL0wKmSwEEyN7TCeshdH0sH3LTwFvTm9uOVnwN-vGbcghvWzm2lRy4rp9MjzXcJH8LXrC5f6AcsJoLlBT_SvS82SRIGvHvOiaR1UsJ2QDGm4MgUt1fsZageQNiAZrUqT9g)

4) Next click on nfs_server.

![image]({{site.baseurl}}/assets/img/2021/11/AZtTD04XfGYhrf8DSNuhLfO24dOpEE_zDvKrpsCgKl1CMI1PudhtrPBbxK1VwHmsfl-uem2FLTNpnPkOMYjLEHS5cPMkfaUjCx1Q_uN5KplP6JmjMLh3S_SWzxiVFIZkaHtF1NA)

5) Next choose the NFS server version.

6) Next provide the IP address / DNS name for the backup server.

![]({{site.baseurl}}/assets/img/2021/11/image-4.png)

7) Next provide the location (Ex: **/home/usersbackup**), where the backup image will be stored inside the NFS server.

8) Next choose the default option(Beginner).

9) Next select the “savedisk” option to save the backup as an image.
![image]({{site.baseurl}}/assets/img/2021/11/oWl3OQogt9swuMkXW0XERKEkbSoWzB03bxDK2a7bHYh9X2Tl2sHKcBt4ZH2spwFxGBXRmPYnEWPS0TC91nOJyGb3SrXE8utStpOdjs-l7Ig_WP7LwqkvzJWIPS4cv1RT_LeDgvI)

10) Next provide a name for the backup image.

11) Next choose which disk has to be backed up.
![image]({{site.baseurl}}/assets/img/2021/11/SRgo9fHiK2We2hSUsfudsIAIUxbcX4fridVn5pMd0oXZiXF3CrKqGmRptaPA69Z7D37EXd-vv-T7gNKsRc9FdlJuUZw5rRGWl6MsyL_gOMVrJUSIgU1MWF_WJexZv36r0RmvXf0)

12) Next choose a few default options.

- 

-sfsck

- 

yes, check the saved image

- 

-senc Not to encrypt the image

                                       .

13)  Next choose the action to perform after the backup is completed.
![image]({{site.baseurl}}/assets/img/2021/11/ko2FgQa49KP69I2U-P2Hc8urZNcGDrWujTZYbwASetvvXq4WPAp2wtdCXRWoWjqfThpJlNOLL5Xr-XuXFY9vcJYoGN9imLBv2kNOMaDrbn1qgYwI4BSyVoAIv32SB-7NUJQ56eA)

                                                                                                                                              .

**Restore the backup image in the NFS server to the Disk:**

1) Boot the system using Pmagic bootable USB.

2) Next click on the “disk cloning” icon present on the desktop.

3) Next click on “device-image”.

4) Next click on nfs_server.

5) Next choose the NFS server version.

![image]({{site.baseurl}}/assets/img/2021/11/UwT5fc6Cg73tVEVcsR3vPYOPNmn1XYXyl6GX8pF9B-dK6b7izkIf-ew8sqMdpdBdJeHTk7DRfj3Y_nhzy_v-ju9GKLnb31X-C76Jv_ITe_KAHvPJjLmfISofVk54b9I_7qcXMAY)

6) Next provide the IP address / DNS name for the NFS server.

7) Next provide the directory path where the backup image is stored.

![]({{site.baseurl}}/assets/img/2021/11/image-5.png)

8) Next choose the default option (Beginner).

9) Now select “restoredisk” & click “ok”.

![image]({{site.baseurl}}/assets/img/2021/11/gJIQf_8R4CSb3wTe1ofRDTdNoPzm-cvGOMw7qsjX1CnZW8lVoPJ48j6-OXwfmV7HhrQE0GJvuBKXI9ZQPYLVGYLyFAsB6tc1ecUocow2_6b9BR_Od8uLpBeOSRNu0NDObto-UF8)

10) Select the image file to restore.

![]({{site.baseurl}}/assets/img/2021/11/image-6.png)

11) Now select the Target disk to which the image has to be restored. 
![image]({{site.baseurl}}/assets/img/2021/11/zkkol8SQRZmTFAPcdL0rJHRVrB6sBB-45bHcwRjKpv8UmiS2uRPuAd3scvweuBsCCJV4QjF5NhLhAAy16kOtmB3gMTJoQnxEipFdp5EZe4lsdtmZzZHR5o7E-TPPowmiJA3rMTo)

12) Verify the image before restoring.

![image]({{site.baseurl}}/assets/img/2021/11/ClCnak3wGzA5tyl1ICg50dEBppTkXr4yIdObtre-3fpFdJL28HBDrshP_u3LbnJusqWhpVIZygGN08pvetXOkZcMwLUgwUU28zlBVgaX-bCtivC3yNAymwgjAZV2EN9bkfHZ358)

13) Choose what to do after the restore is completed.
**
![image]({{site.baseurl}}/assets/img/2021/11/DP5eoc6aMC4TfYRQMiCCwjuenyGOcjEryPJ9rxWm_mFB-GIwgBbzn3fm5eIeyyZY9qIKnDMXmKjBW9vBeZSpfdve5yOUgwSUolozD7CqhoqDgBKIAkkyke6qRhWLxsLYc0GZ1z4)
**
