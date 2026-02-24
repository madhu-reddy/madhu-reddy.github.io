---
layout: post
title: what is git-crypt and the need for it?
date: 2022-04-21
categories: ['DevOps', 'Git']
---

`git-crypt` is a tool that secures sensitive data within GitHub repositories by encrypting files. Here's a step-by-step guide on how to utilize `git-crypt` for encrypting files:

**Step-by-Step Procedure:**

**Step 1: Creation and Initialization**

Create the file you intend to encrypt within your Git repository and add the relevant sensitive information.

```
madhu@madhu-Inspiron-5567:~/madhu-github-testing$ cat mysecretsfile.txt 
MysecretPassword
MysecretPassword1

```

 Run the command `git-crypt init` to generate the encryption key and configure the current Git repository to use `git-crypt`.

```
madhu@madhu-Inspiron-5567:~/madhu-github-testing$ git-crypt init
Generating key...
```

**Step 2: Exporting `git-crypt` Symmetric K****ey**

Export the `git-crypt` symmetric key using the command `git-crypt export-key`

```
madhu@madhu-Inspiron-5567:~/madhu-github-testing$ git-crypt export-key /home/user/git-crypt-symmetric

madhu@madhu-Inspiron-5567:~/madhu-github-testing$ ls -ltrh /home/madhu/git-crypt-symmetric 
-rw------- 1 root root 148 Apr 10 23:23 /home/madhu/git-crypt-symmetric

```

**NOTE:** `git-crypt` symmetric key is crucial for collaborators who need access to the encrypted file within the repository.

**Step 3: Specifying Files for Encryption**

Indicate the file to encrypt within the `.gitattributes` file using `git-crypt`.

```
madhu@madhu-Inspiron-5567:~/madhu-github-testing$ cat .gitattributes 
mysecretsfile.txt filter=git-crypt diff=git-crypt

```

**Step 4: Git Operations**

Perform Git operations like `git add`, `git commit`, and `git push` to push the updated code to GitHub.

```
madhu@madhu-Inspiron-5567:~/madhu-github-testing$ git add .

madhu@madhu-Inspiron-5567:~/madhu-github-testing$ git commit -m "testing secrets"
[main 7bbe54c] testing secrets
 2 files changed, 1 insertion(+)
 create mode 100644 .gitattributes
 create mode 100644 mysecretsfile.txt

madhu@madhu-Inspiron-5567:~/madhu-github-testing$ git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 439 bytes | 439.00 KiB/s, done.
Total 4 (delta 0), reused 0 (delta 0)

```

**Step 5: Validation on GitHub**

Verify on GitHub that the encrypted file (`mysecretsfile.txt`) is no longer readable.

![]({{site.baseurl}}/assets/img/2022/04/image-1.png)

You can see that the git-crypt has successfully encrypted the "mysecretsfile.txt" file contents and the contents of the file are not visible anymore.

.

**Using the Same `git-crypt` Symmetric Key for Other Repositories**

Unlock encrypted files in other repositories using the same `git-crypt` symmetric key via `git-crypt unlock`.

```
git-crypt unlock ../git-crypt-key
```

.

**Other collaborators wants to access the GitHub Repo?**

Collaborators who need access to the encrypted file can use either of the following two methods:

1) Sharing the `git-crypt` symmetric key with collaborators directly.

2) Utilizing GPG keys with `git-crypt` to grant access to encrypted files. A separate guide will cover this method.
