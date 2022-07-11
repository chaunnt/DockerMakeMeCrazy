# Setup Caprover On Ubuntu 20.04

## Install docker

###The centos-extras repository must be enabled. This repository is enabled by default, but if you have disabled it, you need to re-enable it.
####The overlay2 storage driver is recommended.

yum clean all 

sudo yum install -y yum-utils

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo yum list docker-ce --showduplicates | sort -r

sudo yum install docker-ce-18.09.1  docker-ce-cli-18.09.1 containerd.io docker-compose-plugin

sudo systemctl start docker

echo "Done Docker"

#### retest
sudo docker run hello-world

###other way
Refer `https://docs.docker.com/engine/install/centos/` for details

sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "Done Docker"

## Install caprover from docker

Refer `https://caprover.com/docs/get-started.html` for details

ufw allow 80,443,3000,996,7946,4789,2377/tcp; ufw allow 7946,4789,2377/udp;

docker run -p 80:80 -p 443:443 -p 3000:3000 -v /var/run/docker.sock:/var/run/docker.sock -v /captain:/captain caprover/caprover

## Install npm / node (we use v10.3 for ubuntu)

sudo apt install nodejs npm -y

## Setup caprover

npm install -g caprover

caprover serversetup




