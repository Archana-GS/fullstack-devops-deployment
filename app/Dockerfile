# Dockerfile for Flask Application

# Use lightweight Python base image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy dependency file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose port (for documentation purpose)
EXPOSE 5000

# Start the application
CMD ["python", "app.py"]
