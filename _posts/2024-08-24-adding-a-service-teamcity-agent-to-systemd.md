---
layout: post
title: Adding a service (TeamCity Agent) to systemd
date: 2024-08-24
categories: ['DevOps', 'TeamCity']
---

This configuration is a `systemd` service unit file for managing a TeamCity Build Agent.
```ini
cat /etc/systemd/system/teamcity-agent.service
```

![]({{site.baseurl}}/assets/img/2024/08/image-13.png)

`After=network.target`: This directive ensures that the service starts only after the network is available.

`Type=oneshot`: This indicates that the service runs a single task and then exits. The `agent.sh start` script runs, starts an agent child process in the background, and then exits. If `RemainAfterExit` is not set, a `Type=oneshot` service will be marked as `inactive (dead)` once the `ExecStart` command completes.

`ExecStart=/home/teamcityagent/agent/bin/agent.sh start`: Command to start the agent.

`ExecStop=-/home/teamcityagent/agent/bin/agent.sh stop`: Command to stop the agent. The `-` prefix allows the service to ignore errors if the stop command fails.

`RemainAfterExit=yes`: Keeps the service in an active state after `ExecStart` completes. The `systemctl status teamcity-agent` command will show the service as `active (running)` rather than `inactive (dead)` even though `agent.sh start` has finished executing.

With `RemainAfterExit=yes`:
- It keeps the status as **active (running)** if `ExecStart` exited with a status defined in `SuccessExitStatus`
- It keeps the status as **active (exited)** if `ExecStart` exited with a status code not listed in `SuccessExitStatus`

![]({{site.baseurl}}/assets/img/2024/08/image-14.png)

`SuccessExitStatus=0 143`: Defines the exit codes that systemd will consider a successful exit. `143` is used when the process is killed with `SIGTERM`, which is expected during an upgrade.

