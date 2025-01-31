#!/bin/bash

# Log file
LOG_FILE="$HOME/system_health.log"

# Get system stats
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{print $1}' | awk '{print $2}')
MEMORY_USAGE=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
NETWORK_USAGE=$(vnstat -tr 2 | grep "rx" | awk '{print $2 " " $3 " / " $5 " " $6}')


# Format log entry
LOG_MSG="$(date +'%Y-%m-%d %H:%M:%S') | CPU: ${CPU_LOAD}% | RAM: ${MEMORY_USAGE}% | Disk: ${DISK_USAGE}% | Network: ${NETWORK_USAGE}"

# Write to log file
echo "$LOG_MSG" | tee -a "$LOG_FILE"
