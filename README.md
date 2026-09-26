# Blue Team Cyber Security — Portfolio

**Goal:** Cyber security degree apprenticeship (UK), blue team: SOC analyst, then detection/security engineer.
**A-levels:** Maths, Further Maths, Physics (Year 12 in 2026/27).
**Apply:** Oct 2027 – Mar 2028 (Year 13), for a Sept 2028 start.
**Plan:** Certs employers recognise + a home SOC lab + write-ups on GitHub that show I can actually do the work.

---

## Timeline
| When | Focus |
|---|---|
| Oct–Dec 2026 | Wireshark, Pre Security, Bandit, ISC2 CC exam, GitHub live |
| Jan–Apr 2027 | TryHackMe SOC Level 1, home lab, first 3 write-ups, Python project |
| Apr–Aug 2027 | CyberFirst summer course, work experience / insight days, more write-ups, Security+ if affordable |
| Sep 2027 → | Polish CV/GitHub/LinkedIn, apply to degree apprenticeships |

## Phase 1: Foundations + first cert (weeks 1–6)
- [ ] **Step 1:** Install Wireshark, capture and explain my own traffic (DNS, TCP handshake, HTTPS). Notes → `notes/networking.md`
- [ ] **Step 2:** Create a TryHackMe account and finish **Pre Security** (free)
- [ ] **Step 3:** OverTheWire **Bandit** levels 0–15 (Linux command line)
- [ ] **Step 4:** **ISC2 Certified in Cybersecurity (CC)**. Free training course; check the ISC2 site for whether the exam is currently free.
- [ ] **Step 5:** Put this repo on GitHub with a clean profile README

## Phase 2: Blue team core + home lab (weeks 7–16)
- [ ] TryHackMe **Cyber Security 101**, then **SOC Level 1** path
- [ ] **Home SOC lab** on my Mac (M5, 16 GB) using UTM virtual machines. See `lab/` once built.
  - Ubuntu Server VM running **Wazuh** (free SIEM + endpoint detection)
  - A Windows or Linux "victim" VM with the Wazuh agent (+ **Sysmon** on Windows)
  - A Kali VM to generate attacks *inside the lab only*
  - **Suricata**/**Zeek** for network detection, Wireshark for packet analysis
  - Deliverable: 3–5 write-ups, e.g. "Detecting SSH brute force", "Spotting a port scan", "Catching a malicious PowerShell command"
- [ ] **Blue Team Labs Online** (free tier) investigations
- [ ] **Microsoft SC-900** (cheap, cloud security basics; Microsoft sometimes runs free-voucher events)

## Phase 3: Stand out (months 5–12)
- [ ] **CompTIA Security+** (the cert UK job adverts ask for most; the exam costs a few hundred pounds, so plan it)
- [ ] Python projects: log parser that flags suspicious logins, phishing email analyser, simple detection rules (Sigma)
- [ ] Competitions: **CyberFirst** (NCSC), **Cyber Security Challenge UK**, picoCTF
- [ ] Apply for degree apprenticeships (most UK schemes open ~Oct–Mar for a September start)

## Why this direction
Entry-level alert triage is the part of blue team work most likely to be automated by AI.
The safer, better-paid roles build and run the defences: detection engineering, incident response,
cloud security and security engineering. The lab + Python + Security+ route is aimed at those.

## Rules
Only test systems I own or that a platform explicitly lets me attack (THM, BTLO, OTW, picoCTF, my own lab).

## Log
| Date | What I did | Time |
|------|-----------|------|
| 2026-09-26 | Set up roadmap | – |
