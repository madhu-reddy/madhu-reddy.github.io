---
layout: post
title: All about system-resolved DNS resolution
date: 2023-11-13
categories: ['Networking', 'DNS']
---

You might be familiar with the `/etc/resolv.conf` file and configuring it by manually specifying the desired name servers for DNS resolution.

However, the configuration within `/etc/resolv.conf` can also be dynamically managed by various programs such as **NetworkManager**, **resolvconf**, **rdnssd**, and **systemd-resolved**.

If any of the aforementioned programs are actively managing `/etc/resolv.conf`, attempting to modify the file without disabling the program's control may result in your changes being overwritten after a few minutes or reverted upon system reboot.

**Identifying  which program currently controls your /etc/resolv.conf**

If you closely examine the file, you should find comments indicating the program that is currently managing the `/etc/resolv.conf` file.

**Example1 (when using “resolvconf”)**

![]({{site.baseurl}}/assets/img/2023/11/image.png)

**Example2 (when using “systemd-resolved”)**

![image]({{site.baseurl}}/assets/img/2023/11/-6fN2LYE__3XKhNMhHylIoJJdJhz9ubxpyVVoSw78rQ_fSD8Ix7F_pg14pBhDkuqCqgaQrTGdAcnERE07CLJXeME_cLVakxMyBFOZCKCx16TOQBB8jBt6OYSZd1biPyy-wmptAFQWDozvOl-hBiPQ6w)

**About systemd-resolved**

`systemd-resolved` can be configured by editing `/etc/systemd/resolved.conf` and/or by using drop-in `.conf` files in `/etc/systemd/resolved.conf.d/`

![]({{site.baseurl}}/assets/img/2023/11/image-2.png)

`systemd-resolved` has four different modes (**stub**, **uplink**, **static**, **foreign**) for handling the DNS resolution file (`/etc/resolv.conf`), with **stub mode** being the **default** and **recommended** option.

**About "stub" mode**

1) `/run/systemd/resolve/stub-resolv.conf` is the stub resolver configuration file, dynamically created. The file typically contains the local stub address `127.0.0.53` as the sole DNS server and includes a list of search domains for domain search suffixes.

2) The address `127.0.0.53` is the loopback address where `systemd-resolved` operates as a local stub resolver.

3) When DNS resolution is needed, the request first goes to the local stub resolver at `127.0.0.53`, which then forwards the DNS query request to the appropriate DNS server configured in the file `/etc/systemd/resolved.conf`.

4) The file `/etc/resolv.conf` is often symbolically linked (symlinked) to `/run/systemd/resolve/stub-resolv.conf`.

**Enabling only systemd-resolved ("stub" mode) for managing DNS**

$ ls -la /etc/resolv.conf

$ mv /etc/resolv.conf /etc/resolv.conf.BAK

$ ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

$ systemctl restart systemd-resolved

$ resolvectl

![]({{site.baseurl}}/assets/img/2023/11/image-3.png)

**NOTE:**
If multiple programs or services are attempting to manage the `/etc/resolv.conf` file simultaneously, conflicts and inconsistencies can arise. The `/etc/resolv.conf` file is a critical configuration file for DNS resolution, and having multiple sources trying to control it can lead to unexpected behavior.

On systems using `systemd-resolved`, it's recommended to let `systemd-resolved` manage `resolv.conf` and to avoid interference from other programs unless necessary.
