# 给 AI 编码代理的快速指引

项目名称：礼物电商平台

目的：帮助 AI 编码代理在此仓库里快速定位有价值信息、执行常见开发任务，并在项目内容不完整时给出明确的下一步动作。

重要事实（可被发现）：
- 仓库当前仅包含根 README（[README.md](README.md)），没有源码目录或常见构建文件。

优先步骤（首次进入仓库时）：
- 列出仓库文件：`git ls-files` 或 `ls -la`，确认实际源码位置。
- 搜索常见工程清单：查找 `package.json`, `pyproject.toml`, `requirements.txt`, `Gemfile`, `go.mod`, `Cargo.toml`, `Dockerfile`, `docker-compose.yml`。
- 若无源码但有 CI/infra 配置，优先打开 `.github/workflows`、`Dockerfile`、`infra` 或 `deploy` 目录以推断运行时与依赖。

大体架构推断（若可用）：
- 若存在 `services/`、`api/`、`web/`、`worker/` 等目录，通常采用微服务或分层单体：
  - `web/`：前端代码（React/Vue/Next）
  - `api/` 或 `server/`：后端服务（Node/Python/Ruby/Go）
  - `worker/`：异步任务/队列处理
- 没有明确文件时，向仓库所有者确认语言与运行方式。

开发/构建/测试 工作流（发现性指南）：
- 若有 `package.json`：使用 `npm ci` / `npm test` / `npm run build`。
- 若有 `pyproject.toml` 或 `requirements.txt`：使用 `python -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt` 并运行 `pytest`。
- 若有 `docker-compose.yml`：尝试 `docker compose up --build` 来复现服务拓扑。
- 如果 CI 存在（`.github/workflows`）：打开 workflow 文件以提取测试/构建命令与所需秘钥。

项目特定约定（基于可发现文件）：
- 如果存在 `src/`：优先在 `src/` 下查找可执行入口（`index.js`, `main.py`, `cmd/` 等）。
- 配置优先级：优先读取仓库根目录下的 `.env.example` / `config/*`，不要假设默认值。

与外部系统的集成点（如何识别）：
- 在代码中搜索 `ENV`、`SENTRY_`、`DATABASE_URL`、`REDIS_URL`、`AWS_` 等环境变量以推断托管与依赖。
- 查找 `terraform/`、`k8s/`、`charts/` 或云提供商 SDK 的依赖声明来识别部署目标。

对 AI 代理的具体行为规范：
- 不要在没有源码的情况下擅自生成大段实现；先询问仓库拥有者并给出发现步骤。
- 仅在找到明确的构建脚本或依赖文件后运行构建或测试命令。
- 在修改仓库文件前，给出简短的变更计划并请求确认。

示例操作片段（在终端内可直接执行）：
```
git ls-files | sed -n '1,200p'
rg "package.json|pyproject.toml|requirements.txt|Dockerfile|docker-compose.yml" || true
ls -la .github || true
```

合并策略：
- 如果仓库已有 `.github/copilot-instructions.md`，优先保留其中对本项目的具体说明；将本文件作为补充，并在顶部注明已合并的日期与来源。

如果不清楚的地方，请询问：
- 该仓库的主要语言/运行时是哪种？
- 源码是否在子目录（比如 `services/`、`backend/`、`frontend/`）？
- 是否有可用的开发凭证或本地 mock 服务？

更新记录：
- 初始创建 — 请反馈哪些区域需要补充具体示例或项目内引用。
