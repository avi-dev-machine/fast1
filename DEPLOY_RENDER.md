# Deployment Guide for Render

## 🚀 AI Exercise Trainer - Render Deployment

### Prerequisites
- GitHub account (for deploying from repository)
- Render account (free tier available at https://render.com)

---

## 📋 Deployment Steps

### 1. Prepare Your Repository

Push your project to GitHub:
```bash
git init
git add .
git commit -m "Initial commit for Render deployment"
git branch -M main
git remote add origin <your-github-repo-url>
git push -u origin main
```

### 2. Create New Web Service on Render

1. Go to https://dashboard.render.com
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository
4. Select the repository containing this project

### 3. Configure Build Settings

**Basic Settings:**
- **Name:** `ai-exercise-trainer` (or your preferred name)
- **Region:** Choose closest to your users
- **Branch:** `main`
- **Root Directory:** Leave blank (unless project is in subdirectory)

**Build & Deploy:**
- **Runtime:** `Docker`
- **Dockerfile Path:** `./Dockerfile` (automatically detected)

**Instance Type:**
- **Free Tier:** 512 MB RAM, 0.1 CPU (for testing)
- **Starter:** $7/month, 512 MB RAM, 0.5 CPU (recommended for light production)
- **Standard:** $25/month, 2 GB RAM, 1 CPU (for production with moderate traffic)

### 4. Environment Variables

Add these environment variables in Render dashboard:

| Variable | Value | Description |
|----------|-------|-------------|
| `PORT` | `8000` | Port for the application (auto-set by Render) |
| `HOST` | `0.0.0.0` | Listen on all interfaces |
| `PYTHON_VERSION` | `3.11` | Python runtime version |

### 5. Advanced Settings (Optional)

**Health Check Path:** `/`
- This ensures Render monitors your API health

**Auto-Deploy:**
- Enable "Auto-Deploy" to automatically deploy on git push

---

## 🔧 Configuration Files

### render.yaml (Alternative: Infrastructure as Code)

Create a `render.yaml` file for automated deployment:

```yaml
services:
  - type: web
    name: ai-exercise-trainer
    runtime: docker
    dockerfilePath: ./Dockerfile
    plan: starter  # or free
    region: oregon  # choose your region
    healthCheckPath: /
    envVars:
      - key: PYTHON_VERSION
        value: 3.11
      - key: PORT
        value: 8000
    autoDeploy: true
```

Then deploy using Render Blueprint:
- Go to Dashboard → **"New" → "Blueprint"**
- Connect repository and Render will auto-configure

---

## 📦 Build Process

Render will:
1. Clone your repository
2. Build Docker image using your Dockerfile
3. Install all dependencies from requirements files
4. Copy YOLO models and application code
5. Start the FastAPI server with Uvicorn

**Build Time:** ~5-10 minutes (first build)

---

## 🌐 Access Your API

Once deployed, Render provides a URL:
```
https://ai-exercise-trainer-<unique-id>.onrender.com
```

### Test Endpoints:
```bash
# Health check
curl https://ai-exercise-trainer-<unique-id>.onrender.com/

# Create session
curl -X POST https://ai-exercise-trainer-<unique-id>.onrender.com/session/create

# API Documentation
https://ai-exercise-trainer-<unique-id>.onrender.com/docs
```

---

## 📊 Monitoring & Logs

### View Logs:
- Go to your service dashboard
- Click **"Logs"** tab
- Real-time logs from your application

### Metrics:
- **CPU Usage**
- **Memory Usage**
- **Request Latency**
- **HTTP Status Codes**

### Set Up Alerts:
- Configure email/Slack notifications for:
  - High CPU usage
  - High memory usage
  - Service downtime

---

## 🔄 Updates & Redeploy

### Automatic Deploy:
Push to GitHub:
```bash
git add .
git commit -m "Update exercise logic"
git push origin main
```
Render auto-deploys if "Auto-Deploy" is enabled.

### Manual Deploy:
- Go to service dashboard
- Click **"Manual Deploy"** → **"Deploy latest commit"**

---

## 💰 Cost Optimization

### Free Tier Limitations:
- Service spins down after 15 minutes of inactivity
- First request after spin-down takes ~30-60 seconds (cold start)
- 750 hours/month free (enough for 1 service)

### Recommendations:
- **Development/Testing:** Use Free tier
- **Production:** Use Starter ($7/month) or Standard ($25/month)
- **High Traffic:** Consider Standard+ with autoscaling

---

## 🐛 Troubleshooting

### Build Fails:
- Check **Logs** for error messages
- Verify `Dockerfile` syntax
- Ensure all files in `.dockerignore` are correct

### Service Won't Start:
- Check if `PORT` environment variable is set
- Verify `uvicorn` command in Dockerfile
- Check YOLO model files are included

### Out of Memory:
- Upgrade to higher tier plan
- Optimize model loading (use quantized models)
- Reduce worker count in Dockerfile

### Slow Response:
- Cold start issue on Free tier (upgrade to paid plan)
- Model loading time (cache models in memory)
- Large video uploads (optimize video size)

---

## 🔒 Security Best Practices

1. **Environment Variables:** Never commit sensitive data to Git
2. **CORS:** Configure allowed origins in `server.py`
3. **Rate Limiting:** Add rate limiting middleware for production
4. **File Upload Limits:** Set max video file size in FastAPI config

---

## 📚 Additional Resources

- [Render Documentation](https://render.com/docs)
- [Render Docker Guide](https://render.com/docs/docker)
- [FastAPI Deployment](https://fastapi.tiangolo.com/deployment/)
- [Troubleshooting Guide](https://render.com/docs/troubleshooting)

---

## ✅ Deployment Checklist

- [ ] Code pushed to GitHub
- [ ] Render account created
- [ ] Web service configured
- [ ] Docker build successful
- [ ] Health check passing
- [ ] API endpoints tested
- [ ] Logs reviewed
- [ ] Monitoring configured
- [ ] Custom domain set (optional)
- [ ] SSL certificate active (automatic)

---

**Your API is now live on Render! 🎉**

For support, contact: [support@render.com]
