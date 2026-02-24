---
layout: post
title: Harnessing The Potential Of SSH Keys Within Your Dockerized Environment
date: 2023-10-21
categories: ['DevOps', 'Docker']
---

If you find yourself in a situation inside your Docker container where you need to clone a Git repository using SSH keys, but the SSH keys are located within your Docker host, and you want to make them available inside the Docker containers for successful cloning of the Git repository, failure to do so will result in the following error:

```
root@0e6d9b720655:/# git clone git@github.com:madhu-reddy/ansible-playbooks.git
Cloning into 'ansible-playbooks'...
The authenticity of host 'github.com (140.82.112.3)' can't be established.
ECDSA key fingerprint is SHA256:p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/LiyKgUfQM.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com,140.82.112.3' (ECDSA) to the list of known hosts.
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

```

Let us see some of the different ways to do this,

Firstly, if the **docker container is already running**, then

1) Copy the SSH private key directly from the host to inside the Docker container, placing it in the file `~/.ssh/id_rsa`. Ensure that the permissions are set to 600 for the file `~/.ssh/id_rsa`.

2) Test the Docker container's interaction with GitHub using the SSH keys by running the command` ssh -T git@github.com `from inside the container or directly from the docker host using the command `docker exec <container_id> ssh -T git@github.com`.

3) With successful authentication, you should be able to clone a Git repository using SSH keys from inside the container. You can now proceed with cloning the repository inside the container.

```
root@98d9f0b03168:~/.ssh# chmod 600 id_rsa  
root@98d9f0b03168:~/.ssh# ssh -T git@github.com  
Hi madhu-reddy! You've successfully authenticated, but GitHub does not provide shell access.
```

Secondly, if you want to copy or forward the SSH keys/agent into the Docker container at the time of creating the container, you have a few options. Here are two common approaches:

-> Copying SSH Keys during Container Creation using a volume mount 
-> Using the ssh-agent forwarding

Let's look at the second approach (ssh-agent forwarding),

1) Using a single-line Docker command, achieve this with the following:
`docker run --rm -ti  -v ${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK} -e SSH_AUTH_SOCK=${SSH_AUTH_SOCK} nginx bash`

2) In the above command, pay attention to the environmental variable "`SSH_AUTH_SOCK`." This variable holds the location of the ssh-agent UNIX socket file, enabling communication between the docker container and the docker host to address authentication queries from GitHub.

3)** To ensure success**, an ssh-agent must already be running on the host, and the ssh private key should be added to it.

4) To verify whether the ssh-agent daemon is active, check if the environment variable `"SSH_AUTH_SOCK"` is set using the "env" command on the host.

5) If it's set, the ssh-agent daemon is confirmed to be running. If not, initiate the ssh-agent and add the ssh private key to it before executing the Docker command mentioned in the first step.

Please check out [this related post about ssh-agent forwarding and how it works.
