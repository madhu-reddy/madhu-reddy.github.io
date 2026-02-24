---
layout: post
title: Ansible Roles vs Collections and installing them from Galaxy
date: 2024-02-28
categories: ['DevOps', 'Ansible']
---

## 

**Roles**

- **Roles** are community-provided resources in Ansible.

- They serve as standardized solutions for common tasks, making it easier for users to work with Ansible.

- Users can incorporate community roles directly into their playbooks.

- Instead of reinventing the wheel for common tasks, users can leverage community-provided roles.

- Users can customize the behavior of community roles by providing site-specific configurations using variables in their playbooks. This allows users to tailor the role to their specific requirements without modifying the role itself.

- By using roles, playbooks become cleaner and more modular.

- Playbooks mainly consist of tasks that involve the execution of roles. The heavy lifting of task implementation is handled within the roles.

- Tasks in roles are normally executed before other tasks in the playbook.

- Use** pre_tasks** to execute tasks before the role. Handlers that are triggered by **pre_tasks **are also executed before the roles.

- Tasks within a role are typically executed after the **pre_tasks** section and before the **post_tasks** section of a playbook.

**Installing an Ansible Role**

The role mentioned below can be utilized to install **Docker** and **Docker Compose** binaries, configure the **/etc/docker/daemon.json** file, and optionally add any user to the Docker group, etc.

![]({{site.baseurl}}/assets/img/2024/02/image.png)

After installing the role (**geerlingguy.docker**), you can customize the defaults in the /root/.ansible/roles/geerlingguy.docker/defaults/main.yaml file according to your needs. For example, specify the version of **Docker** and **Docker Compose**, choose **'ce' (Community Edition)** or **'ee' (Enterprise Edition)**, and update the **docker_daemon_options** dictionary.

**main.yaml**

Now we are ready to execute the main playbook (**main.yaml**), which includes just the role (name of the role) that you want to be executed from the main playbook.

![]({{site.baseurl}}/assets/img/2024/02/image-1.png)

**Collections**

- **Collections** are a modern approach to packaging Ansible content for improved manageability. 

- They can originate from various sources, such as the Ansible community and Red Hat partners. Collections encompass a range of components, including **roles** (included in playbooks for common task execution), **modules** (provides Ansible core functionality), and **plugins** (extend the Python code on the Ansible control host).

- Collections introduce a fully qualified Collection Name (FQCN) structure, this contrasts with the pre-collection era, where you would address a module simply by its name, such as `**user**`. Now, you address the same module as `**ansible.builtin.user**` within the context of Collections.

**Installing a Collection**

**ansible-galaxy collection install freeipa.ansible_freeipa**

![]({{site.baseurl}}/assets/img/2024/02/image-2.png)

To list the available Roles in the above Collection,

![]({{site.baseurl}}/assets/img/2024/02/image-3.png)

Now to include the above Collection Roles in our main playbook (**main.yaml**), we can use define it as following,

**main.yaml**

![]({{site.baseurl}}/assets/img/2024/02/image-4.png)
