---
layout: post
title: "bash - value too great for base (error token is 08 or 09)?"
date: 2021-11-14
categories: ['Linux', 'Bash']
---

Occasionally, when comparing dates (e.g., 2021-08-09) within a Bash script, unexpected errors may arise, such as '`value too great for base (error token is "08")`' or '`value too great for base (error token is "09")`'.

This occurs because the Bash shell interprets any number preceded by a zero (0) as an octal number, while numbers without a leading zero are treated as decimal values. Octal numbers range from 00 to 07 (equivalent to 0 to 7), and there are no valid octal numbers corresponding to 08 or 09. 
Consequently, attempting to use these values leads to the error '`value too great for base (error token is "08" or "09")`'

Now there are quite a few workarounds for this,

# 1) Using sed "\<" to match the beginning of a word (even number considered as a word):

```
#https://www.gnu.org/software/sed/manual/sed.html

#! /bin/bash -e
TDATE=2021-08-08

TDATE1=$(echo $TDATE | sed 's/\<0//g')  
  
MDATE=2021-07-07

MDATE1=$(echo $MDATE | sed 's/\<0//g') 

if [[ $MDATE1 < $TDATE1 ]]; then
   echo "OK"
   exit 0
else
   echo "FAILED"
   exit 1
fi
```

The `\<0` part of the command matches any character that is a word boundary (`e.g., a space or the beginning of the string or any non-word character`) followed by a zero.
So, in the above code, the command is saying "`Replace any word boundary followed by a zero with an empty string globally`". This means that the command will remove any leading zeros from the string.

**Example for "\<", which matches the beginning of a word:**
echo "2021-08-08" | sed 's/\</X/g'     **#output:**   X2021-X08-X08
echo "2021-08-08" | sed 's/\<0//g'      **#output: **2021-8-8

##                                                                                                                                                                               

# 2) Using sed "\b" to match any word boundary:

```
#! /bin/bash -e
TDATE=2021-08-08
#Match all zeroes (0's) after any word boundary match and remove those zeroes
TDATE1=$(echo $TDATE | sed 's/\b0//g')   # 2021-8-8

MDATE=2021-07-07
#Match all zeroes (0's) after any word boundary match and remove those zeroes
MDATE1=$(echo $MDATE | sed 's/\b0//g')   # 2021-7-7

if [[ $MDATE1 < $TDATE1 ]]; then
   echo "OK"
   exit 0
else
   echo "FAILED"
   exit 1
fi
```

Generally in a string, the bash shell considers a word boundary for any of the following,

- 

The position between a word and a non-word character

- 

Beginning of the string, if the string begins with a word character.

- 

End of the string, if the string ends with a word character

**Example for "\b" word boundary:**
echo "21-677-333" | sed 's/\b/x/g'                   # **Output:** x21x-x677x-x333x
echo "2021-08-08" | sed 's/\b0//g'                   # **Output:** 2021-8-8

                       .

# **3)By converting dates to epoch time using the "date" command(epoch time also referred to as POSIX time or UNIX time)**

```
#! /bin/bash -e
TDATE=2021-08-08
TDATE_EPOCH=$(date -d "$TDATE" +"%s")  #1628395200

MDATE=2021-07-07
MDATE_EPOCH=$(date -d  "$MDATE" +"%s") #1625630400

if [[ $MDATE_EPOCH < $TDATE_EPOCH ]]; then
   echo "OK"
   exit 0
else
   echo "FAILED"
   exit 1
fi
```
