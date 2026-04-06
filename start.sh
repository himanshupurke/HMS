#!/bin/sh

echo "🚀 Starting HMS Unified Stack..."

# 1. Inject Frontend Environment Variables
# Reuses the existing logic from the frontend entrypoint
if [ -f "/app/frontend-entrypoint.sh" ]; then
    echo "⚙️ Injecting frontend configuration..."
    # We pass 'true' to just run the injection part and then exit the script
    /app/frontend-entrypoint.sh echo "Injection complete"
fi

# 2. Start Nginx in the background
echo "🌐 Starting Nginx Reverse Proxy..."
nginx &

# 3. Start Java Backend in the foreground
echo "☕ Starting Java Backend..."
# Use container support for memory limits
exec java -XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -jar /app/app.jar
