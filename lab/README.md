# Home SOC Lab

A small security operations lab running on my MacBook (Apple M5, 16 GB RAM) with UTM virtual machines.
The goal is to generate real attacks inside an isolated network and detect them with a SIEM, the way a SOC analyst would.

## Network

All VMs sit on UTM's private shared network `192.168.64.0/24`. Attacks never leave the Mac.

| VM | IP | OS | RAM | Role |
|---|---|---|---|---|
| `wazuh` | 192.168.64.10 | Ubuntu Server 24.04 LTS (ARM64) | 6 GB | Wazuh SIEM: indexer, manager, dashboard |
| `victim` | 192.168.64.20 | Ubuntu Server 24.04 LTS (ARM64) | 2 GB | Monitored server running the Wazuh agent |
| `kali` | 192.168.64.30 | Kali Linux 2026.2 (ARM64) | 3 GB | Attacker, used only against lab machines |
| next | 192.168.64.40+ | | | Reserved for add-ons (Windows + Sysmon, DVWA, Suricata sensor) |

```
            Mac (UTM)  ──  browser → https://192.168.64.10 (Wazuh dashboard)
  ┌──────────────────────────────────────────────────────────┐
  │  lab network 192.168.64.0/24                             │
  │                                                          │
  │   kali (.30) ──attacks──▶ victim (.20) ──logs──▶ wazuh (.10) │
  └──────────────────────────────────────────────────────────┘
```

## How it's built

- **Hypervisor:** UTM 4.7 (QEMU with Apple's Hypervisor framework, native ARM64).
- **Unattended installs:** each Ubuntu VM installs itself from a cloud-init `autoinstall` seed disk
  (hostname, fixed IP, SSH key login, no password over SSH). The seed files live in `lab/seed/` and are kept out of Git
  because they contain a password hash.
- **Access:** SSH with a lab-only ed25519 key. Passwords are disabled for SSH.
- **Snapshots** are taken after every working phase so the lab can be rolled back.

## Build log

| Date | Step | Evidence |
|---|---|---|
| 2026-10-12 | Planned the lab, installed UTM, downloaded and checksum-verified the Ubuntu 24.04.5 and Kali 2026.2 ARM64 installers | this README |
| 2026-10-12 | Wrote cloud-init autoinstall configs for the Ubuntu VMs and created the `wazuh` VM. First install failed, fixed it (see below) | `watch-install.sh` |
| 2026-10-13 | Ejected the installer, removed the 4 GB swap file (Wazuh recommends no swap for the indexer), installed Wazuh 4.14 all-in-one. Dashboard up at https://192.168.64.10 | [screenshot](screenshots/01-wazuh-dashboard.png) |
| 2026-10-13 | Built the `victim` VM the same way, removed its swap and enrolled it in Wazuh with the 4.14.8 agent. Agent shows as Active | `finish-victim.sh` |
| 2026-10-13 | Switched `/etc` on the victim to real-time file integrity monitoring (default is a scan every 12 h) and checked file, user, sudo and package events all reach Wazuh | [how to use the lab](HOW-TO-USE.md) |

## Problems I hit

**First Ubuntu install failed at "installing kernel".** I read the installer logs over the VM's serial console
(`/var/log/installer/curtin-install.log`) and found `linux-modules-extra-6.8.0-147-generic` was "not installable".
Checking with `apt-cache policy` showed the ARM64 build of that package just wasn't on the mirror yet, even though
the meta-package already pointed to it. I switched the autoinstall to the slimmer `linux-image-virtual-hwe-24.04`
kernel and the `ubuntu-server-minimal` source, which avoids the missing package and also keeps the VM disk smaller.
Lesson: read the logs before changing things.

## Detections (write-ups)

Write-ups go in [`writeups/`](../writeups/). Planned first:

1. SSH brute force from Kali against the victim (Wazuh rules 5710/5712)
2. Nmap port scan detection
3. File integrity monitoring: catching an unexpected change to `/etc/passwd`

## Rules

Only attack machines I own inside this lab, or platforms that allow it (TryHackMe, OverTheWire, picoCTF).
