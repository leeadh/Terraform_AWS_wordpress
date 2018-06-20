#!/bin/bash -xe
whoami
sudo apt-get -y update
sudo apt-get install -y mysql-client

# Install docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce
usermod -aG docker ubuntu

# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

env "export AWS_ACCESS_KEY_ID='XXX'">>/etc/init/docker.override
env "export AWS_SECRET_ACCESS_KEY='YYY'">>/etc/init/docker.override

sudo service docker restart

# ddocker up
sudo docker run --log-driver="awslogs" --log-opt awslogs-group="docker-logs" --log-opt awslogs-stream="docker-logs" -d -e WORDPRESS_DB_HOST=${dbhost}:3306 -e WORDPRESS_DB_PASSWORD=wpdbwpdb -e WORDPRESS_DB_USER=wpdb -e WORDPRESS_DB_NAME=wpdb -p 80:80 wordpress:latest 


