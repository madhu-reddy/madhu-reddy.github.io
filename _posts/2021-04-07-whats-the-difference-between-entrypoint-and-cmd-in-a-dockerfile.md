---
layout: post
title: What's the difference between ENTRYPOINT and CMD in a Dockerfile?
date: 2021-04-07
categories: ['DevOps', 'Docker']
---

---

## CMD

The `CMD` instruction defines the default executable of a Docker image. It is only used when no arguments are added to the `docker run` command while starting a container — providing an argument to `docker run` overrides `CMD`.

> **Note:** If a Dockerfile contains multiple `CMD` instructions, only the last one will be applied.

### Creating a Dockerfile with CMD

![]({{site.baseurl}}/assets/img/2021/04/image-4.png)

### Build the Image

![]({{site.baseurl}}/assets/img/2021/04/image-5.png)

### docker run without arguments

When running `docker run testing-cmd` without any additional arguments, the output will be the default executable specified in the `CMD` instruction.

![]({{site.baseurl}}/assets/img/2021/04/image-6.png)

> **Note:** `testing-cmd` is the name of the Docker image built above.

### docker run with arguments

Now let's observe the output when an argument is added to the `docker run` command:

```bash
docker run testing-cmd echo "run command I wish to run"
```

![]({{site.baseurl}}/assets/img/2021/04/image-7.png)

The executable provided in the `docker run` command overrides the default `CMD` instruction. As a result, the default `CMD` executable (`['echo', 'running default command']`) was not executed.

---

## ENTRYPOINT

`ENTRYPOINT` is similar to `CMD` but with a few key distinctions:

- `ENTRYPOINT` can only be overridden by providing the `--entrypoint` option in the `docker run` command. In contrast, overriding `CMD` requires no additional option — providing just an argument suffices.
- If the Dockerfile contains only an `ENTRYPOINT` (without a `CMD`), the output will be identical to `CMD` when `docker run` is executed without any extra arguments.

### Dockerfile with ENTRYPOINT only

![]({{site.baseurl}}/assets/img/2021/04/image-11.png)

### Build the Image

![]({{site.baseurl}}/assets/img/2021/04/image-9.png)

### docker run without arguments

Running `docker run test-entrypoint` without arguments yields results identical to those obtained with `CMD`.

![]({{site.baseurl}}/assets/img/2021/04/image-12.png)

### docker run with arguments

Running `docker run test-entrypoint echo 'running custom command'` with arguments yields different results compared to `CMD`.

![]({{site.baseurl}}/assets/img/2021/04/image-13.png)

Docker did not override the original command specified in the `ENTRYPOINT` instruction. Instead, it appended the argument provided during `docker run` to the existing `ENTRYPOINT` command.

---

## CMD and ENTRYPOINT Together

When both `CMD` and `ENTRYPOINT` instructions are present in a Dockerfile, `ENTRYPOINT` defines the main executable while `CMD` specifies the default parameters for that command.

### Dockerfile

![]({{site.baseurl}}/assets/img/2021/04/image-14.png)

### Build the Image

![]({{site.baseurl}}/assets/img/2021/04/image-15.png)

### docker run without arguments

![]({{site.baseurl}}/assets/img/2021/04/image-16.png)

### docker run with arguments

In this scenario, the default `CMD` parameters are overridden by providing specific parameters in the `docker run` command.

![]({{site.baseurl}}/assets/img/2021/04/image-17.png)
