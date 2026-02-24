---
layout: post
title: Python2.6 dependency for yum in CentOS 6, RHEL 6?
date: 2021-04-02
categories: ['Linux', 'Administration']
---

CentOS 6 ships with Python 2.6.6 and relies on that specific version. Take caution not to replace it, as 'yum' depends on Python2.6. It's best to compile and install a newer version of Python separately if you need access to an updated version, keeping it installed alongside the system version.

Here are the necessary steps to install Python 2.7.6:

### **Install development tools** 
To compile Python, you must first install the development tools.

```
yum groupinstall “Development tools”
```

Additionally, installing a few extra libraries before compiling Python is crucial; otherwise, you might encounter issues when installing various packages later.

```
yum install zlib-devel
yum install bzip2-devel
yum install openssl-devel
yum install ncurses-devel
yum install sqlite-devel
```

### **Download - compile - install **

```

1) cd /opt 

2) wget –no-check-certificate https://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz

3) tar xf Python-2.7.6.tar.xz

4) cd Python-2.7.6

5) ./configure –prefix=/usr/local

6) make && make altinstall
```

It's important to use '**altinstall**' instead of '**install**' to prevent ending up with two different versions of Python in the filesystem, both named python.

Upon executing the commands above, your newly installed Python 2.7.6 interpreter will be accessible at **/usr/local/bin/python2.7**, while the system version of Python 2.6.6 will remain available at **/usr/bin/python** and **/usr/bin/python2.6**.

#### To confirm the path of 2.7 and also 2.6

```
root@lg1:/opt/Python-2.7.6 ] ls -ltr /usr/bin/python*

lrwxrwxrwx 1 root root    6 Nov 16  2002 /usr/bin/python2 -> python
-rwxr-xr-x 1 root root 1418 Jul 10  2013 /usr/bin/python2.6-config
-rwxr-xr-x 2 root root 4864 Jul 10  2013 /usr/bin/python2.6
-rwxr-xr-x 2 root root 4864 Jul 10  2013 /usr/bin/python
lrwxrwxrwx 1 root root   16 Oct 24 15:39 /usr/bin/python-config -> python2.6-config
```

```
root@lg1:/opt/Python-2.7.6 ] ls -ltr /usr/local/bin/python*

-rwxr-xr-x 1 root root 6214533 Mar 19 22:46 /usr/local/bin/python2.7
-rwxr-xr-x 1 root root    1674 Mar 19 22:46 /usr/local/bin/python2.7-config
```

When using the '**which python**' command, the kernel will display the version of the first available Python executable based on the $PATH variable.

```
root@openstack h2o]# echo $PATH
/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
```

In this case, '**which python**' will display Python 2.7 from /usr/local/sbin, assuming it is listed first in the $PATH.

The key point is to exercise caution when dealing with Python 2.6 in CentOS 6 and RHEL 6 versions.
