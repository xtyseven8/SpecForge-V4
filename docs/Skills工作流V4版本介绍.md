
# SpecForge V4 版本介绍

> V4 在保留 V3 核心优势（AC 贯穿、角色化、中文友好、三层流程）的前提下，融合 Superpowers 的工程化优点，补齐上下文隔离、进度持久化、代码审查、计划审查四大短板，并新增四份文档驱动机制确保前端实现与原型一致。

---

## V3 → V4 变更总览

| 变更项 | V3 现状 | V4 优化 | 影响 Skill |
|--------|---------|---------|-----------|
| 上下文隔离 | 单会话执行，长任务风险高 | Subagent 驱动模式 + 降级策略 | feature-implementation |
| 进度持久化 | 无，compaction 后丢失 | .specforge/progress.md 账本 | feature-implementation |
| 代码审查 | 无独立环节 | 新增 feature-code-review（两/三阶段审查） | 新增 Skill |
| 功能测试 | 无独立环节 | 新增 feature-functional-testing（先写测试用例再执行） | 新增 Skill |
| 计划审查 | 直接执行 | Pre-flight 计划审查 | feature-implementation |
| 文件交接 | 无 | task-brief / report / diff 文件化 | feature-implementation |
| 行为约束 | 恐惧诱导话术 | 理性 Red Flags 表格 | PROJECT-CONTEXT + 7个功能级 Skill |
| Subagent 边界 | 无 | 控制器/执行者职责分离 | GUARDRAILS |
| .gitignore | 无 .specforge/ 规则 | 增加 .specforge/ 忽略 | project-dev-standards |
| **文档驱动** | **三份文档（需求/技术方案/任务规划）** | **四份文档（增加原型文档），原型为空回退三份** | **7个功能级 Skill + PROJECT-CONTEXT** |

---

## Skill 清单（V4）

### 项目级（7个，保留）
- project-requirements-clarification
- project-product-overview
- project-tech-stack
- project-structure
- project-dev-standards（优化：增加 .specforge/ gitignore）
- project-roadmap-planning
- project-initialization

### 功能级（7个，V4 新增 2 个）
- feature-requirements-clarification（优化：增加 Red Flags）
- feature-tech-design（优化：增加 Red Flags）
- feature-task-planning（优化：增加 Red Flags）
- feature-implementation（大改：Subagent + 账本 + Pre-flight + 文件交接 + Red Flags）
- **feature-code-review（新增：两/三阶段审查）**
- **feature-functional-testing（新增：先写测试用例再执行功能测试）**
- feature-evolution（优化：增加 Red Flags + 功能测试回归）

### Bug 级（1个，保留）
- bugfix-workflow

---

## 完整工作流（V4）

```
想法 → ①需求澄清 → ②技术设计 → ③任务规划 → ④编码实现 → ⑤代码审查 → ⑥功能测试 → ⑦功能迭代
         ↓ AC产出    ↓ AC覆盖表   ↓ AC对应任务   ↓ Pre-flight   ↓ AC覆盖矩阵  ↓ 测试用例设计  ↓ 变更影响分析
                                  ↓ Subagent    ↓ 代码质量     ↓ 冒烟测试     ↓ 功能测试回归
                                  ↓ 账本持久化   ↓ 原型一致性   ↓ AC验证测试
                                  ↓ 开发者自验   ↓ 技术债务     ↓ 异常场景测试
                                                             ↓ 原型一致性测试
```
