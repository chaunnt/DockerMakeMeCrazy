#!/bin/bash

echo "BEGIN cleanup system cache"
sudo sync; echo 1 > /proc/sys/vm/drop_caches
echo "END cleanup system cache"

echo "BEGIN cleanup docker image dangling"
sudo docker rmi -f $(sudo docker images -f "dangling=true" -q)
echo "END cleanup docker image dangling"



