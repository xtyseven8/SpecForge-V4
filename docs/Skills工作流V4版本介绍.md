
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

## 新增能力详解

### 1. Subagent 驱动模式

**问题**：V3 单会话执行所有任务，上下文过长导致质量下降。

**方案**：每个任务派发独立 subagent 执行 TDD 循环，主会话（控制器）负责调度、审查、记录。

**降级策略**：平台不支持 subagent 时，回退到「单会话+文件交接」模式，仍能获得文件交接的核心收益。

### 2. 持久化进度账本

**问题**：V3 会话 compaction 后进度可能丢失，导致重复执行已完成任务。

**方案**：用 `.specforge/progress.md` 文件追踪进度，记录每个任务的完成状态、commit 范围、审查结果、技术债务。

**恢复机制**：compaction 后读取账本，从第一个未完成任务恢复，不重新派发已完成任务。

### 3. feature-code-review Skill

**问题**：V3 没有独立的代码审查环节，TDD + 验收测试覆盖了质量，但缺少 spec 合规性审查。

**方案**：新增 feature-code-review Skill，两阶段审查：
- **阶段一**：AC 覆盖合规性（验证每条 AC 在技术方案、任务规划、TDD 测试、验收测试中都有着落）
- **阶段二**：代码质量（DRY、YAGNI、命名、错误处理、测试质量、风格一致性）
- **阶段三**（四份文档驱动模式）：原型一致性审查，验证 UI 实现与原型视觉一致

**集成点**：feature-implementation 完成阶段后建议调用 feature-code-review。

**强制后置**：代码审查通过后必须强制进入功能测试阶段（feature-functional-testing），不能直接标记功能完成。代码审查看的是 diff，看不到运行时表现——应用能否启动、页面是否白屏、用户点击按钮后真实发生什么，只有功能测试才能发现。

### 4. feature-functional-testing Skill（V4 新增）

**问题**：V3 只有开发者自验（feature-implementation 的验收测试），开发者脑子里有实现细节，会无意中避开 bug；代码审查基于 diff，看不到运行时的真实表现。集成层面的问题（无法启动、页面白屏、功能与需求不符）只有在真实用户使用时才会被发现，成本呈数量级上升。

**方案**：新增 feature-functional-testing Skill，独立 QA 视角的功能测试：
- **先写测试用例再执行**：四类测试用例（冒烟测试、AC 验证测试、异常场景测试、原型一致性测试），在执行前完整写好并通过 CHECKPOINT 让用户确认覆盖度
- **发现三类问题**：
  - 致命问题：应用无法启动、页面白屏、核心 API 500、关键路径走不通
  - 功能缺失：需求 AC 描述的功能在实现中不存在或与设计严重不符
  - 集成问题：单个组件测试通过，但组件组合后行为异常（TDD 单元测试覆盖不到）

**工具优先级**：Playwright MCP 优先（可截图、检测 JS 异常）→ curl/CLI 补充（精确状态码）→ 数据库直查 → 手动验证兜底

**位置定位**：`feature-code-review` 通过后强制后置触发，是质量门禁的最后一道。审查通过 ≠ 功能可以发布。

**产出文档**：
- `specs/tests/{功能名}_测试用例.md`（测试用例设计）
- `docs/开发记录/{功能名}_功能测试报告.md`（测试执行报告）

### 5. bugfix-workflow Skill

**问题**：用户报告 bug 时，容易把"需求变更"当"bug"处理，导致流程混乱。

**方案**：新增 bugfix-workflow Skill，明确区分：
- **是 bug**：代码的行为与需求文档/设计文档/AC 的描述不一致
- **不是 bug**：用户想要新行为、调整现有行为、改文案、加功能 → 这是需求变更，应走正常开发流程

**分级处理**：
- **简单问题** → 快速修复：一眼看出问题，改动范围小，不写修复报告
- **复杂问题** → 完整排查：原因不明显、涉及多模块，走完整流程（收集信息 → 复现问题 → 定位根因 → 修复 → 测试验证 → 生成报告）

**核心原则**：
- 没有复现，就不动代码（铁律）
- 最小改动原则，不顺手重构不相关的代码
- 修复后必须有验证（自动化测试或实际验证）

**产出文档**：`docs/BUG修复文档/YYYYMMDD-HHMM-问题简述.md`（复杂问题）

### 6. Pre-flight 计划审查

**问题**：V3 直接执行任务规划，计划层面的冲突执行到一半才发现。

**方案**：派发 Task-1 之前扫描任务规划，检测 5 类问题：
1. 任务间矛盾
2. 全局约束冲突
3. AC 覆盖缺口
4. 验证标准质量
5. 依赖关系合理性

批量呈现所有发现给用户决策，而非逐个中断。

### 7. Red Flags 表格

**问题**：V3 的 PROJECT-CONTEXT.md 使用"违反即是背叛""数千美元损失"等恐惧话术，不如理性红线表格稳健。

**方案**：用 Red Flags 表格替代恐惧诱导，已在以下文件中应用：
- PROJECT-CONTEXT.md
- feature-requirements-clarification
- feature-tech-design
- feature-task-planning
- feature-implementation
- feature-evolution
- feature-code-review
- feature-functional-testing

### 8. 文件交接机制

**问题**：V3 在对话中粘贴大段内容，污染上下文。

**方案**：使用文件交接，避免在对话中粘贴：
- task-brief 文件：任务全文
- report 文件：执行过程和结果
- diff 文件：代码改动包

### 9. 四份文档驱动（V4 新增）

**问题**：V3 三份文档驱动（需求/技术方案/任务规划）缺少 UI 视觉基准，前端实现的样式、排版、布局容易偏离设计意图。

**方案**：新增原型文档作为第四份驱动文档，路径为 `specs/prototype/` 下的所有 html 文件。

**判定规则**：
- `specs/prototype/` 存在且包含 `.html` 文件 → **四份文档驱动模式**，原型是 UI 实现的真相源
- 目录不存在或为空 → **三份文档驱动模式**（回退），按原有流程执行

**各环节作用**：

| 环节 | 原型文档的作用 |
|------|--------------|
| 需求澄清 | 参考原型确认交互细节、页面元素、用户操作路径 |
| 技术设计 | 对照原型设计组件结构、样式规范、布局方案、响应式断点 |
| 任务规划 | UI 相关任务的验证标准必须包含原型一致性检查点 |
| 编码实现 | 实现 UI 时必须对照原型，样式/布局/排版以原型为准 |
| 代码审查 | 增加「原型一致性」审查维度（阶段三），验证实现与原型视觉一致 |
| 功能测试 | 增加原型一致性测试用例，对照原型验证视觉属性、布局结构、交互行为、响应式 |
| 功能迭代 | UI 变更时同步更新原型文档，保持原型与实现一致 |

**原型一致性原则**：
1. 原型是 UI 真相源：实现与原型冲突时以原型为准
2. 样式精确还原：颜色、字体、间距、圆角、阴影等视觉属性必须一致
3. 布局结构对应：DOM 结构和布局方式应与原型对应
4. 交互行为一致：按钮点击、表单提交、动画过渡等交互行为一致
5. 响应式一致：响应式断点和布局变化与原型一致

**feature-code-review 三阶段审查**：
- 阶段一：AC 覆盖合规性
- 阶段二：代码质量
- 阶段三：原型一致性（四份文档驱动模式启用时），输出原型一致性矩阵

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
- **bugfix-workflow**（优化：明确区分 bug vs 需求变更，分级处理）
  - 核心判断：代码行为与需求/设计/AC 不一致 → 是 bug；想要新行为 → 是需求变更
  - 分级处理：简单问题快速修复，复杂问题完整排查（复现 → 定位 → 修复 → 验证 → 报告）
  - 铁律：没有复现就不动代码
  - 产出文档：`docs/BUG修复文档/YYYYMMDD-HHMM-问题简述.md`（复杂问题）

### 参考文档（2个，优化）
- PROJECT-CONTEXT.md（优化：恐惧诱导 → Red Flags）
- GUARDRAILS.md（优化：增加 Subagent 模式边界守卫）

---

## 运行时目录结构

```
你的项目/
├── specs/
│   ├── PROJECT-CONTEXT.md
│   ├── 产品概述.md
│   ├── prototype/                         # V4 新增：原型文档目录
│   │   ├── search.html                    # 搜索页原型
│   │   ├── article-detail.html            # 文章详情页原型
│   │   └── ...
│   └── features/
│       ├── 搜索功能.md
│       ├── 搜索功能_技术方案.md
│       ├── 搜索功能_任务规划.md
│       └── 搜索功能_变更任务_CR-001.md
├── docs/
│   └── 开发记录/
│       ├── 搜索功能_阶段1_完成报告.md
│       ├── 搜索功能_代码审查报告.md      # V4 新增
│       ├── 搜索功能_功能测试报告.md      # V4 新增（功能测试阶段）
│       └── ...
└── .specforge/                           # V4 新增：运行时 scratch（git-ignored）
    ├── progress.md                       # 进度账本
    ├── briefs/                           # task-brief 文件
    ├── reports/                          # 实现报告文件
    └── reviews/                          # diff 包文件
```

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

---

## 预期收益

| 维度 | V3 现状 | V4 优化后 |
|------|---------|-----------|
| 上下文隔离 | 单会话，长任务风险高 | Subagent 隔离或文件交接 |
| 进度持久化 | 无，compaction 后丢失 | 账本机制，抗 compaction |
| 代码审查 | 无独立环节 | 两/三阶段审查（AC 合规 + 质量 + 原型一致性） |
| 功能测试 | 无独立环节 | 先写测试用例再执行（冒烟/AC/异常/原型四类测试） |
| 计划审查 | 直接执行 | Pre-flight 扫描冲突 |
| 文件交接 | 无 | task-brief / report / diff 文件化 |
| 行为约束 | 恐惧诱导话术 | 理性 Red Flags 表格 |
| **UI 视觉一致性** | **无原型基准，实现易偏离设计** | **四份文档驱动，原型是 UI 真相源，原型为空回退三份** |
| **运行时质量保障** | **仅开发者自验，看不到用户视角问题** | **独立 QA 功能测试，发现无法启动/白屏/功能不符等集成问题** |
| AC 追溯 | ✅ 保留 | ✅ 保留 |
| 角色化设计 | ✅ 保留 | ✅ 保留 |
| 中文友好 | ✅ 保留 | ✅ 保留 |
| 三层流程 | ✅ 保留 | ✅ 保留 |
