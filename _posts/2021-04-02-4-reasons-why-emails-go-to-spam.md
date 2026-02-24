---
layout: post
title: 4 reasons why emails go to SPAM?
date: 2021-04-02
categories: ['Networking', 'Email']
---

Are your emails going to the spam folder? Customers are complaining that they have not received your emails, and some have mentioned that although they received the email, it ended up in their spam folder instead of their inbox.

**There are a few important points that need to be checked:**

```
1)Check if appropriate SPF, DKIM, DMARC records are present in DNS (used when authorizing another email provider to send emails on behalf of your domain).

2)**Email Body:** Certain keywords like “free” are considered spam.

3)**Your Mail Server's IP Reputation:** If the mail server has a brand new IP, it needs to build its reputation. You can do this by sending a few emails to yourself and, when you find these emails in the spam folder, click on “does not mark as spam.”

4)Check whether your Mail Server's IP is Blacklisted (Using MXtoolbox website). If the IP is blacklisted, instead of appealing for its removal, consider changing the IP of your Mail Server.
```
