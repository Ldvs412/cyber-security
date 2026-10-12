# cyber-security

Hi, I'm Luan. I'm a Year 12 student in the UK (A-levels in Maths, Further Maths and Physics) working towards a
**cyber security degree apprenticeship**, on the blue team side: SOC analyst first, then detection engineering.

This repo is where I keep my roadmap, my home lab and my write-ups, so there's a record of what I've actually done
and what I learned doing it.

## What's in here

| Folder | What it is |
|---|---|
| [`lab/`](lab/) | My home SOC lab: a Wazuh SIEM, a victim server and a Kali attacker, all running as VMs on my MacBook |
| [`writeups/`](writeups/) | Write-ups of lab detections and practice rooms (no flags) |
| [`notes/`](notes/) | Notes on networking and Linux as I learn them |
| [`tracker/`](tracker/) | A small page I use to track the roadmap below |

## Roadmap

**Timeline:** I'm in Year 12 now (2026/27). Applications open around Oct 2027 to Mar 2028, for a September 2028 start.

| When | Focus |
|---|---|
| Oct to Dec 2026 | Home lab, Wireshark, TryHackMe Pre Security, OverTheWire Bandit, Springpod |
| Jan to Apr 2027 | TryHackMe SOC Level 1, first 3 lab write-ups, a Python project |
| Apr to Aug 2027 | CyberFirst, work experience and insight days, more write-ups, Security+ if I can afford it |
| Sep 2027 onwards | Tidy up my CV, GitHub and LinkedIn, then apply |

### Foundations
- [ ] Capture and explain my own traffic in Wireshark (DNS, the TCP handshake, HTTPS)
- [ ] TryHackMe Pre Security path
- [ ] OverTheWire Bandit, levels 0 to 15
- [ ] Springpod cyber security virtual work experience

### Blue team core
- [ ] **Home SOC lab** (in progress, see [`lab/`](lab/))
- [ ] TryHackMe Cyber Security 101, then SOC Level 1
- [ ] Blue Team Labs Online investigations
- [ ] Microsoft SC-900

### Later
- [ ] CompTIA Security+
- [ ] Python tools: a log parser that flags suspicious logins, a phishing email checker
- [ ] Competitions: CyberFirst, Cyber Security Challenge UK, picoCTF

## Why blue team

I like the idea of being the person who works out what actually happened. Entry-level alert triage is likely to be
automated more and more, so I'm aiming at the skills behind it: building detections, investigating incidents and
understanding the systems underneath.

## How I built this

I used Claude (an AI assistant) as a tutor while building the lab. It helped me with the instructions and the
logic behind each step, wrote the setup scripts with me, and helped me structure this repo. The testing,
detections and write-ups are my own work, and I've written up what I learned in each part.

## Rules I stick to

I only attack machines I own inside my own lab, or platforms that say it's allowed (TryHackMe, OverTheWire, picoCTF).

## Log

| Date | What I did |
|---|---|
| 2026-09-26 | Wrote the roadmap |
| 2026-10-12 | Started the home SOC lab: UTM, unattended Ubuntu installs, first VM |
