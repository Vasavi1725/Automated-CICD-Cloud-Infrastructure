import os
from flask import Flask, jsonify

app = Flask(__name__)
APP_VERSION = os.getenv("APP_VERSION", "local-demo")

@app.get("/")
def home():
    return jsonify(message="Hello from the CI/CD demo application", version=APP_VERSION)

@app.get("/health")
def health():
    return jsonify(status="ok", version=APP_VERSION), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
