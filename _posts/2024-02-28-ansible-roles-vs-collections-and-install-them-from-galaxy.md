---
layout: post
title: Ansible Roles vs Collections and installing them from Galaxy
date: 2024-02-28
categories: ['DevOps', 'Ansible']
---

## Roles

Roles are community-provided resources in Ansible that serve as standardized solutions for common tasks, making it easier for users to work with Ansible. Instead of reinventing the wheel, users can incorporate community roles directly into their playbooks and customize behavior by providing site-specific configurations using variables. This allows tailoring the role to specific requirements without modifying the role itself.

By using roles, playbooks become cleaner and more modular — they mainly consist of tasks that involve the execution of roles, with the heavy lifting handled within the roles themselves.

Tasks in roles are normally executed before other tasks in the playbook. Use `pre_tasks` to execute tasks before the role; handlers triggered by `pre_tasks` are also executed before the roles. Tasks within a role are typically executed after the `pre_tasks` section and before the `post_tasks` section of a playbook.

### Installing an Ansible Role

The role shown below can be used to install **Docker** and **Docker Compose** binaries, configure the `/etc/docker/daemon.json` file, and optionally add any user to the Docker group.

![]({{site.baseurl}}/assets/img/2024/02/image.png)

After installing the role `geerlingguy.docker`, you can customize the defaults in `/root/.ansible/roles/geerlingguy.docker/defaults/main.yaml` according to your needs — for example, specifying the version of Docker and Docker Compose, choosing `ce` (Community Edition) or `ee` (Enterprise Edition), and updating the `docker_daemon_options` dictionary.

### main.yaml

Now we are ready to execute the main playbook (`main.yaml`), which includes just the role name that you want to be executed.

![]({{site.baseurl}}/assets/img/2024/02/image-1.png)

---

## Collections

Collections are a modern approach to packaging Ansible content for improved manageability. They can originate from various sources, such as the Ansible community and Red Hat partners.

Collections encompass a range of components:

- **Roles** — included in playbooks for common task execution
- **Modules** — provide Ansible core functionality
- **Plugins** — extend the Python code on the Ansible control host

Collections introduce a Fully Qualified Collection Name (FQCN) structure. This contrasts with the pre-collection era, where you would address a module simply by its name, such as `user`. Now, you address the same module as `ansible.builtin.user` within the context of Collections.

### Installing a Collection

```bash
ansible-galaxy collection install freeipa.ansible_freeipa
```

![]({{site.baseurl}}/assets/img/2024/02/image-2.png)

To list the available roles in the above collection:

![]({{site.baseurl}}/assets/img/2024/02/image-3.png)

To include the above collection roles in the main playbook (`main.yaml`), define it as follows:

### main.yaml

![]({{site.baseurl}}/assets/img/2024/02/image-4.png)

---

## Summary

| | Roles | Collections |
|---|---|---|
| **Packaging** | Single reusable unit | Bundle of roles, modules, and plugins |
| **Source** | Ansible Galaxy | Galaxy, Red Hat, community |
| **Addressing** | Role name (e.g., `geerlingguy.docker`) | FQCN (e.g., `ansible.builtin.user`) |
| **Use case** | Common task automation | Full content distribution and management |
