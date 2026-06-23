from flask import Flask, jsonify
from datetime import datetime, timezone
import os


app = Flask(__name__)

SERVICE_NAME = os.getenv("SERVICE_NAME", "azure-cloud-devops-api")
APP_VERSION = os.getenv("APP_VERSION", "1.0.0")
ENVIRONMENT = os.getenv("ENVIRONMENT", "local")


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


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
