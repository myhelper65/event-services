echo 'Running Unit Tests on event server Application'
docker run --rm \
  -v /var/lib/jenkins/.m2:/root/.m2 \
  -v /var/lib/jenkins/workspace/event-ci-job:/app \
  -w /app \
  maven:3.9.6-eclipse-temurin-21 \
  mvn clean test -Dspring.profiles.active=docker

