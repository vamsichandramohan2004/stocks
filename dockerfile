# Use an official OpenJDK runtime as a parent image
FROM openjdk:21-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the application JAR file into the container
COPY target/portfolio-0.0.1-SNAPSHOT.jar portfolio.jar

# Expose the application port
EXPOSE 8080

# Set environment variables for the application (optional; override with Docker Compose)
ENV SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3307/portf

ENV SPRING_DATASOURCE_USERNAME=root
ENV SPRING_DATASOURCE_PASSWORD=vamsi@2004/01/02
ENV SPRING_JPA_HIBERNATE_DDL_AUTO=update
ENV SPRING_JPA_PROPERTIES_HIBERNATE_DIALECT=org.hibernate.dialect.MySQL8Dialect

# Run the application
ENTRYPOINT ["java", "-jar", "portfolio.jar"]