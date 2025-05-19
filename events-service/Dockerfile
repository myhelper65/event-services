FROM eclipse-temurin:21

# Add your application JAR
ADD target/events-service-0.0.1-SNAPSHOT.jar /app.jar

# Expose the application port
EXPOSE 8081

# Set a more secure and startup-optimized Java entrypoint
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
