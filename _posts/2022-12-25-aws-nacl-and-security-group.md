---
layout: post
title: AWS NACL and Security Group?
date: 2022-12-25
categories: ['AWS', 'General']
---

Both NACL and Security Group function as virtual firewalls in your VPC; however, there's a key distinction between them. NACL operates at the subnet level, whereas Security Group functions as an instance-level firewall.

#### 
**About NACL (Network Access Control List****)**

NACLs are associated with a subnet in the VPC and govern the allowance or denial of traffic at the subnet level. Every VPC comes with a default NACL that, by default, permits all incoming and outgoing traffic to the subnet.

We have the flexibility to modify the default NACL or create a custom one based on our requirements. However, it's important to note that each subnet must be associated with one NACL.

An NACL consists of inbound or outbound rules, each numbered from 1 to 32766. These rules are evaluated sequentially, with the lowest-numbered rules receiving the highest priority in case of a conflict.

![]({{site.baseurl}}/assets/img/2022/12/image-19.png)

NACLs are stateless, meaning they do not maintain any connection state. For every response to allowed inbound traffic, there must be a corresponding outbound rule explicitly defined (and vice versa).

Now, considering an example where we have an NACL rule allowing HTTP traffic from everywhere on port 80 and a client on the internet is attempting to access a web page hosted on your EC2 instance on port 80, the client's request would be like:

```
**Src IP**: client IP
**Src Port**: Any of the port in the ephemeral ports range (typically 1024-65535)
**Dst IP**: EC2 instance or ELB IP
**Dst Port**: 80
```

To ensure the response from the EC2 instance or ELB reaches the actual client, we must have an outbound rule explicitly defined. The outbound rule should be as follows:

```
**Destination**: 0.0.0.0/0
**Port range**: ephemeral ports range
```

In terms of the Port range, it's essential to choose the `ephemeral ports` range. This is because the actual client's source port, to which the response has to be sent, is dynamic and can be any port within the  `[ephemeral ports range`. 

![]({{site.baseurl}}/assets/img/2022/12/image-21.png)

#### **About Security Groups**

Security Groups are associated with an EC2 instance in the VPC and regulate traffic at the EC2 instance level.

Unlike NACL:
1) Security Groups cannot have rules (Inbound/Outbound) that deny access to resources.
2)  Security Groups are stateful, meaning responses to allowed inbound traffic are automatically permitted to flow out. This behavior occurs regardless of any specific outbound rules defined in the Security Group. This is possible because Security Groups maintain a connection state, tracking connections to and from the EC2 instances.
