---
layout: post
title: Managing different Terraform versions with tfenv?
date: 2021-11-23
categories: ['DevOps', 'Terraform']
---

**`tfenv`** simplifies the installation and management of various Terraform versions on a single host. With '**`tfenv use terraform-version`**' command, you can effortlessly switch between different Terraform versions based on your requirements.

## **Installing "tfenv" and using it to manage Terraform versions in Linux:**

1) Clone the GitHub repository ([https://github.com/tfutils/tfenv) to your preferred directory. Here's an example of cloning it into the root user's home directory
$ git clone https://github.com/tfutils/tfenv.git ~/.tfenv

2) Append the following line to either "root/.bash_profile" or "/etc/profile" file
export PATH="$HOME/.tfenv/bin:$PATH"

![]({{site.baseurl}}/assets/img/2021/11/image-8.png)

3) source /root/.bash_profile

                                                                                                                                                       .

                                                                                                                                                                                               .

**Using "tfenv" to install/uninstall and manage different Terraform versions:**

**1) Install a specific version of Terraform** Syntax: tfenv install [version]
Example: tfenv install 0.12.30

![]({{site.baseurl}}/assets/img/2021/11/image-9.png)

**2) List all Terraform versions installed** 
Syntax: tfenv list

![]({{site.baseurl}}/assets/img/2021/11/image-10.png)

**3) List all installable Terraform versions** 
Syntax: tfenv list-remote

**4) Use a specific Terraform version** 
Syntax: tfenv use [version]
Example:  tfenv use 0.12.30

![]({{site.baseurl}}/assets/img/2021/11/image-11.png)

**5) Uninstall a specific Terraform version** 
Syntax: tfenv uninstall [version]
Example: tfenv uninstall 0.11.14

![]({{site.baseurl}}/assets/img/2021/11/image-12.png)

**NOTE:**
In case, if you have encountered a situation where you ran the command for example, "**tfenv use 0.11.15**", but the terraform version is **NOT** showing up as "**0.11.15**", especially if you are running the "**tfenv use**" command from inside a directory that have a .tf file (**Ex: version.tf**) with the terraform constraint is included in it as shown below,

![]({{site.baseurl}}/assets/img/2021/11/image-3.png)

The **solution** for this is to just reinstall "**tfenv**" again and it worked for me.
