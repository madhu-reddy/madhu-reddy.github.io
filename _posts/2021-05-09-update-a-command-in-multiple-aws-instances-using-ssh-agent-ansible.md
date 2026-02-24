---
layout: post
title: Update a command in AWS instances (using Ansible & ssh-agent)?
date: 2021-05-09
categories: ['DevOps', 'Ansible']
---

Follow the steps below to run a command across multiple AWS instances using Ansible and ssh-agent.

---

## Step 1: Start the ssh-agent

Start the ssh-agent, which holds private keys for public key authentication:

```bash
ssh-agent bash
```

![]({{site.baseurl}}/assets/img/2021/05/ansible1.png)

---

## Step 2: Add the Private Key

Add the private key, along with its passphrase, to the list maintained by the ssh-agent:

```bash
ssh-add privatekey.pem
```

![]({{site.baseurl}}/assets/img/2021/05/ansible2-2.png)

> **Note:** The ssh-agent can then use the private key to log into other servers without requiring the user to retype the passphrase or provide the private key during an SSH connection.

---

## Step 3: Configure the Ansible Inventory

Create an `[aws]` group in `/etc/ansible/hosts` and add the IP addresses of all the AWS instances where you want to execute a command.

![]({{site.baseurl}}/assets/img/2021/05/ansible3-1.png)

---

## Step 4: Run the Ansible Ad-Hoc Command

Run the following Ansible command, where `uname -r` is the ad-hoc command to execute on all AWS instances:

```bash
ansible aws -u ubuntu -a "uname -r"
```

![]({{site.baseurl}}/assets/img/2021/05/ansible4.png)

---

## Step 5: Done

Following these steps enables you to execute a command on multiple AWS instances simultaneously using Ansible and ssh-agent.
