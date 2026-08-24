# My-Prompts

个人 AI Workflow Library，用于集中管理 **Prompt、Skill、Agent 与项目规则**。

这个仓库的目标不是收集尽可能多的提示词，而是让不同类型的 AI 工作有清楚边界：

- **Prompts**：一次性文本/图像任务模板。
- **Skills**：需要真实执行、跨阶段产物、Gate、工具、测试或验证的可复用能力。
- **Agents**：负责在多个 Prompt / Skill 之间路由和编排。
- **AGENTS.md**：具体代码仓库长期需要遵守的规则，不放在本库的业务 Skill 里。
- **Plugins（预留）**：多个 Skill、工具、MCP、Hook、命令或 UI 的集成打包层；当前仓库尚未提供 `plugins/` 目录。

---

# 1. Prompt / Skill / Agent / Plugin 怎么区分

## Prompt

适合“输入一次 → 处理一次 → 输出一次”的任务。

即使内部写了很多思考步骤，只要这些步骤可以在一次上下文中完成、最终主要产物仍是一段文本/提示词，就优先作为 Prompt。

典型例子：

- 把模糊产品想法整理成 MVP 草案。
- 根据图片做隐私风险分析。
- 写一篇结构化长文。
- 把技术方案整理成 PPT 分镜。
- 把脚本整理成视频分镜。
- 为一张独立图片设计生图提示词。
- 给另一个 Codex 生成一份开发任务书。

Prompt 不会因为放进仓库就自动成为 Codex Skill。

## Skill

只有当任务需要至少一种下面能力时，才优先做 Skill：

- 读取真实仓库、文件、网络或其他环境。
- 上一步产物作为下一步真实输入。
- 跨阶段维护状态。
- Gate、失败回退或重试。
- 实际修改文件/代码。
- 运行测试、构建或验证。
- 需要脚本、references、assets 等配套资源。
- 希望 Codex 根据 `name + description` 自动发现和调用。

一句话：**“写了很多步骤”不等于 Skill；必须有真实执行闭环。**

## Agent

Agent 是路由/编排层：它不与具体 Skill 抢任务，而是在目标模糊或需要组合多个能力时决定下一步调用谁。

当前有：

- `workflow-router`：仓库总路由器。
- `product-development-agent`：产品研发组合 Agent。

## AGENTS.md

项目长期规则应放在目标代码仓库自己的 `AGENTS.md`，例如：

```text
JDK 必须使用 17
修改接口后必须运行 mvn test
禁止修改某公共模块
数据库脚本必须兼容 PostgreSQL 14
模型文件必须放 models/
```

这些规则不是某次任务流程，不应做成 Prompt/Skill。

## Plugin（预留）

Plugin 是更高一层的打包/集成形态。当一个能力需要同时组合多个 Skill、工具、MCP、Hook、命令或 UI 时，可以考虑 Plugin。

当前仓库还没有 `plugins/` 目录，因此这里只把 Plugin 作为路由概念预留，不把普通 Prompt、单个 Skill 或 Agent 强行升级成 Plugin。

---

# 2. 当前目录

```text
My-Prompts/
├── prompts/
│   ├── product-definition/
│   ├── software-development/
│   ├── writing/
│   ├── technical-communication/
│   ├── video-generation/
│   ├── vision-multimodal-understanding/
│   ├── safety-compliance-risk/
│   ├── geospatial-intelligence/
│   └── image-generation/
│       ├── general/
│       ├── architecture/
│       ├── character-portrait/
│       ├── character-reference/
│       └── style-transfer/
│
├── skills/
│   ├── product-development-skills/
│   ├── product-development-pipeline/
│   ├── software-development/
│   ├── research-analysis/
│   ├── agent-automation/
│   ├── safety-quality/
│   ├── layered-shot-narrative/
│   ├── panorama-generation/
│   └── style-reference-research/
│
├── agents/
│   ├── workflow-router/
│   └── product-development-agent/
│
├── scripts/
│   ├── install-codex-skills.ps1
│   └── audit-skill-metadata.ps1
│
└── docs/
```

---

# 3. Prompts：具体用途

## `product-definition`

- `想法产品化.md`：模糊想法 → 用户/场景/MVP/业务闭环/验收/路线图草案。

## `software-development`

- `codex-task-brief.md`：把自然语言开发需求整理成一份可复制给**另一个** Codex/编码 Agent 的任务书。

注意：如果当前 Codex 就要直接修改仓库，请使用 `codex-task-execution` Skill。

## `writing`

- `structured-longform-writing.md`：主题/素材 → 提纲 → 长文 → 自检与修订。

如果需要真实外部调研，先调用研究 Skill，再把核验后的资料交给写作 Prompt。

## `technical-communication`

- `technical-to-ppt-storyboard.md`：技术方案 → PPT 页级分镜。
- `technical-to-video-storyboard.md`：技术方案 → 技术视频分镜、旁白和 timing JSON。

这里生成的是**汇报脚本**，不是最终 PPTX/视频文件。

## `video-generation`

- `storyboard-design.md`：故事、产品演示、业务流程 → 通用视频分镜与每镜头提示词。

## `image-generation/general`

- `image-prompt-design.md`：独立单张图 → 结构化生图 Prompt。

如果已有原始剧照并要生成连续 A/B/C/D/E 图组，改用 `layered-shot-narrative` Skill。

## 其他现有 Prompt

- `vision-multimodal-understanding`：图片标签等视觉理解模板。
- `safety-compliance-risk`：图片隐私/安全风险分析。
- `geospatial-intelligence`：基于可见证据的图片区域判断。
- `image-generation/architecture`：建筑类视觉提示词。
- `image-generation/character-reference`：人物/关系参考图。
- `image-generation/character-portrait`：职业照、电影肖像、杂志、九宫格等人物 Prompt。
- `image-generation/style-transfer`：参考图调色、LUT、油画、老照片等转换模板。

详细索引见 [`prompts/README.md`](prompts/README.md)。

---

# 4. Skills：具体用途

## 产品研发能力库

`skills/product-development-skills/`

- `requirement-clarification`：信息不足时多轮澄清。
- `requirement-analysis`：分析价值、根因、范围、角色、规则、风险和验证方式。
- `solution-design`：形成候选方案、模块、对象、状态、权限与核心流程。
- `prd-writing`：把已确认方案转成研发/测试可使用的 PRD。
- `requirement-review`：独立评审，输出 S0–S3 与 GO / CONDITIONAL GO / NO-GO。
- `prototype-greenfield`：从零生成可运行可点击的前端原型。
- `prototype-existing-project`：在现有前端工程中新增/修改高保真原型。
- `version-retrospective`：版本复盘和行动项。
- `project-knowledge-capture`：把多个资料沉淀成可检索、可追溯项目知识。

## `product-development-pipeline`

端到端编排器：需求澄清 → 分析 → 方案 → 模块/状态/异常 Gate → PRD → 评审 → 页面规格 → 输出路由。

只有用户希望跨多个阶段完整推进时才使用；单阶段任务直接使用上面的专项 Skill。

## 软件开发

### `codex-task-execution`

当前 Codex 直接：

```text
读仓库 → 找调用链 → 修改真实文件 → 补测试 → 跑测试/构建 → 修复失败 → 汇报结果
```

最终交付是实际代码变化和验证结果，不再生成“另一段给 Codex 的 Prompt”。

### `code-review-fix`

主动审查代码/PR，按证据发现 P0–P3 问题，并在允许时直接修复和验证。

### `java-project-architecture-analysis`

读取真实 Java/Spring 项目，建立模块、启动、调用链、数据/状态、集成和部署视图。

## 研究分析

- `deep-research-fact-checking`：外部多来源研究与事实核验。
- `paper-reading-reproduction`：论文—代码—实验对照和复现计划。
- `python-vision-project-reproduction`：在真实 Python/CUDA/GPU 环境中安装、推理、评测/训练和验证视觉项目。
- `style-reference-research`：检索作者/作品并提炼可验证视觉风格参数。

## Agent / 安全 / 质量

- `agent-workflow-design`：设计 Routing、Chaining、Parallel、Orchestrator 等 Agent 工作流。
- `prompt-optimization-evaluation`：为 Prompt/Skill 建测试集、基线、回归与失败归因。
- `prompt-injection-defense`：设计 Agent 信任边界、权限 Gate 和红队测试。

## 图像工作流

- `layered-shot-narrative`：基于原剧照/参考画面直接生成连续分层镜头图组并检查连续性。
- `panorama-generation`：360° equirectangular 全景资产 → Three.js 查看器 → 映射/交互验证。

详细索引见 [`skills/README.md`](skills/README.md)。

---

# 5. Agents

## `workflow-router`

只有在任务模糊、跨域，或明确问“应该用哪个 Prompt/Skill/Agent”时使用。

它是裁判，不是参赛 Skill。这里放在 `agents/` 是为了仓库结构清晰；真正让它不属于 Codex Skill 候选的是：它使用 `AGENT.md` 而不是标准 `SKILL.md`，没有 Skill 的 `name + description` frontmatter，并且本仓库不会把它安装到 `.codex/skills` 或项目 `.agents/skills`。

## `product-development-agent`

组合产品定义 Prompt、产品研发专项 Skill、完整流水线和汇报 Prompt，维护产品阶段状态与 Gate。

详细索引见 [`agents/README.md`](agents/README.md)。

---

# 6. 导入 Codex 使用

## 6.1 推荐：按需安装 Skill

不要默认把所有 Skill 全装。安装与当前工作真正有关的能力即可，减少自动路由噪声。

仓库提供 Windows PowerShell 脚本：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -List
```

查看可安装 Skill。

安装指定 Skill：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 `
  -Include product-development-pipeline,codex-task-execution,code-review-fix
```

安装全部 Skill（不推荐长期这么做）：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -All
```

## 6.2 全局安装

本仓库脚本默认将 Skill 安装到用户级 Codex Skill 目录：

```text
%USERPROFILE%\.codex\skills\<skill-name>\SKILL.md
```

适合多个项目都需要的能力，例如：

- `codex-task-execution`
- `code-review-fix`
- `deep-research-fact-checking`

## 6.3 项目级安装

需要只对一个代码仓库生效时，把对应 Skill 放到项目：

```text
<project>\.agents\skills\<skill-name>\SKILL.md
```

适合项目专属流程或不希望污染全局候选的 Skill。

## 6.4 Prompt 怎么用

Prompt **不安装到 Skill 目录**。

使用方式：

1. 打开对应 `.md`，复制内容并替换变量。
2. 或让 Codex 直接读取本仓库的 Prompt 文件并执行。

例如：

```text
读取 My-Prompts/prompts/software-development/codex-task-brief.md，
根据下面需求生成任务书：……
```

## 6.5 Agent 怎么用

`agents/` 是本仓库自己的组合定义，不应复制到 `.codex/skills`。

可以显式让 Codex 读取：

```text
读取 My-Prompts/agents/workflow-router/AGENT.md，
判断下面任务应该使用哪个 Prompt / Skill / Agent：……
```

---

# 7. 维护与审计

Skill 元数据必须满足：

```yaml
---
name: directory-name
description: 清楚说明什么时候触发、负责什么、与相邻 Skill 的边界。
---
```

运行审计：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\audit-skill-metadata.ps1
```

详细规范：

- [`docs/skill-description-guidelines.md`](docs/skill-description-guidelines.md)
- [`docs/naming-conventions.md`](docs/naming-conventions.md)

新增内容前先问：

> 这件事真的需要真实执行闭环吗？

如果答案只是“我要模型按一个模板输出一段内容”，优先新增 Prompt，而不是 Skill。
