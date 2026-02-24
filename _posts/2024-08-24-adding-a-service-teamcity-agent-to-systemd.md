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

![]({{site.baseurl}}/assets/img/2024/08/teamcity-agent-service.png)

## Configuration Breakdown

`After=network.target` — Ensures the service starts only after the network is available.

`Type=oneshot` — The service runs a single task and exits. The `agent.sh start` script starts an agent child process in the background and then exits. If `RemainAfterExit` is not set, the service will be marked as `inactive (dead)` once `ExecStart` completes.

`ExecStart=/home/teamcityagent/agent/bin/agent.sh start` — Command to start the agent.

`ExecStop=-/home/teamcityagent/agent/bin/agent.sh stop` — Command to stop the agent. The `-` prefix allows the service to ignore errors if the stop command fails.

`RemainAfterExit=yes` — Keeps the service in an active state after `ExecStart` completes. The `systemctl status teamcity-agent` command will show the service as `active (running)` rather than `inactive (dead)` even though `agent.sh start` has finished executing.

With `RemainAfterExit=yes`:

| Exit Condition | Status |
|---|---|
| Exit code defined in `SuccessExitStatus` | `active (running)` |
| Exit code NOT in `SuccessExitStatus` | `active (exited)` |

`SuccessExitStatus=0 143` — Defines exit codes considered successful. `143` is used when the process is killed with `SIGTERM`, which is expected during an upgrade.
