---
layout: post
title: About the POSIX-compliant shell and is Bash shell POSIX-compliant?
date: 2021-11-26
categories: ['Linux', 'Bash']
---

POSIX, short for "Portable Operating System Interface," is a family of standards developed to ensure compatibility between various operating systems. This compatibility extends to user interfaces, allowing users to interact with the operating system kernel through a consistent shell environment.

A shell is nothing but a user interface through which a user can interact with the OS Kernel.

## 
About POSIX-compliant shells**: **

By utilizing fully POSIX-compliant shells, software developers can create applications that operate seamlessly across different operating systems, provided the OS supports POSIX-compliant shells. 
For instance, a shell script written in the "dash" shell to retrieve resource utilization information on an Ubuntu Linux server can be executed on a macOS server using the "dash" shell or any other POSIX-compliant shell installed on macOS or any other OS.
                                                                                                                                               

In most UNIX-based operating systems, shell scripts typically begin with a shebang line, either **#!/bin/bash** or **#!/bin/sh**. 
The "sh" command, also known as the "Bourne shell," is often implemented by programs like "bash" or "dash" or other POSIX-compliant shells.

 For example, in Ubuntu 20.04, the "sh" command is symlinked to the POSIX-compliant shell "dash".

```
root@madhu-Inspiron-5567:~# ls -ltrh /bin/sh
lrwxrwxrwx 1 root root 4 Jan  3  2021 /bin/sh -> dash

```

                                                                                                              .

## **Now whether "bash" POSIX-compliant?**

Yes, the "bash" shell is fully POSIX compliant, but it also includes additional features and extensions that are not part of the POSIX standard.
[https://betterprogramming.pub/24-bashism-to-avoid-for-posix-compliant-shell-scripts-8e7c09e0f49a

For many years, "/bin/sh" was linked to "/bin/bash". However, as new features and extensions were incorporated into "bash," some of which contradict the POSIX standards, this linkage was discontinued

To verify if your shell script complies with POSIX standards, you can utilize the "spellcheck" application with the following option (**-s dash**) as demonstrated below:

```
shellcheck -s dash shell-script-name.sh
```

**Example:**
In the following example bash script, we utilize double square brackets "[[" which are not defined in POSIX but have been introduced as an extension to the single square brackets defined in POSIX within the "bash" shell.

```
#name:  mytest.sh

#!/bin/bash
if [[ -z $1 ]]
then
    echo "enter only numbers"
else
   echo "entered value other than numbers"
exit 1
fi

```

Upon observation of the output below, it becomes evident that when attempting to analyze the aforementioned bash script using the "dash" shell (which is fully POSIX compatible), an error is encountered.

![]({{site.baseurl}}/assets/img/2021/11/image-14.png)

However, when the same bash script is analyzed using the "bash" shell, no errors occur as double square brackets are supported within the "bash" shell.

![]({{site.baseurl}}/assets/img/2021/11/image-16.png)

**Few additional features in "bash" that are not present in POSIX:**

1) Using Command-line completion in "bash", a command can be completed faster just by typing a few words of the command and then using <TAB> to complete the command.

2) Scrolling through history can be done using the <UP> arrow.
