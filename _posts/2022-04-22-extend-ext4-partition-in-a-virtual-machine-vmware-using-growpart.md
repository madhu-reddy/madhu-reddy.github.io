---
layout: post
title: Extend ext4 partition (/) in a Virtual Machine (VMware) using growpart?
date: 2022-04-22
categories: ['Linux', 'Administration']
---

In this post, we'll explore extending an ext4 partition, both with and without LVM, using `growpart`. We'll start by extending the LVM root partition (`/`), followed by extending a non-LVM partition.

---

## Extend LVM Root Partition (/) using growpart

### Step 1: Increase disk size in VMware

From the VM, navigate to **Edit Settings** and adjust the hard disk size as needed. In this example, the disk was increased from 120GB to 140GB.

![]({{site.baseurl}}/assets/img/2022/04/image-2.png)

### Step 2: Rescan the block device

Run the following command to rescan the block device so the kernel has the latest disk size information:

```bash
echo '1' > /sys/class/scsi_disk/32\:0\:0\:0/device/rescan
```

> **Note:** `32:0:0:0` is the SCSI disk ID in this example. Verify the correct value for your disk inside the `/sys/class/scsi_disk/` directory.

### Step 3: Check the partition layout

Using `fdisk -l`, notice that the `/dev/sda5` LVM partition is created within an **Extended** partition. We need to extend the Extended partition (`/dev/sda2`) first, then extend the actual LVM partition (`/dev/sda5`).

```bash
root@madhu-testvm:~# fdisk -l
Disk /dev/sda: 150.3 GB, 150323855360 bytes
/dev/sda1   *        2048      499711      248832   83  Linux
/dev/sda2          499712   251658239   125579264    5  Extended
/dev/sda5          501760   251658239   125578240   8e  Linux LVM
```

### Step 4: Extend the Extended partition

```bash
growpart /dev/sda 2
```

![]({{site.baseurl}}/assets/img/2022/04/image-3.png)

### Step 5: Extend the LVM partition

```bash
growpart /dev/sda 5
```

![]({{site.baseurl}}/assets/img/2022/04/image-4.png)

### Step 6: Re-read the partition table

```bash
partprobe /dev/sda
```

### Step 7: Resize the physical volume

```bash
pvresize /dev/sda5
```

The new size can be verified using `pvs` or `vgs`.

### Step 8: Extend the logical volume

```bash
lvextend -l +100%FREE /dev/madhu-vg/root
```

### Step 9: Resize the filesystem

```bash
resize2fs /dev/madhu-vg/root
```

---

## Extend a Non-LVM Partition using growpart

### Step 1: Increase disk size in VMware

From the VM, navigate to **Edit Settings** and increase the hard disk size as needed. In this example, the disk was increased from 130GB to 150GB.

![]({{site.baseurl}}/assets/img/2022/04/image-5.png)

### Step 2: Rescan the block device

```bash
echo '1' > /sys/class/scsi_disk/32\:0\:1\:0/device/rescan
```

> **Note:** `32:0:1:0` is the SCSI disk ID for this disk. Verify the correct value for your disk inside the `/sys/class/scsi_disk/` directory.

### Step 3: Identify the partition to expand

Use `fdisk` or `lsblk` to identify the target partition. In this example it is `/dev/sdb1`.

```bash
root@madhu-server:~# fdisk -l | grep sdb
Disk /dev/sdb: 161.1 GB, 161061273600 bytes
/dev/sdb1            2048   314568764   157283358+  83  Linux
```

### Step 4: Extend the partition

```bash
growpart /dev/sdb 1
```

![]({{site.baseurl}}/assets/img/2022/04/image-7.png)

### Step 5: Re-read the partition table

```bash
partprobe /dev/sdb
```

### Step 6: Extend the filesystem

```bash
resize2fs /dev/sdb1
```
