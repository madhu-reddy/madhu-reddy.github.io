---
layout: post
title: About NUMA Node Affinity in VMWare?
date: 2022-09-04
categories: ['VMware', 'General']
---

NUMA, which stands for '`Non-Uniform Memory Access`,' in a multi-processor system refers to a set of memory sockets considered local to a particular CPU, allowing faster access. The memory local to the 1st CPU becomes remote memory for the 2nd CPU and vice versa.

As shown in the picture below, you can observe how the set of 12 memory sockets is local (and remote) to each of the CPUs (CPU1 and CPU2)

![]({{site.baseurl}}/assets/img/2022/09/image-5.png)

The NUMA architecture, as the name implies, provides non-uniform memory access. This means that the time required for the CPU to access memory is not uniform. For instance, the 1st CPU has faster memory access (low latency) to its local memory but experiences slower access (higher latency) to remote memory related to the 2nd CPU. The distinction between low and high latency memory access depends on whether the memory for the CPU is local or remote in NUMA (non-uniform remote access) architecture.

To better leverage NUMA, configuring something called '**`NUMA node affinity`**' is necessary.

**Without NUMA Node Affinity**

Without 'NUMA node affinity,' a process scheduled to run on a CPU (e.g., CPU 0) may find its related data in remote memory (memory related to CPU 1), potentially causing performance issues for the application."

![]({{site.baseurl}}/assets/img/2022/09/image-9.png)

**With NUMA Node Affinity**

However, with '`NUMA node affinity'`, a process scheduled to run on a CPU (e.g., CPU 0) ensures that the related data is consistently present in local memory (related to CPU 0 itself) when needed. This optimizes memory access speed for the CPU when processing the application."

![]({{site.baseurl}}/assets/img/2022/09/image-10.png)

.

**Enabling NUMA Node affinity for Virtual Machines in VMWare ESXi**

In this example, I have an ESXi host (Dell PowerEdge R610), which has 2 CPU sockets with 6 cores each.
I have created 2 VMs with 1 vCPU and 6 cores each.

To configure NUMA node affinity for each VM, follow these steps:
1) Go to VM settings.
2) Navigate to VM options > Advanced > Edit configuration.
3) Add an option with the key name '`numa.nodeAffinity`' and set a value of either 0 or 1. This constrains the virtual machine resource scheduling to NUMA nodes 0 or 1."

![]({{site.baseurl}}/assets/img/2022/09/image-12.png)

By configuring NUMA node affinity, you're ensuring that the applications in each VM can efficiently access the local memory associated with the dedicated NUMA nodes, optimizing their processing speed.
