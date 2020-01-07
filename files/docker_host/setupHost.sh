#!/bin/bash

# Notes

# - Need to change the Tower Password to "admin"
# - Need to setup tower - fix the SCM https://github.com/jmcalalang/Agility-2020---AnO-Tool-Chain---Advanced-Design-Patterns-with-AS3-DO-and-TS - fix the 
# - Need to turn off ssl cert verification in Postman
# - Default passwords for BIG-IP's?
# - Create Bookmarks
# - Get License Pool - F5-BIG-VEP7-1G-4-V13-LIC
# - Update the linux host

# Create Ethernet 1
# cat > /etc/sysconfig/network-scripts/ifcfg-eth1 <<- "EOF"
# DEVICE="eth1"
# BOOTPROTO="dhcp"
# ONBOOT="yes"
# TYPE="Ethernet"
# EOF

# Create Ethernet 2
# cat > /etc/sysconfig/network-scripts/ifcfg-eth2 <<- "EOF"
# DEVICE="eth2"
# BOOTPROTO="dhcp"
# ONBOOT="yes"
# TYPE="Ethernet"
# EOF


# Update Host
# sudo yum -y update

# Install GIT
sudo yum install git

# Git working repository
wget https://github.com/jmcalalang/Agility-2020---AnO-Tool-Chain---Advanced-Design-Patterns-with-AS3-DO-and-TS

# Install Docker
sudo curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo systemctl start docker
sudo service docker start
sudo usermod -aG docker cloud-user
echo -e "Default \e[34mDocker installed\e[0m"

# Create the persistant storage for our containers
mkdir ~/Container_Content
mkdir ~/Container_Content/consul
sudo chown -R 1001:1001 ~/Container_Content/consul/
mkdir ~/Container_Content/gitlab
mkdir ~/Container_Content/gitlab/config
mkdir ~/Container_Content/gitlab/data
mkdir ~/Container_Content/gitlab/logs
mkdir ~/Container_Content/nginx_html
	
echo -e "Default \e[97mPersistant storage for our containers created\e[0m"

# Create lab containers
sudo docker run --restart=unless-stopped -d -p 8080:80 --name nginx01 -v ~/Container_Content/nginx_html:/usr/share/nginx/html:ro nginx:latest
sudo docker run --restart=unless-stopped -d -p 8081:3000 --name juice-shop bkimminich/juice-shop
sudo docker run --restart=unless-stopped -d -p 8300:8300 -p 8301:8301 -p 8500:8500 -p 8600:8600 --name consul -v ~/Container_Content/consul:/bitnami bitnami/consul:latest
sudo docker run --restart=unless-stopped -d -p 8501:80 -p 8443:443 -p 8222:22 --name gitlab --hostname gitlab.example.com -v ~/Container_Content/gitlab/config:/etc/gitlab -v ~/Container_Content/gitlab/logs:/var/log/gitlab -v ~/Container_Content/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:latest
echo -e "Default \e[96mContainers created\e[0m"

# Create static page for NGiNX
cat > ~/Container_Content/nginx_html/index.html <<- "EOF"
<!DOCTYPE html>
<html>

<head>
  <style>
    img {
      width: 100%;
    }
  </style>
</head>

<body>

  <img src="https://raw.githubusercontent.com/jmcalalang/Agility-2020---AnO-Tool-Chain---Advanced-Design-Patterns-with-AS3-DO-and-TS/master/docs/intro/images/image1.png" alt="f5.com">

</body>

</html>"
EOF
echo -e "Default \e[98mNGiNX static page created\e[0m"