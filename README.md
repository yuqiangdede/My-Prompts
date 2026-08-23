# My-Prompts

个人 AI Workflow Library：同时管理一次性 Prompt、可编排 Skill，以及组合多个能力的 Agent。

## Prompt / Skill / Agent

| 类型 | 判断标准 | 适合场景 |
| --- | --- | --- |
| Prompt | 输入 → 模型处理 → 输出；无跨轮状态、固定流程或工具依赖 | 图片标签、隐私分析、单次生图、单次产品化 |
| Skill | 多步骤、固定顺序、中间状态、多阶段输出、质量检查或工具编排 | 产品研发流水线、分层镜头叙事、技术报告生成 |
| Agent | 组合多个 Prompt 和 Skill 的角色入口，负责路由、状态和交付 | 产品研发负责人、研究助手、报告编排角色 |

## 快速开始

### 使用 Prompt

从 [`prompts/`](prompts/README.md) 选择单任务文件，补全输入后直接交给模型。

### 使用 Skill

从 [`skills/README.md`](skills/README.md) 按类别选择工作流；不确定入口时使用 [`workflow-router`](skills/workflow-router/SKILL.md)。

#### 产品研发

- [产品研发能力库](skills/product-development-skills/README.md)
- [产品研发流水线](skills/product-development-pipeline/SKILL.md)

#### 软件开发

- [Codex 任务执行](skills/software-development/codex-task-execution/SKILL.md)
- [代码审查与修复](skills/software-development/code-review-fix/SKILL.md)
- [Java 项目架构分析](skills/software-development/java-project-architecture-analysis/SKILL.md)

#### 研究分析

- [深度调研与事实核验](skills/research-analysis/deep-research-fact-checking/SKILL.md)
- [论文阅读与复现](skills/research-analysis/paper-reading-reproduction/SKILL.md)
- [Python 视觉算法项目复现](skills/research-analysis/python-vision-project-reproduction/SKILL.md)
- [风格参考研究](skills/style-reference-research/SKILL.md)

#### 内容与报告

- [结构化长文写作](skills/content-creation/structured-longform-writing/SKILL.md)
- [技术报告生成](skills/technical-report-generation/SKILL.md)

#### 图像视频

- [图像提示词设计](skills/image-video/image-prompt-design/SKILL.md)
- [视频分镜提示词](skills/image-video/video-storyboard-prompts/SKILL.md)
- [分层镜头叙事](skills/layered-shot-narrative/SKILL.md)

#### Agent、评测与安全

- [Agent 工作流设计](skills/agent-automation/agent-workflow-design/SKILL.md)
- [提示词优化与评测](skills/agent-automation/prompt-optimization-evaluation/SKILL.md)
- [提示词注入防护](skills/safety-quality/prompt-injection-defense/SKILL.md)

### 使用 Agent

从 [`agents/product-development-agent/AGENT.md`](agents/product-development-agent/AGENT.md) 开始，由 Agent 根据输入在产品定义 Prompt、产品研发流水线和技术报告 Skill 之间路由。

## 目录结构

```text
prompts/    # 一次性单任务 Prompt
skills/     # 带状态、顺序、质量检查或工具编排的工作流
agents/     # 组合多个 Prompt / Skill 的角色入口
docs/       # 来源、迁移映射和维护文档
```

主要 Skill 结构：

```text
skills/
├── product-development-skills/
├── product-development-pipeline/
├── software-development/
├── research-analysis/
├── content-creation/
├── image-video/
├── agent-automation/
├── safety-quality/
├── layered-shot-narrative/
├── technical-report-generation/
├── style-reference-research/
└── workflow-router/
```

## 产品研发流水线

`product-development-skills` 是可独立调用的能力库，`product-development-pipeline` 是复杂项目的总控编排器。

```text
01 需求澄清
02 需求分析
03 风险 Gate ①
04 方案设计
05 模块边界 Gate ②-A
06 数据/状态 Gate ②-B
07 异常流程补全
08 PRD → 独立评审 → 页面规格
09 页面/流程/权限 Gate ③
10 输出路由：文档 / UI Prompt / 从零原型 / 已有项目原型
```

Gate 未通过时必须回退，不能用默认假设强行推进。

## 目录命名规范

- 所有**目录名**统一使用英文 `kebab-case`，例如 `product-development-pipeline`。
- 目录名不使用中文、空格、中文标点或中英混排。
- `README.md`、`SKILL.md`、`AGENT.md` 的标题和正文可以继续使用中文。
- 历史资料中的中文文件名可以保留；新增可执行入口优先使用稳定英文名称。
- 修改目录后必须同步更新 README、Router、Agent、迁移映射和跨 Skill 链接。
- 完整规则见 [`docs/naming-conventions.md`](docs/naming-conventions.md)。

## 收录与维护

- 新增内容先判断是单任务 Prompt、工作流 Skill 还是组合 Agent。
- 新增 Skill 必须包含 `description`、`input`、`workflow`、`rules`、`output`、`examples`。
- 外部 Prompt 或 Skill 只吸收方法和结构，不直接复制低质量万能模板。
- 修改内容时同步检查来源说明和 README 索引。
- 来源和改编原则见 [`docs/提示词Skill来源.md`](docs/提示词Skill来源.md)。
- 历史路径到当前路径的映射见 [`docs/迁移映射.md`](docs/迁移映射.md)。

## 维护入口

- [Prompt 索引](prompts/README.md)
- [Skill 索引](skills/README.md)
- [Agent 索引](agents/README.md)
- [工作流路由器](skills/workflow-router/SKILL.md)
- [目录命名规范](docs/naming-conventions.md)
- [提示词 Skill 来源](docs/提示词Skill来源.md)
- [迁移映射](docs/迁移映射.md)
