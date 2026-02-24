---
layout: post
title: "How to reset a forgotten MySQL root password?"
date: 2021-11-19
categories: ['Database', 'MySQL']
---

Did you forget your MySQL root password and want to reset the password?

## 
[Then let's look at a way to reset your MySQL root password.

**1) Stop the MySQL server**

```
`service mysql stop (for "**init**" systems)
systemctl stop mysql.service (for "**systemd**" systems)`
```

**2) Start the MySQL server with the "--skip-grant-tables" option**

```
`mysqld_safe --skip-grant-tables --skip-networking &  
`
```

**W.R.T to this above command, let me explain how it works**

"mysqld_safe" is a command to start a MySQL server.

**"--skip-grant-tables"** is an option in MySQL that bypasses the grant table checks for connections and queries. This means that anyone can connect to the database without a password, bypassing the usual authentication and authorization checks.

Since the server runs without grants, it is possible for users from other networks to connect to the MySQL server, so "--skip-networking" is an option, which is used to allow connection only from the localhost & skip remote MySQL connections from any of the network hosts.   

"&" is to tell to start the MySQL service in the background.                                                                                       

**Now, what are grant tables?**

Grant tables, located within the "MySQL" system database, play a pivotal role in the MySQL server. They manage authentication, enabling users to log in and execute diverse operations on the databases and tables within the MySQL server.

**List of grant tables:**

- 

mysql.user

- 

mysql.db

- 

mysql.tables_priv

- 

mysql.columns_priv

- 

mysql.procs_priv

- 

mysql.proxies_priv

**3) log in to MySQL passwordless with the following command**

```
`mysql -u root`
```

**4) Update the MySQL "root" user password & exit MySQL prompt**

```
`UPDATE mysql.user SET Password=PASSWORD('new-password') WHERE User='root';
exit;`
```

Please note, in newer MySQL versions (8 and above), if you encounter the following error while attempting to update the "**root**" password using the aforementioned "UPDATE" command:

`ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '( 'Mypass') where user='root'' at line 1`

Then the following steps can be performed to reset the password,

---> The **first** command linked to "UPDATE" sets the root password to "null". Execute this only if you encounter the "`ERROR 1396 (HY000): Operation ALTER USER failed for 'root'@'localhost'`" when running the below mentioned **third** "**ALTER**" command to reset the "root" password.

---> The **second** command "flush privileges", is used to load the grant tables.

---> The **third** command, associated with "**ALTER**" is used to reset the "root" user password. 

```
`mysql> UPDATE mysql.user SET authentication_string=null WHERE User='root';
mysql> flush privileges;
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'pass123'; `
```

**5)Stop the MySQL server**

```
mysqladmin shutdown (if this command does not work, use the command "killall mysqld")
```

**6)Start the MySQL server**

```
service mysql start (for "**init**" systems)
systemctl start mysql.service (for "**systemd**" systems)
```
