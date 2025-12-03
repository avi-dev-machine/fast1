# 🏋️ AI Exercise Trainer - Deployment Package

A production-ready FastAPI application for real-time exercise analysis using YOLO11 pose estimation.

![Python](https://img.shields.io/badge/Python-3.11-blue)
![FastAPI](https://img.shields.io/badge/FastAPI-0.104-green)
![Docker](https://img.shields.io/badge/Docker-Ready-blue)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 🎯 What This Does

Real-time exercise analysis and performance scoring for:
- **Push-ups** - Form quality, ROM, alignment, symmetry
- **Squats** - Depth, torso angle, knee stability, tempo
- **Sit-ups** - ROM, hip flexion, foot stability, momentum
- **Sit-and-Reach** - Flexibility, trunk mobility, symmetry
- **Skipping** - Jump height, frequency, posture
- **Jumping Jacks** - Coordination, ROM, tempo
- **Vertical Jump** - Height, power, landing control
- **Broad Jump** - Distance, technique, stability

---

## 📁 Project Files

```
fast/
├── 🐳 Deployment Files
│   ├── Dockerfile                 # Multi-stage production build
│   ├── .dockerignore             # Optimized build context
│   ├── docker-compose.yml        # Local development setup
│   ├── render.yaml               # Render configuration
│   └── railway.toml              # Railway configuration
│
├── 📚 Documentation
│   ├── DEPLOYMENT.md             # Deployment overview
│   ├── DEPLOY_RENDER.md          # Render guide
│   └── DEPLOY_RAILWAY.md         # Railway guide
│
├── 🔧 Application
│   ├── server.py                 # FastAPI REST API
│   ├── utils.py                  # Pose detection
│   ├── metrics.py                # Performance analysis
│   ├── requirements.txt          # Core dependencies
│   └── requirements_api.txt      # API dependencies
│
└── 🤖 Models
    ├── yolo11n-pose.pt          # YOLO pose model
    └── yolo11n-pose.onnx        # ONNX format (optional)
```

---

## 🚀 Quick Deploy

### Option 1: Render (Recommended)
[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

1. Click the button above or go to https://render.com
2. Connect your GitHub repository
3. Render auto-detects Dockerfile
4. Click "Create Web Service"
5. Done! ✅

**Cost:** Free tier available, $7/month for production

📖 **Full Guide:** [DEPLOY_RENDER.md](./DEPLOY_RENDER.md)

---

### Option 2: Railway
[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new)

1. Click the button above or go to https://railway.app
2. Connect GitHub repository
3. Railway auto-deploys!
4. Done! ✅

**Cost:** $5 free credit, then usage-based (~$10-25/month)

📖 **Full Guide:** [DEPLOY_RAILWAY.md](./DEPLOY_RAILWAY.md)

---

### Option 3: Docker Local
```bash
# 1. Build
docker build -t ai-exercise-trainer .

# 2. Run
docker run -p 8000:8000 ai-exercise-trainer

# 3. Test
curl http://localhost:8000/
```

---

### Option 4: Docker Compose (Development)
```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

---

## 🧪 Testing Your Deployment

Once deployed, test with these commands:

```bash
# Replace <YOUR_URL> with your deployment URL

# 1. Health Check
curl https://<YOUR_URL>/

# 2. Create Session
curl -X POST https://<YOUR_URL>/session/create

# 3. Upload Video (replace with your video path)
curl -X POST https://<YOUR_URL>/session/<SESSION_ID>/upload \
  -F "video=@video.mp4" \
  -F "exercise_type=pushup"

# 4. Start Analysis
curl -X POST https://<YOUR_URL>/session/<SESSION_ID>/analyze

# 5. Check Status
curl https://<YOUR_URL>/session/<SESSION_ID>/status

# 6. Get Report
curl https://<YOUR_URL>/session/<SESSION_ID>/report
```

---

## 📖 API Documentation

Once deployed, visit:
```
https://<YOUR_URL>/docs
```

Interactive Swagger UI for testing all endpoints.

### Main Endpoints:

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/` | Health check |
| `POST` | `/session/create` | Create new session |
| `POST` | `/session/{id}/upload` | Upload video |
| `POST` | `/session/{id}/analyze` | Start analysis |
| `GET` | `/session/{id}/status` | Check progress |
| `GET` | `/session/{id}/report` | Get results |
| `DELETE` | `/session/{id}` | Delete session |
| `GET` | `/sessions` | List all sessions |

---

## 🏗️ Architecture

```
┌────────────────┐
│   Client       │
│  (Web/Mobile)  │
└───────┬────────┘
        │ HTTPS
        ▼
┌────────────────────────────────┐
│     Cloud Platform             │
│  (Render/Railway/AWS)          │
│                                │
│  ┌──────────────────────────┐ │
│  │   FastAPI Server         │ │
│  │   - Session Management   │ │
│  │   - Video Upload         │ │
│  │   - Background Tasks     │ │
│  └──────────┬───────────────┘ │
│             │                  │
│  ┌──────────▼───────────────┐ │
│  │   YOLO11 Pose Engine     │ │
│  │   - Keypoint Detection   │ │
│  │   - Angle Calculation    │ │
│  └──────────┬───────────────┘ │
│             │                  │
│  ┌──────────▼───────────────┐ │
│  │   Metrics Engine         │ │
│  │   - Exercise Analysis    │ │
│  │   - Performance Scoring  │ │
│  └──────────────────────────┘ │
└────────────────────────────────┘
```

---

## 💰 Cost Comparison

| Platform | Free Tier | Starter | Production | Best For |
|----------|-----------|---------|------------|----------|
| **Render** | 750 hrs/month | $7/month | $25/month | Stable workloads |
| **Railway** | $5 credit | Usage-based | $20-50/month | Flexible scaling |
| **Heroku** | ❌ None | $7/month | $25/month | Legacy apps |
| **AWS ECS** | ❌ None | $15-40/month | $100+/month | Enterprise |

**Recommendation:** Render Starter ($7/month) for production

---

## 🔒 Security Features

- ✅ **HTTPS by default** (automatic SSL)
- ✅ **CORS configuration** (customizable)
- ✅ **Environment variables** for secrets
- ✅ **Input validation** (Pydantic models)
- ✅ **File type validation** (video uploads)
- ✅ **Health checks** (monitoring)

---

## 📊 Performance

### Typical Metrics:
- **Cold Start:** 5-30 seconds (free tier), <5s (paid)
- **Video Upload:** 1-5 seconds per MB
- **Analysis:** 2-10 seconds per video (depending on length)
- **Report Generation:** <1 second

### Optimization:
- ONNX model support (faster inference)
- Multi-stage Docker build (smaller images)
- Async processing (non-blocking)
- Cached dependencies (faster builds)

---

## 🐛 Troubleshooting

### Build Fails
```bash
# Check logs in your platform
# Common fix: Update requirements.txt
pip freeze > requirements.txt
```

### Out of Memory
```bash
# Upgrade to higher tier or optimize:
# - Use quantized models
# - Reduce concurrent requests
# - Stream video processing
```

### Slow Response
```bash
# Solutions:
# 1. Upgrade to paid plan (no cold starts)
# 2. Use ONNX models
# 3. Add keep-alive pings
```

---

## 🔄 Updates & Maintenance

### Deploy Updates:
```bash
git add .
git commit -m "Your changes"
git push origin main
# Platform auto-deploys! ✅
```

### Rollback:
- **Render:** Dashboard → Deployments → Select previous → Redeploy
- **Railway:** Deployments tab → Click previous deployment → Redeploy

---

## 📚 Documentation

- **[Deployment Overview](./DEPLOYMENT.md)** - Complete deployment guide
- **[Render Guide](./DEPLOY_RENDER.md)** - Step-by-step Render deployment
- **[Railway Guide](./DEPLOY_RAILWAY.md)** - Step-by-step Railway deployment
- **[API Documentation](./API_README.md)** - API endpoints and usage
- **[Testing Guide](./TESTING_GUIDE.md)** - Testing instructions

---

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## 📄 License

MIT License - See LICENSE file for details

---

## 🆘 Support

### Platform Support:
- **Render:** support@render.com
- **Railway:** https://discord.gg/railway

### Project Issues:
- GitHub Issues: [Create Issue]
- Email: your-email@example.com

---

## ⭐ Features

- ✅ **8 Exercise Types** - Comprehensive analysis
- ✅ **Real-time Processing** - Fast pose detection
- ✅ **Detailed Metrics** - Form, ROM, tempo, etc.
- ✅ **RESTful API** - Easy integration
- ✅ **Docker Ready** - Deploy anywhere
- ✅ **Auto-scaling** - Handle traffic spikes
- ✅ **Cloud Native** - Optimized for cloud platforms

---

## 🎯 Use Cases

- **Fitness Apps** - Integrate exercise analysis
- **Physical Therapy** - Track rehabilitation progress
- **Sports Training** - Analyze athlete performance
- **Virtual Coaching** - Provide real-time feedback
- **Research** - Biomechanics analysis

---

**Ready to deploy? Choose your platform and follow the guide!** 🚀

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)
[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new)

**Questions? Check the [DEPLOYMENT.md](./DEPLOYMENT.md) for comprehensive guides!**
