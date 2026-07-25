# My-Prompts

个人 AI Workflow Library：同时管理一次性 Prompt、可编排 Skill，以及组合多个能力的 Agent。

## Prompt / Skill / Agent

| 类型 | 判断标准 | 适合场景 |
| --- | --- | --- |
| Prompt | 输入 → 模型处理 → 输出；无跨轮状态、固定流程或工具依赖 | 图片标签、隐私分析、单次生图、单次产品化 |
| Skill | 多步骤、固定顺序、中间状态、多阶段输出、质量检查或工具编排 | 软件设计流水线、分层影视剧照、技术报告生成 |
| Agent | 组合多个 Prompt 和 Skill 的角色入口，负责路由、状态和交付 | 软件设计负责人、研究助手、报告编排角色 |

## 快速开始

### 使用 Prompt

从 [`prompts/`](prompts/README.md) 选择单任务文件，补全输入后直接复制到模型中。

### 使用 Skill

从 [`skills/README.md`](skills/README.md) 按类别选择工作流，或从 [`提示词工程技能库`](skills/提示词工程技能库/SKILL.md) 进行任务路由。

#### 软件开发

- [Codex 任务执行](skills/01-软件开发/Codex任务执行/SKILL.md)
- [代码审查与修复](skills/01-软件开发/代码审查与修复/SKILL.md)
- [软件设计流水线](skills/软件设计流水线/SKILL.md)

#### 研究分析

- [深度调研与事实核验](skills/02-研究分析/深度调研与事实核验/SKILL.md)
- [论文阅读与复现](skills/02-研究分析/论文阅读与复现/SKILL.md)
- [风格参考研究](skills/风格参考研究/SKILL.md)

#### 内容与报告

- [结构化长文写作](skills/03-内容创作/结构化长文写作/SKILL.md)
- [技术报告生成](skills/技术报告生成/SKILL.md)

#### 图像视频

- [图像提示词设计](skills/04-图像视频/图像提示词设计/SKILL.md)
- [视频分镜提示词](skills/04-图像视频/视频分镜提示词/SKILL.md)
- [分层镜头叙事](skills/分层镜头叙事/SKILL.md)

#### Agent、评测与安全

- [Agent 工作流设计](skills/05-Agent与自动化/Agent工作流设计/SKILL.md)
- [提示词优化与评测](skills/05-Agent与自动化/提示词优化与评测/SKILL.md)
- [提示词注入防护](skills/06-安全与质量/提示词注入防护/SKILL.md)

### 使用 Agent

从 [`agents/软件设计Agent/AGENT.md`](agents/软件设计Agent/AGENT.md) 开始，由 Agent 根据输入在产品化 Prompt、软件设计 Skill 和技术报告 Skill 之间路由。

## 目录结构

```text
prompts/    # 一次性单任务 Prompt
skills/     # 带状态、顺序、质量检查或工具编排的工作流
agents/     # 组合多个 Prompt / Skill 的角色入口
docs/       # 来源、迁移映射和维护文档
```

Skill 分类结构：

```text
skills/
├── 01-软件开发/
├── 02-研究分析/
├── 03-内容创作/
├── 04-图像视频/
├── 05-Agent与自动化/
├── 06-安全与质量/
├── 软件设计流水线/
├── 分层镜头叙事/
├── 技术报告生成/
├── 风格参考研究/
└── 提示词工程技能库/
```

原有 `01-软件工程` 至 `07 技术报告生成` 历史目录已完成迁移并清理；后续内容统一维护在 `prompts/`、`skills/` 和 `agents/` 三类目录中。

## 软件设计流水线

执行顺序固定为：

```text
01 问题澄清与反问
02 问题拆解
03 需求风险扫描       Gate ①
04 决策与方案对比
05 模块边界审计
06 数据模型与状态校验  Gate ②
07 关键流程异常枚举
08 需求分析与页面规格
09 页面-流程-权限校验  Gate ③
10 效果图渲染
```

Gate 未通过时必须回退，不能继续生成后续交付物。

## 分层镜头叙事

该 Skill 以原始影视剧照为镜头母版，可接收配色条和人物参考图。调用“拆解”或“分析”也必须进入图片生成流程。

- 最小交付：A、B、C 三张叙事图片 + 一张独立色彩控制卡图片。
- D 只在新增关系会改变主主体处境、目标或理解时生成。
- E 只在存在明确动作或状态变化时生成。
- C/D 顺序有歧义时先给最多两个方案并等待选择。
- 禁止未成年角色、原演员身份复制、文字、水印和无叙事依据的新增元素。

## 收录与维护

- 新增内容先判断是单任务 Prompt、工作流 Skill 还是组合 Agent。
- 新增 Skill 必须包含 `description`、`input`、`workflow`、`rules`、`output`、`examples`。
- 外部 Prompt 或 Skill 只吸收方法和结构，不直接复制低质量万能模板。
- 修改内容时同步检查来源说明和 README 索引。
- 所有迁移均采用复制，原文件不删除、不覆盖。
- 来源和改编原则见 [`docs/提示词Skill来源.md`](docs/提示词Skill来源.md)。
- 原路径到新路径的完整映射见 [`docs/迁移映射.md`](docs/迁移映射.md)。

## 维护入口

- [Prompt 索引](prompts/README.md)
- [Skill 索引](skills/README.md)
- [Agent 索引](agents/README.md)
- [提示词 Skill 来源](docs/提示词Skill来源.md)
- [迁移映射](docs/迁移映射.md)
