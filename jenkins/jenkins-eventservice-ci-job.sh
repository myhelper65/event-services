echo 'Running Unit Tests on event server Application'

docker run --rm \
  -v $HOME/.m2:/root/.m2 \
  -v "$(pwd)":/app \
  -w /app \
  maven:3.9.6-eclipse-temurin-21 \
  mvn clean test