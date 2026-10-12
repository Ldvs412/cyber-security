#!/bin/zsh
# Live install progress for a lab VM: disk written so far and VM status.
# Usage: ./watch-install.sh wazuh
vm=${1:-wazuh}
disk_dir="$HOME/Library/Containers/com.utmapp.UTM/Data/Documents/$vm.utm/Data"
target_mb=2800
start=$(date +%s)
while true; do
  vmstate=$(osascript -e "tell application \"UTM\" to get status of virtual machine named \"$vm\"" 2>/dev/null)
  mb=$(du -sm "$disk_dir"/*.qcow2 2>/dev/null | awk '{s+=$1} END {print s+0}')
  pct=$(( mb * 100 / target_mb )); (( pct > 99 )) && pct=99
  bar=$(printf '%*s' $(( pct / 4 )) '' | tr ' ' '#')
  mins=$(( ($(date +%s) - start) / 60 ))
  printf "\r%-7s [%-25s] ~%2d%%  %5d MB written  %d min  " "$vmstate" "$bar" "$pct" "$mb" "$mins"
  if [[ "$vmstate" == "stopped" ]]; then
    printf "\nInstall finished: the VM switched itself off.\n"
    break
  fi
  sleep 5
done
