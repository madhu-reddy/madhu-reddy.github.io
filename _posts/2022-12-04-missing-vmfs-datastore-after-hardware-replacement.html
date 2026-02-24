---
layout: post
title: "Troubleshooting Missing VMFS Datastore After RAID Controller Card Replacement"
date: 2022-12-04
categories: ['VMware', 'Storage']
---

Are you experiencing a missing VMFS datastore after replacing the RAID Controller Card in your server. Although all the disk's foreign configurations have been successfully imported, the datastore is still missing.

While the storage device (Disk/LUN) is detected and visible in the vCenter, the VMFS volume/datastore associated with the storage device remains unmounted and invisible in the vCenter. Consequently, all my VMs are displaying as inaccessible.

After troubleshooting, I discovered that the issue stemmed from the ESXi host identifying the LUN as a `Snapshot LUN`. According to VMware, this problem may arise after replacing SAN hardware, performing firmware upgrades, SAN replication, DR tests, or certain HBA firmware upgrades.

**What is a Snapshot LUN?**

A Snapshot LUN is essentially a copy of the original LUN. When a VMFS volume is created on a Disk/LUN, it is assigned a Universally Unique Identifier (UUID). This UUID, a crucial part of VMFS metadata, is determined by certain properties of the Disk/LUN and is stored on the LUN itself.

After changing the RAID controller, the properties of the LUN could undergo internal modifications. Subsequently, when the ESXi discovers the Disk/LUN, it compares the VMFS metadata with the LUN properties. `If a mismatch is detected, ESXi identifies the LUN as a snapshot.` To confirm this, check the 'vmkernel.log' file

## **Resolution for Missing VMFS Datastore is force mounting**

1) From the ESXi SSH shell, execute the following command to list the LUNs detected as snapshot LUNs
`**esxcli storage vmfs snapshot list**`

The above provided screenshot illustrates that the VMFS datastore (TEST_DATASTORE) exists on the snapshot LUN.

2) In our case,  '**Can mount**' is set to **true**, so you can forcibly mount the VMFS datastore using its UUID or name, as demonstrated below
`**esxcli storage vmfs snapshot mount -l label|-u uuid**`

**For example:**
`**esxcli storage vmfs snapshot mount -l "TEST_DATASTORE"
esxcli storage vmfs snapshot mount -u "9532244d-a124e5c7-39c6-635678884144"**`

The command above mounts the VMFS datastore without changing its existing signature (`no change in VMFS UUID`). 
However, there is a drawback to this approach. If in the future we need to increase the VMFS datastore size, it won't be possible. `'Force mounting' `is a temporary step for immediate access. Later, to allow for size expansion, all VMs must be migrated or stopped, enabling the assignment of a new signature (`resulting in a change in VMFS UUID`) to the VMFS datastore.

**Assigning a new signature to the VMFS Datastore**

**NOTE:**
Before proceeding with the resignature, ensure that all VMs are either stopped or migrated off this datastore, and unmount it from the ESXi Host.

**Syntax:**
`**esxcli storage vmfs snapshot resignature -l label|-u uuid**`

**For example:**
`**esxcli storage vmfs snapshot resignature -l "**TEST_DATASTORE**"
esxcli storage vmfs snapshot resignature -u "**9532244d-a124e5c7-39c6-635678884144**"**`
