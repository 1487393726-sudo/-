# 修复 Prisma Client 错误脚本
Write-Host "正在修复 Prisma Client 错误..." -ForegroundColor Cyan
Write-Host ""

# 步骤1: 清理 Next.js 缓存
Write-Host "步骤1: 清理 Next.js 缓存..." -ForegroundColor Yellow
if (Test-Path ".next") {
    Remove-Item -Recurse -Force ".next"
    Write-Host "✓ 缓存已清理" -ForegroundColor Green
} else {
    Write-Host "✓ 没有缓存需要清理" -ForegroundColor Green
}
Write-Host ""

# 步骤2: 生成 Prisma Client
Write-Host "步骤2: 生成 Prisma Client..." -ForegroundColor Yellow
try {
    npm run db:generate
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Prisma Client 生成成功！" -ForegroundColor Green
    } else {
        Write-Host "尝试使用 npx..." -ForegroundColor Yellow
        npx prisma generate --schema=prisma/schema.prisma
    }
} catch {
    Write-Host "✗ 生成失败: $_" -ForegroundColor Red
}
Write-Host ""

# 步骤3: 验证
Write-Host "步骤3: 验证生成结果..." -ForegroundColor Yellow
if (Test-Path "node_modules\@prisma\client\index.js") {
    Write-Host "✓ Prisma Client 文件存在" -ForegroundColor Green
} else {
    Write-Host "✗ Prisma Client 文件不存在" -ForegroundColor Red
}
Write-Host ""

Write-Host "修复完成！请重启开发服务器 (npm run dev)" -ForegroundColor Cyan
Read-Host "按 Enter 键退出"
