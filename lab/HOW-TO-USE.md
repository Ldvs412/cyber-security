# How to use the lab

## 1. Start it up

1. Open **UTM**.
2. Start **wazuh** (press ▶). Wait about 2 minutes for the dashboard to load.
3. Start **victim**.
4. Open **https://192.168.64.10** in Safari and log in as `admin`
   (password: `open -e ~/Claude/cyber-security/lab/secrets/wazuh-dashboard-login.txt`).

## 2. Log in to the victim from your Mac

In Terminal:

```bash
ssh -F ~/Claude/cyber-security/lab/ssh_config victim
```

You're now typing commands **on the victim**. Type `exit` to come back to your Mac.

## 3. The loop

**Do something on the victim → find the alert in Wazuh → explain what happened.**

To find alerts: Wazuh menu ☰ → **Threat Hunting** → agent **victim** → time picker **Last 15 minutes** → **Events** tab.
Click an alert to see every detail (rule ID, level, time, user, file).

## 4. Tests

| # | Run this on the victim | What Wazuh should show (rule ID, level) |
|---|---|---|
| 1 | `echo "hello" \| sudo tee /etc/my-test.txt` | **554** File added to the system (5) |
| 2 | `echo "changed" \| sudo tee -a /etc/my-test.txt` | **550** Integrity checksum changed (7). Open it to see exactly what changed |
| 3 | `sudo rm /etc/my-test.txt` | **553** File deleted (7) |
| 4 | `sudo useradd testuser` | **5902** New user added to the system (8), **5901** New group added (8) |
| 5 | `sudo userdel testuser` | **5903** Group (or user) deleted (3) |
| 6 | `sudo apt-get install -y tree` | **2902** New dpkg package installed (7) |
| 7 | `sudo apt-get remove -y tree` | **2903** Dpkg package removed (7) |
| 8 | any `sudo` command | **5402** Successful sudo to ROOT executed (3) |

`/etc` is watched in **real time**, so file alerts show up within seconds. Other folders are only checked every 12 hours.

## 5. Questions to answer in each write-up

1. What did I do, and when?
2. Which alert(s) fired? Rule ID, level, description.
3. Which log did Wazuh get it from (journald, dpkg.log, file integrity monitoring)?
4. Why would a SOC analyst care? What would it mean if an attacker did this?
5. What would I check next?

## 6. Shut down

In UTM: click each VM → ■ stop → **Request power down**. Do victim first, then wazuh.
