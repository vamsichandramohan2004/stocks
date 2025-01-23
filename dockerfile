# Step 1: Build stage
FROM maven:3.9.9-eclipse-temurin-21 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and install dependencies
COPY pom.xml ./

# Download dependencies (this will cache dependencies if there are no changes to pom.xml)
RUN mvn dependency:go-offline

# Copy the rest of the source code
COPY src /app/src

# Build the application and package it into a jar
RUN mvn clean package -DskipTests

# Step 2: Runtime stage
FROM eclipse-temurin:21-jdk AS runtime

# Set the working directory inside the container
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/portfolio-0.0.1-SNAPSHOT.jar /app/portfolio.jar

# Expose the port the app will run on
EXPOSE 8080

# Set environment variables for MySQL (you can pass these through Docker Compose or command line for flexibility)
ENV SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/portf
ENV SPRING_DATASOURCE_USERNAME=root
ENV SPRING_DATASOURCE_PASSWORD=vamsi@2004

# Run the application
ENTRYPOINT ["java", "-jar", "portfolio.jar"]
