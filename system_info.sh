#!/bin/bash

#Display hostname
echo -e "Hostname: $(hostnamectl)"


#Display current date and time
echo -e "Date and time: $(date)\n"


#Display uptime
echo -e "Uptime: $(uptime)\n"

#Display SSH status
echo -e "SSH client: $SSH_CONNECTION"
echo -e "$(who)\n"

#Display USB devices y disks
echo -e "USB devices: "
lsusb
echo -e "\nDISKs: "
lsblk
# Display CPU usage
echo -e "\nCPU Usage:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
echo -e "\n"

# Display memory usage
echo "Memory Usage:"
free -h | awk 'NR==2{printf "Used: %s / Total: %s (%.2f%%)\n", $3, $2, $3*100/$2}'
echo -e "\n"

# Display disk space usage
echo "Disk Space Usage:"
df -h | awk '$NF=="/"{printf "Used: %d / Total: %d (%s)\n", $3, $2, $5}'
echo -e "\n"

# Display network information
echo "Network Information:"
ip -brief addr show | awk '{print $1 " " $3}'
echo -e "\n"

# Display top 5 processes by memory usage
echo "Top 5 Processes by Memory Usage:"
ps aux --sort=-%mem | awk 'NR<=6{printf "%-10s %-8s %-8s %-8s %-s\n", $1, $2, $3, $4, $11}'
