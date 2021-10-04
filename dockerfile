# Pull tomcat latest image from dockerhub
FROM tomcat:8.0.51-jre8-alpine
MAINTAINER vaibhavi.warke79@gmail.com
# copy war file on to container
COPY /target/java-project.war /usr/local/tomcat/webapps/
EXPOSE  8080
USER java-project
WORKDIR /usr/local/tomcat/webapps/
CMD ["catalina.sh","run"]
