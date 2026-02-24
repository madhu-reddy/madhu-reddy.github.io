---
layout: post
title: "About Encoding in Python and handling Unicode characters in Python2.x?"
date: 2021-12-08
categories: ['Python', 'General']
---

In Python 2.x, the default encoding method is ASCII, while in Python 3.x, the default encoding method is UTF-8.

In Python 2.x, strings are treated as ASCII by default, while in Python 3.x, strings are treated as Unicode by default.

**What is an encoding method?**

Encoding is the process of converting data into a format that a computer can understand. This format is typically binary, as computers store and process information in binary form. Different encoding methods exist, each with its own way of representing characters and symbols.

Each character is assigned a number, called a code point.
Code points are mapped to binary. Each code point is represented as a sequence of bits, which corresponds to a specific binary number. This binary representation allows computers to store and process characters in a standardized way.

There are different ways to map code points to binary. The most common encoding schemes are ASCII, UTF-8, UTF-16, and UTF-32. Each scheme uses a different number of bits to represent each code point.

- 

Ascii character set has 127 characters and thus has 128 code points, which are not enough for all human languages.

- 

The Unicode character set is huge and has about 1,114,112 possible code points.

- 

The first 128 code points of Unicode are ASCII -- backward compatible.

ASCII and UTF-8 are 2 popular encoding methods used in Python.

- 

UTF-8 encoding follows the Unicode character set.

- 

ASCII encoding follows the ASCII character set.

In **ASCII** and **UTF-8**, every code point from 0 to 127 is stored in a single byte.
In **UTF-8**, code points above 128 are stored using 2, 3, up to 6 bytes.

## Encoding and d**ealing with Unicode characters in Python2.x**

Since Python 2.x uses ASCII as the default encoding method, attempting to process a string containing non-ASCII characters (e.g., Unicode characters not part of the ASCII character set) will result in errors.

```
`SyntaxError: Non-ASCII character '\xef' in file pyss1.py on line 2, but no encoding declared; see http://www.python.org/peps/pep-0263.html for details`
```

To handle Unicode characters in Python 2.x, you need to explicitly specify the encoding method using a special comment at the beginning of the program file as shown below,

```
`# -*- coding: utf-8 -*-`
```

This comment informs the interpreter to use UTF-8 (or UTF-16 or UTF-32) for encoding Unicode characters. Additionally, Unicode strings in Python 2.x must be prefixed with the letter "u" (e.g., u"s3rr2�"). This tells the interpreter to treat the string as a Unicode type variable.

**Example:**

```
`#-*- coding: utf-8 -*- 
s = u"s3rr2�"
print(s)
print(type(s))
`
```

**Output:**

```
`root@my-server:~# python python2.x-unicode-test.py  
s3rr2�
<type 'unicode'>`
```

**NOTE:**
In case you want to learn about "UnicodeEncodeError" and "UnicodeDecodeError" related errors when dealing with Python and why they happen, click on this [blog post.
