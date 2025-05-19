./mvnw clean package
# Assuming Dockerfiles are in these folders:
docker build -t "events-service:dev" ./events-service
docker build -t "registration-service:dev" ./registration-service

