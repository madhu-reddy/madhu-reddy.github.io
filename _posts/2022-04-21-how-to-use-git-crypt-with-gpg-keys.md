---
layout: post
title: How to use git-crypt with gpg keys?
date: 2022-04-21
categories: ['DevOps', 'Git']
---

The purpose of this guide is to explore using `git-crypt` alongside GPG keys for encryption within Git repositories.

**Step-by-Step Procedure:**

**Step 1: Preparation**

Navigate to your Git repository and create the file you wish to encrypt.

```
madhu@madhu-Inspiron-5567:~/madhu-github-testing$ cat mysecretsfile.txt 
MysecretPassword
MysecretPassword1
```

**Step 2: Initializing `git-crypt`**

Execute the command `git-crypt init` to set up `git-crypt` within your Git repository. This command generates the encryption key and configures the repository to use `git-crypt`.

```
madhu@madhu-Inspiron-5567:~/madhu-github-testing$ git-crypt init
Generating key...
```

**Step 3: Specifying Files for Encryption**

Define the files intended for encryption in the `.gitattributes` file by mentioning the file(s) and indicating `git-crypt` as the filter.

```
madhu@madhu-Inspiron-5567:~/madhu-github-testing$ cat .gitattributes 
mysecretsfile.txt filter=git-crypt diff=git-crypt

```

**Step 4: GPG Key Generation and Usage**

**4.1)** Generate a GPG key on your local machine, necessary for decrypting the repository's encrypted files.

**Example:**

```
madhu@myclient:~/madhu-github-testing$ gpg --gen-key
gpg (GnuPG) 1.4.20; Copyright (C) 2015 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection? 
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 
Requested keysize is 2048 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 
Key does not expire at all
Is this correct? (y/N) y

You need a user ID to identify your key; the software constructs the user ID
from the Real Name, Comment and Email Address in this form:
    "Heinrich Heine (Der Dichter) <heinrichh@duesseldorf.de>"

Real name: madhu kunta     # Not mandatory, but it would be good if it matches the real GitHub user name
Email address: madhu@mylearningsguru.com # Not mandatory, but it would be good if it matches real GitHub user's mail ID. 
Comment: 
You selected this USER-ID:
    "madhu kunta <madhu@mylearningsguru.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
You need a Passphrase to protect your secret key.

gpg: key 09F305B1 marked as ultimately trusted
public and secret key created and signed.

gpg: checking the trustdb
gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
gpg: depth: 0  valid:   2  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 2u
pub   2048R/09F305B1 2022-04-12
      Key fingerprint = 4FF4 1694 5A32 F162 D7BB  73C9 2107 C977 09F3 05B1
uid                  madhu kunta <madhu@mylearningsguru.com>
sub   2048R/4EDA4314 2022-04-12

```

**4.2)** Confirm key creation
gpg --list-keys 
gpg --list-secret-keys

**Example:**

```
madhu@myclient:~/madhu-github-testing$ gpg --list-keys
/home/madhu/.gnupg/pubring.gpg
------------------------------
pub   2048R/09F305B1 2022-04-12
uid                  madhu kunta <madhu@mylearningsguru.com>
sub   2048R/4EDA4314 2022-04-12

madhu@myclient:~/madhu-github-testing$ gpg --list-secret-keys
/home/madhu/.gnupg/secring.gpg
------------------------------
sec   2048R/09F305B1 2022-04-12
uid                  madhu kunta <madhu@mylearningsguru.com>
ssb   2048R/4EDA4314 2022-04-12

```

**4.3)** Export your GPG public key

**Syntax: **gpg --armor --export --output pubkeyname.gpg pubkeyID

```
madhu@myclient:~/madhu-github-testing$ gpg --armor --export --output madhukunta_pubkey.gpg 09F305B1

madhu@myserver:~/madhu-github-testing$ ls -ltrh | grep madhukunta_pubkey.gpg 
-rw-rw-r-- 1 madhu madhu 1.7K Apr 12 03:00 madhukunta_pubkey.gpg

```

**4.4)** **Import** the GPG public key to the server **where the `git-crypt` initialization was performed.**

**Syntax**: gpg --import gpg-pub-key

```
madhu@madhu-Inspiron-5567:~/madhu-github-testing$ gpg --import madhukunta_pubkey.gpg 
gpg: key 09F305B1: "madhu kunta <madhu@mylearningsguru.com>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1

```

**Step 5: Adding User GPG Key to `git-crypt`**

```
madhu@madhu-Inspiron-5567:~/madhu-github-testing$ git-crypt add-gpg-user --trusted madhu@mylearningsguru.com
[madhu-projects f247991] Add 1 git-crypt collaborator
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 .git-crypt/keys/default/0/4FF416945A32F162D7BB73C92107C97709F305B1.gpg

```

**Step 6: Pushing Changes**

Perform a `git push` to push the auto-generated commit after adding the user's GPG key to `git-crypt`.

```
madhu@madhu-Inspiron-5567:~/madhu-github-testing$ git push
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 4 threads
Compressing objects: 100% (6/6), done.
Writing objects: 100% (8/8), 1.14 KiB | 1.14 MiB/s, done.
Total 8 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To github.com:madhu-reddy/shell-scripts.git
   ce73f20..a4a2a68  madhu-projects -> madhu-projects
```

**Step 7: Decrypting Files**

On the client machine, clone the repository or execute `git pull`.

```
madhu@myclient:~/madhu-github-testing$ git pull
remote: Enumerating objects: 9, done.
remote: Counting objects: 100% (9/9), done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 8 (delta 1), reused 8 (delta 1), pack-reused 0
Unpacking objects: 100% (8/8), done.
From https://github.com/madhu-reddy/shell-scripts
   ce73f20..a4a2a68  madhu-projects -> origin/madhu-projects
Updating ce73f20..a4a2a68
Fast-forward
 .git-crypt/.gitattributes                                              |   4 ++++
 .git-crypt/keys/default/0/0319FE440F58CA13A132AA77388C7E249E62F31A.gpg | Bin 0 -> 469 bytes
 2 files changed, 4 insertions(+)
 create mode 100644 .git-crypt/.gitattributes
 create mode 100644 .git-crypt/keys/default/0/0319FE440F58CA13A132AA77388C7E249E62F31A.gpg

```

Run `git-crypt unlock` and enter the passphrase used while generating the GPG key.

```
madhu@myclient:~/shell-scripts$ cat mysecretsfile.txt 
GITCRYPTXQq����S�▒�]\y�UwZ�-=�

madhu@myclient:~/shell-scripts$ git-crypt unlock
You need a passphrase to unlock the secret key for
user: "madhu kunta <madhu@mylearningsguru.com>"
2048-bit RSA key, ID 7A807071, created 2022-04-10 (main key ID 9E62F31A)

madhu@myclient:~/shell-scripts$ cat mysecretsfile.txt 
apmanorame

```

That's it, by following these steps, you can encrypt and decrypt files within a Git repository using `git-crypt` with GPG keys, ensuring secure handling of sensitive information.
