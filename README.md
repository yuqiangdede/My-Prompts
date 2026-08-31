# My-Prompts

个人 AI Workflow Library，用于集中管理 **Prompt、Skill、Agent 与项目规则**。

这个仓库的目标不是收集尽可能多的提示词，而是让不同类型的 AI 工作有清楚边界，并且让 README 本身就能作为仓库导航使用。

- **Prompts**：一次性文本、图像、分析和脚本生成模板。
- **Skills**：需要真实执行、跨阶段产物、Gate、工具、测试或验证的可复用能力。
- **Agents**：负责在多个 Prompt / Skill 之间路由和编排。
- **AGENTS.md**：具体代码仓库长期需要遵守的规则。
- **Plugins（预留）**：多个 Skill、工具、MCP、Hook、命令或 UI 的集成打包层。

---

# 1. Prompt / Skill / Agent 怎么区分

## Prompt

适合“输入一次 → 处理一次 → 输出一次”的任务。

典型例子：

- 把模糊产品想法整理成 MVP 草案。
- 根据图片做隐私风险分析。
- 写结构化长文。
- 把技术方案整理成 PPT / 视频分镜。
- 为独立图片设计生图提示词。
- 给另一个 Codex 生成开发任务书。

入口：[`提示词/prompts/`](提示词/prompts/)

## Skill

只有任务需要至少一种真实执行闭环时，才优先做 Skill：

- 读取真实仓库、文件、网络或工具结果。
- 修改真实代码、文件或环境。
- 上一步产物作为下一步真实输入。
- 跨阶段维护状态。
- Gate、失败回退或重试。
- 运行测试、构建、启动或其他验证。
- 依赖 scripts / references / assets。

入口：[`技能/skills/`](技能/skills/)

## Agent

Agent 是路由与编排层：目标模糊、跨多个能力域，或者需要组合多个 Prompt / Skill 时使用。

当前有：

- [`workflow-router`](智能体/agents/工作流编排/workflow-router/)：仓库总路由器。
- [`product-development-agent`](智能体/agents/产品研发/product-development-agent/)：产品研发组合 Agent。

入口：[`智能体/agents/`](智能体/agents/)

---

# 2. 当前目录结构

```text
My-Prompts/
├── 提示词/
│   └── prompts/
│       ├── 产品与业务/
│       ├── 软件开发/
│       ├── 内容写作/
│       ├── 技术汇报/
│       ├── 视频生成/
│       ├── 视觉理解/
│       ├── 安全合规/
│       ├── 地理空间/
│       └── 图像生成/
├── 技能/
│   └── skills/
│       ├── 产品研发/
│       ├── 软件开发/
│       ├── 研究与复现/
│       ├── 图像与视觉/
│       ├── 智能体与自动化/
│       ├── 安全与质量/
│       └── 需求 设计 实现/     # 历史原始稿
├── 智能体/
│   └── agents/
│       ├── 产品研发/
│       └── 工作流编排/
├── docs/
└── scripts/
```

Prompt、Skill、Agent 统一采用“**中文展示分类 + 英文机器目录**”的分层方式：

```text
提示词/prompts/<中文分类>/<英文机器目录>/
技能/skills/<中文分类>/<英文机器目录>/
智能体/agents/<中文分类>/<英文机器目录>/
```

例如：

```text
提示词/prompts/图像生成/image-generation/
提示词/prompts/软件开发/software-development/
技能/skills/图像与视觉/panorama-generation/
技能/skills/软件开发/software-development/codex-task-execution/
智能体/agents/工作流编排/workflow-router/
智能体/agents/产品研发/product-development-agent/
```

中文分类层方便人工浏览和归类；英文目录继续作为稳定机器标识。Skill 的 `SKILL.md -> name`、Agent 名称和 Prompt 英文目录名都不包含中文分类前缀。

---

# 3. Prompt 导航

完整索引：[`提示词/prompts/README.md`](提示词/prompts/README.md)

## 3.1 产品与业务

目录：[`提示词/prompts/产品与业务/`](提示词/prompts/产品与业务/)

- [`product-definition/`](提示词/prompts/产品与业务/product-definition/)：产品定义。
- [`想法产品化.md`](提示词/prompts/产品与业务/product-definition/想法产品化.md)：模糊想法 → 用户、场景、MVP、闭环、验收、指标、风险和路线图草案。

## 3.2 软件开发

目录：[`提示词/prompts/软件开发/`](提示词/prompts/软件开发/)

- [`software-development/`](提示词/prompts/软件开发/software-development/)：软件开发任务书。
- [`codex-task-brief.md`](提示词/prompts/软件开发/software-development/codex-task-brief.md)：给另一个 Codex / 编码 Agent 生成完整任务书。

## 3.3 内容写作

目录：[`提示词/prompts/内容写作/`](提示词/prompts/内容写作/)

- [`writing/`](提示词/prompts/内容写作/writing/)：结构化写作。
- [`structured-longform-writing.md`](提示词/prompts/内容写作/writing/structured-longform-writing.md)：提纲 → 正文 → 检查 → 修订。

## 3.4 技术汇报

目录：[`提示词/prompts/技术汇报/`](提示词/prompts/技术汇报/)

- [`technical-communication/`](提示词/prompts/技术汇报/technical-communication/)：PPT / 视频技术汇报脚本。
- [`technical-to-ppt-storyboard.md`](提示词/prompts/技术汇报/technical-communication/technical-to-ppt-storyboard.md)
- [`technical-to-video-storyboard.md`](提示词/prompts/技术汇报/technical-communication/technical-to-video-storyboard.md)

## 3.5 视频生成

目录：[`提示词/prompts/视频生成/`](提示词/prompts/视频生成/)

- [`video-generation/`](提示词/prompts/视频生成/video-generation/)：视频分镜。
- [`storyboard-design.md`](提示词/prompts/视频生成/video-generation/storyboard-design.md)

## 3.6 视觉理解

目录：[`提示词/prompts/视觉理解/`](提示词/prompts/视觉理解/)

- [`vision-multimodal-understanding/`](提示词/prompts/视觉理解/vision-multimodal-understanding/)：视觉与多模态理解。

## 3.7 安全合规

目录：[`提示词/prompts/安全合规/`](提示词/prompts/安全合规/)

- [`safety-compliance-risk/`](提示词/prompts/安全合规/safety-compliance-risk/)：安全、合规、隐私与风险初筛。

## 3.8 地理空间

目录：[`提示词/prompts/地理空间/`](提示词/prompts/地理空间/)

- [`geospatial-intelligence/`](提示词/prompts/地理空间/geospatial-intelligence/)：地理与空间智能。

## 3.9 图像生成

目录：[`提示词/prompts/图像生成/`](提示词/prompts/图像生成/)

- [`image-generation/`](提示词/prompts/图像生成/image-generation/)：生图 Prompt。
- [`general/image-prompt-design.md`](提示词/prompts/图像生成/image-generation/general/image-prompt-design.md)：通用单张图提示词设计。
- `architecture/`：建筑视觉。
- `character-reference/`：人物参考图。
- `character-portrait/`：人物肖像、写真、海报等。
- `style-transfer/`：调色、油画、老照片等风格转换。

---

# 4. Skill 导航

完整索引：[`技能/skills/README.md`](技能/skills/README.md)

## 4.1 产品研发

目录：[`技能/skills/产品研发/`](技能/skills/产品研发/)

### `product-development-skills`

单阶段专项能力：

- `requirement-clarification`
- `requirement-analysis`
- `solution-design`
- `prd-writing`
- `requirement-review`
- `prototype-greenfield`
- `prototype-existing-project`
- `version-retrospective`
- `project-knowledge-capture`

目录：[`product-development-skills/`](技能/skills/产品研发/product-development-skills/)

### `product-development-pipeline`

从模糊需求一路推进到方案、数据、状态、流程、页面规格和交付结果的跨阶段总控 Skill。

目录：[`product-development-pipeline/`](技能/skills/产品研发/product-development-pipeline/)

## 4.2 软件开发

目录：[`技能/skills/软件开发/`](技能/skills/软件开发/)

### `software-development`

- [`codex-task-execution`](技能/skills/软件开发/software-development/codex-task-execution/)：当前 Codex 直接修改真实仓库并验证。
- [`code-review-fix`](技能/skills/软件开发/software-development/code-review-fix/)：代码/PR 审查、修复和验证。
- [`java-project-architecture-analysis`](技能/skills/软件开发/software-development/java-project-architecture-analysis/)：Java / Spring 项目架构、调用链和部署分析。

## 4.3 研究与复现

目录：[`技能/skills/研究与复现/`](技能/skills/研究与复现/)

### `research-analysis`

- [`deep-research-fact-checking`](技能/skills/研究与复现/research-analysis/deep-research-fact-checking/)：多来源调研与事实核验。
- [`paper-reading-reproduction`](技能/skills/研究与复现/research-analysis/paper-reading-reproduction/)：论文、代码与实验对照。
- [`python-vision-project-reproduction`](技能/skills/研究与复现/research-analysis/python-vision-project-reproduction/)：真实 Python / CUDA / GPU 环境项目复现。

## 4.4 图像与视觉

目录：[`技能/skills/图像与视觉/`](技能/skills/图像与视觉/)

- [`layered-shot-narrative`](技能/skills/图像与视觉/layered-shot-narrative/)：连续分层镜头图组与连续性检查。
- [`panorama-generation`](技能/skills/图像与视觉/panorama-generation/)：360° 全景资产、Three.js 查看器与运行验证。
- [`style-reference-research`](技能/skills/图像与视觉/style-reference-research/)：视觉风格资料检索与参数化提炼。

## 4.5 智能体与自动化

目录：[`技能/skills/智能体与自动化/`](技能/skills/智能体与自动化/)

### `agent-automation`

- [`agent-workflow-design`](技能/skills/智能体与自动化/agent-automation/agent-workflow-design/)
- [`prompt-optimization-evaluation`](技能/skills/智能体与自动化/agent-automation/prompt-optimization-evaluation/)

## 4.6 安全与质量

目录：[`技能/skills/安全与质量/`](技能/skills/安全与质量/)

### `safety-quality`

- [`prompt-injection-defense`](技能/skills/安全与质量/safety-quality/prompt-injection-defense/)：Agent 信任边界、最小权限、危险操作 Gate 和红队测试。

## 4.7 历史原始稿

[`技能/skills/需求 设计 实现/`](技能/skills/需求%20设计%20实现/) 是迁移前原始稿目录。

当前维护入口已经迁移到 `产品研发/product-development-skills/`，不要继续在历史目录新增标准 Skill。

---

# 5. Agent 导航

完整索引：[`智能体/agents/README.md`](智能体/agents/README.md)

## 5.1 工作流编排

目录：[`智能体/agents/工作流编排/`](智能体/agents/工作流编排/)

- [`workflow-router/`](智能体/agents/工作流编排/workflow-router/)：仓库总路由器，在 Prompt / Skill / Agent 之间选择最合适入口。

## 5.2 产品研发

目录：[`智能体/agents/产品研发/`](智能体/agents/产品研发/)

- [`product-development-agent/`](智能体/agents/产品研发/product-development-agent/)：组合产品定义 Prompt、产品研发 Skill、Pipeline 和技术汇报 Prompt，并维护阶段状态与 Gate。

---

# 6. 常见选择方式

```text
只需要一次输出文本 / Prompt / JSON / 分镜 / 分析
→ 提示词/prompts/<中文分类>/<英文机器目录>/

需要读取真实仓库、网络、文件、工具结果，或者修改文件、跑测试、做验证
→ 技能/skills/<中文分类>/<英文机器目录>/

任务目标模糊，或者需要组合多个 Prompt / Skill
→ 智能体/agents/<中文分类>/<英文机器目录>/

某个代码仓库长期必须遵守的固定规则
→ 目标仓库自己的 AGENTS.md
```

几个例子：

- “给另一个 Codex 写开发任务书” → [`codex-task-brief.md`](提示词/prompts/软件开发/software-development/codex-task-brief.md)
- “你现在直接把这个 GitHub 项目改好并跑测试” → [`codex-task-execution`](技能/skills/软件开发/software-development/codex-task-execution/)
- “帮我分析需求” → [`requirement-analysis`](技能/skills/产品研发/product-development-skills/requirement-analysis/)
- “从需求一直做到方案、PRD、页面规格和一致性检查” → [`product-development-pipeline`](技能/skills/产品研发/product-development-pipeline/)
- “按参考图写一张生图 Prompt” → [`image-prompt-design.md`](提示词/prompts/图像生成/image-generation/general/image-prompt-design.md)
- “连续生成多张镜头并保持人物、空间和色彩一致” → [`layered-shot-narrative`](技能/skills/图像与视觉/layered-shot-narrative/)
- “生成 360° 全景并实际验证查看器” → [`panorama-generation`](技能/skills/图像与视觉/panorama-generation/)
- “我不知道应该用哪个能力” → [`workflow-router`](智能体/agents/工作流编排/workflow-router/)

---

# 7. 导入 Codex 使用

## 查看可安装 Skill

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -List
```

## 安装指定 Skill

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 `
  -Include product-development-pipeline,codex-task-execution,code-review-fix
```

## 安装全部 Skill

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -All
```

安装脚本递归扫描 `技能\skills\`，所以仓库里的中文分类层不会进入最终 Codex Skill 名称。

全局安装后的结构仍是：

```text
%USERPROFILE%\.codex\skills\<skill-name>\SKILL.md
```

项目级安装仍是：

```text
<project>\.agents\skills\<skill-name>\SKILL.md
```

Prompt 不安装到 Skill 目录；按仓库路径读取或直接复制对应 Prompt 即可。

Agent 也不安装到 `.codex/skills`，需要时显式读取对应 `AGENT.md`。

---

# 8. 维护与审计

Skill 元数据必须满足：

```yaml
---
name: directory-name
description: 清楚说明什么时候触发、负责什么、与相邻 Skill 的边界。
---
```

其中 `name` 指真实 Skill 的**英文叶子目录名**，不包含中文分类层。

运行审计：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\audit-skill-metadata.ps1
```

相关规范：

- [`docs/naming-conventions.md`](docs/naming-conventions.md)
- [`docs/skill-description-guidelines.md`](docs/skill-description-guidelines.md)
- [`docs/迁移映射.md`](docs/迁移映射.md)

新增、移动或删除 Prompt / Skill / Agent 时，同时检查：

1. 根 README 导航。
2. 对应中文分类 README 和机器目录 README。
3. Agent 路由路径。
4. 迁移映射。
5. 安装脚本和元数据审计。
6. 所有跨目录 Markdown 链接。
