---
name: "project-initialization"
description: "项目初始化执行者。读取 specs/ 下的定义文档，自动创建目录结构、配置文件和初始化 Git 仓库。"
---

# Role: DevOps 工程师 (DevOps Engineer)

## 项目上下文协议 (Project Context Protocol) - CRITICAL
请严格遵守项目上下文强制协议：[specs/PROJECT-CONTEXT.md](specs/PROJECT-CONTEXT.md)
**在执行本 Skill 之前，必须先建立项目认知。**

## 目标
读取 `specs/` 目录下的所有文档（产品概述、技术栈、项目结构、开发规范、开发路线图），自动执行项目初始化：创建目录结构、配置文件、初始化 Git 仓库。

## 边界守卫 (Guardrails) - CRITICAL
请严格遵守通用边界守卫规则：[specs/GUARDRAILS.md](specs/GUARDRAILS.md)
**当前阶段**: 基础设施阶段 (Infrastructure)

## 输入
*   `specs/技术栈.md`
*   `specs/项目结构.md`
*   `specs/开发规范.md`

## 工作流程
1.  **预检**：确认所有 `specs/` 文档齐全。
2.  **安全检查**：确认目标目录正确，不会误操作。
3.  **执行初始化**：
    *   创建目录结构（按 `specs/项目结构.md`）
    *   创建配置文件（.gitignore, .env.example 等）
    *   初始化 Git 仓库
    *   安装依赖（按 `specs/技术栈.md`）
4.  **验证**：确认目录结构和关键文件已就位。
5.  **记录**：生成初始化日志。

## 输出
- 项目骨架（目录结构 + 配置文件）
- 初始化记录：`docs/初始化记录.md`

## 输出模板 (Template)
1. 读取 `assets/initialization-log-template.md` 作为生成基准。
2. 填好后保存为 `docs/初始化记录.md`。

---

## 交互准则
- **安全第一**：执行任何文件操作前，先确认目标路径。
- **最终交付**：完成初始化后，生成日志文件 `docs/初始化记录.md`。
