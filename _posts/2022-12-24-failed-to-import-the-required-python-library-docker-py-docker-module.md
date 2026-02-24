---
layout: post
title: Failed to import the required python library docker-py docker module?
date: 2022-12-24
categories: ['DevOps', 'Docker']
---

Encountering an error "Failed to import Python library docker-py" while running an Ansible task.

My Ansible task example,

```
---  
- name: Perform Docker Registry Login
  become: yes
  docker_login: 
    username: "{{ dockerhub_user }}"
    password: "{{ dockerhub_pass }}"
```

Encountering the following error when running the aforementioned Ansible task.

```
TASK [docker_run : Docker Login] ***********************************************
fatal: [mytesthost]: FAILED! => {"changed": false, "msg": "Failed to import the required Python library (Docker SDK for Python: docker (Python >= 2.7) or docker-py (Python 2.6)) on mytesthost's Python /usr/bin/python3. Please read module documentation and install in the appropriate location, for example via `pip install docker` or `pip install docker-py` (Python 2.6). The error was: No module named 'docker'"}
```

#### An explanation for the above error "failed to import the docker-py library" is as follows:

In my scenario, I am utilizing the Ansible module "docker_login." This module facilitates logging into a Docker registry, offering functionality akin to the 'docker login' command. It's important to note that the successful execution of this Ansible module, necessitates the presence of the Docker module for Python on the host where it is being executed.

The aforementioned error indicates that there is no suitable Docker module (or Docker SDK) for Python installed on the host where the Ansible task is intended to run.

To successfully execute any Docker-related Ansible modules, such as "docker_login," the Docker module (or Docker SDK) for Python must be installed and available on the host where the Ansible task is intended to run. This ensures that Ansible can communicate with the Docker daemon and perform the required Docker-related actions.

Some of the **Docker related Ansible modules**, we can use in our Ansible tasks are,
`**docker_login**`  ---> To log into a docker registry
`**docker_container**` ---> To create/start/stop a docker container
`**docker_image**` ---> To build, pull an image

Now, the command to install the Docker module (or Docker SDK) for Python can vary based on the Python version on the host,

For example,
If **Python version >=  2.7**, we need to execute the following command `pip install docker` 
If **Python version = 2.6**, we need to execute the following command `pip install docker-py`

**NOTE:**

1)  According to the Ansible documentation, Ansible 2.1.0 introduces significant updates to the Docker modules and necessitates the installation of Python Docker module version >= 1.7.0.

2) Additionally, ensure that only one instance of `docker` and `docker-py` is installed. Installing both will lead to a broken installation. If this situation occurs, Ansible will detect it and display a corresponding message when running an Ansible job, as illustrated below.

```
Cannot have both the docker-py and docker python modules installed together as they use the same
namespace and cause a corrupt installation. Please uninstall both packages, and re-install only
the docker-py or docker python module. It is recommended to install the docker module if no support
for Python 2.6 is required. Please note that simply uninstalling one of the modules can leave the
other module in a broken state.
```
