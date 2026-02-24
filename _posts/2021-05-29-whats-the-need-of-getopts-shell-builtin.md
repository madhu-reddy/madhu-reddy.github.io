---
layout: post
title: whats the need for getopts shell builtin?
date: 2021-05-29
categories: ['Linux', 'Bash']
---

The 'getopts' command is a built-in tool in shell scripting. It helps in handling different types of input when working with scripts. It can process information in two ways:

- It can recognize single options/flags, like '-h' or '-c'.

- It can also handle options/flags that come with additional data, for example, '-h 20' or '-c 45'.

## Syntax:

```
getopts: getopts optstring name [arg]
```

In this context:

- '**optstring**' contains a list of options or flags that 'getopts' recognizes.

- '**name**' is a variable that holds each option, one at a time, during script execution.

- '**arg'** is an optional set of parameters that 'getopts' can process. If 'arg' isn’t specified, 'getopts' looks at the **command-line arguments** provided and handles them accordingly, whether they are single options/flags or options/flags with associated data.

 

 

# Example using just options/flags

```
#!/bin/bash

while getopts "ab" option_char                    
do
  case $option_char in
  a)
    echo "option a is called and its argument is $OPTARG"
    ;;
  b)
    echo "option b is called and its argument $OPTARG"
    ;;
  ?)
    echo "$OPTARG is not a valid option."
    ;;
  esac
done

```

**Explaining the 'while getopts' line:**
 1) 'getopts' looks for provided options 'a' or 'b'.
 2) If 'a' or 'b' is passed as an argument, the case statement executes accordingly. 

**About $OPTARG:** 

1) It contains the argument value passed to an option.

2) If no argument is provided, $OPTARG remains empty.

3) In this script, 'a' and 'b' options don’t take arguments, so $OPTARG will be empty.

 

**Output**

![]({{site.baseurl}}/assets/img/2021/05/getopts-option.png)

 

 

# Example using options/flags with arguments

```
#!/bin/bash

while getopts "a:b:" option_char
do
  case $option_char in
  a)
    echo "option a is called and its argument is $OPTARG"
    ;;
  b)
    echo "Option b is called and its argument $OPTARG"
    ;;
  ?)
    echo "$OPTARG is not a valid option."
    ;;
  esac
done

```

** Explaining the 'while getopts' line: **
 1) 'getopts' looks for provided options 'a' or 'b'.
 2) 'a' expects an argument, while 'b' expects an argument, the colon (`:`) following the option characters (`a:` and `b:`) in the `getopts` command signifies that these options are expected to be followed by an argument.
 3) If an argument is not provided with 'a' or 'b', an error message is displayed.

 

**About $OPTARG: **

1) It contains the argument value passed to an option. 

2) If an argument is expected but not provided, $OPTARG will be empty. 

3) In this script, the 'a' and 'b' options require arguments, so $OPTARG will contain the argument passed.

# **Output:**

![]({{site.baseurl}}/assets/img/2021/05/getops-option1.png)

 

 

# How do getopts report errors?

**Getopts in Bash reports errors in two ways:**

- **Silent Error Reporting (Leading Colon)**:

- 

- If the first character of OPTSTRING is a colon, getopts uses silent error reporting.

- No error messages are printed.

- If a required argument is missing, a "?" is assigned to the 'name' variable, and the related case statement executes.

- 

**Verbose Error Reporting (No Leading Colon)**:

- If the first character of OPTSTRING is not a colon, silent error reporting is disabled.

- Diagnostic messages are printed for errors.

- Missing required arguments or invalid options trigger diagnostic messages.

- In case of an error, a "?" is assigned to the 'name' variable, and the related case statement also executes.

**Testing the first way (silent error reporting) practically**

```
#!/bin/bash

**while getopts ":a:b:" option_char**     #silent error reporting enabled
do
  case $option_char in
  a)
    echo "option a is called and its argument is $OPTARG"
    ;;
  b)
    echo "Option b is called and its argument $OPTARG"
    ;;
  ?)
    echo "$OPTARG is not a valid option."
    ;;
  esac
done

```

## Output:

![]({{site.baseurl}}/assets/img/2021/05/getopts-3.png)

 

 

**Testing the second way (silent error reporting disabled) practically**

```
#!/bin/bash

**while getopts "a:b:" option_char**** **     # silent error reporting disabled
do
  case $option_char in
  a)
    echo "option a is called and its argument is $OPTARG"
    ;;
  b)
    echo "Option b is called and its argument $OPTARG"
    ;;
  ?)
    echo "$OPTARG is not a valid option."
    ;;
  esac
done

```

## Output:

![]({{site.baseurl}}/assets/img/2021/05/getopts-4.png)

.

.

# Points to be noted:

When `getopts` identifies an option from the script's command line, it internally maintains the index of the option in the shell variable `OPTIND`. This approach allows `getopts` to effectively manage and process options, particularly those that come with associated arguments. Instead of utilizing the `shift` command to cycle through all the options, `getopts` intelligently handles the parsing and processing of individual options and their arguments, simplifying the script's logic.

![]({{site.baseurl}}/assets/img/2021/05/getopts-5.png)
