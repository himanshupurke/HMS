# HMS - Healthcare Management System (Single-Hospital Edition)

A full-stack HIPAA-compliant HMS refactored for single-hospital use.

---

## 🚀 Unified Deployment (Recommended)
This is the easiest way to run the entire stack (Nginx + Backend + Frontend) as a single unit using the root Docker configuration.

```bash
# Build and start the unified stack
docker build -t hms-unified .
docker run -p 80:80 \
  -e SUPABASE_URL=your_url \
  -e SUPABASE_ANON_KEY=your_key \
  hms-unified
```

---

## 🛠️ Local Development

### 1. Backend (Java/Spring Boot)
To run the backend development server manually from the `hms-backend` directory, use the following command:

> [!NOTE]
> **Preferred Dev Command (Backup)**
> ```bash
> export JAVA_HOME=$(/usr/libexec/java_home -v 17) && mvn spring-boot:run \
>   -Dspring.profiles.active=local \
>   -Dspring.autoconfigure.exclude=org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration,org.springframework.boot.autoconfigure.amqp.RabbitAutoConfiguration,org.springframework.boot.autoconfigure.data.redis.RedisRepositoriesAutoConfiguration
> ```
> *This command excludes Redis and RabbitMQ dependencies for lightweight local testing.*

### 2. Frontend (Vanilla JS/CSS)
To serve the frontend assets locally:
```bash
cd hms-frontend
npx serve . -l 3000
```

---

## 📂 Project Structure
-   `/hms-backend`: Java Spring Boot API.
-   `/hms-frontend`: Vanilla JS/CSS Web UI.
-   `/nginx`: Reverse proxy and Load Balancer configuration.
-   `Dockerfile`: Root-level multi-stage build orchestrator.
-   `start.sh`: Unified service entrypoint.
