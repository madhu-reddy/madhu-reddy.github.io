---
layout: post
title: HOW TO MEASURE NETWORK SPEED BETWEEN SERVERS IN LINUX?
date: 2021-04-26
categories: ['Networking', 'General']
---

## On receiving server B:

`madhu@192.168.1.100:~$ **while true; do netcat -vvlnp 5656 > /dev/null; done**
Listening on [0.0.0.0] (family 0, port 5656)
Connection from [192.168.1.100] port 5656 [tcp/*] accepted (family 2, sport 53714)
Listening on [0.0.0.0] (family 0, port 5656)`

![]({{site.baseurl}}/assets/img/2021/04/image-29.png)

## 

## On sending server A:

## `dd if=/dev/zero bs=1024k count=1024 | nc -vvn 192.168.1.100 5656`

![]({{site.baseurl}}/assets/img/2021/04/image-30.png)

Based on the results, it's evident that we successfully transmitted **1 GB** of data at a rate of **82.1 MB/s** (Megabytes per second).

However, considering that network speed is typically measured in bits, we need to convert **MB (Megabytes)** to **Mb (Megabits)** using the formula:

82.1 * 8 = 656 Mbps (Megabits per second) (This calculation involves multiplying by 8, as 1 byte equals 8 bits.)

Therefore, our data transfer from** server A** to **server B** amounted to **1 GB** at a speed of **656 Mbps (Megabits per second)**.
