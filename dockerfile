# Use Maven with Java 21 for building the application
FROM maven:3.9.4-eclipse-temurin-21 AS build

# Set the working directory
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Use OpenJDK 21 runtime for running the application
FROM eclipse-temurin:21-jdk

# Set the working directory
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /app/target/portfolio-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]