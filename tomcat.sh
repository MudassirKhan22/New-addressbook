#1 /bin/bash

sudo yum install tomcat -y
NEW_PORT="9090" 
SERVER_XML="/usr/share/tomcat/conf/server.xml"

if grep -q 'Connector port="8080"' "$SERVER_XML"; then
    sed -i "s/Connector port=\"8080\"/Connector port=\"$NEW_PORT\"/" "$SERVER_XML"
    echo "Tomcat HTTP port set to $NEW_PORT"
else
    echo "Tomcat HTTP port already set to $NEW_PORT"
fi
sudo systemctl start tomcat
cd /usr/share/tomcat/webapps
if [ -f "addressbook.war" ]
then
    echo "War File is already available"
else
    cp /home/ec2-user/New-addressbook/target/addressbook.war ./

