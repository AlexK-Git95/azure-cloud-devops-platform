from flask import Flask, jsonify
from datetime import datetime, timezone
import os
import redis

app = Flask(__name__)

SERVICE_NAME = os.getenv("SERVICE_NAME", "azure-cloud-devops-api")
APP_VERSION = os.getenv("APP_VERSION", "1.0.0")
ENVIRONMENT = os.getenv("ENVIRONMENT", "local")
REDIS_HOST = os.getenv("REDIS_HOST", "localhost")
REDIS_PORT = int(os.getenv("REDIS_PORT", "6379"))


@app.route("/")
def home():
    return jsonify({
        "message": "Azure Cloud DevOps Platform API",
        "service": SERVICE_NAME,
        "version": APP_VERSION,
        "environment": ENVIRONMENT
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy",
        "service": SERVICE_NAME,
        "timestamp": datetime.now(timezone.utc).isoformat()
    })


@app.route("/version")
def version():
    return jsonify({
        "service": SERVICE_NAME,
        "version": APP_VERSION,
        "environment": ENVIRONMENT
    })


@app.route("/api/status")
def api_status():
    return jsonify({
        "status": "running",
        "uptime_check": "ok",
        "dependencies": {
            "database": "not_configured",
            "cache": "not_configured"
        }
    })

@app.route("/redis")
def redis_check():
    try:
        client = redis.Redis(
            host=REDIS_HOST,
            port=REDIS_PORT,
            decode_responses=True
        )

        client.set("health_check", "ok")
        value = client.get("health_check")

        return jsonify({
            "redis_status": "connected",
            "redis_host": REDIS_HOST,
            "redis_port": REDIS_PORT,
            "test_key": "health_check",
            "test_value": value
        })

    except Exception as error:
        return jsonify({
            "redis_status": "error",
            "redis_host": REDIS_HOST,
            "redis_port": REDIS_PORT,
            "error": str(error)
        }), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
