---
layout: post
title: Update a command in AWS instances (using ansible & ssh-agent)?
date: 2021-05-09
categories: ['DevOps', 'Ansible']
---

1) First, we need to start the ssh-agent (this program holds private keys for public key authentication) using the command.
`ssh-agent bash

![]({{site.baseurl}}/assets/img/2021/05/ansible1.png)

`2) Now, we need to add the private key, along with its passphrase, to the list maintained by the ssh-agent using the following command:
`ssh-add privatekey.pem
``
![]({{site.baseurl}}/assets/img/2021/05/ansible2-2.png)

**
NOTE:**
The ssh-agent can then use the private key to log into other servers without requiring the user to retype the passphrase or provide the private key during an ssh connection.
`

 

3) Create a **[aws]** group in **/etc/ansible/hosts** and add all the IPs of the AWS instances where we want to execute a command.

![]({{site.baseurl}}/assets/img/2021/05/ansible3-1.png)

4) Run the ansible command,
`ansible aws -u ubuntu  -a "uname -r" `("uname -r" is the ad-hoc command we want to run in all the AWS Instances)

![]({{site.baseurl}}/assets/img/2021/05/ansible4.png)

5) Following these steps enables us to execute a command on multiple AWS instances.

`

`
``
