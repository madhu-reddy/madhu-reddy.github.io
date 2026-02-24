---
layout: post
title: Failed to import the required Python library docker-py docker module
date: 2022-12-24
categories: ['DevOps', 'Docker']
---

While running an Ansible task, you may encounter the error "Failed to import Python library docker-py". Here is an example task that triggers this issue:

```yaml
---
- name: Perform Docker Registry Login
  become: yes
  docker_login:
    username: "{{ dockerhub_user }}"
    password: "{{ dockerhub_pass }}"
```

Running the above task produces the following error:

```
TASK [docker_run : Docker Login] ***********************************************
fatal: [mytesthost]: FAILED! => {"changed": false, "msg": "Failed to import the required Python library (Docker SDK for Python: docker (Python >= 2.7) or docker-py (Python 2.6)) on mytesthost's Python /usr/bin/python3. Please read module documentation and install in the appropriate location, for example via `pip install docker` or `pip install docker-py` (Python 2.6). The error was: No module named 'docker'"}
```

---

## Explanation

The `docker_login` Ansible module facilitates logging into a Docker registry, offering functionality similar to the `docker login` command. For this module to execute successfully, the Docker SDK for Python must be present on the host where the task runs.

The error above indicates that no suitable Docker SDK for Python is installed on the target host. To successfully execute any Docker-related Ansible module, the Docker SDK for Python must be installed and available so that Ansible can communicate with the Docker daemon.

Some commonly used Docker-related Ansible modules are:

- `docker_login` — log into a Docker registry
- `docker_container` — create, start, or stop a Docker container
- `docker_image` — build or pull an image

---

## Fix

The installation command varies based on the Python version on the host:

- **Python >= 2.7:**

  ```bash
  pip install docker
  ```

- **Python = 2.6:**

  ```bash
  pip install docker-py
  ```

---

## Notes

1. According to the Ansible documentation, Ansible 2.1.0 introduced significant updates to the Docker modules and requires the Python Docker SDK version >= 1.7.0.

2. Ensure that only **one** of `docker` or `docker-py` is installed — not both. Installing both will lead to a broken installation. Ansible will detect this and display the following message:

   ```
   Cannot have both the docker-py and docker python modules installed together as they use the same
   namespace and cause a corrupt installation. Please uninstall both packages, and re-install only
   the docker-py or docker python module. It is recommended to install the docker module if no support
   for Python 2.6 is required. Please note that simply uninstalling one of the modules can leave the
   other module in a broken state.
   ```
