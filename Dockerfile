#Docker base image
FROM alpine/git
WORKDIR /app
RUN git clone https://github.com/ggsre/helloworld.git

FROM maven:3.5-jdk-8-alpine
WORKDIR /app
COPY --from=0 /app/helloworld /app
RUN mvn install 

FROM openjdk:8-jre-alpine
#Set the working directory for RUN and ADD commands
WORKDIR /app
COPY --from=1 /app/target/helloworld-0.0.1-SNAPSHOT.jar /app 

#Port the container listens on
EXPOSE 8080 

#CMD to be executed when docker is run.
ENTRYPOINT ["java","-jar","helloworld-0.0.1-SNAPSHOT.jar"]
