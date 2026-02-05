@echo off
chcp 65001 >nul
echo 正在修复 Prisma Client 错误...
echo.

echo 步骤1: 清理 Next.js 缓存...
if exist .next rmdir /s /q .next
echo 缓存已清理
echo.

echo 步骤2: 生成 Prisma Client...
call npm run db:generate
if %errorlevel% neq 0 (
    echo.
    echo 尝试使用 npx...
    call npx prisma generate --schema=prisma/schema.prisma
)
echo.

echo 步骤3: 验证生成结果...
if exist "node_modules\@prisma\client\index.js" (
    echo ✓ Prisma Client 生成成功！
) else (
    echo ✗ Prisma Client 生成失败，请检查错误信息
)
echo.

echo 修复完成！请重启开发服务器 (npm run dev)
pause
