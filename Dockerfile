# Use Maven with JDK 8 for building the application
FROM maven:3.6.3-jdk-8 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml file from the target directory
COPY target/pom.xml .

# Download all dependencies (this helps with caching)
RUN mvn dependency:go-offline

# Copy the rest of your source code
COPY target/ .

# Build the application
RUN mvn clean package

# Use OpenJDK for running the application
FROM openjdk:8-jre

# Set the working directory
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/helloworld-maven-0.0.1-SNAPSHOT-jar-with-dependencies.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
