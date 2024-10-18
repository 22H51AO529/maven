# Use Maven image to build the application
FROM maven:3.6.3-jdk-8 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the contents of the current directory to /app in the container
COPY . .

# Move into the helloprint directory where the pom.xml is located
WORKDIR /app/helloprint

# Run the Maven build
RUN mvn clean package

# Use OpenJDK for running the application
FROM openjdk:8-jre

# Set the working directory for the runtime environment
WORKDIR /app

# Copy the packaged JAR from the build stage
COPY --from=build /app/helloprint/target/*.jar /app/helloprint.jar

# Command to run the application
CMD ["java", "-jar", "helloprint.jar"]
