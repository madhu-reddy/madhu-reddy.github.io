---
layout: post
title: How to use the apt-get package management tool?
date: 2021-05-17
categories: ['Linux', 'Package Management']
---

**apt-get** is a command-line tool in the Ubuntu OS used for installing, removing, upgrading, and updating packages. It can also be employed to upgrade the entire operating system.

## 

1) Updating the repository List:

```
apt-get update
```

 

It's advisable to update the local source repository list before installing a package because the package might have received an upgrade in the primary package source repository on the internet.

Executing '**apt-get update**' fetches the updated package sources list locally to the server, stored in the '/var/lib/apt/lists' directory.

If '**apt-get update**' isn't performed before package installation, the server might retain an older version of the package despite an updated version being available online.

The source repositories are specified in the '**/etc/apt/sources.list**' file and the '**/etc/apt/source.list.d**' directory.

**Note:** Running '**apt-get update**' doesn't update any existing installed packages, making it safe to run at any time.

 

## 

2) Installing a Package

```
apt-get install packagename
```

The '**install**' command reads the most recent repository list update and proceeds to download the package from the specified URL.

Upon download completion, '**apt-get install**' unpacks and installs the software onto the system.

Should the software require additional packages for seamless functionality, '**apt-get**' will automatically download these dependencies and proceed to install them.

 

 

**3) Upgrading a Package** 
```
apt-get upgrade
```

As previously mentioned, '**apt-get update**' refreshes the local source package repository list, providing the system with information about the availability of the latest package versions.

On the other hand, '**apt-get upgrade**' downloads and installs the available upgrades for installed packages.

![]({{site.baseurl}}/assets/img/2021/05/apt-get-upgrade-1.png)

The image displays that approximately 103 packages are awaiting an upgrade.

 

 

## 

4) Cleaning up downloaded packages with the "apt-get clean" command

```
apt-get clean
```

All the packages that are downloaded (when we do apt-get install package-name or apt-get upgrade), will be stored in a directory location "/var/cache/apt/archives".

### Before running "apt-get clean"

![]({{site.baseurl}}/assets/img/2021/05/before-running-clean.png)

## After running "apt-get clean"

![]({{site.baseurl}}/assets/img/2021/05/after-apt-get-clean.png)

 

 

 

## 

5) Cleaning up downloaded packages which are obsolete with "apt-get autoclean" command

```
apt-get autoclean
```

While '**apt-get clean**' removes all downloaded packages, '**apt-get autoclean**' specifically targets downloaded packages that are no longer maintained and lack newer versions.

Obsolete packages refer to downloaded packages that are no longer offered by any APT repositories listed in the '**/etc/apt/source.lists**' file or the files within the '**/etc/apt/source.list.d**' directory.

 

 

## 6) Remove dependencies that are not being used anymore

```
apt-get autoremove
```

When we install a package like '**apache2**' using '**apt-get install**,' it often brings along additional dependent packages required for its functionality, such as '**apache2-bin**,' '**apache2-data**,' '**apache2-utils**,' '**libapr1**,' '**libaprutil1**,' '**libaprutil1-dbd-sqlite3**,' and '**libaprutil1-ldap**.'

Subsequently, when we decide to remove the '**apache2**' package using commands like '**apt-get purge apache2**' or '**apt-get remove apache2**' in the future, these commands solely uninstall '**apache2**' without removing the dependent packages that were initially installed alongside it but are no longer necessary.

To remove these unnecessary dependent packages, we can use '**apt-get autoremove**.' This command effectively clears out the dependency packages that are no longer required after the removal of the main package ('**apache2**' in this case).

## apt-get purge package and then run apt-get autoremove

![]({{site.baseurl}}/assets/img/2021/05/autoremove.png)

 

 

## 7) Remove Packages (using apt-get purge or apt-get remove?)

When you execute '**apt-get purge package**,' it not only removes the specified package but also eliminates all associated configuration files related to that package.

However, using '**apt-get remove package**' solely removes the package itself, leaving behind all configuration files associated with that package intact.

 

 

# 

8) apt-get dist-upgrade?

Using '**apt-get dist-upgrade**' encompasses all the functionalities of '**apt-get upgrade**.' Additionally, it manages the installation or removal of any additional dependent packages required for newer versions of existing packages.

In contrast, '**apt-get upgrade**' might display a message stating '**The following packages have been kept back**.' This occurs when the newer version of these packages relies on a dependent package that isn't present in the system. '**apt-get upgrade**' strictly focuses on upgrading existing packages and does not introduce or remove additional packages into the system.

In scenarios where the installation of additional dependent packages for newer versions is preferred, '**apt-get dist-upgrade**' serves as a beneficial option.
