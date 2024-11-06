#!/bin/bash
swapon --show
free -h
df -h
fallocate -l 4G /swapfile
ls -lh /swapfile
chmod 600 /swapfile
ls -lh /swapfile
mkswap /swapfile
swapon /swapfile
swapon --show
free -h
cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sysctl vm.swappiness=10
sysctl vm.vfs_cache_pressure=50
echo 'vm.swappiness=10' >> '/etc/sysctl.conf'
echo 'vm.vfs_cache_pressure=50' >> '/etc/sysctl.conf'
sysctl -p
cat /proc/sys/vm/swappiness
cat /proc/sys/vm/vfs_cache_pressure

