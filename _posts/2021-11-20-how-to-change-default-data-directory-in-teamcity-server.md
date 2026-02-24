---
layout: post
title: How to change the default data directory in the TeamCity server?
date: 2021-11-20
categories: ['DevOps', 'TeamCity']
---

Follow the steps below to change the default data directory in a TeamCity server.

## Step 1: Stop the TeamCity Server

```bash
/opt/jetbrains/TeamCity/bin/runAll.sh stop
```

![image]({{site.baseurl}}/assets/img/2021/11/K8uCaxxNTYsUe4OGsKAGJx_fbbZopF6LaYXsdMwJ1J7K_4DFJgYHuHdI0KXS7UzizZi4eaaCCYGAvIrHNV-_hooy82ys-cTuxyd9qLZegAVMP6yIV-Fsz98Loq8Xyvp_Dz1mWg1c)

## Step 2: Copy Data to the New Directory

Copy all files and directories with the same permissions from the default data directory `/root/.BuildServer` to the new target directory `/opt/teamcity-data`.

![image]({{site.baseurl}}/assets/img/2021/11/iy6V_92O9_3OmUc4d7WM4w0pSQhD7ZAGbh6liCUupDHF1TqXCnx7AoE2kKPeI7cXe8oOEgoCnKhrktRrKRhbqTCicDl17-uYPWO5QEKcYwkhv4vJOo4R_A9TL0ykWXfF87_LRkyH)

## Step 3: Update teamcity-startup.properties

Edit the `teamcity-startup.properties` file and set `teamcity.data.path` to `/opt/teamcity-data`.

![image]({{site.baseurl}}/assets/img/2021/11/5pBR7MiK0SMtV5BSJEDEXY-nRGeNkZcTXNoNgdZ1PRI3j2LKCpy-OU97q8Fx8uF0Hc1A4XB8J_Y_uPHUQFW8ZHITaZUCGdyd8IOoB9X-rMxRWIASxow3bHUR4jK_6yhoz2DZd3ng)

## Step 4: Start the TeamCity Server

```bash
/opt/jetbrains/TeamCity/bin/runAll.sh start
```

## Step 5: Verify in the TeamCity GUI

Open the TeamCity GUI and verify that the data directory has been updated to `/opt/teamcity-data`. All data related to artifacts will be stored within `/opt/teamcity-data` going forward.

![]({{site.baseurl}}/assets/img/2021/11/image-2.png)
