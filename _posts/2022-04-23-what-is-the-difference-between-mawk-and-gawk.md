---
layout: post
title: What is the difference between mawk and gawk?
date: 2022-04-23
categories: ['Linux', 'Administration']
---

AWK is a versatile text-processing tool that comes in different versions, such as `mawk`, `gawk`, and `nawk`. Let's explore the distinctions between `mawk` and `gawk`.

---

## mawk

`mawk` is an older version of AWK that lacks full POSIX compliance. Depending on the specific version, `mawk` may not support certain features such as special character classes like `[[:digit:]]`, `[[:alnum:]]`, `[[:lower:]]`, `[[:space:]]`, and some Extended Regular Expression (ERE) patterns like curly braces `{}`.

> **Note:** In `mawk` version 1.3.3 (Nov 1996), special character classes are not supported. However, in `mawk` version 1.3.4 (20200120), special character classes are supported.

### Example 1: ERE curly braces

Even with `mawk` version 1.3.4, the result below is empty, indicating that `mawk` does not support the POSIX ERE curly braces pattern.

```bash
echo "tot" | mawk '/to{1}t/{print $0}'
```

![]({{site.baseurl}}/assets/img/2022/04/image-8.png)

### Example 2: Special character classes

With `mawk` version 1.3.3, the result is empty as this version does not support special character classes.

```bash
echo "Madhu" | mawk '/[[:lower:]]/ {print}'
```

![]({{site.baseurl}}/assets/img/2022/04/image-10.png)

However, with `mawk` version 1.3.4, the result is different — special character classes appear to be supported in this version.

```bash
echo "Madhu" | mawk '/[[:lower:]]/ {print}'
```

![]({{site.baseurl}}/assets/img/2022/04/image-12.png)

---

## gawk

`gawk` fully supports POSIX ERE curly braces, resulting in the expected output.

### Example 1: ERE curly braces

```bash
echo "tot" | gawk '/to{1}t/{print $0}'
```

![]({{site.baseurl}}/assets/img/2022/04/image-9.png)

### Example 2: Special character classes

`gawk` also supports special character classes.

```bash
echo "Madhu" | gawk '/[[:lower:]]/ {print}'
```

![]({{site.baseurl}}/assets/img/2022/04/image-13.png)

---

## Summary

> **Note:** In certain Linux distributions, the `awk` command is a symlink to `mawk`. When `awk` points to `mawk`, it does not support curly braces, and depending on the `mawk` version, it may or may not support special character classes.

| Feature | mawk 1.3.3 | mawk 1.3.4 | gawk |
|---|---|---|---|
| **POSIX ERE curly braces `{}`** | No | No | Yes |
| **Special character classes** | No | Yes | Yes |
| **Full POSIX compliance** | No | Partial | Yes |
