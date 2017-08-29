#!/bin/sh
echo lz4k > /sys/block/zram0/comp_algorithm 
# ZRAM swap - 160MB
echo 167772160 > /sys/block/zram0/disksize
/system/bin/mkswap /dev/block/zram0
/system/bin/swapon /dev/block/zram0
### Manipulation of 2nd swap ###
# Remove IMMUTABLE attribute
chattr -i /data/2ndswap
# Second swap - 128MB
tiny_fallocate 134217728 /data/2ndswap
mkswap /data/2ndswap
swapon /data/2ndswap
# Add IMMUTABLE attribute
chattr +i /data/2ndswap
# Set swappiness
echo 150 > /proc/sys/vm/swappiness
