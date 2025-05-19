FROM eclipse-temurin:21
ENV SPRING_PROFILES_ACTIVE docker
# Add your application JAR

COPY ./target/*.jar /app.jar
# Expose the application port
EXPOSE 8081

# Set a more secure and startup-optimized Java entrypoint
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
