---
layout: post
title: Upgrading Docker in Ubuntu and its impact on running containers
date: 2022-12-24
categories: ['DevOps', 'Docker']
---

Suppose the current Docker version is 18.09 and the target version for the upgrade is 20.10. There are several methods for upgrading, such as manual upgrading, utilizing convenience scripts, or leveraging the APT repository.

---

## Upgrading Docker Using the APT Repository

First, verify the latest Docker package version in the APT cache:

```bash
apt-cache policy docker-ce
```

![]({{site.baseurl}}/assets/img/2022/12/image-4.png)

If the package is present, run the following command:

```bash
apt-get install docker-ce docker-ce-cli containerd.io
```

Where:

- `docker-ce` — the primary Docker engine package for the community edition.
- `docker-ce-cli` — optional but recommended. Provides a Docker client that communicates with the Docker engine (`dockerd` daemon) through API calls.
- `containerd.io` — optional but advisable. `containerd` is the service responsible for managing the complete lifecycle of a container on a host.

After completing the upgrade, run `docker version`. You should see the latest Docker version (`20.10.7`) installed.

**Example output:**

```
Client:
 Version:           20.10.7
 API version:       1.39

Server: Docker Engine - Community
 Engine:
  Version:          20.10.7
  API version:      1.41 (minimum version 1.12)
 containerd:
  Version:          1.4.6
  GitCommit:        d71fcd7d8303cbf684402823e425e9dd2e99285d
```

If the latest Docker package version (`20.10`) is **not found in the APT cache**, you need to first add the Docker APT repository and run `apt-get update`. Afterward, proceed to upgrade using the same command:

```bash
apt-get install docker-ce docker-ce-cli containerd.io
```

Docker APT repository setup instructions can be found here:
[https://docs.docker.com/engine/install/ubuntu/#install-docker-engine](https://docs.docker.com/engine/install/ubuntu/#install-docker-engine)

---

## Impact of Upgrading Docker on Running Containers

> **Note:** Prior to the Docker upgrade, the Docker daemon is automatically stopped, thereby halting all running Docker containers. After the upgrade, the Docker daemon restarts automatically, but it does **not** resume the stopped containers.

If your application is sensitive and requires zero downtime, careful planning and a maintenance window are necessary during the Docker upgrade.

However, if a brief period of container downtime is acceptable, you can use the `restart: unless-stopped` option in your `docker-compose.yml` file:

```yaml
restart: unless-stopped
```

When added to each container section in `docker-compose.yml`, containers that were automatically stopped before the upgrade will be automatically restarted after the upgrade. This eliminates the need to start each container manually, minimizing downtime.

The `restart: unless-stopped` policy means the container will always be restarted — even after the Docker daemon restarts — unless it was manually stopped by a user.
