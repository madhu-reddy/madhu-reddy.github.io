---
layout: post
title: How does DNS (Domain Name System) resolution work in real-time?
date: 2021-11-19
categories: ['Networking', 'DNS']
---

# **About DNS resolution** 
DNS resolution is pivotal for seamless internet functionality for end-users. For instance, imagine the inconvenience of entering the IP Address directly instead of typing "google.com" into the browser's search bar.

The DNS service's responsibility is to locate the server's IP address for the entered domain (e.g., "google.com") in the browser.

Once the DNS service finds the IP address, the end-user can connect to the server hosting the "google.com" domain.

# **How DNS works:**

1) Whenever we visit a website (e.g., google.com), our client system (laptop/desktop, etc.) tries to retrieve the IP address for that domain. To obtain the IP Address, our system first checks the local system cache for the IP related to the domain (google.com).

2) If the local system cache lacks the IP address, our system connects to the DNS server known as the "DNS Recursive Resolver" (also called DNS Recursor), often managed by the Internet Service Provider (ISP). If the DNS Recursor cache already contains the IP address, it promptly responds with the IP corresponding to the domain (google.com).

3) If the DNS Recursor does not have the IP address in its cache, it reaches out to the DNS Root Server (usually denoted with a dot "."). The DNS maintains a hierarchy (using DNS zones) to manage its distributed database system. The DNS Root Server sits atop the DNS hierarchy and contains all DNS information related to various Top-level domains (TLDs).

TLDs are categorized into two subcategories: **Organizational Hierarchy** (com, org, gov, edu, net, etc.) and** Geographic Hierarchy **(in, uk, fr, etc.).

![]({{site.baseurl}}/assets/img/2021/11/dn-work-root-1.png)

                                                                                                                                                                                                                .

4) If the DNS Root Server doesn't have an IP address in its cache, it forwards the request to the Top-Level Domain (TLD) domain (.com). Similarly, if the TLD domain (.com) also lacks the IP address in its cache, it will forward the DNS request to the authoritative DNS server for "google.com" since it holds the authoritative DNS server information related to "google.com".

5) The Authoritative DNS server for "google.com" responds with the corresponding IP Address for "google.com". This response gets cached at each level (e.g., Root, TLDs, DNS Recursor) before reaching the client.

**NOTE:** **Authoritative DNS servers **are responsible for providing answers to queries made by **Recursive DNS resolver **servers regarding the IP address related to a specific domain name.

## [Pictorial representation of how DNS works:

![]({{site.baseurl}}/assets/img/2021/11/dns-works.png)
