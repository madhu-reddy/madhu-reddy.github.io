---
layout: post
title: Get to know about Symbolic links and Hard links?
date: 2021-11-06
categories: ['Linux', 'Administration']
---

#### **Symbolic links:**

-> A symbolic link (also known as a symlink) is a file that points to another file within the system.
-> These links are analogous to shortcuts in Windows.
-> Symlinks can be created for any regular files, special files, or directories.
-> A symlink can span across different filesystems.
-> The original file and the symlink file have distinct inode numbers.

**NOTE:** If you happen to delete the original file, the symlink file will no longer function and its existence will become meaningless.**

**A common use case where symlinks can be beneficial is when one of your filesystems (e.g., /) is approaching full capacity, and you want to relocate some files or directories to a larger filesystem (e.g., /mnt/data). However, directly moving the files or directories is not feasible because certain applications (e.g., Docker) are linked to specific locations under / (e.g., /var/lib/docker).

In this scenario, you have two options:

**Option 1:**
Directly copy the files and directories from the original location (/var/lib/docker) to the new location (/mnt/data/var-lib-docker) using the command:
`mv /var/lib/docker/* /mnt/data/var-lib-docker`

Once the files and directories have been copied, modify the application's configuration to point to the new location (/mnt/data/var-lib-docker) instead of the original location (/var/lib/docker).

**Option 2:**
Utilize symbolic links to maintain the application's existing location (/var/lib/docker) while actually storing the files and directories in the new location (/mnt/data/var-lib-docker).
1) `mv /var/lib/docker/* /mnt/data/var-lib-docker
`2) `ln -s /mnt/data/var-lib-docker /var/lib/docker`

Now when you run the below command, 
ls -ltrh /var/lib/ | grep docker

You should see the Symlink as follows,
lrwxrwxrwx  1 root       root         22 Nov  6 08:46 docker -> /mnt/data/var-lib-docker

**NOTE:**
For both options described above, it is crucial to temporarily halt any applications, such as the Docker application in our case, that are accessing or modifying the directory in question (/var/lib/docker).

# **Hard Links:**

-> Hard links can only be created for regular files, not directories or special files.
-> A hard link cannot exist across multiple filesystems.
-> The original file and the hard link file share the same inode number.

**NOTE:** Even if the original file is deleted, the hard link file remains functional, and its contents remain accessible.

**Syntax:**
**`ln actual_file_name hard_link_file_name`**
