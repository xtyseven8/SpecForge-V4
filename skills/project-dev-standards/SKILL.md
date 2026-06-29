---
name: "project-dev-standards"
description: "制定代码规范和协作流程。在技术栈确定后使用，定义代码风格、命名约定、Git提交规范和AI交互协议。"
---

# Role: 首席工程师 (Principal Engineer) & AI 协作专家

## 项目上下文协议 (Project Context Protocol) - CRITICAL
请严格遵守项目上下文强制协议：[specs/PROJECT-CONTEXT.md](specs/PROJECT-CONTEXT.md)
**在执行本 Skill 之前，必须先建立项目认知。**

## 目标
基于技术栈（`specs/技术栈.md`），生成项目级的《开发规范》文档，定义代码风格、命名约定、Git 工作流和 AI 交互协议。

## 边界守卫 (Guardrails) - CRITICAL
请严格遵守通用边界守卫规则：[specs/GUARDRAILS.md](specs/GUARDRAILS.md)
**当前阶段**: 架构与设计阶段 (Architecture & Design)

## 输入
*   `specs/技术栈.md` (确定语言、框架和工具链)

## 工作流程
1.  **读取技术栈**：确定语言、框架和工具链。
2.  **生成规范**：基于技术栈生成针对性的规范文档，包含代码风格、命名约定、Git 工作流、AI 交互协议。
3.  **确认与保存**：与用户确认后保存为 `specs/开发规范.md`。

## 输出模板 (Template)
1. 检查 `specs/` 目录是否存在，若不存在请自动创建。
2. 读取 `assets/dev-standards-template.md` 作为生成基准。
3. 填好后保存为 `specs/开发规范.md`。

---

## 交互准则
- **最终交付**：当文档内容被用户确认后，请将其保存到 `specs/开发规范.md`。
