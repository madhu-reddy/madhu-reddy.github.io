---
layout: post
title: Resolving Unicode Encoding and Decoding Errors in Python?
date: 2021-12-08
categories: ['Python', 'General']
---

## **UnicodeEncodeError: 'ascii' codec can't encode character:**

**UnicodeEncodeError **typically occurs when you attempt to encode a Unicode string using the "ASCII" encoding method instead of using a UTF encoding method.

**Example in Python3:**

```
madhu@madhu-Inspiron-5567:~$** cat unicode-encode-error.py **
s = "s3rr2Ä"
print(s)
print(type(s))
e1 = s.encode("**ascii**")  # **Should use "utf-8" instead of "ascii", as we are dealing with a non ascii character in the string**.
print(e1)
print(type(e1))
```

**Output:**

```
madhu@madhu-Inspiron-5567:~$ **python unicode-encode-error.py** 
s3rr2Ä
<class 'str'>
Traceback (most recent call last):
  File "unicode-encode-error.py", line 4, in <module>
    e1 = s.encode("ascii")
**UnicodeEncodeError: 'ascii' codec can't encode character '\xc4' in position 5: ordinal not in range(128)**

```

**UnicodeDecodeError: 'ascii' codec can't decode byte**

**UnicodeDecodeError **typically arises when you attempt to decode a byte string, created by encoding a Unicode string containing at least one non-ASCII character using a UTF encoding method, using the "ASCII" decoding method instead of using the corresponding UTF decoding method.

**Example in Python3:**

```
madhu@madhu-Inspiron-5567:~$ **cat unicode-decode-error.py** 
s = b"s3rr2\xc3\x84"   # **Actual character string related to this byte string is an Unicode string (s3rr2Ä)**
print(s)
print(type(s))
e1 = s.decode("**ascii**")  # **In this case, should use "utf-8" instead of "ascii", otherwise  we get UnicodeDecodeError**.
print(e1)
print(type(e1))

```

**Output:**

```
madhu@madhu-Inspiron-5567:~$ **python unicode-decode-error.py **
b's3rr2\xc3\x84'
<class 'bytes'>
Traceback (most recent call last):
  File "unicode-decode-error.py", line 4, in <module>
    e1 = s.decode("ascii")
**UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 5: ordinal not in range(128)**

```
