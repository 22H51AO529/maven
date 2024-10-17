# Use Maven image for building the application
FROM maven:3.6.3-jdk-8 AS build

# Set the working directory
WORKDIR /app

# Copy the entire project files to the container
COPY . .

# Build the application
RUN mvn clean package

# Use OpenJDK for running the application
FROM openjdk:8-jre

# Set the working directory for the runtime image
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/helloworld-maven-0.0.1-SNAPSHOT-jar-with-dependencies.jar /app/hello-world.jar

# Specify the command to run the application
ENTRYPOINT ["java", "-jar", "/app/hello-world.jar"]
