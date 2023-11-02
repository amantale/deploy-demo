FROM eclipse-temurin:17

# Set the working directory
WORKDIR /microservice1

# Copy the application JAR file into the container
COPY target/microservice1-0.0.1-SNAPSHOT.jar /app/

# Expose the default HTTP port
EXPOSE 8080

# Run the command to start the application
CMD ["java", "-jar", "/app/microservice1-0.0.1-SNAPSHOT.jar"]