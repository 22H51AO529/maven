# Use Maven to build the project
FROM maven:3.6.3-jdk-8 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy only the pom.xml first
COPY pom.xml .

# Download all dependencies (this helps with caching)
RUN mvn dependency:go-offline

# Copy the rest of the project
COPY . .

# Run Maven to clean and package the application
RUN mvn clean package

# Use OpenJDK for the runtime
FROM openjdk:8-jre

# Set the working directory to /app inside the container for the runtime
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/helloworld-maven-0.0.1-SNAPSHOT-jar-with-dependencies.jar .

# Specify the entry point for the container
ENTRYPOINT ["java", "-jar", "helloworld-maven-0.0.1-SNAPSHOT-jar-with-dependencies.jar"]
