---
layout: post
title: "'"Destination Host Unreachable" when doing a ping request?'"
date: 2022-08-30
categories: ['Networking', 'Troubleshooting']
---

Are you seeing '`From x.x.x.x icmp_seq=1 Destination Host Unreachable'` when you ping an IP Address using ICMP?

This could be due to various reasons, which I'll cover here.

Let me first explain how routing works on a host.

I'll use a Linux box as an example, and below is the output for '`**route -n**`,' which displays all the route table information present on your host.

```
`Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.10.1     0.0.0.0         UG    600    0        0 wlp2s0
172.13.10.0     0.0.0.0         255.255.255.0   U     600    0        0 wlp2s0
192.168.16.0    0.0.0.0         255.255.240.0   U     0      0        0 docker0
`
```

Now, considering the above routing table, we can infer that any ping request with a destination outside the network (172.13.10.0/24, 192.168.16.0/20) is directed to the default gateway 192.168.10.1, which is usually the router's IP.

However, for ping requests where the destination host IP belongs to the networks (172.13.10.0/24, 192.168.16.0/20) that have 0.0.0.0 as their gateway, it indicates there's no gateway or external route available. 

This situation occurs due to two reasons:

**1) **These networks are directly connected to the machine itself. For instance, when utilizing Docker within your machine, this setup appears as follows:

```
`docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:12:d3:aa:96 brd ff:ff:ff:ff:ff:ff
    inet 192.168.16.1/20 brd 192.168.31.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:12ff:fed3:aa96/64 scope link 
       valid_lft forever preferred_lft forever
`
```

As a result, packets related to `192.168.16.0/24` are directly forwarded to the destination host within these networks. In this scenario, there's no need for external routing since the machine handles the internal routing process.

**2)** Additionally, if the packet is destined for another device (e.g., with an IP of 172.13.10.45) within the same network (172.13.10.0/24) as your machine (with an IP of 172.13.10.56), there's no need for a gateway or external routing. In this scenario, both the source and destination are within the same network, and the packet is directly transmitted to the destination machine by the switch using the MAC address. If the switch lacks this information, it initiates an ARP request to locate the respective MAC address of the destination machine.

.

### **Now coming back to "Destination Host Unreachable" when doing a "ping" request?**

There could be several reasons for this. Firstly, the destination host might genuinely be down, or it's possible that the network cable for that host is disconnected. Secondly, this issue could be related to conflicting routes in your [route table.

```
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         172.14.5.1      0.0.0.0         UG        0 0          0 wlp2s0
169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 docker0
172.14.0.0      0.0.0.0         255.255.0.0     U         0 0          0 br-b2cef7603ade

```

An example of the** above route table** illustrates this issue. 

When attempting to ping a host (172.14.10.52) from my laptop (172.14.5.34), I encounter '**Destination Host Unreachable.**' 

This problem arises from a conflicting route present as the third entry in my route table, associated with the docker bridge network interface on my laptop. Due to this route, my laptop attempts to deliver the packet locally to the bridge network interface, but there is no IP (172.14.10.52) linked to any of the interfaces on the docker bridge network. 

It's important to note that a bridge network interface functions similarly to a network switch, forwarding packets between connected interfaces.
