# 开发规范 (Development Standards)

## 1. 代码风格 (Code Style)
*   **缩进**: [2 spaces / 4 spaces / tabs]
*   **分号**: [required / not required]
*   **引号**: [single / double]
*   **行宽**: [80 / 120]
*   **格式化工具**: [Prettier / gofmt / black]
*   **Lint 工具**: [ESLint / golangci-lint / ruff]

## 2. 命名约定 (Naming Conventions)
*   **变量/函数**: [camelCase / snake_case]
*   **类/接口**: [PascalCase]
*   **常量**: [UPPER_SNAKE_CASE]
*   **文件名**: [kebab-case / camelCase / snake_case]
*   **组件名**: [PascalCase]

## 3. Git 工作流 (Git Workflow)
*   **分支策略**: [GitHub Flow / GitFlow]
*   **提交消息格式**: [Conventional Commits]
    *   `feat: 新增搜索功能`
    *   `fix: 修复登录页面样式错误`
    *   `refactor: 重构用户模块`
*   **PR 规范**: [描述变更内容、关联 Issue]

## 4. AI 交互协议 (AI Interaction Protocol)
*   **指令格式**: 使用 Markdown 格式
*   **上下文管理**: 每次对话开始时，AI 应先读取 specs/ 目录
*   **输出规范**: 代码 + 简要说明，不生成冗余文档

## 5. 项目特定规则 (Project-Specific Rules)
*   [根据项目特点添加的特定规则]

## 6. .gitignore 配置
```
# Dependencies
node_modules/

# Environment
.env
.env.local

# Build
dist/
build/

# IDE
.vscode/
.idea/

# SpecForge runtime scratch
.specforge/
```
