# Use Maven image for building the application
FROM maven:3.8.6-openjdk-8 AS build

# Set the working directory
WORKDIR /app

# Copy the entire project files to the container
COPY . .

# Build the application
RUN mvn clean package

# Use a slim OpenJDK image for running the application
FROM openjdk:8-jre-slim

# Set the working directory for the runtime image
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/*.jar /app/hello-world.jar

# Specify the command to run the application
ENTRYPOINT ["java", "-jar", "/app/hello-world.jar"]
