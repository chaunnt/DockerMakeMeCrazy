#!/bin/bash
sudo docker rmi -f $(sudo docker images -f "dangling=true" -q)

