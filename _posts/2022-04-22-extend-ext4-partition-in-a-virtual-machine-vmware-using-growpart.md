---
layout: post
title: "Extend ext4 partition(/) in a Virtual machine (VMware) using "growpart"?"
date: 2022-04-22
categories: ['Linux', 'Administration']
---

In this post, we'll explore extending an ext4 partition, both with and without LVM, using  "[growpart".
Initially, we'll focus on extending the LVM root partition (/), followed by extending a non-LVM partition using '**growpart**'.

## **Extend LVM root partition(/) using growpart:**

1) From the VM, navigate to 'Edit settings' and adjust the hard disk size according to your needs. In my case, I increased it from 120GB to 140GB.

2) Now, execute the following command to rescan the block device, updating the kernel with the latest disk size information:
`echo '1' > /sys/class/scsi_disk/32\:0\:0\:0/device/rescan` –> (where “32\:0\:0\:0” is the SCSI disk ID for my disk, which might differ for yours; verify the correct value inside the directory).

3) When you use the command '**fdisk -l**' observe that the '**/dev/sda5**' LVM partition is created within an '**Extended**' partition. Consequently, we need to extend the '**Extended**' partition (/dev/sda2) first, and then proceed to extend the actual LVM partition (/dev/sda5).

```
`root@madhu-testvm:~# fdisk -l
Disk /dev/sda: 150.3 GB, 150323855360 bytes
/dev/sda1   *        2048      499711      248832   83  Linux
/dev/sda2          499712   251658239   125579264    5  Extended
/dev/sda5          501760   251658239   125578240   8e  Linux LVM
`
```

4) First extending the "Extended" partition as shown in the below command
growpart /dev/sda 2

5) Now after extending the "Extended" partition, we can go ahead and extend the actual LVM partition with the following command,
growpart /dev/sda 5

6) partprobe /dev/sda # **To request the kernel to re-read the partition table**.

7) pvresize /dev/sda5  # **To resize the physical volume** **to the maximum size available**. (the new size can be verified using "**pvs**" or can also be verified using "**vgs**" command)

8) lvextend -l +100%FREE /dev/madhu-vg/root   #** to extend the LVM to maximum size available.**

9) resize2fs /dev/madhu-vg/root    # **This is to enlarge the file system (Ex: ext4 in my case) on the LVM**.

.

**Expanding normal (Non-LVM)  partition using growpart:**

1) From the VM, navigate to “Edit settings” and increase the size of the hard disk as per the requirement. In my case, it was 130GB, so I have increased it to 150GB.

2) Now, execute the following command to rescan the block device, so that the kernel has the latest disk size information.
`echo '1' > /sys/class/scsi_disk/32\:0\:1\:0/device/rescan` –> (where “32\:0\:0\:0” is the SCSI disk ID).

3) Identify the partition we need to expand (using fdisk or lsblk), in my case, it's '**/dev/sdb1**'.

```
`root@madhu-server~# fdisk -l | grep sdb
Disk /dev/sdb: 161.1 GB, 161061273600 bytes
/dev/sdb1            2048   314568764   157283358+  83  Linux
`
```

4) Now extend the partition (/dev/sdb1) with growpart.

5) partprobe /dev/sdb # **To request the kernel to re-read the partition table**.

6) Now the final step is to extend the file system on the partition.
     **resize2fs /dev/sdb1**
