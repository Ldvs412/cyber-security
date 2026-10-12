#!/bin/zsh
# After the victim VM's unattended install powers off: eject the installer,
# boot it, remove swap, and enrol it in Wazuh with the agent.
set -e
cd "${0:A:h}"
vm=victim
until [[ "$(osascript -e "tell application \"UTM\" to get status of virtual machine named \"$vm\"")" == "stopped" ]]; do sleep 10; done
echo "install finished, ejecting installer and booting"
osascript <<EOF
tell application "UTM"
  set v to virtual machine named "$vm"
  set cfg to configuration of v
  set keep to {}
  repeat with d in drives of cfg
    if removable of d is false then set end of keep to (contents of d)
  end repeat
  set drives of cfg to keep
  update configuration of v with cfg
  start v
end tell
EOF
until ssh -F ssh_config -o ConnectTimeout=3 $vm true 2>/dev/null; do sleep 5; done
echo "SSH up"
ssh -F ssh_config $vm 'sudo swapoff -a; sudo rm -f /swap.img; sudo sed -i "/swap.img/d" /etc/fstab
cd /tmp && curl -so wazuh-agent.deb https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.14.8-1_arm64.deb
sudo WAZUH_MANAGER=192.168.64.10 WAZUH_AGENT_NAME=victim dpkg -i ./wazuh-agent.deb >/dev/null
rm -f wazuh-agent.deb
sudo systemctl daemon-reload && sudo systemctl enable --now wazuh-agent
sleep 5; sudo systemctl is-active wazuh-agent; df -h / | tail -1'
echo "agent installed"
