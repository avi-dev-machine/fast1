# Deployment Guide for Railway

## 🚀 AI Exercise Trainer - Railway Deployment

### Prerequisites
- GitHub account (for deploying from repository)
- Railway account (free trial available at https://railway.app)

---

## 📋 Deployment Steps

### 1. Prepare Your Repository

Push your project to GitHub:
```bash
git init
git add .
git commit -m "Initial commit for Railway deployment"
git branch -M main
git remote add origin <your-github-repo-url>
git push -u origin main
```

### 2. Create New Project on Railway

1. Go to https://railway.app
2. Click **"New Project"**
3. Select **"Deploy from GitHub repo"**
4. Authorize Railway to access your GitHub
5. Select the repository containing this project

### 3. Railway Auto-Configuration

Railway automatically detects:
- **Dockerfile** → Uses Docker build
- **requirements.txt** → Python project
- **Port 8000** → From Dockerfile ENV

**No manual configuration needed!** Railway is smart.

### 4. Environment Variables (Optional)

Railway auto-sets `PORT`, but you can add custom variables:

```bash
# In Railway Dashboard → Variables tab:
PYTHON_VERSION=3.11
MAX_UPLOAD_SIZE=100MB
```

---

## 🔧 Configuration Files

### railway.toml (Optional - Advanced Configuration)

Create a `railway.toml` for custom settings:

```toml
[build]
builder = "DOCKERFILE"
dockerfilePath = "./Dockerfile"

[deploy]
startCommand = "uvicorn server:app --host 0.0.0.0 --port $PORT"
healthcheckPath = "/"
healthcheckTimeout = 100
restartPolicyType = "ON_FAILURE"
restartPolicyMaxRetries = 10
```

This is **optional** - Railway works great without it!

---

## 📦 Build Process

Railway will:
1. ✅ Clone your repository
2. ✅ Detect Dockerfile
3. ✅ Build Docker image (multi-stage build)
4. ✅ Install dependencies
5. ✅ Copy models and code
6. ✅ Start FastAPI server
7. ✅ Assign public URL

**Build Time:** ~3-7 minutes (first build)

---

## 🌐 Access Your API

Railway provides a **custom domain** instantly:
```
https://<project-name>-production.up.railway.app
```

### Test Endpoints:
```bash
# Health check
curl https://<your-project>.up.railway.app/

# Create session
curl -X POST https://<your-project>.up.railway.app/session/create

# API Documentation (Swagger)
https://<your-project>.up.railway.app/docs
```

---

## 📊 Monitoring & Logs

### Real-Time Logs:
- Click on your service in Railway dashboard
- **Logs tab** shows live application output
- Filter by severity: INFO, ERROR, WARNING

### Metrics:
Railway provides:
- **CPU Usage** (%)
- **Memory Usage** (MB)
- **Network Egress** (GB)
- **Request Count**

### Resource Usage:
Check the **Metrics** tab:
- View historical usage graphs
- Set up usage alerts
- Monitor cost

---

## 🔄 Updates & Redeploy

### Automatic Deployment:
Railway watches your GitHub repo:
```bash
git add .
git commit -m "Fix pushup angle detection"
git push origin main
```
✅ **Auto-deploys in ~2-5 minutes**

### Manual Redeploy:
- Dashboard → Service → **"Redeploy"** button
- Or trigger via Railway CLI

### Rollback:
- Click **"Deployments"** tab
- Select previous deployment
- Click **"Redeploy this version"**

---

## 💰 Pricing & Plans

### Free Trial ($5 Credit):
- No credit card required
- 500 hours execution time
- 100 GB network egress
- Great for testing

### Hobby Plan ($5/month):
- $5 included usage credit
- Pay-as-you-go after credit
- **Usage-based:** ~$0.000463/GB-sec (memory) + ~$0.20/GB (egress)
- **Typical monthly cost:** $10-25 for moderate traffic

### Pro Plan ($20/month):
- $20 included usage credit
- Priority support
- Advanced metrics
- Team collaboration

### Cost Example:
For a service running 24/7 with 512 MB RAM:
- **Memory:** 512 MB × 730 hours × $0.000463 = ~$173/month
- BUT with $5-20 credit, effective cost = $153-168/month
- **Note:** Railway is best for intermittent use or scale to zero

---

## ⚡ Performance Optimization

### 1. Enable Scale to Zero (Free Tier):
Railway automatically sleeps inactive services:
- Service pauses after 10 minutes idle
- Wakes up on next request (~5-10 seconds)

### 2. Resource Limits:
Set limits in `railway.toml`:
```toml
[deploy]
numReplicas = 1
maxMemory = 1024  # MB
```

### 3. Docker Optimization:
Already done in the Dockerfile:
- ✅ Multi-stage build
- ✅ Minimal base image
- ✅ Cache dependencies
- ✅ Remove unnecessary files

---

## 🐛 Troubleshooting

### Build Fails:
1. Check **Build Logs** tab
2. Common issues:
   - Missing dependencies → Add to `requirements.txt`
   - Docker syntax error → Validate Dockerfile
   - Model files too large → Use Git LFS or external storage

### Service Crashes:
1. Check **Deployment Logs**
2. Look for Python errors:
   ```bash
   ModuleNotFoundError: No module named 'cv2'
   ```
3. Fix in requirements and redeploy

### Out of Memory:
- Upgrade memory allocation
- Optimize model loading
- Use quantized YOLO models
- Reduce concurrent requests

### Port Binding Issues:
Ensure Dockerfile uses Railway's `$PORT`:
```dockerfile
CMD uvicorn server:app --host 0.0.0.0 --port $PORT
```
✅ Already configured!

### Slow Cold Starts:
- Railway pauses inactive services (free tier)
- Solution: Upgrade to paid plan or add keep-alive
- Keep-alive example:
  ```python
  # Add to server.py
  import asyncio
  @app.on_event("startup")
  async def keep_alive():
      while True:
          await asyncio.sleep(300)  # Ping every 5 min
  ```

---

## 🔒 Security Best Practices

### 1. Environment Variables:
Store secrets in Railway's **Variables** tab:
```bash
DATABASE_URL=postgresql://...
SECRET_KEY=your-secret-key
```

### 2. Private Networking:
Use Railway's **Private Networking** for databases:
```
railway-internal.railway.app
```

### 3. CORS Configuration:
Update `server.py`:
```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://yourdomain.com"],  # Not "*"
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### 4. Rate Limiting:
Add middleware in `server.py`:
```python
from slowapi import Limiter, _rate_limit_exceeded_handler
limiter = Limiter(key_func=lambda: request.client.host)
app.state.limiter = limiter
```

---

## 🛠️ Railway CLI (Optional)

Install Railway CLI for advanced control:

```bash
# Install
npm i -g @railway/cli

# Login
railway login

# Link project
railway link

# View logs
railway logs

# Run locally
railway run python server.py

# Deploy manually
railway up
```

---

## 🌍 Custom Domain

### Add Your Domain:
1. Go to **Settings** → **Domains**
2. Click **"Add Domain"**
3. Enter your domain: `api.yourdomain.com`
4. Add DNS records (Railway provides instructions):
   ```
   CNAME api yourdomain.railway.app
   ```
5. ✅ SSL certificate auto-issued

---

## 📊 Advanced: Monitoring with Railway Observability

Railway provides built-in observability:
- **Logs:** Real-time application logs
- **Metrics:** CPU, memory, network
- **Traces:** Request tracing (coming soon)
- **Alerts:** Set up notifications

### Set Up Alerts:
1. Go to **Observability** tab
2. Create alert rules:
   - CPU > 80% for 5 minutes
   - Memory > 90% for 2 minutes
   - Error rate > 5% for 1 minute
3. Configure notifications (email, Slack, Discord)

---

## 📚 Additional Resources

- [Railway Documentation](https://docs.railway.app)
- [Railway CLI Guide](https://docs.railway.app/develop/cli)
- [Dockerfile Best Practices](https://docs.railway.app/deploy/dockerfiles)
- [Railway Discord Community](https://discord.gg/railway)

---

## ✅ Deployment Checklist

- [ ] Code pushed to GitHub
- [ ] Railway account created
- [ ] Project linked to repository
- [ ] Dockerfile configured
- [ ] Build successful (check logs)
- [ ] Service running (green status)
- [ ] Public URL accessible
- [ ] Health check passing (/)
- [ ] API endpoints tested (/docs)
- [ ] Environment variables set
- [ ] Monitoring configured
- [ ] Custom domain added (optional)

---

## 💡 Pro Tips

1. **Use Railway Templates:** Start with Railway's FastAPI template
2. **Database Integration:** Add PostgreSQL with one click
3. **GitHub Actions:** Set up CI/CD pipeline
4. **Staging Environment:** Create separate Railway service for testing
5. **Cost Monitoring:** Check usage regularly in dashboard
6. **Logs Retention:** Export logs for long-term storage

---

## 🆚 Railway vs Render Comparison

| Feature | Railway | Render |
|---------|---------|--------|
| **Pricing** | Usage-based | Fixed plans |
| **Free Tier** | $5 trial credit | 750 hours/month |
| **Auto-Deploy** | ✅ Instant | ✅ ~5 min |
| **Docker Support** | ✅ Native | ✅ Native |
| **Database** | ✅ One-click | ✅ Separate service |
| **CLI** | ✅ Powerful | ❌ Limited |
| **Learning Curve** | Easy | Easy |
| **Best For** | Dev/staging, flexible | Production, stable |

**Recommendation:**
- **Railway:** Great for development, testing, and flexible scaling
- **Render:** Better for production with predictable traffic

---

**Your API is now live on Railway! 🚂**

Need help? Join Railway Discord: https://discord.gg/railway
