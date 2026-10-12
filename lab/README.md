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

## Detections (write-ups)

Write-ups go in [`writeups/`](../writeups/). Planned first:

1. SSH brute force from Kali against the victim (Wazuh rules 5710/5712)
2. Nmap port scan detection
3. File integrity monitoring: catching an unexpected change to `/etc/passwd`

## Rules

Only attack machines I own inside this lab, or platforms that allow it (TryHackMe, OverTheWire, picoCTF).
