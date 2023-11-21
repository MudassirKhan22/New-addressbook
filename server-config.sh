#! /bin/bash

sudo yum install git -y
sudo yum install docker -y
sudo systemctl start docker

if [ -d "New-addressbook" ]
then
    echo "Repository is already cloned  and exist"
    cd /home/ec2-user/New-addressbook
    git pull origin cicd-docker
else
    git clone https://github.com/MudassirKhan22/New-addressbook.git
fi
    cd /home/ec2-user/New-addressbook
    git checkout cicd-docker
    sudo docker build -t $1:$2 /home/ec2-user/New-addressbook
