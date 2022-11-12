#!/bin/bash

archi=`uname -a`
cpu=`nproc`
vcpu=`cat /proc/cpuinfo | grep processor | wc -l`

#The architecture of your operating system and its kernel version
echo "#Architecture: $archi"
#The number of physical processors
echo "#CPU (physical): $cpu"
#The number of virtual processors.
echo "#CPU (virtual): $vcpu"
# The current available RAM on your server and its utilization rate as a percentage.
free --mega | grep Mem | awk '{printf("#Memory Usage: %i/%iMB (%i%%)\n", $7, $2, ($2 - $7) / $2 * 100)}'
# The current available memory on your server and its utilization rate as a percentage.
df -H | grep sda1 | awk '{printf("#Disc Usage: %s (%s)", $4, $5)}'

# The current utilization rate of your processors as a percentage
# top -bn1 | grep %Cpu | awk '{printf("CPU load: ", )}'

# The date and time of the last reboot.
who -b | awk '{printf("#Last reboot: %s %s\n", $3, $4)}'

# Whether LVM is active or not

# The number of active connections.
activeConnections=`netstat -paunt | grep tcp | grep ESTABLISHED | wc -l`
echo "#Connection TCP: $activeConnections"

# The number of users using the server

# The IPv4 address of your server and its MAC (Media Access Control) address

ipAddr=`hostname -I`
macAddr=`ip -o link show enp0s8 | awk '{printf("#%s\n", $17)}'`
echo "#Network IP: $ipAddr $macAddr"

# The number of commands executed with the sudo program.
logsu=`sudo grep sudo /var/log/auth.log | wc -l`
echo "#sudo: $logsu cmd"
