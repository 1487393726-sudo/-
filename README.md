# 礼盒精选电商平台

一个功能完整、用户体验优秀的现代化电商平台，专注于高品质礼品销售。

![项目完成度](https://img.shields.io/badge/完成度-95%25-brightgreen)
![测试通过](https://img.shields.io/badge/测试-145%20passed-success)
![TypeScript](https://img.shields.io/badge/TypeScript-100%25-blue)

## ✨ 项目特点

- 🎨 **现代化UI设计** - 基于shadcn/ui的精美界面
- 📱 **响应式布局** - 完美适配移动端和桌面端
- 🔐 **完整认证系统** - JWT Token + 密码加密
- 🛒 **完整购物流程** - 从浏览到支付的全流程
- 📦 **订单管理** - 订单创建、取消、确认收货、评价
- 💬 **客服支持** - 在线留言、FAQ、联系方式
- ⚡ **高性能** - Next.js 14 + TypeScript
- 🧪 **测试覆盖** - 145个测试用例全部通过

## 🚀 快速开始

### 环境要求

- Node.js 18+
- PostgreSQL 14+
- npm 或 yarn

### 安装步骤

1. 克隆项目
```bash
git clone <repository-url>
cd gift-box-store
```

2. 安装依赖
```bash
npm install
```

3. 配置环境变量
```bash
cp .env.example .env
```

编辑 `.env` 文件，配置数据库连接：
```env
DATABASE_URL="postgresql://user:password@localhost:5432/giftbox"
JWT_SECRET="your-secret-key"
NEXT_PUBLIC_APP_URL="http://localhost:3000"
```

4. 数据库迁移
```bash
npx prisma migrate dev
npx prisma db seed
```

5. 启动开发服务器
```bash
npm run dev
```

访问 http://localhost:3000

## 📦 功能模块

### 用户端功能

#### 商品浏览
- ✅ 首页商品展示
- ✅ 8个商品分类
- ✅ 商品搜索和筛选
- ✅ 商品详情页

#### 购物流程
- ✅ 加入购物车
- ✅ 购物车管理
- ✅ 收藏夹
- ✅ 结账页面
- ✅ 订单创建

#### 订单管理
- ✅ 订单列表和筛选
- ✅ 订单详情
- ✅ 取消订单
- ✅ 确认收货
- ✅ 订单评价

#### 用户中心
- ✅ 个人信息管理
- ✅ 地址管理
- ✅ 账户设置
- ✅ 密码修改

#### 认证系统
- ✅ 用户注册/登录
- ✅ 忘记密码
- ✅ 密码重置
- ✅ 自动登录

#### 客服支持
- ✅ 在线留言
- ✅ 帮助中心
- ✅ FAQ（22个问题）

### 管理端功能

- ✅ 商品管理（CRUD）
- ✅ 订单管理
- ✅ 订单状态更新

## 🛠️ 技术栈

### 前端
- **框架**: Next.js 14 (App Router)
- **语言**: TypeScript
- **样式**: Tailwind CSS
- **UI组件**: shadcn/ui
- **状态管理**: Zustand
- **表单验证**: Zod
- **动画**: Framer Motion
- **图标**: Lucide React

### 后端
- **API**: Next.js API Routes
- **数据库**: PostgreSQL
- **ORM**: Prisma
- **认证**: JWT
- **密码加密**: bcrypt

### 开发工具
- **测试**: Vitest
- **代码质量**: ESLint, TypeScript
- **版本控制**: Git

## 📁 项目结构

```
├── app/                    # Next.js App Router页面
│   ├── api/               # API路由
│   ├── (auth)/            # 认证相关页面
│   ├── orders/            # 订单相关页面
│   ├── profile/           # 个人中心页面
│   └── ...
├── components/            # React组件
│   ├── ui/               # UI基础组件
│   └── ...
├── lib/                   # 工具函数和配置
│   ├── stores/           # Zustand状态管理
│   ├── data/             # 静态数据
│   └── ...
├── prisma/               # Prisma配置和迁移
│   ├── schema.prisma     # 数据库Schema
│   └── seed.ts           # 数据种子
└── public/               # 静态资源
```

## 🧪 测试

运行所有测试：
```bash
npm test
```

运行测试并查看覆盖率：
```bash
npm run test:coverage
```

## 📊 项目统计

- **页面数量**: 21个
- **API端点**: 25个
- **组件数量**: 60+个
- **代码行数**: ~18,000行
- **测试用例**: 145个
- **测试通过率**: 100%

## 🚀 部署

### Vercel部署（推荐）

1. 连接GitHub仓库到Vercel
2. 配置环境变量
3. 部署数据库（Vercel Postgres）
4. 一键部署

### 传统VPS部署

1. 安装Node.js和PostgreSQL
2. 克隆代码并安装依赖
3. 配置环境变量
4. 运行数据库迁移
5. 构建项目：`npm run build`
6. 启动服务：`npm start`
7. 配置Nginx反向代理

## 📝 环境变量

```env
# 数据库
DATABASE_URL="postgresql://user:password@host:5432/database"

# JWT密钥
JWT_SECRET="your-secret-key-change-in-production"

# 应用URL
NEXT_PUBLIC_APP_URL="https://your-domain.com"

# 邮件服务（可选）
SMTP_HOST="smtp.example.com"
SMTP_PORT="587"
SMTP_USER="your-email"
SMTP_PASS="your-password"
```

## 🔒 安全性

- ✅ JWT Token认证
- ✅ bcrypt密码加密
- ✅ 受保护路由
- ✅ API权限验证
- ✅ XSS防护
- ✅ CSRF防护
- ✅ SQL注入防护（Prisma ORM）

## 📖 文档

### 核心文档
- 📘 [API 文档](./docs/API.md) - 完整的 API 接口文档
- 🧪 [测试指南](./docs/TESTING.md) - 测试编写和运行指南
- 🏗️ [架构文档](./docs/ARCHITECTURE.md) - 项目架构和技术设计
- 🚀 [部署指南](./DEPLOYMENT.md) - 详细的部署步骤
- ⚡ [快速启动](./QUICKSTART.md) - 5分钟快速上手
- 🤝 [贡献指南](./CONTRIBUTING.md) - 如何参与项目开发

### API 快速参考

**认证相关**:
- `POST /api/auth/register` - 用户注册
- `POST /api/auth/login` - 用户登录
- `POST /api/auth/forgot-password` - 忘记密码
- `POST /api/auth/reset-password` - 重置密码

**订单相关**:
- `GET /api/orders` - 获取订单列表
- `POST /api/orders` - 创建订单
- `POST /api/orders/[id]/cancel` - 取消订单
- `POST /api/orders/[id]/confirm` - 确认收货

完整 API 文档请查看 [docs/API.md](./docs/API.md)

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📄 许可证

MIT License

## 👥 作者

Kiro AI Assistant

## 🙏 致谢

- [Next.js](https://nextjs.org/)
- [shadcn/ui](https://ui.shadcn.com/)
- [Tailwind CSS](https://tailwindcss.com/)
- [Prisma](https://www.prisma.io/)

---

**项目状态**: ✅ 核心功能开发完成，准备部署

**完成度**: 95%

**最后更新**: 2025年1月16日
