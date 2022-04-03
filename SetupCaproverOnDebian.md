# Setup Caprover On Debian 10

## Install docker

Refer `https://docs.docker.com/engine/install/debian/` for details

apt-get remove docker docker-engine docker.io containerd runc

apt-get update

apt-get install ca-certificates curl gnupg lsb-release -y

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

apt-get install docker-ce docker-ce-cli containerd.io -y


## Install caprover from docker

Refer `https://caprover.com/docs/get-started.html` for details

ufw allow 80,443,3000,996,7946,4789,2377/tcp; ufw allow 7946,4789,2377/udp;

docker run -p 80:80 -p 443:443 -p 3000:3000 -v /var/run/docker.sock:/var/run/docker.sock -v /captain:/captain caprover/caprover


## Install npm / node (we use v12)

curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -

apt update

apt install nodejs npm -y

## Setup caprover

npm install -g caprover

caprover serversetup




