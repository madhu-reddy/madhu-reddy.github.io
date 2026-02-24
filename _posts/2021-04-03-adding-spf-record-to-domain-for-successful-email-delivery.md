---
layout: post
title: "Adding SPF record to the domain for successful email delivery"
date: 2021-04-03
categories: ['Networking', 'Email']
---

If your company is using the paid version of Gmail for business and wants to have email IDs in the format of [username@companydomain.com, then you need to add the 'SPF' record related to the Google mail servers. This is necessary if you want to use Google mail servers to successfully send emails for your domain.

#### **Create TXT record for SPF**

A TXT record for SPF specifies the mail servers allowed to send emails on behalf of your domain.

```
`v=spf1 include:_spf.google.com ~all`
```

- The above example applies when all your domain emails are routed through Google mail servers. In such cases, an internal postfix SMTP Relay server can be configured optionally to relay all emails to the actual Google mail servers.

However, if you also send emails using other service providers, you can add them to the existing SPF (TXT Record).

```
`v=spf1 ip4:70.70.20.20 include:_spf.google.com include:mailgun.org ~all`
```

- In this scenario, authorization includes an IPv4 address and a couple of domains permitted to send emails on behalf of your domain.
