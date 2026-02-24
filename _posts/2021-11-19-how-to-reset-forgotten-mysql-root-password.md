---
layout: post
title: How to reset a forgotten MySQL root password?
date: 2021-11-19
categories: ['Database', 'MySQL']
---

Did you forget your MySQL root password and want to reset the password?

### 1) Stop the MySQL server
```bash
service mysql stop        # for "init" systems
systemctl stop mysql.service  # for "systemd" systems
```

### 2) Start the MySQL server with the "--skip-grant-tables" option
```bash
mysqld_safe --skip-grant-tables --skip-networking &
```

**How this command works:**

- `mysqld_safe` is a command to start a MySQL server
- `--skip-grant-tables` bypasses the grant table checks — anyone can connect without a password
- `--skip-networking` allows connections only from localhost, blocking remote connections
- `&` starts the MySQL service in the background

**What are grant tables?**

Grant tables, located within the MySQL system database, manage authentication and authorization. They enable users to log in and execute operations on databases and tables.

**List of grant tables:**
- mysql.user
- mysql.db
- mysql.tables_priv
- mysql.columns_priv
- mysql.procs_priv
- mysql.proxies_priv

### 3) Log in to MySQL passwordless
```bash
mysql -u root
```

### 4) Update the MySQL root user password and exit
```bash
UPDATE mysql.user SET Password=PASSWORD('new-password') WHERE User='root';
exit;
```

For newer MySQL versions (8 and above), if you encounter this error:

`ERROR 1064 (42000): You have an error in your SQL syntax`

Run these commands instead:
```sql
mysql> UPDATE mysql.user SET authentication_string=null WHERE User='root';
mysql> flush privileges;
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'pass123';
```

- The **first** `UPDATE` command sets the root password to null. Run this only if you get `ERROR 1396 (HY000): Operation ALTER USER failed for 'root'@'localhost'`
- The **second** `flush privileges` loads the grant tables
- The **third** `ALTER USER` resets the root password

### 5) Stop the MySQL server
```bash
mysqladmin shutdown
# if above doesn't work:
killall mysqld
```

![]({{site.baseurl}}/assets/img/2021/11/image-13.png)

### 6) Start the MySQL server
```bash
service mysql start           # for "init" systems
systemctl start mysql.service  # for "systemd" systems
```
