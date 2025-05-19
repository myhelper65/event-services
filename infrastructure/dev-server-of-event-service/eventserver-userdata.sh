#! /bin/bash
dnf update -y
sudo hostnamectl set-hostname event-dev-server
dnf install docker -y
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user
curl -SL https://github.com/docker/compose/releases/download/v2.29.3/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
dnf install git -y
sudo rpm --import https://yum.corretto.aws/corretto.key
sudo curl -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
sudo dnf install java-21-amazon-corretto -y
cd /home/ec2-user && git clone https://github.com/myhelper65/event-services.git
git checkout dev
newgrp docker
