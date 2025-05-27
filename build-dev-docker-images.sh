./mvnw clean package
# Assuming Dockerfiles are in these folders:
docker build -t "events-service:dev" ./events-service
docker build -t "registration-service:dev" ./registration-service

docker pull mongo:5.0
docker tag mongo:5.0 mongo:dev

docker pull postgres:14
docker tag postgres:14 postgres:dev

#If you want both: build images individually first then use Docker Compose, you can do Then bring up your full environment
# docker-compose up