#! /bin/bash
sudo yum install git -y
sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install maven install -y
if[ -d "New-addressbook" ]
then
    echo "Repository is already cloned  and exist"
    cd /home/ec2-user/New-addressbook
    git pull origin startJenkins
else
    git clone https://github.com/MudassirKhan22/New-addressbook.git
fi
    cd /home/ec2-user/New-addressbook
    mvn package
    
