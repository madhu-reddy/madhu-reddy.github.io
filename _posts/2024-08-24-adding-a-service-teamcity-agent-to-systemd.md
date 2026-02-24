---
layout: post
title: Adding a service (TeamCity Agent) to systemd
date: 2024-08-24
categories: ['DevOps', 'TeamCity']
---

[This configuration is a `systemd` service unit file for managing a TeamCity Build Agent.

`**cat /etc/systemd/system/teamcity-agent.service**`

![]({{site.baseurl}}/assets/img/2024/08/image-13.png)

`**After=network.target**:` 
This directive ensures that the service starts only after the network is available.

**`Type=oneshot`:** 
This indicates that the service runs a single task and then exits. In this case, the `agent.sh start` script runs, starts an agent child process in the background, and then exits (meaning the main process runs and exits immediately after initiating the child process).
If `RemainAfterExit` is not set, a `Type=oneshot` service will be marked as `inactive (dead)` once the `ExecStart` command completes, regardless of the exit status.

**`ExecStart=/home/teamcityagent/agent/bin/agent.sh start`: **
Command to start the agent.

**`ExecStop=-/home/teamcityagent/agent/bin/agent.sh stop`:** 
Command to stop the agent. The `-` prefix allows the service to ignore errors if the stop command fails.

**`RemainAfterExit=yes`: **
This keeps the service in an active state after the `ExecStart` command completes. When you set `RemainAfterExit=yes` in a systemd service file, it means that the service will remain in an "active" state even after the `ExecStart` command completes. 
The `systemctl status teamcity-agent` command will show the service as "`active (running)`", rather than "`inactive` `(dead)`" even though the `ExecStart` command (in this case, `agent.sh start`) has finished executing.
**With **`RemainAfterExit=yes`: 
--> It keeps the status as **active (running)**,  if the `ExecStart` command exited with a status defined in `SuccessExitStatus`. 
--> It keeps the status as **active (exited)**, if the `ExecStart` command exited with a status code, which is not listed in `SuccessExitStatus`.

![]({{site.baseurl}}/assets/img/2024/08/image-14.png)

**`SuccessExitStatus=0 143`:**
Defines the exit codes that systemd will consider a successful exit. `143` is used when the process is killed with `SIGTERM`, which is expected during an upgrade.
