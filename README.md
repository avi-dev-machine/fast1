---
title: AI Exercise Trainer
emoji: 🏋️
colorFrom: blue
colorTo: green
sdk: docker
pinned: false
license: mit
app_port: 8000
---

# 🏋️ AI Exercise Trainer API

Real-time exercise analysis and performance scoring using YOLO11 pose estimation.

## 🎯 Features

- **8 Exercise Types:** Push-ups, Squats, Sit-ups, Sit-and-Reach, Skipping, Jumping Jacks, Vertical Jump, Broad Jump
- **Real-time Analysis:** YOLO11 pose detection with 17 keypoints
- **Performance Metrics:** Form quality, ROM, tempo, symmetry, and more
- **REST API:** Session-based video upload and analysis

## 🚀 API Endpoints

- `POST /session/create` - Create new session
- `POST /session/{id}/upload` - Upload video
- `POST /session/{id}/analyze` - Start analysis
- `GET /session/{id}/status` - Check progress
- `GET /session/{id}/report` - Get results

## 📖 Documentation

Visit `/docs` for interactive API documentation (Swagger UI).

## 🔗 Links

- [GitHub Repository](https://github.com/avi-dev-machine/fast1)
- [API Documentation](https://huggingface.co/spaces/YOUR_USERNAME/ai-exercise-trainer/docs)
