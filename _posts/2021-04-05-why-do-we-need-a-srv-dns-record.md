---
layout: post
title: Why do we need an SRV DNS record?
date: 2021-04-05
categories: ['Networking', 'DNS']
---

For explanation purposes, let's consider a practical example involving an LDAP server and a client.

Usually, when configuring an LDAP client, we specify the direct address—either the LDAP server's IP address or its domain name.

LDAP logins typically function smoothly without encountering any significant issues most of the time.

**But Wait…., what if your LDAP server is down?**

In Linux, LDAP logins continue to work seamlessly as long as the SSSD or NSCD cache remains unexpired. When these caches are valid, no requests are sent to the LDAP server for authenticating the LDAP client.

However, encountering a situation where both** - the LDAP server is unavailable, and the SSSD/NSCD cache is invalid simultaneously** would result in a considerable problem, this is where the significance of "**SRV**" records becomes crucial.

![]({{site.baseurl}}/assets/img/2021/04/image-3.png)

In the aforementioned illustration, what we're explaining is that, in order for the LDAP client to establish a connection with the LDAP server, the LDAP client needs to perform the following steps:

- 

**Connect to the DNS server**

- 

**Retrieve the SRV record for the domain "madhu.choosebestldapserver.com"**

- 

**Whatever the result (SRV record) is, that will be the LDAP server to which the LDAP client must connect and authenticate itself.**
