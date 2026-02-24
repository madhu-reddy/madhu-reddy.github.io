---
layout: post
title: "How to map docker container with a veth interface?"
date: 2021-05-15
categories: ['DevOps', 'Docker']
---

In certain scenarios, especially when numerous Docker containers are operational within a server host, it becomes pivotal to identify the specific **veth** interface associated with each container. This enables us to effectively monitor the inbound and outbound traffic of individual Docker containers.

Consider a scenario with **15** active Docker containers. In such instances, determining the exact **veth** interface linked to a particular container proves essential for comprehensive traffic analysis and management.

```
`madhu@myserver:~$ ip addr list | grep veth | wc -l
15
`
```

```
`madhu@myserver:~$ sudo docker ps --format '{{.ID}}'
dcfb47b708fc
b4e72699410a
4c187a15f99d
62f7ba1f359e
88f9a3ca5751
5158fa9ff82e
6b9fc5cb32ef
b4ef57f36be8
ddb4dfc4b667
48a81371f7b5
242141c957ff
f87bc82d5ab7
3553a4f18964
26846185b81b
f607fbc8eb3c
308a1363eaf6

`
```

Each Docker container is associated with a distinct "veth" network interface, resulting in a total of 15 "veth" network interfaces for the 15 Docker containers running concurrently. 

```
`madhu@myserver:~$ ip addr list | grep veth
6: veth7948fb0@if5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-56185a481942 state UP group default 
8: vetha1a7201@if7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
10: veth615757e@if9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-56185a481942 state UP group default 
12: vethebb8592@if11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
16: veth740737f@if15: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-56185a481942 state UP group default 
20: veth84fc46c@if19: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-56185a481942 state UP group default 
22: veth84c7bdf@if21: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
24: veth75c2a1f@if23: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-56185a481942 state UP group default 
26: veth0eac4c9@if25: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
28: veth703f874@if27: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
30: veth9ee258e@if29: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
32: vetha9a1a85@if31: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
34: vethc51f83f@if33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
36: veth03fe67a@if35: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
48: vethb4659b0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
`
```

## Get the "veth" interface ID specific to a docker container

```
`ip addr list | grep ^$(sudo docker exec dcfb47b708fc cat /sys/class/net/eth0/iflink)`
```

## Output:

```
`48: vethb4659b0@if47: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default`
```

More information about "**/sys/class/net**" can be found in this [link
