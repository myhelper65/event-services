FROM eclipse-temurin:21

# Add your application JAR to a consistent path
ADD target/registration-service-0.0.1-SNAPSHOT.jar /app.jar

# Expose the application port
EXPOSE 8080

# Secure and optimized Java entrypoint
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
