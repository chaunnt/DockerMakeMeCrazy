# Setup Caprover On Ubuntu 20.04

## Install docker

Refer `https://docs.docker.com/engine/install/debian/` for details

sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

sudo apt-get install ca-certificates curl gnupg lsb-release -y

sudo apt-get install docker.io -y

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




