#!/bin/bash


echo "pulling the lastest versions for all microservices"
docker pull deploydemo.jfrog.io/docker/microservice1:lastest
docker pull deploydemo.jfrog.io/docker/microservice2:latest

echo "starting the microservices"
docker run -p 8080:8080 deploydemo.jfrog.io/docker/microservice1:lastest
echo "microservice1 was started on port 8080"
docker run -p 8081:8081 deploydemo.jfrog.io/docker/microservice2:lastest
echo "microservice2 was started on port 8081"