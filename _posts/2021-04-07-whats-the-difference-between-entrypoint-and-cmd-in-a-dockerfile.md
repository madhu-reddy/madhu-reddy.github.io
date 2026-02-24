---
layout: post
title: "What's the difference between ENTRYPOINT  and CMD in a Dockerfile?"
date: 2021-04-07
categories: ['DevOps', 'Docker']
---

# 
About** CMD:**

The Docker CMD defines the default executable of a Docker image.

The CMD instruction is used only when no arguments are added to the run command while starting a container. Therefore, adding an argument to the '**docker run**' command overrides the CMD.

## 
**Creating the Dockerfile with CMD :
**

 

**

Build the Image

**

When running the command **`docker run testing-cmd`** without providing any additional arguments to the '**docker run**' command, the output will be the default executable specified after the CMD instruction in the Dockerfile.

## 
**
"docker run" without arguments
**

 

**
NOTE:**'**testing-cmd**' is the name of the Docker image we've built.

## **
"docker run" with arguments**

Now, let's observe the output when an argument is added to the '**docker run**' command.

`docker run testing-cmd echo "run command I wish to run"`

Upon reviewing the above output, it's evident that the executable—specifically, the executable with an argument—that we included in the '**docker run**' command overrides the default CMD executable. Consequently, the default CMD executable (***['echo', 'running default command']***) was not executed.

**NOTE:**  If a Dockerfile contains multiple CMD instructions, only the instructions from the last one will be applied.

# 
**                           
****
About ENTRYPOINT:**

**ENTRYPOINT** is akin to **CMD** but comes with a few distinctions.

- ENTRYPOINT can only be overridden by providing the '**--entrypoint**' option along with the executable in the '**docker run**' command. Conversely, to override CMD, no additional option is required in the '**docker run**' command; providing just the executable as an argument suffices.

- If the Dockerfile contains only an ENTRYPOINT (without a CMD), the output will be identical to that of CMD when the '**docker run**' command is executed without any extra arguments.

## 
**
Dockerfile (containing only ENTRYPOINT):

**

 

**

Build the Image

**

 

 

**

"docker run" without arguments:**

Observing the image below, executing the 'docker run' command (**docker run test-entrypoint**) without arguments yields results exactly mirroring those obtained with CMD.

 

### **
"docker run" with arguments:**

### Executing the '**docker run**' command (*docker run test-entrypoint echo 'running custom command'*) with arguments yields different results compared to those obtained with CMD.

Notably, Docker did not override the original command specified in the Dockerfile for the ENTRYPOINT instruction. Instead, it simply appended the executable provided during '**docker run**' as a standard argument to the existing command specified in the Dockerfile for the ENTRYPOINT instruction.

#  

#              CMD and ENTRYPOINT together:

When both CMD and ENTRYPOINT instructions are present in the Dockerfile, it's analogous to defining the main executable or command with ENTRYPOINT, **while CMD specifies the default parameters for that command set by ENTRYPOINT**.

## 
**Dockerfile

**

## 
**
Build the Image

**

## 
**
"docker run" without arguments

**

 

## **"docker run" with arguments**

### In this scenario, we override the default parameters of CMD by providing specific parameters during the '**docker run**' command.
