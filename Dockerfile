# Multi-stage build for AI Exercise Trainer API
# Optimized for cloud deployment (Render, Railway, etc.)

# Stage 1: Base Python image with system dependencies
FROM python:3.11-slim as base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    libgl1 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Stage 2: Install Python dependencies
FROM base as dependencies

# Copy requirements file
COPY requirements_api.txt requirements.txt ./

# Install Python packages (use --no-cache-dir to reduce image size)
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements_api.txt && \
    pip install --no-cache-dir -r requirements.txt

# Stage 3: Final application image
FROM dependencies as final

# Copy application code
COPY server.py utils.py metrics.py ./

# Copy YOLO models (pose detection)
COPY yolo11n-pose.pt yolo11n-pose.onnx ./

# Create directories for uploads and results
RUN mkdir -p uploads results

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PORT=8000 \
    HOST=0.0.0.0

# Expose port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:8000/')" || exit 1

# Run the application
CMD uvicorn server:app --host $HOST --port $PORT --workers 1
