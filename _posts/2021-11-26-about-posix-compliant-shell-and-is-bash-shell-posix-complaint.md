---
layout: post
title: About the POSIX-compliant shell and is Bash shell POSIX-compliant?
date: 2021-11-26
categories: ['Linux', 'Bash']
---

POSIX, short for "Portable Operating System Interface," is a family of standards developed to ensure compatibility between various operating systems. This compatibility extends to user interfaces, allowing users to interact with the OS kernel through a consistent shell environment. A shell is simply a user interface through which a user can interact with the OS kernel.

---

## About POSIX-compliant Shells

By utilizing fully POSIX-compliant shells, software developers can create applications that operate seamlessly across different operating systems, provided the OS supports POSIX-compliant shells.

For example, a shell script written in the `dash` shell to retrieve resource utilization on an Ubuntu Linux server can also be executed on a macOS server using `dash` or any other POSIX-compliant shell.

In most UNIX-based operating systems, shell scripts typically begin with a shebang line, either `#!/bin/bash` or `#!/bin/sh`. The `sh` command, also known as the "Bourne shell," is often implemented by programs like `bash`, `dash`, or other POSIX-compliant shells.

For example, in Ubuntu 20.04, the `sh` command is symlinked to the POSIX-compliant shell `dash`:

```bash
root@madhu-Inspiron-5567:~# ls -ltrh /bin/sh
lrwxrwxrwx 1 root root 4 Jan  3  2021 /bin/sh -> dash
```

---

## Is Bash POSIX-compliant?

Yes, the `bash` shell is fully POSIX-compliant, but it also includes additional features and extensions that are not part of the POSIX standard. For more details, see [this article on bashisms to avoid for POSIX-compliant shell scripts](https://betterprogramming.pub/24-bashism-to-avoid-for-posix-compliant-shell-scripts-8e7c09e0f49a).

For many years, `/bin/sh` was linked to `/bin/bash`. However, as new features and extensions were added to `bash` — some of which contradict POSIX standards — this linkage was discontinued.

To verify if your shell script complies with POSIX standards, use `shellcheck` with the `-s dash` option:

```bash
shellcheck -s dash shell-script-name.sh
```

### Example

The following bash script uses double square brackets `[[`, which are not defined in POSIX but were introduced as a `bash` extension:

```bash
#name: mytest.sh
#!/bin/bash
if [[ -z $1 ]]
then
    echo "enter only numbers"
else
   echo "entered value other than numbers"
exit 1
fi
```

When analyzing this script using the `dash` shell (which is fully POSIX-compliant), an error is encountered:

![]({{site.baseurl}}/assets/img/2021/11/image-14.png)

However, when the same script is analyzed using the `bash` shell, no errors occur since double square brackets are supported in `bash`:

![]({{site.baseurl}}/assets/img/2021/11/image-16.png)

---

## Additional Bash Features Not Present in POSIX

1. **Command-line completion** — a command can be completed faster by typing a few characters and pressing `<TAB>`.
2. **History scrolling** — previous commands can be recalled using the `<UP>` arrow key.
