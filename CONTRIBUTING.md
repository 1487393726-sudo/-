# 贡献指南

感谢您对礼盒精选电商平台的关注！我们欢迎任何形式的贡献。

## 🤝 如何贡献

### 报告 Bug
如果您发现了 Bug，请：
1. 检查是否已有相关 Issue
2. 创建新 Issue，包含：
   - Bug 描述
   - 复现步骤
   - 预期行为
   - 实际行为
   - 环境信息（浏览器、Node 版本等）
   - 截图（如果适用）

### 提出新功能
如果您有新功能建议，请：
1. 创建 Feature Request Issue
2. 描述功能需求和使用场景
3. 说明为什么需要这个功能
4. 提供可能的实现方案（可选）

### 提交代码
1. Fork 项目
2. 创建功能分支：`git checkout -b feature/amazing-feature`
3. 提交更改：`git commit -m 'Add amazing feature'`
4. 推送到分支：`git push origin feature/amazing-feature`
5. 创建 Pull Request

## 📝 代码规范

### TypeScript
- 使用 TypeScript 编写所有代码
- 为函数和变量添加类型注解
- 避免使用 `any` 类型

### 命名规范
- 组件：PascalCase（如 `UserProfile`）
- 函数：camelCase（如 `getUserData`）
- 常量：UPPER_SNAKE_CASE（如 `MAX_FILE_SIZE`）
- 文件：kebab-case（如 `user-profile.tsx`）

### 代码风格
```typescript
// ✅ 好的示例
export function calculateTotal(items: CartItem[]): number {
  return items.reduce((sum, item) => sum + item.price * item.quantity, 0)
}

// ❌ 不好的示例
export function calc(items: any) {
  let total = 0
  for (let i = 0; i < items.length; i++) {
    total = total + items[i].price * items[i].quantity
  }
  return total
}
```

### 组件规范
```typescript
// ✅ 好的示例
interface UserCardProps {
  user: User
  onEdit?: () => void
}

export function UserCard({ user, onEdit }: UserCardProps) {
  return (
    <Card>
      <CardHeader>
        <CardTitle>{user.name}</CardTitle>
      </CardHeader>
      <CardContent>
        <p>{user.email}</p>
        {onEdit && <Button onClick={onEdit}>编辑</Button>}
      </CardContent>
    </Card>
  )
}
```

## 🧪 测试

### 编写测试
- 为新功能编写测试
- 确保所有测试通过
- 测试覆盖率不低于当前水平

### 运行测试
```bash
# 运行所有测试
npm test

# 运行特定测试
npm test -- user.test.ts

# 查看覆盖率
npm run test:coverage
```

## 📦 提交规范

使用语义化提交信息：

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type 类型
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `style`: 代码格式（不影响功能）
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 构建/工具相关

### 示例
```
feat(auth): add password reset functionality

- Add forgot password page
- Add reset password API
- Add email notification

Closes #123
```

## 🔍 代码审查

Pull Request 将经过以下审查：
- ✅ 代码质量
- ✅ 测试覆盖
- ✅ 文档完整性
- ✅ 性能影响
- ✅ 安全性

## 📚 文档

### 更新文档
如果您的更改影响到：
- API 接口
- 配置选项
- 使用方式

请同时更新相关文档。

### 文档位置
- README.md - 项目概述
- DEPLOYMENT.md - 部署指南
- QUICKSTART.md - 快速开始
- API.md - API 文档

## 🎨 UI/UX 指南

### 设计原则
- 简洁明了
- 一致性
- 响应式
- 可访问性

### 组件使用
- 优先使用 shadcn/ui 组件
- 保持设计系统一致
- 遵循 Tailwind CSS 规范

## 🐛 调试技巧

### 开发工具
```bash
# 启动开发服务器
npm run dev

# 打开数据库管理界面
npx prisma studio

# 查看日志
npm run dev | grep ERROR
```

### 常见问题
1. 清除缓存：`rm -rf .next`
2. 重新安装依赖：`rm -rf node_modules && npm install`
3. 重置数据库：`npx prisma migrate reset`

## 📞 获取帮助

如果您需要帮助：
1. 查看文档
2. 搜索已有 Issue
3. 在 Discussions 提问
4. 联系维护者

## 🙏 致谢

感谢所有贡献者！

## 📄 许可证

通过贡献代码，您同意您的贡献将在 MIT 许可证下发布。

---

**再次感谢您的贡献！** ❤️
