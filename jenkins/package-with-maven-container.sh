# docker run --rm -v $HOME/.m2:/root/.m2 -v $WORKSPACE:/app -w /app maven:3.9.6-eclipse-temurin-21  mvn clean package

#below command will ensure to user docker profile docker
docker run --rm \
  -v $HOME/.m2:/root/.m2 \
  -v $WORKSPACE:/app \
  -w /app \
  maven:3.9.6-eclipse-temurin-21 \
  mvn clean package -Dspring.profiles.active=docker