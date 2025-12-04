# 🚀 Hugging Face Spaces Deployment Guide

## 📋 Prerequisites
- Hugging Face account (free at https://huggingface.co/join)
- Git with LFS installed
- Your code repository

---

## 🎯 Quick Deploy (3 Steps)

### Step 1: Create a New Space

1. Go to https://huggingface.co/new-space
2. Fill in the details:
   - **Space name:** `ai-exercise-trainer`
   - **License:** MIT
   - **Select SDK:** Docker
   - **Space hardware:** CPU basic (free) or CPU upgrade ($0.02/hour)
   - **Visibility:** Public (or Private)
3. Click **"Create Space"**

---

### Step 2: Clone and Push Your Code

```bash
# 1. Install Git LFS (if not already)
git lfs install

# 2. Clone your new Hugging Face Space
git clone https://huggingface.co/spaces/YOUR_USERNAME/ai-exercise-trainer
cd ai-exercise-trainer

# 3. Copy your files from the fast1 repository
# Option A: Copy files manually
cp -r ../fast/* .

# Option B: Add as remote and merge
git remote add github https://github.com/avi-dev-machine/fast1.git
git pull github main --allow-unrelated-histories

# 4. Track large model files with Git LFS
git lfs track "*.pt"
git lfs track "*.onnx"
git add .gitattributes

# 5. Add all files
git add .

# 6. Commit
git commit -m "Initial deployment to Hugging Face Spaces"

# 7. Push to Hugging Face
git push origin main
```

---

### Step 3: Wait for Build

- Hugging Face will automatically build your Docker image
- Build time: ~10-15 minutes
- Check build logs in the Space's "Logs" tab
- Once complete, your API will be live!

---

## 🌐 Access Your API

Your API will be available at:
```
https://YOUR_USERNAME-ai-exercise-trainer.hf.space
```

### Test Endpoints:
```bash
# Health check
curl https://YOUR_USERNAME-ai-exercise-trainer.hf.space/

# API documentation
https://YOUR_USERNAME-ai-exercise-trainer.hf.space/docs

# Create session
curl -X POST https://YOUR_USERNAME-ai-exercise-trainer.hf.space/session/create
```

---

## ⚙️ Configuration

### README.md Header (Already configured)
```yaml
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
```

### Dockerfile
✅ Already configured - uses the optimized single-stage build

### Hardware Options:
- **CPU basic (free):** 2 vCPU, 16 GB RAM
- **CPU upgrade ($0.02/hr):** 8 vCPU, 32 GB RAM
- **T4 small ($0.60/hr):** GPU for faster inference (optional)

**Recommendation:** Start with CPU basic (free)

---

## 🔧 Alternative: Direct Git Push

If you prefer to push from your existing repository:

```bash
# In your current fast directory
cd c:\Users\avijn_th5xjtu\Desktop\fast

# Add Hugging Face as remote
git remote add hf https://huggingface.co/spaces/YOUR_USERNAME/ai-exercise-trainer

# Track large files with Git LFS
git lfs install
git lfs track "*.pt"
git lfs track "*.onnx"
git add .gitattributes

# Commit if needed
git add README.md
git commit -m "Add Hugging Face configuration"

# Push to Hugging Face
git push hf main
```

---

## 📊 Model Files Handling

Your YOLO models are large files. Git LFS is required:

```bash
# Track model files
git lfs track "yolo11n-pose.pt"
git lfs track "yolo11n-pose.onnx"

# Verify tracking
git lfs ls-files

# Push with LFS
git add .
git commit -m "Add YOLO models with Git LFS"
git push origin main
```

---

## 💰 Cost Comparison

| Hardware | vCPU | RAM | Cost/Hour | Best For |
|----------|------|-----|-----------|----------|
| **CPU basic** | 2 | 16 GB | **FREE** | Testing, demos |
| **CPU upgrade** | 8 | 32 GB | $0.02 | Production |
| **T4 small** | 4 | 15 GB | $0.60 | GPU inference |
| **A10G small** | 4 | 24 GB | $1.05 | Heavy workloads |

**Recommendation:** Start with CPU basic (free)

---

## 🔒 Environment Variables (Optional)

If you need secrets (API keys, etc.):

1. Go to your Space settings
2. Click "Repository secrets"
3. Add variables:
   - `SECRET_KEY`
   - `DATABASE_URL`
   - etc.

Access in code:
```python
import os
secret = os.environ.get("SECRET_KEY")
```

---

## 🐛 Troubleshooting

### Build Timeout
```bash
# Reduce Docker image size
# Already optimized in your Dockerfile!
```

### Git LFS Issues
```bash
# Install Git LFS
# Windows
git lfs install

# Verify installation
git lfs version

# Re-track files
git lfs migrate import --include="*.pt,*.onnx"
```

### Port Issues
✅ Already configured - `app_port: 8000` in README.md

### Model Not Loading
```bash
# Ensure models are committed with LFS
git lfs ls-files

# Should show:
# yolo11n-pose.pt
# yolo11n-pose.onnx
```

---

## 📖 Documentation

- **Hugging Face Docs:** https://huggingface.co/docs/hub/spaces-sdks-docker
- **Git LFS Guide:** https://git-lfs.com/
- **Spaces Pricing:** https://huggingface.co/pricing#spaces

---

## 🎯 Features of Hugging Face Spaces

✅ **Free tier** - CPU basic forever  
✅ **Automatic HTTPS** - SSL certificates included  
✅ **Git-based deployment** - Just push to deploy  
✅ **Built-in API docs** - Swagger UI at `/docs`  
✅ **Community showcase** - Discoverable on HF homepage  
✅ **Gradio/Streamlit** - Optional web UI (not needed for API)  
✅ **Docker support** - Full control over environment  

---

## 🚀 Next Steps

1. **Create Space** on Hugging Face
2. **Push code** using Git (with LFS for models)
3. **Wait for build** (~10-15 minutes)
4. **Test API** at your Space URL
5. **Share** with the community!

---

## ✅ Deployment Checklist

- [ ] Hugging Face account created
- [ ] Space created with Docker SDK
- [ ] Git LFS installed
- [ ] README.md with Space config
- [ ] Model files tracked with LFS
- [ ] Code pushed to HF Space
- [ ] Build successful (check logs)
- [ ] API tested and working
- [ ] Documentation updated

---

**Your API will be live at:**
```
https://YOUR_USERNAME-ai-exercise-trainer.hf.space
```

**Need help?** Check Hugging Face Discord: https://discord.gg/huggingface
