---
layout: post
title: About Bash Special variables and differences between $*, $*, $@, $@?
date: 2021-05-14
categories: ['Linux', 'Bash']
---

Bash scripts offer a range of special variables that prove incredibly valuable when handling arguments within a Bash script.

**$0 **
Prints filename of the script.

**$1, $2 ….. $n **
$1 is the first argument, $2 is second argument and so---on.

**$# **
Prints the total number of arguments passed to the script.

**$?** 
Prints the exit status of last command.

**$$**
Prints the process id of the current shell.

**$!**
Prints the process id of last background command.

**$* **
Prints all the arguments passed, with each argument as a separate entity.
Even if the arguments are passed with double quotes, each argument inside double quote is treated as a separate entity.

**“$*” **
Prints all the arguments passed, but as a single entity. (Irrespective of whether arguments are passed with double quotes or not).

**$@ **
Prints all the arguments passed, with each argument as a separate entity.
Even if the arguments are passed with double quotes, each argument inside double quote is treated as a separate entity.

**“$@”** 
This will print all the arguments, but with a condition,
If the arguments are double quoted, then the double quoted arguments are treated  as single entity and the remaining arguments as separate entities.

**positionalargstest.sh** 
```
#!/bin/bash

echo arguments passed: $1 $2 $3 $4
echo total arguments passed: $#
echo status of last above command: $? 
echo process id of current shell: $$
echo ""
echo ""
echo 'All about $*, "$*", $@, "$@" and differences between them'? 
echo ""

echo "Printing \$* without double quotes"
for argument in $*
do    
        echo argument is: $argument
done

echo ""

echo 'Printing "$*" with double quotes'
for argument in "$*"
do    
        echo argument is: $argument
done

echo ""

echo "Printing \$@ without double quotes"
for argument in $@
do    
        echo argument is: $argument
done

echo ""

echo 'Printing "$@" with double quotes'
for argument in "$@"
do
        echo argument is: $argument
done

```

## 

## **Arguments passed without any double quotes:**

![]({{site.baseurl}}/assets/img/2021/05/positional-args-2.png)

## **Only a few arguments passed with double quotes:**

![]({{site.baseurl}}/assets/img/2021/05/positional-args-1-1.png)
