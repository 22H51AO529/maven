# Use Maven to build the project
FROM maven:3.6.3-jdk-8 AS build

# Set the working directory to /app inside the container
WORKDIR /app

# Copy the contents of your local working directory (C:\Users\kaila\OneDrive\Desktop\maven) to /app in the container
COPY . .

# Run Maven to clean and package the application
RUN mvn clean package

# Use OpenJDK for the runtime
FROM openjdk:8-jre

# Set the working directory to /app inside the container for the runtime
WORKDIR /app

# Copy the packaged JAR file from the build stage
COPY --from=build /app/target/helloworld-maven-0.0.1-SNAPSHOT-jar-with-dependencies.jar .

# Specify the entry point for the container
ENTRYPOINT ["java", "-jar", "helloworld-maven-0.0.1-SNAPSHOT-jar-with-dependencies.jar"]
