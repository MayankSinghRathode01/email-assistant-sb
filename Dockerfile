# Build stage
FROM maven:3.9.4-eclipse-temurin-21 AS builder
WORKDIR /app

# Copy Maven wrapper files first to leverage layer caching
COPY .mvn/ .mvn/
COPY mvnw mvnw.cmd ./
RUN chmod +x ./mvnw

# Copy the project files
COPY pom.xml ./
COPY src ./src/

# Build using Maven Wrapper with cache
RUN --mount=type=cache,id=maven-repo:/root/.m2/repository \
    ./mvnw clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]