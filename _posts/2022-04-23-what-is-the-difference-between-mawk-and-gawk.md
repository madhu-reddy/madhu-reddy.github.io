---
layout: post
title: "What is the difference between mawk and gawk?"
date: 2022-04-23
categories: ['Linux', 'Administration']
---

AWK, a versatile text-processing tool, comes in different versions, such as **mawk**, **gawk**, and **nawk**. Let's specifically explore the distinctions between **mawk** and **gawk**.

## 

**mawk:**

**[mawk **is an older version of AWK that lacks full POSIX compliance. Depending on the specific version, **mawk** may not support certain features such as special character classes like **[[:digit:]]**, **[[:alnum:]]**, **[[:lower:]],** **[[:space:]]**, and some Extended Regular Expression (ERE) patterns like curly braces {}.

**NOTE:**
In the mawk version 1.3.3 (Nov 1996), the tool does not support special character classes. However, in the mawk version 1.3.4 (20200120), I observed that special character classes are supported.

**Example1**
Even with **mawk** version 1.3.4, the below result remains empty, indicating that **mawk** does not support the POSIX ERE curly braces pattern.
**echo "tot" | mawk '/to{1}t/{print $0}'**  

**Example2**

Even when using **mawk** version 1.3.3, the result remains empty, as this version of mawk does not support special character classes.
**echo "Madhu" | mawk '/[[:lower:]]/ {print}'**

However, in the screenshot below using mawk 1.3.4, we notice a different result, indicating that special character classes appear to be supported in this version of mawk.

**echo "Madhu" | mawk '/[[:lower:]]/ {print}'**

.

## **GAWK**

The command below uses "[gawk", which supports curly braces, resulting in the expected output.
**echo "tot" | gawk '/to{1}t/{print $0}'  ** 

Once more, the command utilizes 'gawk,' enabling support for special character classes.
**echo "Madhu" | gawk '/[[:lower:]]/ {print}'**

**NOTE:**

An important point to note is that in certain Linux distributions, the '**awk**' command is a symlink to '**mawk**.' Consequently, when '**awk**' points to '**mawk**,' it does not support curly braces. 
Additionally, depending on the version of '**mawk**,' '**awk**' may or may not support special character classes.
