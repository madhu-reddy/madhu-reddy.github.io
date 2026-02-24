---
layout: post
title: SSH public key authentication fails under what kind of scenarios?
date: 2023-10-22
categories: ['Linux', 'SSH']
---

---

## Scenario 1: LDAP / FreeIPA User Public Key Not Retrieved

While attempting to log in to a server with an LDAP user using SSH public key authentication, the authentication was failing even though the public key had been added to the user in LDAP (FreeIPA in this case).

After troubleshooting, the following line must be present in the SSH server configuration:

```
AuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys
```

This instructs the SSH server to retrieve user public keys from an external source such as an LDAP server (FreeIPA), using the SSSD daemon running on the server — as opposed to fetching public keys from the conventional `~/.ssh/authorized_keys` file.

---

## Scenario 2: RSA Key Disabled in OpenSSH >= 8.8

With the release of OpenSSH version 8.8, the RSA signature algorithm was disabled (see [release notes](https://www.openssh.com/txt/release-8.8)). If a user attempts to SSH to a server running OpenSSH >= 8.8 using an RSA key, public key authentication will fail.

There are two ways to fix this:

**Option 1: Re-enable RSA**

Edit `/etc/ssh/sshd_config` and add the following lines:

```
HostKeyAlgorithms +ssh-rsa
PubkeyAcceptedKeyTypes +ssh-rsa
```

**Option 2: Generate a new key using a modern algorithm**

Generate a new SSH key using ECDSA or Ed25519 and copy the public key to the remote server:

```bash
ssh-keygen -t ed25519
```

---

## Scenario 3: PubkeyAuthentication Disabled in sshd_config

Verify that `PubkeyAuthentication` is set to `yes` in your `sshd_config` file. If it is set to `no`, public key authentication is disabled on that host.

```bash
root@my-host:~# cat /etc/ssh/sshd_config | grep -i pubkey
PubkeyAuthentication yes
```
