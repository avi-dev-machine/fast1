# Optimized single-stage build for faster deployment
FROM python:3.11-slim

# Install system dependencies in one layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libgomp1 \
    libgl1 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy and install requirements (separate for better caching)
COPY requirements_api.txt requirements.txt ./
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir torch torchvision --index-url https://download.pytorch.org/whl/cpu && \
    pip install --no-cache-dir -r requirements_api.txt && \
    pip install --no-cache-dir -r requirements.txt && \
    pip cache purge

# Copy application code
COPY server.py utils.py metrics.py ./

# Copy only essential model (remove onnx if not used)
COPY yolo11n-pose.pt ./

# Create directories
RUN mkdir -p uploads results

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PORT=8000 \
    HOST=0.0.0.0 \
    PYTHONDONTWRITEBYTECODE=1

# Expose port
EXPOSE 8000

# Run the application
CMD uvicorn server:app --host $HOST --port $PORT --workers 1
