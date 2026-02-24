---
layout: post
title: Whats the difference between NLB and ALB in AWS?
date: 2021-10-26
categories: ['AWS', 'General']
---

NLB (Network Load Balancer) 

Network Load Balancers (NLBs) function at layers 3 and 4 of the OSI model, while ALBs (Application Load Balancers) operate at layer 7.

When a request reaches an NLB, it makes routing decisions based on source and destination IP addresses and port numbers. NLBs lack access to packet content, preventing inspection of data within the packet.

Upon an HTTP request from a client, using TCP as the transport protocol, a TCP connection is established after the three-way handshake between the client and NLB. Subsequent HTTP requests and responses occur between the client and server.

NLBs utilize the established TCP connection from the client to connect to upstream servers, employing NAT to modify both source and destination IP addresses to align with the NLB and upstream servers.

NLBs are generally faster because, unlike ALBs, they do not inspect data before making routing decisions. They focus on NAT and forward/route packets to upstream servers based on source and destination IP addresses in the data packet.

![]({{site.baseurl}}/assets/img/2021/10/aws-1.png)

![]({{site.baseurl}}/assets/img/2021/10/aws-2.png)

In the provided example, all L4 TCP requests arriving at NLB (on port 80 or 8080) are directed to a target group (**madhu-tcp**), subsequently forwarding requests to an instance on port 80.

                                                                                                                                                                         .

.

ALB (Application Load Balancer)

                                                                                                                                                                                             .

In contrast, ALBs make routing decisions based on the actual packet content, operating at layer 7 of the OSI model. Layer 7 load balancers base their decisions on HTTP headers and message contents, including data type (e.g., text, video) or details from cookies or query strings in the URL.

ALBs establish two separate TCP connections. The first between the client and ALB is terminated by the ALB, followed by a new TCP connection from the ALB to the upstream server.

In our example, our ALB comprises three listeners:

The **first listener** (HTTP request on port 80) defaults to forwarding to a target group (**madhu-http**).
The **second **and **third listeners** (HTTP requests on ports 8080 and 8081) also default to forwarding to the target group (**madhu-http**).

![]({{site.baseurl}}/assets/img/2021/10/aws-3.png)

**NOTE:** The target group (**madhu-http**) merely forwards requests from the ALB to a target instance on port 80.

**Let's examine the distinctions between ALB and NLB**. 
In the second listener, two rules are configured. The first rule directs the ALB to forward requests to the target group (**madhu-http2**) if the URL contains a query string with the key "**name**" and key value "**ramu8080**". Otherwise, using the second rule, it forwards all requests to the target group (**madhu-http**).

![]({{site.baseurl}}/assets/img/2021/10/aws-5.png)

The target group (**madhu-http2**) forwards ALB requests to an instance on port  8080.

![]({{site.baseurl}}/assets/img/2021/10/aws-7.png)

The target group (**madhu-http**) forwards ALB requests to an instance on port 80.

![]({{site.baseurl}}/assets/img/2021/10/aws-8.png)
