---
layout: post
title: How to perform ssh agent forwarding for git clone using ssh authentication?
date: 2021-11-07
categories: ['Linux', 'SSH']
---

Suppose we want to clone a GitHub repository using SSH authentication. In this case, we need to ensure that the corresponding private key is available on the server where we intend to perform the Git clone.

One option, which is not recommended, is to manually copy the private key to the server and delete it once the clone is complete. However, this method can be problematic if we need to clone the repository to multiple servers and we forget to delete the key after each clone.

SSH agent forwarding provides a more secure and efficient solution for this task.

**1) Start the ssh-agent and then add the SSH private key to the ssh-agent** `ssh-agent bash
ssh-add /home/user/id_rsa`

**2)** **Enabling the ssh agent forwarding** 
In your client's **ssh_config** file, add the following line:
Host *
  ForwardAgent yes
The "*" wildcard indicates that agent forwarding should be enabled for all hosts.

                    **    (OR)**

Alternatively, instead of modifying the client's **ssh_config** file, you can directly enable ssh-agent forwarding using the "-A" option with the "ssh" command as shown below:
ssh -A madhu@remoteserver

By following either method, you can successfully clone the Git repository on the remote server using SSH authentication.

madhu@remoteserver:~$ git clone git@github.com:madhu-reddy/python-projects.git
Cloning into 'python-projects'...
remote: Enumerating objects: 65, done.
remote: Counting objects: 100% (65/65), done.
remote: Compressing objects: 100% (58/58), done.
remote: Total 65 (delta 13), reused 42 (delta 2), pack-reused 0
Receiving objects: 100% (65/65), 13.52 KiB | 0 bytes/s, done.
Resolving deltas: 100% (13/13), done.
Checking connectivity... done.

**In simpler terms, here's how this authentication works:**

When the user attempts to clone the GitHub repository from within the server, GitHub sends a randomly generated encrypted message (encrypted using the public key stored on GitHub's servers) to the server to verify its possession of the corresponding private key.

The server, lacking the private key locally, utilizes the environment variable (SSH_AUTH_SOCK) to forward GitHub's challenge to the local client system, which holds the actual private key.

The local client system deciphers the random encrypted message sent by GitHub using its stored private key and prepares the answer. It then sends the response back to the server, which relays it to GitHub.

Upon receiving the decrypted message, GitHub verifies that it matches the original message sent to the server. If the verification is successful, authentication is deemed successful, and GitHub grants the server permission to clone the repository.

I found [this nice article, which explains clearly with real-world example,

```
It works like this: you ask your remote server to pull some code from Github, and Github says “who are you?” to the server. Usually the server would consult its own id_rsa files to answer, but instead it will forward the question to your local machine. Your local machine answers the question and sends the response (which does not include your private key) to the server, which forwards it back to Github. Github doesn’t care that your local machine answered the question, it just sees that it’s been answered, and lets you connect.
```
