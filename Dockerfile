# Stage 1: Build Backend (Java/Maven)
FROM eclipse-temurin:17-jdk-alpine AS backend-build
WORKDIR /app
COPY hms-backend/pom.xml .
COPY hms-backend/.mvn .mvn
COPY hms-backend/mvnw .
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B
COPY hms-backend/src src
RUN ./mvnw package -DskipTests -B

# Final Stage: Unified Container
FROM eclipse-temurin:17-jre-alpine

# Install Nginx
RUN apk add --no-cache nginx

# Create necessary directories
RUN mkdir -p /run/nginx /app/logs /usr/share/nginx/html/js

# Set up Nginx config
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Set up Static Frontend files
WORKDIR /usr/share/nginx/html
COPY hms-frontend/ .

# Set up Backend JAR
WORKDIR /app
COPY --from=backend-build /app/target/*.jar app.jar

# Set up Entrypoint and Startup scripts
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Re-use the existing frontend-injection script for runtime env-vars
COPY hms-frontend/docker-entrypoint.sh /app/frontend-entrypoint.sh
RUN chmod +x /app/frontend-entrypoint.sh

# Expose Web (Nginx) and API (Internal port for health checks)
EXPOSE 80 8080

# Environment Variable defaults (these can be overridden at runtime)
ENV PORT=80

ENTRYPOINT ["/app/start.sh"]
