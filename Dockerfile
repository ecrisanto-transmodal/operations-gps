FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app
COPY . .
RUN ./gradlew bootJar --no-daemon -x test

FROM amazoncorretto:17-alpine
WORKDIR /app-backend
COPY --from=builder /app/build/libs/operations-gps-0.0.1-SNAPSHOT.jar operations-gps-0.0.1-SNAPSHOT.jar
COPY --from=builder /app/data data
EXPOSE 4401
ENTRYPOINT ["java", "-jar", "operations-gps-0.0.1-SNAPSHOT.jar"]