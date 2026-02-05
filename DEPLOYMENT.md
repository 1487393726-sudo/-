# 部署指南

本文档提供详细的部署步骤，帮助您将礼盒精选电商平台部署到生产环境。

## 📋 部署前准备

### 1. 环境要求
- Node.js 18.0 或更高版本
- PostgreSQL 14.0 或更高版本
- npm 或 yarn 包管理器
- Git

### 2. 必需的服务
- 数据库服务（PostgreSQL）
- 邮件服务（可选，用于密码重置）
- 支付服务（可选，用于在线支付）

---

## 🚀 部署方案

### 方案一：Vercel 部署（推荐）

Vercel 是 Next.js 的官方部署平台，提供最佳的性能和开发体验。

#### 步骤 1: 准备代码仓库
```bash
# 初始化 Git 仓库（如果还没有）
git init
git add .
git commit -m "Initial commit"

# 推送到 GitHub
git remote add origin <your-github-repo-url>
git push -u origin main
```

#### 步骤 2: 创建 Vercel 项目
1. 访问 [Vercel](https://vercel.com)
2. 点击 "New Project"
3. 导入您的 GitHub 仓库
4. 配置项目设置

#### 步骤 3: 配置数据库
**选项 A: 使用 Vercel Postgres**
1. 在 Vercel 项目中添加 Postgres 存储
2. 自动获取 `DATABASE_URL` 环境变量

**选项 B: 使用外部数据库**
1. 创建 PostgreSQL 数据库（推荐：Supabase, Railway, Neon）
2. 获取数据库连接字符串

#### 步骤 4: 配置环境变量
在 Vercel 项目设置中添加以下环境变量：

```env
DATABASE_URL=postgresql://user:password@host:5432/database
JWT_SECRET=your-super-secret-jwt-key-change-this
NEXT_PUBLIC_APP_URL=https://your-domain.vercel.app
```

#### 步骤 5: 部署
1. 点击 "Deploy"
2. 等待构建完成
3. 访问您的网站

#### 步骤 6: 运行数据库迁移
```bash
# 在本地运行迁移
npx prisma migrate deploy

# 或者使用 Vercel CLI
vercel env pull .env.local
npx prisma migrate deploy
npx prisma db seed
```

---

### 方案二：Railway 部署

Railway 提供简单的部署流程和内置的 PostgreSQL 数据库。

#### 步骤 1: 创建 Railway 项目
1. 访问 [Railway](https://railway.app)
2. 点击 "New Project"
3. 选择 "Deploy from GitHub repo"

#### 步骤 2: 添加 PostgreSQL
1. 点击 "New" → "Database" → "PostgreSQL"
2. Railway 会自动创建数据库并设置 `DATABASE_URL`

#### 步骤 3: 配置环境变量
在 Railway 项目设置中添加：

```env
JWT_SECRET=your-super-secret-jwt-key-change-this
NEXT_PUBLIC_APP_URL=https://your-app.railway.app
```

#### 步骤 4: 部署
1. Railway 会自动检测 Next.js 项目
2. 自动构建和部署
3. 获取部署 URL

#### 步骤 5: 运行数据库迁移
```bash
# 使用 Railway CLI
railway run npx prisma migrate deploy
railway run npx prisma db seed
```

---

### 方案三：传统 VPS 部署

适合需要完全控制的场景。

#### 步骤 1: 准备服务器
```bash
# 更新系统
sudo apt update && sudo apt upgrade -y

# 安装 Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# 安装 PostgreSQL
sudo apt install -y postgresql postgresql-contrib

# 安装 Nginx
sudo apt install -y nginx

# 安装 PM2（进程管理器）
sudo npm install -g pm2
```

#### 步骤 2: 配置数据库
```bash
# 切换到 postgres 用户
sudo -u postgres psql

# 创建数据库和用户
CREATE DATABASE giftbox;
CREATE USER giftbox_user WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE giftbox TO giftbox_user;
\q
```

#### 步骤 3: 部署应用
```bash
# 克隆代码
cd /var/www
git clone <your-repo-url> giftbox
cd giftbox

# 安装依赖
npm install

# 配置环境变量
nano .env.production
```

添加以下内容：
```env
DATABASE_URL=postgresql://giftbox_user:your_password@localhost:5432/giftbox
JWT_SECRET=your-super-secret-jwt-key-change-this
NEXT_PUBLIC_APP_URL=https://your-domain.com
NODE_ENV=production
```

```bash
# 运行数据库迁移
npx prisma migrate deploy
npx prisma db seed

# 构建应用
npm run build

# 使用 PM2 启动
pm2 start npm --name "giftbox" -- start
pm2 save
pm2 startup
```

#### 步骤 4: 配置 Nginx
```bash
sudo nano /etc/nginx/sites-available/giftbox
```

添加以下配置：
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

```bash
# 启用站点
sudo ln -s /etc/nginx/sites-available/giftbox /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

#### 步骤 5: 配置 SSL（使用 Let's Encrypt）
```bash
# 安装 Certbot
sudo apt install -y certbot python3-certbot-nginx

# 获取 SSL 证书
sudo certbot --nginx -d your-domain.com

# 自动续期
sudo certbot renew --dry-run
```

---

## 🔒 安全配置

### 1. 环境变量安全
- ✅ 使用强随机字符串作为 `JWT_SECRET`
- ✅ 不要在代码中硬编码敏感信息
- ✅ 使用环境变量管理所有配置

### 2. 数据库安全
- ✅ 使用强密码
- ✅ 限制数据库访问 IP
- ✅ 定期备份数据库
- ✅ 启用 SSL 连接

### 3. 应用安全
- ✅ 启用 HTTPS
- ✅ 配置 CORS
- ✅ 设置安全响应头
- ✅ 定期更新依赖

---

## 📊 性能优化

### 1. 数据库优化
```sql
-- 创建索引
CREATE INDEX idx_orders_user_id ON "Order"(user_id);
CREATE INDEX idx_orders_status ON "Order"(status);
CREATE INDEX idx_products_category ON "Product"(category_id);
```

### 2. 缓存配置
```javascript
// next.config.mjs
export default {
  images: {
    domains: ['your-cdn-domain.com'],
  },
  // 启用 SWC 压缩
  swcMinify: true,
}
```

### 3. CDN 配置
- 使用 CDN 托管静态资源
- 配置图片优化
- 启用 Gzip/Brotli 压缩

---

## 🔄 持续部署

### GitHub Actions 配置
创建 `.github/workflows/deploy.yml`：

```yaml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Run tests
        run: npm test
        
      - name: Build
        run: npm run build
        
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
```

---

## 📧 邮件服务配置

### 使用 SendGrid
```env
SMTP_HOST=smtp.sendgrid.net
SMTP_PORT=587
SMTP_USER=apikey
SMTP_PASS=your-sendgrid-api-key
```

### 使用 AWS SES
```env
SMTP_HOST=email-smtp.us-east-1.amazonaws.com
SMTP_PORT=587
SMTP_USER=your-aws-access-key
SMTP_PASS=your-aws-secret-key
```

---

## 🔍 监控和日志

### 1. 应用监控
推荐使用：
- Vercel Analytics（Vercel 部署）
- Sentry（错误追踪）
- LogRocket（用户会话记录）

### 2. 数据库监控
```bash
# 查看数据库连接
SELECT * FROM pg_stat_activity;

# 查看数据库大小
SELECT pg_size_pretty(pg_database_size('giftbox'));
```

### 3. 服务器监控（VPS）
```bash
# 安装监控工具
sudo apt install -y htop

# 查看 PM2 日志
pm2 logs giftbox

# 查看 Nginx 日志
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

---

## 🔄 数据库备份

### 自动备份脚本
```bash
#!/bin/bash
# backup.sh

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/var/backups/giftbox"
DB_NAME="giftbox"

mkdir -p $BACKUP_DIR

pg_dump $DB_NAME | gzip > $BACKUP_DIR/backup_$DATE.sql.gz

# 保留最近 7 天的备份
find $BACKUP_DIR -name "backup_*.sql.gz" -mtime +7 -delete

echo "Backup completed: backup_$DATE.sql.gz"
```

### 设置定时任务
```bash
# 编辑 crontab
crontab -e

# 每天凌晨 2 点备份
0 2 * * * /path/to/backup.sh
```

---

## 🆘 故障排查

### 常见问题

#### 1. 数据库连接失败
```bash
# 检查数据库是否运行
sudo systemctl status postgresql

# 检查连接字符串
echo $DATABASE_URL

# 测试连接
psql $DATABASE_URL
```

#### 2. 应用无法启动
```bash
# 查看 PM2 日志
pm2 logs giftbox

# 重启应用
pm2 restart giftbox

# 查看端口占用
sudo lsof -i :3000
```

#### 3. Nginx 配置错误
```bash
# 测试配置
sudo nginx -t

# 查看错误日志
sudo tail -f /var/log/nginx/error.log

# 重启 Nginx
sudo systemctl restart nginx
```

---

## 📞 获取帮助

如果遇到部署问题，可以：
1. 查看项目文档
2. 检查错误日志
3. 搜索相关问题
4. 联系技术支持

---

## ✅ 部署检查清单

部署前请确认：

- [ ] 代码已推送到 Git 仓库
- [ ] 环境变量已正确配置
- [ ] 数据库已创建并迁移
- [ ] 测试数据已导入（可选）
- [ ] SSL 证书已配置
- [ ] 域名已解析
- [ ] 备份策略已设置
- [ ] 监控已配置
- [ ] 邮件服务已配置（可选）
- [ ] 支付服务已配置（可选）

---

**祝您部署顺利！** 🚀
