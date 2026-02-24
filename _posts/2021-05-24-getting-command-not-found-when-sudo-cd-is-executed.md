---
layout: post
title: "Getting "command not found" when "Sudo cd" is executed?"
date: 2021-05-24
categories: ['Linux', 'Bash']
---

```
`madhu@madhu-Inspiron-5567:~$ sudo cd /root
[sudo] password for madhu: 
**sudo: cd: command not found**
`
```

If you encountered the mentioned error after running `sudo` with the "cd" command, it occurred because:

The "cd" command is exclusively a shell builtin, meaning it's directly integrated within the shell itself. `sudo` operates solely on executable programs and does not function with shell builtins.

 

 

## But why does sudo work with the echo command (although echo is also a shell built-in)?

There's a difference with the "echo" command, even though it's also a shell builtin. The reason `sudo` works with "echo" is that, despite being a builtin, "echo" is also an executable file, allowing `sudo` to function with the "echo" command.

 

 

- 

We can determine a command's type using the "type" command. By employing "type -a," we obtain comprehensive information about a command's nature, identifying whether it's an "alias," "file," "function," "shell builtin," or "keyword."

- 

When utilizing "type -a," it provides the complete file path if the command type is identified as a "file."
