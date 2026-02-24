---
layout: post
title: Extend ext4 root partition(/) in a Virtual machine (VMware) using parted?
date: 2021-10-26
categories: ['Linux', 'Administration']
---

This post will guide you through extending the ext4 partition (/) with and without LVM using parted.

While there are other methods for extending the root partition, such as fdisk and growpart, we will focus only on these two approaches in this discussion.

First, we will explore extending the LVM root partition (/), followed by extending the non-LVM ext4 root partition (/) using parted.

                            .

# Extending LVM root partition(/) using parted: 

1) From the VM, go to "Edit settings" and increase the size of the hard disk as per the requirement.
In my case, it was 100, so I have increased it to 120.

![]({{site.baseurl}}/assets/img/2021/10/disk-increase.png)

2) Run the following command to rescan the block device, so that the kernel has the latest disk size information.
`echo '1' > /sys/class/scsi_disk/32\:0\:0\:0/device/rescan`      --> (where "32\:0\:0\:0" is the SCSI disk ID).

3) Open a terminal window and enter the command `parted`. Within the parted utility, type the command `print` to display the current partition table. Locate the partition you want to expand, which in this case is `/dev/sda5`.
Note the current size of the partition, which is 107 GB in your example.

In our case, we need to expand the LVM partition (`/dev/sda5`) from 107 GB to 129 GB.

```
root@madhu-testvm# parted
GNU Parted 2.3
Using /dev/sda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) print                                                            
Model: VMware Virtual disk (scsi)
Disk /dev/sda: 129GB                                            ** # New size** Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End    Size   Type      File system  Flags
 1      1049kB  256MB  255MB  primary   ext2         boot
 2      256MB   107GB  107GB  extended
 5      257MB   107GB  107GB  logical                lvm

(parted)                                               
```

4) In the example above, we are using a logical partition within an extended partition. This requires expanding both partitions sequentially. First, extend the "extended partition" save the changes, and then extend the "logical partition".

![]({{site.baseurl}}/assets/img/2021/10/parted-1.png)

Next, execute the following commands to update the kernel and enable it to recognize the updated partition table. This will also allow the Logical Volume to be resized to reflect the new disk size.

5) partprobe /dev/sda                              # **To request the kernel to re-read the partition table**.

6) pvresize /dev/sda5

7) lvextend -l +100%FREE /dev/madhu-vg/root
8)resize2fs /dev/madhu-vg/root

                                                     .

# Extending normal root partition(/) using parted:

1) From the VM, go to "Edit settings" and increase the size of the hard disk as per the requirement.
In my case, it was 20, so I have increased it to 35.

![]({{site.baseurl}}/assets/img/2021/10/increase-disk.png)

2) Run the following command to rescan the block device, so that the kernel has the latest disk size information.
`echo '1' > /sys/class/scsi_disk/32\:0\:0\:0/device/rescan` --> (where "32\:0\:0\:0" is the scsi disk ID).

3) Open a terminal window and enter the command `parted`. Within the parted utility, type the command `print` to display the current partition table. Locate the partition you want to expand, which in this case is the root partition (`/dev/sda1`).
Note the current size of the partition, which is 20 GB in your example.
Now, use the command `resizepart 1 37GB` to resize the non-LVM root partition from 20 GB to 37 GB.
Save the changes using the command `print` and then `quit`.

![]({{site.baseurl}}/assets/img/2021/10/increase-disk1-1.png)

Subsequently, execute the following commands to instruct the kernel to reread the partition table and subsequently resize the filesystem using resize2fs.

4) partprobe /dev/sda

5) resize2fs /dev/sda1
