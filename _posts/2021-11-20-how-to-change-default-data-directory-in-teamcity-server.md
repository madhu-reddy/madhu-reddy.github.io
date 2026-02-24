---
layout: post
title: How to change the default data directory in the TeamCity server?
date: 2021-11-20
categories: ['DevOps', 'TeamCity']
---

## Changing the default data directory in a TeamCity server, would require the following steps

1) First Stop the TeamCity server with the following command,
/opt/jetbrains/TeamCity/bin/runAll.sh stop

![image]({{site.baseurl}}/assets/img/2021/11/K8uCaxxNTYsUe4OGsKAGJx_fbbZopF6LaYXsdMwJ1J7K_4DFJgYHuHdI0KXS7UzizZi4eaaCCYGAvIrHNV-_hooy82ys-cTuxyd9qLZegAVMP6yIV-Fsz98Loq8Xyvp_Dz1mWg1c)

2) Copy all the files and directories with the same permissions,  from the default data directory "**/root/.BuildServer**" to the directory which we want to be the new data directory "**/opt/teamcity-data**".

![image]({{site.baseurl}}/assets/img/2021/11/iy6V_92O9_3OmUc4d7WM4w0pSQhD7ZAGbh6liCUupDHF1TqXCnx7AoE2kKPeI7cXe8oOEgoCnKhrktRrKRhbqTCicDl17-uYPWO5QEKcYwkhv4vJOo4R_A9TL0ykWXfF87_LRkyH)

3) Edit the file "**teamcity-startup.properties**" & set the "**teamcity.data.path**"  to "**/opt/teamcity-data**".

![image]({{site.baseurl}}/assets/img/2021/11/5pBR7MiK0SMtV5BSJEDEXY-nRGeNkZcTXNoNgdZ1PRI3j2LKCpy-OU97q8Fx8uF0Hc1A4XB8J_Y_uPHUQFW8ZHITaZUCGdyd8IOoB9X-rMxRWIASxow3bHUR4jK_6yhoz2DZd3ng)

4) Now Start the TeamCity Server(/opt/jetbrains/TeamCity/bin/runAll.sh start)

5) Now, open the TeamCity GUI and verify that the data directory has been updated to "**/opt/teamcity-data**". Consequently, all data related to "**artifacts**" will be stored within the "**/opt/teamcity-data**" directory going forward.

![]({{site.baseurl}}/assets/img/2021/11/image-2.png)
