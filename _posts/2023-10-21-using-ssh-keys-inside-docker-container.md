---
layout: post
title: Harnessing The Potential Of SSH Keys Within Your Dockerized Environment
date: 2023-10-21
categories: ['DevOps', 'Docker']
---

If you find yourself inside a Docker container needing to clone a Git repository using SSH keys that are located on the Docker host, failure to make them available inside the container will result in the following error:

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

Let's look at the different ways to handle this.

---

## Option 1: Container Already Running

If the Docker container is already running, follow these steps:

1. Copy the SSH private key directly from the host into the container at `~/.ssh/id_rsa` and set the correct permissions:

   ```bash
   chmod 600 ~/.ssh/id_rsa
   ```

2. Test the container's SSH connection to GitHub from inside the container:

   ```bash
   ssh -T git@github.com
   ```

   Or directly from the Docker host:

   ```bash
   docker exec <container_id> ssh -T git@github.com
   ```

3. With successful authentication, you can now clone the repository from inside the container.

**Example output after a successful setup:**

```
root@98d9f0b03168:~/.ssh# chmod 600 id_rsa
root@98d9f0b03168:~/.ssh# ssh -T git@github.com
Hi madhu-reddy! You've successfully authenticated, but GitHub does not provide shell access.
```

---

## Option 2: Forwarding SSH Keys at Container Creation

If you want to make SSH keys available at the time of creating the container, there are two common approaches:

- Copying SSH keys during container creation using a volume mount
- Using SSH agent forwarding

### SSH Agent Forwarding

1. Use the following Docker command to forward the SSH agent socket into the container:

   ```bash
   docker run --rm -ti \
     -v ${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK} \
     -e SSH_AUTH_SOCK=${SSH_AUTH_SOCK} \
     nginx bash
   ```

2. The environment variable `SSH_AUTH_SOCK` holds the location of the ssh-agent UNIX socket file. This enables communication between the Docker container and the Docker host to handle authentication queries from GitHub.

3. For this to work, an ssh-agent must already be running on the host with the SSH private key added to it.

4. To verify whether the ssh-agent is active, check if `SSH_AUTH_SOCK` is set on the host:

   ```bash
   env | grep SSH_AUTH_SOCK
   ```

5. If the variable is set, the ssh-agent is confirmed to be running. If not, start the ssh-agent and add your private key before running the Docker command above:

   ```bash
   eval $(ssh-agent)
   ssh-add ~/.ssh/id_rsa
   ```

