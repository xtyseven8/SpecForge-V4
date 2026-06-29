# SpecForge V4

AI 驱动的软件工程工作流技能集，专为 Trae IDE 设计。**四份文档驱动**（需求/技术方案/任务规划/原型），AC 贯穿链路，TDD 驱动开发，支持 Subagent 模式。

## 核心特性

- **四份文档驱动**：需求文档 → 技术方案 → 任务规划 → 原型文档，原型为空时自动回退到三份文档驱动
- **AC 贯穿链路**：验收标准从需求澄清到代码审查全链路可追溯
- **TDD 驱动开发**：RED → GREEN → REFACTOR，测试先行
- **Subagent 模式**：每个任务派发独立 subagent 执行，上下文隔离
- **持久化进度**：`.specforge/progress.md` 账本，抗 compaction
- **两/三阶段代码审查**：AC 覆盖合规性 + 代码质量 + 原型一致性
- **原型一致性验证**：前端实现必须与原型视觉一致，原型是 UI 真相源

## 工作流全景

```
想法 → ①需求澄清 → ②技术设计 → ③任务规划 → ④编码实现 → ⑤代码审查 → ⑥功能迭代
         ↓ AC产出    ↓ AC覆盖表   ↓ AC对应任务   ↓ Pre-flight   ↓ AC覆盖矩阵  ↓ 变更影响分析
                                  ↓ Subagent    ↓ 代码质量
                                  ↓ 账本持久化   ↓ 原型一致性
```

## 四份文档驱动

SpecForge V4 在「需求/技术方案/任务规划」三份文档驱动的基础上，新增**原型文档**作为第四份驱动文档。

### 判定规则

- `specs/prototype/` 存在且包含 `.html` 文件 → **四份文档驱动模式**，原型是 UI 真相源
- 目录不存在或为空 → **三份文档驱动模式**（回退），按原有流程执行

### 各环节原型作用

| 环节 | 原型文档的作用 |
|------|--------------|
| 需求澄清 | 参考原型确认交互细节、页面元素、用户操作路径 |
| 技术设计 | 对照原型设计组件结构、样式规范、布局方案、响应式断点 |
| 任务规划 | UI 相关任务的验证标准必须包含原型一致性检查点 |
| 编码实现 | 实现 UI 时必须对照原型，样式/布局/排版以原型为准 |
| 代码审查 | 增加「原型一致性」审查维度（阶段三），验证实现与原型视觉一致 |
| 功能迭代 | UI 变更时同步更新原型文档，保持原型与实现一致 |

## Skill 清单

### 项目级（7 个）

| Skill | 说明 |
|-------|------|
| project-requirements-clarification | 苏格拉底式需求挖掘，生成标准化项目描述 |
| project-product-overview | 将需求转化为产品概述文档 |
| project-tech-stack | 技术选型，推荐最合适而非最热门的技术栈 |
| project-structure | 设计项目目录结构，高内聚低耦合 |
| project-dev-standards | 制定代码规范、Git 工作流、AI 协作协议 |
| project-roadmap-planning | 开发路线图规划，依赖分析和里程碑设计 |
| project-initialization | 读取 specs/ 文档，自动创建项目骨架 |

### 功能级（6 个）

| Skill | 说明 |
|-------|------|
| feature-requirements-clarification | 对话式需求澄清，产出高质量 AC |
| feature-tech-design | 技术方案设计，AC 覆盖总表 |
| feature-task-planning | 垂直切片拆任务，TDD 验证标准 |
| feature-implementation | TDD 驱动编码实现，Subagent + 账本 |
| feature-code-review | 两/三阶段代码审查（AC 覆盖 + 质量 + 原型一致性） |
| feature-evolution | 功能变更管理，增量文档更新 |

### 参考文档（2 个）

| 文档 | 说明 |
|------|------|
| PROJECT-CONTEXT.md | 项目上下文协议，所有 Skill 执行前必读 |
| GUARDRAILS.md | 边界守卫，防止 Skill 越界 |

## 项目目录结构

```
你的项目/
├── specs/
│   ├── PROJECT-CONTEXT.md
│   ├── 产品概述.md
│   ├── prototype/                         # 原型文档目录
│   │   ├── search.html
│   │   └── ...
│   └── features/
│       ├── 搜索功能.md
│       ├── 搜索功能_技术方案.md
│       ├── 搜索功能_任务规划.md
│       └── 搜索功能_变更任务_CR-001.md
├── docs/
│   └── 开发记录/
│       ├── 搜索功能_阶段1_完成报告.md
│       ├── 搜索功能_代码审查报告.md
│       └── ...
└── .specforge/                           # 运行时 scratch（git-ignored）
    ├── progress.md
    ├── briefs/
    ├── reports/
    └── reviews/
```

## 安装

### 方式一：复制到 Trae IDE Skills 目录

```bash
# 将仓库 clone 到 Trae IDE 的 skills 目录
git clone https://github.com/xtyseven8/SpecForge-V4.git
# 复制需要的 Skill 到 .trae/skills/ 目录
cp -r SpecForge-V4/skills/* ~/.trae/skills/
```

### 方式二：在项目内使用

1. 将 `references/` 下的 `PROJECT-CONTEXT.md` 和 `GUARDRAILS.md` 复制到项目的 `specs/` 目录
2. 根据需要复制对应 Skill 文件夹到 `.trae/skills/`
3. 在项目根目录创建 `specs/prototype/` 目录，放入 HTML 原型文件（可选）

## 使用方法

### 项目初始化流程

```
1. project-requirements-clarification  → 需求挖掘
2. project-product-overview            → 产品概述
3. project-tech-stack                  → 技术选型
4. project-structure                   → 目录结构
5. project-dev-standards               → 开发规范
6. project-roadmap-planning            → 路线图
7. project-initialization              → 项目初始化
```

### 功能开发流程

```
1. feature-requirements-clarification  → 需求澄清 + AC
2. feature-tech-design                 → 技术方案 + AC 覆盖表
3. feature-task-planning               → 垂直切片 + TDD 验证标准
4. feature-implementation              → TDD 编码 + 验收
5. feature-code-review                 → 代码审查
6. feature-evolution（需要时）          → 变更管理
```

### 四份文档驱动模式

当项目存在 `specs/prototype/` 目录且包含 HTML 文件时，自动启用四份文档驱动模式：

- 需求澄清时会参考原型确认交互细节
- 技术设计时会从原型提取设计 token 和布局方案
- 任务规划时 UI 任务会标注原型一致性检查点
- 编码实现时会对照原型精确还原样式和布局
- 代码审查时会增加原型一致性审查阶段
- 功能迭代时 UI 变更会同步更新原型

## 版本历史

### V4（当前）
- 新增四份文档驱动（原型文档作为第四份驱动文档）
- 新增 feature-code-review Skill（两/三阶段审查）
- 新增 Subagent 驱动模式 + 降级策略
- 新增持久化进度账本
- 新增 Pre-flight 计划审查
- 新增文件交接机制
- Red Flags 表格替代恐惧诱导话术

### V3
- AC 贯穿链路
- 角色化设计
- 中文友好
- 三层流程（项目级/功能级/Bug级）

## 许可证

MIT License
