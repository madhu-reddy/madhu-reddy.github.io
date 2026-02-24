---
layout: post
title: SSH public key authentication fails under what kind of scenarios?
date: 2023-10-22
categories: ['Linux', 'SSH']
---

**Scenario 1** 
I recently encountered an issue while attempting to log in to a server with an LDAP user using SSH public key authentication. 
Unfortunately, the public key authentication was failing, even though the public key had been added to the user in LDAP (FreeIPA in our case). After some troubleshooting, I found that the following line must be present:

```
AuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys

```

This command instructs the SSH server to retrieve user public keys from an external source, such as an LDAP server (FreeIPA in my case), using the SSSD daemon running on the server. This is in contrast to fetching public keys from the conventional `~/.ssh/authorized_keys` file.

**Scenario 2** 
With the release of OpenSSH version 8.8, the RSA algorithm/signature is disabled (refer to [https://www.openssh.com/txt/release-8.8). Consequently, if a user attempts to SSH to a server with OpenSSH version greater than or equal to 8.8 using an RSA key, public authentication will fail in this scenario. To address this issue, there are two possible solutions:

1) Re-enable RSA by editing the sshd_config file and adding the following lines:

```
HostKeyAlgorithms +ssh-rsa
PubkeyAcceptedKeyTypes +ssh-rsa
```

2) Generate SSH keys using another key type, such as ECDSA or Ed25519, and then copy the public key to the remote SSH server (which has OpenSSH version greater than or equal to 8.8).

```
ssh-keygen -t ed25519
```

**Scenario3** 
Verify the presence of the entry "PubkeyAuthentication yes" in your sshd_config file. If it is set to "no," it indicates that public key authentication is disabled on this host.

`root@my-host-:~# cat /etc/ssh/sshd_config | grep -i pubkey
PubkeyAuthentication yes`
