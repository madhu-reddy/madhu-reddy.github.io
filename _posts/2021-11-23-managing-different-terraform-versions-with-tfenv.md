---
layout: post
title: Managing different Terraform versions with tfenv?
date: 2021-11-23
categories: ['DevOps', 'Terraform']
---

`tfenv` simplifies the installation and management of various Terraform versions on a single host. With the `tfenv use terraform-version` command, you can effortlessly switch between different Terraform versions based on your requirements.

## Installing tfenv and managing Terraform versions in Linux

### 1) Clone the GitHub repository
```bash
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
```

### 2) Add tfenv to PATH

Append the following line to `~/.bash_profile` or `/etc/profile`:
```bash
export PATH="$HOME/.tfenv/bin:$PATH"
```

![]({{site.baseurl}}/assets/img/2021/11/image-8.png)

### 3) Source the profile
```bash
source ~/.bash_profile
```

## Using tfenv to install and manage Terraform versions

### 1) Install a specific version
```bash
tfenv install 0.12.30
```

![]({{site.baseurl}}/assets/img/2021/11/image-9.png)

### 2) List all installed Terraform versions
```bash
tfenv list
```

![]({{site.baseurl}}/assets/img/2021/11/image-10.png)

### 3) List all installable Terraform versions
```bash
tfenv list-remote
```

### 4) Use a specific Terraform version
```bash
tfenv use 0.12.30
```

![]({{site.baseurl}}/assets/img/2021/11/image-11.png)

### 5) Uninstall a specific Terraform version
```bash
tfenv uninstall 0.11.14
```

![]({{site.baseurl}}/assets/img/2021/11/image-12.png)

## NOTE

If you ran `tfenv use 0.11.15` but the terraform version is **not** showing as `0.11.15`, especially if you are running the command from inside a directory that has a `.tf` file (e.g. `version.tf`) with a terraform version constraint:

![]({{site.baseurl}}/assets/img/2021/11/image-3.png)

The solution is to reinstall `tfenv` again.
