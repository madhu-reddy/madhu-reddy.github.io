---
layout: post
title: Why is SPF important for email delivery?
date: 2021-04-02
categories: ['Networking', 'Email']
---

The Sender Policy Framework (SPF) Record is created to prevent applications or users that you don't trust from sending emails on behalf of your domain.

#### Mail delivery process with SPF record

Let me provide a real-time example: Suppose we are using '**mailgun**' as the email service provider for our domain. Since our domain doesn't have a dedicated SMTP server like PostFix, we rely on third-party email providers such as '**mailgun**' e.t.c.

SPF plays a crucial role in ensuring successful delivery of emails sent using '**mailgun**.' To simplify, let's use the following names for the sending and receiving domains in action.

```
**sending mail server domain**: mylearningsguru.com (this is the domain name on behalf of which "mailgun" send mails)

**receiving mail server domain**: madhutesting.com

```

Suppose the receiving domain (**madhutesting.com**) mail server receives an email from '**mailgun**.' The receiving mail server of '**madhutesting.com**' will go through the following steps:

```
1)It contacts the DNS server 'mylearningsguru.com' for the SPF record.

2)It checks the SPF record for all the IP addresses that are approved to send emails on behalf of 'mylearningsguru.com.'

3)If it finds that the IP address from which 'mailgun' had previously sent the email matches with the IP address from which the mail is received, then it's considered an SPF check pass.

4) Otherwise, it considers it an SPF check failure and treats the email as illegitimate. It might discard the email without receiving it or send the email to the spam folder.
```
