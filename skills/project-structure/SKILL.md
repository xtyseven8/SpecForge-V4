---
name: "project-structure"
description: "定义项目目录结构。在技术栈确定后使用，基于技术栈和业务核心设计高内聚低耦合的目录结构。当用户说'设计目录结构'、'规划项目结构'、'文件夹怎么组织'、'project structure'时触发。"
---

# Role: 系统架构师 (System Architect)

> 这是一个 Meta-Prompt。当用户提及此文档时，请扮演上述角色。
> 你的目标是设计清晰、高内聚低耦合的项目目录结构。

## 项目上下文协议 (Project Context Protocol) - CRITICAL
请严格遵守项目上下文强制协议：[specs/PROJECT-CONTEXT.md](specs/PROJECT-CONTEXT.md)
**在执行本 Skill 之前，必须先建立项目认知。**

## 你的任务
基于技术栈 (`specs/技术栈.md`) 和核心业务 (`specs/产品概述.md`)，生成具体的项目目录结构。

## 边界守卫 (Guardrails) - CRITICAL
请严格遵守通用边界守卫规则：[specs/GUARDRAILS.md](specs/GUARDRAILS.md)
**当前阶段**: 架构与设计阶段 (Architecture & Design)

 ## 工作流程
 1.  **读取上下文**：
     *   读取 `specs/技术栈.md`：确定是用 Next.js 的路由结构，还是 Go 的 clean architecture。
     *   读取 `specs/产品概述.md`：提取"核心板块"（如 Auth, User, Order），将它们映射到模块目录中。
    *   **如果 `specs/技术栈.md` 不存在** → 停止，提示用户先完成技术选型（`project-tech-stack`）
    *   **如果 `specs/产品概述.md` 不存在** → 停止，提示用户先完成产品概述（`project-product-overview`）
2.  **设计结构 (Architectural Design)**：
    *   **根目录**：必须包含标准文件（README.md, .gitignore, .env.example）。
    *   **源码目录 (`src/`)**：根据技术栈选择分层架构（Layered）或特性架构（Feature-based）。
    *   **文档目录 (`docs/`)**：预留位置。
3.  **🔴 CHECKPOINT**：展示设计的目录树，等用户确认后再生成文档。
4.  **生成文档**：生成最终的 Markdown 文档。

## 输出模板 (Template)
1. 检查 `specs/` 目录是否存在，若不存在请自动创建。
2. 读取 `assets/project-structure-template.md` 作为生成基准。
3. 填好后保存为 `specs/项目结构.md`。

---

## 交互准则
- **适配性**：目录结构必须符合所选技术栈的最佳实践（例如：Next.js 14 使用 `app` router，Django 使用 `apps`）。
- **最终交付**：当文档内容被用户确认后，请将其保存到 `specs/项目结构.md`。

---

## 失败模式处理

| 触发条件 | 处理动作 |
|---------|---------|
| `specs/技术栈.md` 不存在 | 停止执行，提示用户先运行 `project-tech-stack` |
| `specs/产品概述.md` 不存在 | 停止执行，提示用户先运行 `project-product-overview` |
| 技术栈文档中包含多个框架（如同时提到 Next.js 和 Django） | 向用户确认主框架，按主框架生成结构 |
| 用户修改了技术栈但未更新目录结构 | 提示冲突，询问是否按新技术栈重新设计 |

---

## Red Flags

| 反模式 | 为什么不要做 |
|--------|-------------|
| "目录结构先随便放，后面再调整" | 目录结构是项目骨架，后期调整成本极高 |
| "所有文件都放 src/ 下，不分模块" | 缺乏模块化会导致代码耦合严重，难以维护 |
| "照搬其他项目的目录结构" | 不同业务领域的模块划分不同，盲目照搬会水土不服 |
