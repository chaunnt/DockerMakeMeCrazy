 

echo "Setup Caprover On Oracle Linux 8"
echo "Install docker"
dnf install -y dnf-utils zip unzip
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf remove -y runc
dnf install -y docker-ce --nobest
systemctl enable docker.service
systemctl start docker.service

docker info
docker version

echo "Open firewall ports"
#ufw allow 80,443,3000,996,7946,4789,2377/tcp; ufw allow 7946,4789,2377/udp;
# Open Docker Swarm management port
sudo firewall-cmd --permanent --add-port=2377/tcp

# Open for cluster communication (TCP and UDP)
sudo firewall-cmd --permanent --add-port=7946/tcp
sudo firewall-cmd --permanent --add-port=7946/udp

# Open overlay network communication (UDP only)
sudo firewall-cmd --permanent --add-port=4789/udp

sudo firewall-cmd --permanent --add-service=http

sudo firewall-cmd --permanent --add-service=https

# Open admin panel port 
sudo firewall-cmd --permanent --add-port=3000/tcp
sudo firewall-cmd --permanent --add-port=3000/udp

# Apply the changes
sudo firewall-cmd --reload

echo "install caprover from docker image"
docker run -p 80:80 -p 443:443 -p 3000:3000 -e BY_PASS_PROXY_CHECK='TRUE' -e ACCEPTED_TERMS=true -v /var/run/docker.sock:/var/run/docker.sock -v /captain:/captain caprover/caprover

echo "Install npm / node"
dnf install curl -y
curl -sL https://rpm.nodesource.com/setup_20.x | bash -
dnf install nodejs -y
node -v
npm -v

echo "Setup caprover"
#npm install -g caprover

echo  "{\"skipVerifyingDomains\":\"true\"}" >  /captain/data/config-override.json

caprover serversetup

