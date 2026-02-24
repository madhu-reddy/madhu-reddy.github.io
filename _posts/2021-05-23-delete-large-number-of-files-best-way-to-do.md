---
layout: post
title: Delete a large number of files (best way to do this)?
date: 2021-05-23
categories: ['Linux', 'Administration']
---

Imagine having millions of small files within a directory. When attempting to delete files in the directory that match a specific pattern using the "rm -rf" command, or to remove all files without a matching pattern, you might encounter an error such as "**-su: /bin/rm: Argument list too long**," much to your disappointment.

Let's practically test this scenario and explore how to address this issue.

First, I'll create a directory and populate it with several thousand small files (approximately 300K). Then, we'll explore various methods to delete these files.

 

 

## **Creating 300K files:**

```
for num in $(seq 1 300000); do (touch file$num) && echo "test$num" > file$num; done
```

Now, let's initiate file deletion based on a pattern using the find command and also explore removing all files in a directory using rsync.

 

 

## 
1) Deleting the files matching a pattern using the **rm -rf** command:

![]({{site.baseurl}}/assets/img/2021/05/image-3.png)

As observed earlier, executing "**rm -rf file***" triggers an "**Argument list too long**" error. This occurs because in the bash shell, "**file***" encompasses any file commencing with the name "file" (including the file named "file" if present).

Consequently, all the matching files become command line arguments for the "**rm -rf**" command. Since there are approximately 300k files adhering to this pattern, they are passed as arguments to the "**rm -rf**" command.

However, the kernel imposes a limit on the command line argument size. If this limit is exceeded, it results in the "**Argument list too long**" error.

 

 

## 2) Using the find with -exec option

```
find . -type f -iname "file*" -exec rm -rf {} \;
```

The command successfully deleted all files starting with the specified pattern (**file***).

It took approximately 5 minutes and 23 seconds to complete the deletion of the 300 thousand matching files.

When using **-exec** with the find command, a new child process is spawned for each matched file. Consequently, the matched file is removed, followed by the creation of a new child process for the subsequent matched file. This process continues iteratively until all files are deleted.

![]({{site.baseurl}}/assets/img/2021/05/find-exec-rm.png)

 

 

## 3) Using the find with -delete option (preferred method)

```
find . -type f -name "file*" -delete
```

![]({{site.baseurl}}/assets/img/2021/05/find-delete-1.png)

Using this particular command, the deletion of all 300 thousand files was completed in merely 4.32 seconds.

The efficiency of this method is due to the utilization of the "**-delete"** option, which eliminates the necessity of spawning a child process for every matched file. However, it's essential to note that the** "-delete"** option might not be available in all versions of the find command. In cases where it's unavailable, the "**find**" command can be used in conjunction with the "**-exec**" option for similar functionality.

 

 

## 
**4) Using rsync with --delete option (preferred method)** 

```
rsync -a emptydir/ remove-files/ --delete
```

This `rsync` command performs synchronization between the contents of two directories (`emptydir/` and `remove-files/`).

- 
`emptydir/`: Source directory. This is where the synchronization process starts.

- `remove-files/`: Destination directory. This is the directory that will be synchronized with the source directory (`emptydir/`).

`--delete`: This option instructs `rsync` to delete files in the destination directory (`remove-files/`) if they don't exist in the source directory (`emptydir/`). It ensures that the destination directory mirrors the exact contents of the source directory after synchronization. Any files or directories in the destination that are not present in the source will be deleted.

In our scenario, the "`emptydir`" directory is empty leading to the removal of all files in the `"remove-files"` directory.

Remarkably, using rsync to delete 300k files required just under 3 seconds.

![]({{site.baseurl}}/assets/img/2021/05/rsync-empty-dir.png)
