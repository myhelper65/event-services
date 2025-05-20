./mvnw clean package
# Assuming Dockerfiles are in these folders:
docker build -t "events-service:dev" ./events-service
docker build -t "registration-service:dev" ./registration-service

#If you want both: build images individually first then use Docker Compose, you can do Then bring up your full environment
# docker-compose up