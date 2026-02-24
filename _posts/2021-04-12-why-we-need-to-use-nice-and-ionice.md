---
layout: post
title: why do we need to use nice and ionice?
date: 2021-04-12
categories: ['Linux', 'Administration']
---

#### **Schedule the Linux process CPU priority with nice?**

By default, every process is assigned the same CPU scheduling priority level. Consequently, the kernel strives to allocate a fair amount of CPU time to each process competing for CPU resources, considering the nature of each process.

For instance, when 10 processes are running at the same scheduling priority, their CPU time allocation depends on the individual CPU requirements of each process.

In simpler terms, a highly CPU-intensive process receives more CPU time, while a less CPU-intensive process receives less CPU time.

Now let's think of 2 scenarios here, 

`1) We aim to execute a critical and highly CPU-intensive process, desiring to grant this process the utmost CPU time possible.`

`2) Another crucial CPU-intensive process is essential, yet it can patiently await its turn for CPU time, allowing other processes requiring CPU resources to utilize them.`

In both scenarios, we utilize "**nice**" to manage the CPU scheduling priority.

The nice value can range from **-20 (highest priority)** to **+19 (lowest priority)**. The default nice value for all processes typically inherited from their parent process is usually 0.

A higher positive nice value (+19) indicates the process has lower priority, utilizing CPU time only when there is no demand from other competing processes.

Conversely, a lower negative nice value (-20) signifies the process has higher priority, utilizing most of the CPU time, causing lower priority processes to wait for their turn.

In the screenshot below, process ID 25822 exhibits a nice value of +19, indicating it has the least CPU priority, receiving CPU time only in the absence of contention from other processes.

Additionally, process IDs like 3, 4, 6, and 9 hold a nice value of -20, portraying the highest CPU priority among them, consequently receiving most of the CPU time compared to others.

Setting CPU priority for a command using **nice** as shown below:

`**nice -n 19 top  --> giving "top' command least CPU prioriy
nice -n -20 htop --> giving "htop" command highest CPU priority**`

![]({{site.baseurl}}/assets/img/2021/04/image-20.png)

#### Schedule the Linux process IO priority with ionice?

**ionice** sets or retrieves the I/O scheduling class and priority for a program. It is employed to specify the priority for I/O operations, thereby lessening the load on a disk by minimizing disk input/output operations.

A process can belong to one of three scheduling classes:

**Idle** – This falls under scheduling class 3, and this class does not accept any priority argument. A program operating with the "Idle" scheduling class will only receive disk time when no other program has requested disk I/O within a defined grace period. Idle I/O processes are expected to have zero impact on normal system activity. This scheduling class is currently permitted for an ordinary user (since kernel 2.6.25).

**Best Effort** – This is scheduling class 2, and it accommodates priorities ranging from 0 to 7, with lower numbers indicating higher priority. Programs operating at the same best-effort priority are served in a round-robin fashion. A process that has not requested an I/O priority formally uses "none" as a scheduling class, yet the I/O scheduler treats such processes as if they were in the best-effort class. Priority within the best-effort class dynamically derives from the CPU nice level of the process: io_priority = (cpu_nice + 20) / 5.

**Real Time** – This is scheduling class 1, with 8 priority levels that define the size of a time slice a given process will receive on each scheduling window. This scheduling class is not accessible for an ordinary (non-root) user. Processes in this class are granted primary access to the disk, regardless of other system activities. Thus, the RT class requires careful usage as it can starve other processes.

Setting IO priority for a process using **ionice** as shown below,

![]({{site.baseurl}}/assets/img/2021/04/image-21.png)

**Using nice and ionice together for a command** 
**I'll provide a brief example here:** Let's consider a scenario where a production server has a 1TB disk allocated for the / partition, which is nearly full. The objective is to identify which directory is consuming the most space within this 1TB disk.

However, a concern arises if several CPU-intensive critical processes are already running within the production server. These processes are both CPU and disk I/O intensive. Consequently, we aim to execute commands (such as du or ncdu) to evaluate disk usage, but we prefer these commands not to consume CPU cycles or perform disk I/O activities when the CPU or disk is busy due to the critical processes.

To address this situation, we can employ "**nice**" and "**ionice**" in conjunction, as exemplified below:
**` nice -n 19 ionice -c 3 ncdu -x  /`**

The command provided is safe to execute on any production server without causing concerns regarding CPU or disk I/O issues. It won't impact CPU or disk I/O activities on the production server.
