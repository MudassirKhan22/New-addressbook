FROM tomcat:8.5.72-jdk8-openjdk-buster


# Define the Maven version and download URL
ENV MAVEN_VERSION 3.8.4
ENV MAVEN_DOWNLOAD_URL https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.8.4/apache-maven-3.8.4-bin.tar.gz

# Create a directory for Maven installation
RUN mkdir -p /usr/share/maven

# Download and extract Maven
RUN curl -fsSL $MAVEN_DOWNLOAD_URL -o /tmp/apache-maven.tar.gz \
    && tar -xzvf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
    && rm -f /tmp/apache-maven.tar.gz

# Set environment variables for Maven
ENV MAVEN_HOME /usr/share/maven
ENV PATH $MAVEN_HOME/bin:$PATH

#Create a work directory in the container
WORKDIR /app

#Copy the file from host in to the container.
COPY ./pom.xml ./pom.xml

#Copy the source code from host in to the container
COPY ./src ./src

#Packing the application
RUN mvn package

#Cleaning the tomcat directory
RUN rm -rf /usr/local/tomcat/webapps/*

#Copy the war file in to the webapps directory
RUN cp /app/target/addressbook.war /usr/local/tomcat/webapps/

#Exposing the application to the world
EXPOSE 8080

#It is used to start the tomcat server in the foreground!!
CMD ["catalina.sh", "run"]