# Use the official Maven image to build the application
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory in the Docker container
WORKDIR /app

# Copy the project files to the Docker container
COPY pom.xml .
COPY src ./src

MAINTAINER Parthasarathi

# Package the application
RUN mvn clean package -DskipTests

# Use the official OpenJDK image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory in the Docker container
WORKDIR /app

# Copy the packaged JAR file from the build stage
COPY --from=build /app/target/calculator-0.0.1-SNAPSHOT.jar calculator.jar

# Expose the port that the application will run on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "calculator.jar"]
