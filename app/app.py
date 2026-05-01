"""
Simple Flask Application

This is the main application file.
It starts a web server and exposes a single endpoint (/).

Key Points:
- Runs on port 5000
- Bound to 0.0.0.0 so it is accessible from outside the container
- Used inside Docker and deployed on AWS EC2

Flow:
User → Load Balancer → EC2 → Docker → Flask App
"""

from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "App is running successfully!!!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
