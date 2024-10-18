# Use the official Maven image to build the application
FROM maven:3.6.3-jdk-8 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml file into the container
COPY helloprint/pom.xml .

# Download all dependencies (this helps with caching)
RUN mvn dependency:go-offline

# Copy the source code into the container
COPY helloprint/src ./src

# Build the application
RUN mvn clean package

# Use OpenJDK for running the application
FROM openjdk:8-jre

# Copy the built jar file from the build stage
COPY --from=build /app/target/helloworld-maven-0.0.1-SNAPSHOT-jar-with-dependencies.jar /usr/local/bin/helloworld-maven.jar

# Command to run the application
CMD ["java", "-jar", "/usr/local/bin/helloworld-maven.jar"]
