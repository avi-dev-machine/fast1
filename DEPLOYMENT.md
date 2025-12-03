# 🚀 AI Exercise Trainer - Cloud Deployment Guide

Complete deployment structure for cloud platforms (Render, Railway, Heroku, AWS, etc.)

---

## 📁 Project Structure

```
fast/
├── Dockerfile                  # Multi-stage Docker build
├── .dockerignore              # Exclude unnecessary files from Docker
├── render.yaml                # Render Blueprint configuration
├── railway.toml               # Railway configuration
├── requirements.txt           # Core Python dependencies
├── requirements_api.txt       # FastAPI backend dependencies
│
├── server.py                  # FastAPI application
├── utils.py                   # Pose detection utilities
├── metrics.py                 # Performance metrics
│
├── yolo11n-pose.pt           # YOLO pose detection model
├── yolo11n-pose.onnx         # ONNX format (optional)
│
├── DEPLOY_RENDER.md          # Render deployment guide
├── DEPLOY_RAILWAY.md         # Railway deployment guide
└── DEPLOYMENT.md             # This file
```

---

## 🎯 Quick Start (Choose Your Platform)

### Option 1: Render (Recommended for Beginners)
```bash
# 1. Push to GitHub
git init && git add . && git commit -m "Deploy to Render"
git push origin main

# 2. Go to https://render.com
# 3. New Web Service → Connect GitHub repo
# 4. Render auto-detects Dockerfile
# 5. Deploy! ✅
```
📖 **Detailed Guide:** [DEPLOY_RENDER.md](./DEPLOY_RENDER.md)

---

### Option 2: Railway (Fastest Deployment)
```bash
# 1. Push to GitHub
git init && git add . && git commit -m "Deploy to Railway"
git push origin main

# 2. Go to https://railway.app
# 3. New Project → Deploy from GitHub
# 4. Railway auto-deploys! ✅
```
📖 **Detailed Guide:** [DEPLOY_RAILWAY.md](./DEPLOY_RAILWAY.md)

---

### Option 3: Docker Locally (Testing)
```bash
# Build Docker image
docker build -t ai-exercise-trainer .

# Run container
docker run -p 8000:8000 ai-exercise-trainer

# Test API
curl http://localhost:8000/
```

---

## 🏗️ Architecture Overview

### Application Stack
```
┌─────────────────────────────────────────┐
│         Client (Web/Mobile)             │
│   POST /upload, GET /report, etc.       │
└──────────────┬──────────────────────────┘
               │ HTTPS
               ▼
┌─────────────────────────────────────────┐
│        Cloud Platform                   │
│   (Render / Railway / AWS)              │
│   ┌─────────────────────────────────┐   │
│   │   FastAPI Server (Uvicorn)      │   │
│   │   - Session Management          │   │
│   │   - Video Upload                │   │
│   │   - Background Processing       │   │
│   └──────────┬──────────────────────┘   │
│              │                           │
│   ┌──────────▼──────────────────────┐   │
│   │   YOLO11 Pose Estimation        │   │
│   │   - Keypoint Detection          │   │
│   │   - Angle Calculation           │   │
│   └──────────┬──────────────────────┘   │
│              │                           │
│   ┌──────────▼──────────────────────┐   │
│   │   Performance Metrics           │   │
│   │   - Exercise Analysis           │   │
│   │   - Scoring & Feedback          │   │
│   └─────────────────────────────────┘   │
└─────────────────────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────┐
│         Storage                         │
│   - Uploaded Videos (/uploads)          │
│   - Analysis Results (/results)         │
│   - Session Data (in-memory)            │
└─────────────────────────────────────────┘
```

---

## 🔧 Configuration Files Explained

### 1. **Dockerfile**
Multi-stage build optimized for cloud deployment:
- **Stage 1:** System dependencies (OpenCV, FFmpeg)
- **Stage 2:** Python dependencies
- **Stage 3:** Application code and models

**Key Features:**
- Minimal image size (~800 MB)
- Cached dependency layers
- Health check included
- Port configuration via ENV

---

### 2. **.dockerignore**
Excludes unnecessary files from Docker build:
- Python cache (`__pycache__`)
- Virtual environments
- Test files
- Documentation
- Large video files

**Benefit:** Faster builds, smaller images

---

### 3. **render.yaml**
Infrastructure as Code for Render:
- Auto-detects Dockerfile
- Sets environment variables
- Configures health checks
- Enables auto-deploy

**Usage:** Deploy via Render Blueprint

---

### 4. **railway.toml**
Configuration for Railway platform:
- Specifies Dockerfile
- Sets start command
- Configures health checks
- Defines restart policy

**Usage:** Railway auto-detects and uses

---

## 📊 Platform Comparison

| Feature | Render | Railway | Heroku | AWS ECS |
|---------|--------|---------|--------|---------|
| **Free Tier** | ✅ 750 hrs/month | ✅ $5 credit | ❌ Paid only | ❌ Paid only |
| **Docker Support** | ✅ Native | ✅ Native | ✅ Container | ✅ Native |
| **Auto-Deploy** | ✅ Yes | ✅ Yes | ✅ Yes | ⚠️ Manual |
| **Custom Domain** | ✅ Free SSL | ✅ Free SSL | ✅ Paid | ✅ Route53 |
| **Build Time** | ~5-10 min | ~3-7 min | ~8-12 min | Varies |
| **Cold Start** | ~30 sec (free) | ~5-10 sec | ~30 sec | None |
| **Pricing (Starter)** | $7/month | Usage-based | $5-7/month | Pay-as-go |
| **Best For** | Production | Dev/Testing | Legacy apps | Enterprise |

---

## 💰 Cost Estimates

### Render
- **Free Tier:** $0/month (with limitations)
- **Starter:** $7/month (recommended)
- **Standard:** $25/month (high traffic)

### Railway
- **Trial:** $5 free credit
- **Hobby:** ~$10-25/month (usage-based)
- **Pro:** ~$30-50/month

### AWS ECS (Fargate)
- **Typical:** $15-40/month
- **High Traffic:** $100+/month

**Recommendation:** Start with Render Free → Upgrade to Starter ($7/month) for production

---

## 🔐 Security Checklist

- [ ] Use environment variables for secrets
- [ ] Enable HTTPS (automatic on Render/Railway)
- [ ] Configure CORS properly
- [ ] Add rate limiting
- [ ] Set file upload size limits
- [ ] Validate video file types
- [ ] Use secure session management
- [ ] Regular dependency updates

---

## 📈 Scaling Strategy

### Vertical Scaling (More Resources)
1. **Render:** Upgrade plan (Starter → Standard)
2. **Railway:** Auto-scales with usage
3. **AWS:** Increase task CPU/memory

### Horizontal Scaling (More Instances)
1. **Render:** Add replicas (Standard+ plan)
2. **Railway:** Set `numReplicas` in railway.toml
3. **AWS:** Increase desired task count

### Optimization
- Use ONNX models (faster inference)
- Cache model in memory
- Async video processing
- Redis for session management
- CDN for static assets

---

## 🐛 Common Issues & Solutions

### 1. **Build Fails**
**Error:** `ModuleNotFoundError`
```bash
# Solution: Add missing package to requirements.txt
pip freeze | grep <package-name> >> requirements.txt
```

### 2. **Out of Memory**
**Error:** `Container killed (OOMKilled)`
```bash
# Solution: Upgrade plan or optimize:
- Use quantized models
- Reduce concurrent requests
- Stream video processing
```

### 3. **Slow Cold Starts**
**Error:** 30+ second response time
```bash
# Solution:
- Upgrade to paid plan (no sleep)
- Add keep-alive endpoint
- Use smaller model (yolo11n vs yolo11s)
```

### 4. **Port Binding Error**
**Error:** `Address already in use`
```bash
# Solution: Ensure Dockerfile uses $PORT
CMD uvicorn server:app --host 0.0.0.0 --port $PORT
```

---

## 📚 Resources

### Deployment Guides
- [Render Guide](./DEPLOY_RENDER.md)
- [Railway Guide](./DEPLOY_RAILWAY.md)

### Documentation
- [FastAPI Deployment](https://fastapi.tiangolo.com/deployment/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Render Docs](https://render.com/docs)
- [Railway Docs](https://docs.railway.app)

### Tutorials
- [API Documentation](./API_README.md)
- [Testing Guide](./TESTING_GUIDE.md)

---

## 🎉 Success Checklist

### Pre-Deployment
- [ ] All code tested locally
- [ ] Dependencies in requirements files
- [ ] Dockerfile builds successfully
- [ ] Environment variables documented
- [ ] .dockerignore configured

### Deployment
- [ ] Code pushed to GitHub
- [ ] Platform account created
- [ ] Service deployed
- [ ] Build successful
- [ ] Health check passing

### Post-Deployment
- [ ] API endpoints tested
- [ ] Logs reviewed
- [ ] Monitoring configured
- [ ] Custom domain set (optional)
- [ ] Documentation updated

---

## 🆘 Getting Help

### Render Support
- Email: support@render.com
- Docs: https://render.com/docs
- Status: https://status.render.com

### Railway Support
- Discord: https://discord.gg/railway
- Docs: https://docs.railway.app
- Status: https://railway.statuspage.io

### Project Issues
- GitHub Issues: [Create Issue]
- Email: your-email@example.com

---

**Congratulations! Your AI Exercise Trainer is now deployable to any cloud platform! 🚀**

**Next Steps:**
1. Choose your deployment platform
2. Follow the detailed guide
3. Deploy and test
4. Monitor and optimize

Happy Deploying! 💪
