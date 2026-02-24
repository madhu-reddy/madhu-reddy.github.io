---
layout: post
title: What is the use of the X server?
date: 2022-08-30
categories: ['Sysadmin', 'General']
---

In a Linux server OS, such as the Ubuntu server version, we can utilize the '**X server**' to execute GUI-based applications.

Are you attempting to run a GUI application—such as '**xclock**' or '**Firefox**'—on a remote Linux system but encountering display-related issues?

![]({{site.baseurl}}/assets/img/2022/08/image-7.png)

Now, this is because there is no "**X server**" running on the remote Linux system.

In this article, we'll explore the steps to resolve this problem.
Utilizing the '**X server**' enables the display of graphical applications such as Firefox or the clock."

**To check if "X server" is running** 
**ps -e | grep X **     # checks if the X11 or X server is currently running on your system.

![]({{site.baseurl}}/assets/img/2022/08/image-1.png)

If your remote Linux server already has an '**X server**' running, running GUI-based applications like '**firefox**' or '**xclock**' is straightforward without any issues. However, if the remote Linux server doesn't have an '**X server**' active, '**X11 forwarding**' can help resolve this problem.

# Steps to perform X11 Forwarding from a Linux desktop-based operating system and execute GUI-based applications on a remote Linux server

In a Linux desktop environment, the '**X server**' is typically installed and active by default. To enable '**X11 Forwarding**' on any Linux desktop OS, simply execute the command below, using the '**-X**' option."

```
ssh -X user@remotelinuxserver-name
```

2) This single command connects you to a remote Linux server lacking an '**X server**,' allowing you to execute GUI-based applications effortlessly.

**Steps to perform X11 Forwarding from a Windows desktop-based operating system and execute GUI-based applications on a remote Linux server** 
In a Windows environment, the '**X server**' isn't pre-installed, requiring the installation and launch of an application named '**Xming**' to serve as the '**X server**' for Windows.

1) Begin by installing and running '**Xming**,' the designated '**X server**' application for Microsoft Windows.

2) Upon launching '**Xming**,' access the '**xlaunch**' application to configure display settings, dictating how '**Xming**' should exhibit GUI programs.

![]({{site.baseurl}}/assets/img/2022/08/image-2.png)

3) Now at this stage, using "**putty**" you are ready to connect to the remote Linux server and start running the GUI-dependent programs.
**NOTE:** Don't forget to enable  "**X11 forwarding**" in "**putty**".

![image]({{site.baseurl}}/assets/img/2022/08/Nxxl_xpVCNxwtQFNAerbdscRU7pw2A2T7yU9IYA310TOK2gYlKsY8qE3dpv-cBCv6wNq4W7WUykF9OWZsmso3bnaYYh_g582GcDW8brtC8-1WkLX3_pWMX4BUw2jRfvMLggUH8qAQOAwq9DRGkXVsg)

![image]({{site.baseurl}}/assets/img/2022/08/aRag9PYSkhIW5-hjdGh4mnfNNslsA8HLLkS78dqEhj-bGhI3LJRZNZkMbybmQkiGGrV9y5jy2ZiPO9NAKW1R7wh8YBi46zDTFO7gs-QAxWabCnn91BW40fjoidr1REbo1DBVeLXPZHVtMkmigDmwrQ)

4) That's it! With this command, you've successfully connected to the remote Linux server, even though it doesn't have an 'X server' running, enabling you to run GUI-based applications seamlessly.

# Now unable to run GUI-based programs on the remote Linux server after using sudo or su -?

If you encounter the following error while attempting to run GUI-based applications on the remote Linux server after executing 'sudo' or 'su -'

![]({{site.baseurl}}/assets/img/2022/08/image-8.png)

The '**X11 authentication**' is typically cookie-based and generated upon the user's initial login to the server via SSH or Putty. 
However, when you switch users using 'su -' or 'sudo,' these cookies are not automatically transferred to the new user ('root,' for example). Consequently, this leads to the '`X11 connection rejected because of wrong authentication`' error.

To resolve this, 

1) You can execute the command '**`xauth list`**' to retrieve the cookie value associated with the initial user used to log in via SSH or Putty.

![]({{site.baseurl}}/assets/img/2022/08/image-5.png)

2) Next, utilize the '**xauth add**' command to incorporate this cookie for the '**root**' user (or any other user to which you've switched). 
**Example** xauth add madhu-server/unix:10  MIT-MAGIC-COOKIE-1  f95a2f111fb4ae17435ccf3b245e9770

![]({{site.baseurl}}/assets/img/2022/08/image-6.png)

3) At this stage, you should be able to execute GUI-based applications even after transitioning to any desired user via 'sudo' or 'su -'.
