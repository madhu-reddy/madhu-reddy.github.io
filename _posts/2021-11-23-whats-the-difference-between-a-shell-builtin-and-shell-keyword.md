---
layout: post
title: "Whats the difference between a shell builtin and shell keyword?"
date: 2021-11-23
categories: ['Linux', 'Bash']
---

Let's explore the differences between a shell built-in and a shell keyword.

**Shell Built-in **

A built-in command is hardcoded into the shell, executing faster than external commands since there's no need to load an external program. When compared to other commands that aren't built-ins, a shell built-in executes more efficiently.

**To list all Shell Built-ins:**

```
compgen -b
```

## 

**Shell Keyword **

Similar to a built-in, a keyword is hardcoded into the shell. However, unlike a built-in command, a keyword isn't a command but a reserved word with a specific meaning in the shell. Using a keyword as a variable within the shell isn't permissible due to its special reserved status.

**To list all Shell Keywords:**

```
compgen -k
```

                                                                                                                                                                                                    .

**[Example for Shell Built-in and Keyword**

Let's delve into the distinction between the shell built-in "single square bracket [" and the shell keyword "double square brackets [[ ]]".

**# Using single square bracket "["****   (****equivalent to "test" command)**

```
#!/bin/bash -e

string="my learnings guru"
if [ "my learnings guru" = $string ]
then
echo "strings are equal"
else
echo "strings are not equal"
fi

```

In the above example, we are using single square bracket "[", which is a shell builtin and thus the shell treats this single square bracket "[" as a command with the following arguments
1) my learnings guru
2) = 
3) my
4) learnings
5)guru
6) ]     

The "**]**" denoting the end of the test condition, serves as the last argument for "**[**".

**Unquoted variable usage** within the if statement causes the **$string **variable to split into three separate strings, leading the string comparison operators (=) to throw an error (**[: too many arguments**). This error results from receiving more than one string for comparison on the right-hand side.

![]({{site.baseurl}}/assets/img/2021/11/image-19.png)

The solution to this error involves quoting the **$string** variable within the if statement. By doing so, word splitting doesn't occur, keeping the **$string** variable value intact as a single string inside the if statement.

![]({{site.baseurl}}/assets/img/2021/11/image-20.png)

                                                                                                                                                                                               .

**# Using double square bracket** [[ ]]

Double square brackets [[ ]] serve as examples of bash shell keywords. 
These keywords hold a special significance within the shell. When the bash script is parsed, the shell identifies **[[** and seeks the corresponding closing **]]**. Any code enclosed within these brackets is handled uniquely as per its intended treatment.

It's unnecessary to quote **$string** within the double square brackets. The shell recognizes these constructions as keywords, treating their contents differently compared to regular variable usage.

![]({{site.baseurl}}/assets/img/2021/11/image-21.png)
