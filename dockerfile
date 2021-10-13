FROM openjdk:8-jdk-alpine
MAINTAINER vaibhavi.warke79@gmail.com
# copy war file on to container
COPY /target/spring-boot-rest-example-0.5.0.war /opt
EXPOSE  8091
EXPOSE 8090
#USER jenkins
ENTRYPOINT ["java","-jar","-Dspring.profiles.active=mysql", "/opt/spring-boot-rest-example-0.5.0.war"]
