# SpecForge V4

> AC 贯穿的全栈开发 Skill 工作流，融合工程化最佳实践，补齐上下文隔离、进度持久化、代码审查、功能测试四大短板。

---

## 核心优势

### 1. AC 贯穿链路
每条验收标准（AC）从需求澄清 → 技术设计 → 任务规划 → 编码实现 → 代码审查 → 功能测试，全程可追溯。

### 2. 四份文档驱动
- 需求文档（specs/features/{功能名}.md）
- 技术方案（specs/features/{功能名}_技术方案.md）
- 任务规划（specs/features/{功能名}_任务规划.md）
- 原型文档（specs/prototype/*.html）— **V4 新增**，确保 UI 实现与原型一致

原型为空时回退三份文档驱动模式。

### 3. 完整质量门禁
```
需求澄清 → 技术设计 → 任务规划 → 编码实现 → 代码审查 → 功能测试 → 功能迭代
                         ↓ Pre-flight    ↓ AC覆盖矩阵  ↓ 测试用例设计  ↓ 变更影响分析
                         ↓ Subagent      ↓ 代码质量    ↓ 冒烟测试     ↓ 功能测试回归
                         ↓ 账本持久化    ↓ 原型一致性  ↓ AC验证测试
                         ↓ 开发者自验    ↓ 技术债务    ↓ 异常场景测试
                                                      ↓ 原型一致性测试
```

### 4. 角色化设计
每个 Skill 扮演专业角色（需求分析师、架构师、技术主管、开发者、审查者、QA），职责清晰，不越界。

### 5. 中文友好
全中文文档和 Skill，适合中文开发者使用。

---

## Skill 清单

### 项目级（7个）
| Skill | 作用 |
|-------|------|
| project-requirements-clarification | 项目需求澄清 |
| project-product-overview | 产品概述文档 |
| project-tech-stack | 技术栈选型 |
| project-structure | 项目目录结构 |
| project-dev-standards | 开发规范 |
| project-roadmap-planning | 开发路线图 |
| project-initialization | 项目初始化 |

### 功能级（7个）
| Skill | 作用 |
|-------|------|
| feature-requirements-clarification | 功能需求澄清 |
| feature-tech-design | 技术方案设计 |
| feature-task-planning | 任务规划 |
| feature-implementation | 编码实现（Subagent + TDD） |
| **feature-code-review** | 代码审查（两/三阶段）— V4 新增 |
| **feature-functional-testing** | 功能测试（先写用例再执行）— V4 新增 |
| feature-evolution | 功能迭代 |

### Bug级（1个）
| Skill | 作用 |
|-------|------|
| bugfix-workflow | BUG修复工作流 |

---

## V4 核心特性

### Subagent 驱动模式
每个任务派发独立 subagent 执行 TDD 循环，主会话负责调度、审查、记录。不支持 subagent 时回退文件交接模式。

### 持久化进度账本
`.specforge/progress.md` 追踪进度，抗 compaction，可恢复。

### Pre-flight 计划审查
派发 Task-1 前扫描任务规划，检测矛盾、冲突、缺口、依赖问题。

### Red Flags 表格
理性红线替代恐惧诱导，已在 7 个功能级 Skill 中应用。

### 原型一致性
四份文档驱动模式下，UI 实现必须对照原型，代码审查和功能测试增加原型一致性维度。

### 功能测试
独立 QA 视角，先写测试用例再执行，发现无法启动、页面白屏、功能与需求不符等集成问题。

---

## 快速开始

### 1. 项目启动
```
用户：我想做一个 XX 项目
→ 调用 project-requirements-clarification
→ 调用 project-product-overview
→ 调用 project-tech-stack
→ 调用 project-structure
→ 调用 project-dev-standards
→ 调用 project-roadmap-planning
→ 调用 project-initialization
```

### 2. 功能开发
```
用户：开发 XX 功能
→ 调用 feature-requirements-clarification
→ 调用 feature-tech-design
→ 调用 feature-task-planning
→ 调用 feature-implementation
→ 自动建议 feature-code-review
→ 自动建议 feature-functional-testing
```

### 3. BUG修复
```
用户：XX 功能有个 bug
→ 调用 bugfix-workflow
→ 简单问题快速修复，复杂问题完整排查
```

---

## 目录结构

```
你的项目/
├── specs/
│   ├── PROJECT-CONTEXT.md         # 项目上下文协议
│   ├── 产品概述.md
│   ├── prototype/                 # 原型文档（V4）
│   │   ├── search.html
│   │   └── ...
│   └── features/
│       ├── XX功能.md
│       ├── XX功能_技术方案.md
│       ├── XX功能_任务规划.md
├── docs/
│   └── 开发记录/
│       ├── XX功能_代码审查报告.md    # V4
│       ├── XX功能_功能测试报告.md    # V4
├── .specforge/                    # 运行时（git-ignored）
│   ├── progress.md                # 进度账本
│   ├── briefs/
│   ├── reports/
│   └── reviews/
```

---

## 参考文档

- [Skills工作流V4版本介绍](docs/Skills工作流V4版本介绍.md)
- [PROJECT-CONTEXT.md](references/PROJECT-CONTEXT.md) — 项目上下文协议
- [GUARDRAILS.md](references/GUARDRAILS.md) — 边界守卫协议

---

## 适合谁

- 独立开发者：从想法到代码的全流程指导
- 小团队：标准化协作流程，降低沟通成本
- 学习者：理解软件开发各阶段的职责边界

---

## 致谢

SpecForge V4 在保留 V3 核心优势的基础上，融合了 Anthropic Superpowers 的工程化最佳实践。

---

## 许可证

MIT License
