# My-Prompts

个人 AI Workflow Library，用于集中管理 **Prompt、Skill、Agent 与项目规则**。

这个仓库的目标不是收集尽可能多的提示词，而是让不同类型的 AI 工作有清楚边界，并且让 README 本身就能作为仓库导航使用。

- **Prompts**：一次性文本、图像、分析和脚本生成模板。
- **Skills**：需要真实执行、跨阶段产物、Gate、工具、测试或验证的可复用能力。
- **Agents**：负责在多个 Prompt / Skill 之间路由和编排。
- **AGENTS.md**：具体代码仓库长期需要遵守的规则，不放在本库的业务 Skill 里。
- **Plugins（预留）**：多个 Skill、工具、MCP、Hook、命令或 UI 的集成打包层；当前仓库尚未提供 `plugins/` 目录。

---

# 1. Prompt / Skill / Agent / Plugin 怎么区分

## Prompt

适合“输入一次 → 处理一次 → 输出一次”的任务。

即使内部写了很多思考步骤，只要这些步骤可以在一次上下文中完成、最终主要产物仍是一段文本、分析结果、提示词或 JSON，就优先作为 Prompt。

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

- [`workflow-router`](智能体/agents/workflow-router/)：仓库总路由器。
- [`product-development-agent`](智能体/agents/product-development-agent/)：产品研发组合 Agent。

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

# 2. 项目目录与能力导航

下面按当前 `main` 分支的真实目录组织。**目录名、能力说明和链接保持对应**；新增、迁移或删除 Prompt / Skill 时，应同步更新本节。

## 2.1 [`提示词/prompts/`](提示词/prompts/)：一次性 Prompt

### [`product-definition/`](提示词/prompts/product-definition/)：产品定义

- [`想法产品化.md`](提示词/prompts/product-definition/想法产品化.md)：把模糊产品想法整理成用户、场景、问题、MVP、业务闭环、验收标准、指标、风险和路线图草案。

### [`software-development/`](提示词/prompts/software-development/)：软件开发任务书

- [`codex-task-brief.md`](提示词/prompts/software-development/codex-task-brief.md)：把自然语言开发需求整理成一份可直接复制给**另一个 Codex / 编码 Agent** 的完整任务书。

> 如果当前 Codex 就要直接读取仓库、修改代码并运行测试，应使用 [`codex-task-execution`](技能/skills/software-development/codex-task-execution/)，而不是这个 Prompt。

### [`writing/`](提示词/prompts/writing/)：结构化写作

- [`structured-longform-writing.md`](提示词/prompts/writing/structured-longform-writing.md)：主题/素材 → 提纲 → 完整长文 → 批评检查 → 修订，适合一次上下文内完成的结构化长文写作。

### [`technical-communication/`](提示词/prompts/technical-communication/)：技术汇报脚本

- [`technical-to-ppt-storyboard.md`](提示词/prompts/technical-communication/technical-to-ppt-storyboard.md)：把技术方案整理成 PPT 页级结构、每页重点和讲述顺序。
- [`technical-to-video-storyboard.md`](提示词/prompts/technical-communication/technical-to-video-storyboard.md)：把技术方案整理成视频分镜、旁白、镜头说明和 timing JSON。
- [`examples/`](提示词/prompts/technical-communication/examples/)：AIS / ClickHouse 示例，用于参考最终 PPT 分镜和视频分镜应该如何组织。

> 这一目录输出的是**制作脚本/分镜**，不是最终 PPTX 或视频文件。

### [`video-generation/`](提示词/prompts/video-generation/)：视频分镜

- [`storyboard-design.md`](提示词/prompts/video-generation/storyboard-design.md)：把故事、产品演示或业务流程拆成通用视频分镜，并为每个镜头生成可继续用于视频/图片生成的提示词。

### [`vision-multimodal-understanding/`](提示词/prompts/vision-multimodal-understanding/)：视觉与多模态理解

- [`图片标签.md`](提示词/prompts/vision-multimodal-understanding/图片标签.md)：分析图片中可见对象、场景和属性，生成结构化图片标签。

### [`safety-compliance-risk/`](提示词/prompts/safety-compliance-risk/)：安全、合规与风险

- [`图片隐私风险分析.md`](提示词/prompts/safety-compliance-risk/图片隐私风险分析.md)：在图片发布、共享或使用前，对可见个人信息、敏感内容和隐私风险进行初筛。

### [`geospatial-intelligence/`](提示词/prompts/geospatial-intelligence/)：地理与空间智能

- [`图片地理位置分析.md`](提示词/prompts/geospatial-intelligence/图片地理位置分析.md)：只根据图片可见证据推断候选地区，同时给出证据、反证、不确定性和置信度。

> 如果以后升级成“图片 → OCR → Web / 地图检索 → 候选核验 → 排除”的真实工具链，应再升级为 Skill。

### [`image-generation/`](提示词/prompts/image-generation/)：生图 Prompt

#### [`general/`](提示词/prompts/image-generation/general/)：通用单图

- [`image-prompt-design.md`](提示词/prompts/image-generation/general/image-prompt-design.md)：把单张图片需求整理成主体、构图、镜头、光线、材质、风格和负面约束明确的结构化生图 Prompt。

#### [`architecture/`](提示词/prompts/image-generation/architecture/)：建筑视觉

- [`01 建筑分析`](提示词/prompts/image-generation/architecture/01%20建筑分析)：分析建筑参考图中的结构、比例、材质、视角、光照和环境，为建筑类视觉生成/复刻提供约束。

#### [`character-reference/`](提示词/prompts/image-generation/character-reference/)：人物参考图

- [`01 人物图谱`](提示词/prompts/image-generation/character-reference/01%20人物图谱)：整理人物外貌、服装、关系和一致性信息，用于建立后续生图时可复用的人物参考。

#### [`character-portrait/`](提示词/prompts/image-generation/character-portrait/)：人物肖像

- [`01 职业照转换`](提示词/prompts/image-generation/character-portrait/01%20职业照转换)：把普通人物照片转换成正式职业照风格。
- [`02 时尚照片`](提示词/prompts/image-generation/character-portrait/02%20时尚照片)：生成时尚摄影、商业人像风格照片。
- [`03 美术馆肖像`](提示词/prompts/image-generation/character-portrait/03%20美术馆肖像)：生成偏艺术展览/美术馆质感的人物肖像。
- [`04 艺术黑白照片`](提示词/prompts/image-generation/character-portrait/04%20艺术黑白照片)：生成强调光影、层次和质感的黑白艺术人像。
- [`05 杂志封面`](提示词/prompts/image-generation/character-portrait/05%20杂志封面)：生成杂志封面式人物构图和视觉风格。
- [`06 电影肖像`](提示词/prompts/image-generation/character-portrait/06%20电影肖像)：生成电影感人物肖像，强调镜头、布光和氛围。
- [`07 海马体九宫格`](提示词/prompts/image-generation/character-portrait/07%20海马体九宫格)：生成同一人物多造型/多构图的九宫格写真。
- [`07.1 海马体 女生`](提示词/prompts/image-generation/character-portrait/07.1%20海马体%20女生)：面向女性人物的海马体式写真模板。
- [`08 同一张脸的柔和模糊的侧面特写`](提示词/prompts/image-generation/character-portrait/08%20同一张脸的柔和模糊的侧面特写)：保持同一人物身份特征，生成柔和、浅景深的侧面特写。
- [`09 人物的电影级逼真图像`](提示词/prompts/image-generation/character-portrait/09%20人物的电影级逼真图像)：生成电影级、写实、细节丰富的人物图像。
- [`10 多角度特写的写真海报图`](提示词/prompts/image-generation/character-portrait/10%20多角度特写的写真海报图)：把同一人物的多个角度和特写组织成写真海报。
- [`11 体育看台`](提示词/prompts/image-generation/character-portrait/11%20体育看台)：生成人物位于体育场/看台场景中的氛围照片。
- [`12 发型`](提示词/prompts/image-generation/character-portrait/12%20发型)：在尽量保持人物身份特征的前提下探索不同发型效果。

#### [`style-transfer/`](提示词/prompts/image-generation/style-transfer/)：风格转换

- [`01 参考图片调色.md`](提示词/prompts/image-generation/style-transfer/01%20参考图片调色.md)：根据参考图提取并复刻整体色调、明暗和色彩关系。
- [`02 参考图片调色.md`](提示词/prompts/image-generation/style-transfer/02%20参考图片调色.md)：另一套参考图调色模板，用于不同调色表达和约束方式。
- [`03 复刻油画.md`](提示词/prompts/image-generation/style-transfer/03%20复刻油画.md)：把参考内容转换/复刻为油画质感和绘画语言。
- [`04 复刻老照片.md`](提示词/prompts/image-generation/style-transfer/04%20复刻老照片.md)：生成老照片、年代感、颗粒、褪色等历史影像效果。

> 360° 全景已经升级成真实执行 Skill，见 [`panorama-generation`](技能/skills/panorama-generation/)。

完整 Prompt 索引也可以查看 [`提示词/prompts/README.md`](提示词/prompts/README.md)。

---

## 2.2 [`技能/skills/`](技能/skills/)：真实执行 Skill

### [`product-development-skills/`](技能/skills/product-development-skills/)：产品研发专项能力

这一组是**单阶段专项 Skill**，适合只做需求澄清、分析、方案、PRD、评审、原型或复盘中的某一件事。

- [`requirement-clarification/`](技能/skills/product-development-skills/requirement-clarification/)：信息不足、目标模糊或存在关键歧义时，多轮提出必要问题并收敛需求。
- [`requirement-analysis/`](技能/skills/product-development-skills/requirement-analysis/)：分析业务价值、问题根因、范围、角色、规则、风险、依赖和验证方式。
- [`solution-design/`](技能/skills/product-development-skills/solution-design/)：把已确认需求转成候选方案、模块边界、核心对象、状态、权限和主流程设计。
- [`prd-writing/`](技能/skills/product-development-skills/prd-writing/)：把已经确认的需求和方案整理成研发、测试可以直接使用的 PRD。
- [`requirement-review/`](技能/skills/product-development-skills/requirement-review/)：独立审查需求/方案完整性，给出 S0–S3 问题等级以及 GO / CONDITIONAL GO / NO-GO 结论。
- [`prototype-greenfield/`](技能/skills/product-development-skills/prototype-greenfield/)：从零生成可运行、可点击的前端高保真原型，并完成基本验证。
- [`prototype-existing-project/`](技能/skills/product-development-skills/prototype-existing-project/)：读取已有前端项目，在现有技术栈和页面结构中新增或修改高保真原型。
- [`version-retrospective/`](技能/skills/product-development-skills/version-retrospective/)：对版本结果、问题、根因、决策和后续行动项进行复盘。
- [`project-knowledge-capture/`](技能/skills/product-development-skills/project-knowledge-capture/)：读取多份项目资料，整理成可检索、可追溯、可持续维护的项目知识。

### [`product-development-pipeline/`](技能/skills/product-development-pipeline/)：产品研发完整流水线

端到端推进：

```text
需求澄清
→ 问题拆解
→ 风险扫描
→ 方案对比
→ 模块边界
→ 数据模型/状态
→ 异常枚举
→ PRD/页面规格
→ 页面-流程-权限一致性检查
→ 输出路由
```

适合“从模糊需求一直推进到可交付方案”的跨阶段任务；只做单阶段任务时优先使用上面的专项 Skill。

目录中的 [`steps/`](技能/skills/product-development-pipeline/steps/) 是流水线步骤定义，[`references/`](技能/skills/product-development-pipeline/references/) 保存需求分析、交互渲染、功能实现、数据大屏、性能优化等参考资料。

### [`software-development/`](技能/skills/software-development/)：软件开发

- [`codex-task-execution/`](技能/skills/software-development/codex-task-execution/)：当前 Codex 直接读取真实仓库 → 找调用链 → 修改文件 → 补测试 → 跑测试/构建 → 修复失败 → 汇报真实结果。
- [`code-review-fix/`](技能/skills/software-development/code-review-fix/)：主动审查代码或 PR，以证据识别 P0–P3 问题，并在允许时直接修改、测试和验证。
- [`java-project-architecture-analysis/`](技能/skills/software-development/java-project-architecture-analysis/)：读取真实 Java / Spring 项目，建立模块、启动入口、调用链、数据/状态、外部集成和部署视图。

### [`research-analysis/`](技能/skills/research-analysis/)：研究与复现

- [`deep-research-fact-checking/`](技能/skills/research-analysis/deep-research-fact-checking/)：通过外部多来源检索、交叉验证和证据分级完成深度调研与事实核验。
- [`paper-reading-reproduction/`](技能/skills/research-analysis/paper-reading-reproduction/)：把论文、代码仓库、实验配置、数据集和硬件条件对应起来，形成可执行复现方案。
- [`python-vision-project-reproduction/`](技能/skills/research-analysis/python-vision-project-reproduction/)：在真实 Python / CUDA / GPU 环境中安装视觉项目，跑推理、评测或训练，并处理依赖、显存、模型和验证问题。

### [`style-reference-research/`](技能/skills/style-reference-research/)：视觉风格研究

- [`SKILL.md`](技能/skills/style-reference-research/SKILL.md)：检索作者、作品和可靠资料，提炼可验证的视觉风格特征和生成参数，而不是仅凭印象模仿。
- [`prompts/作者风格复刻.md`](技能/skills/style-reference-research/prompts/作者风格复刻.md)：Skill 内部使用的风格复刻提示模板。

### [`agent-automation/`](技能/skills/agent-automation/)：Agent 与自动化

- [`agent-workflow-design/`](技能/skills/agent-automation/agent-workflow-design/)：根据任务设计 Chaining、Routing、Parallel、Orchestrator、Evaluator 等 Agent 工作流，并明确状态、边界和失败处理。
- [`prompt-optimization-evaluation/`](技能/skills/agent-automation/prompt-optimization-evaluation/)：为 Prompt / Skill 建测试集、基线、失败归因、回归评测和优化闭环。

### [`safety-quality/`](技能/skills/safety-quality/)：安全与质量

- [`prompt-injection-defense/`](技能/skills/safety-quality/prompt-injection-defense/)：设计 Agent 的信任边界、最小权限、危险操作 Gate、Prompt Injection 防护和红队测试。

### [`layered-shot-narrative/`](技能/skills/layered-shot-narrative/)：连续分层镜头图组

基于原剧照或场景参考，直接生成连续 A/B/C/(D)/(E) 镜头图组，同时检查人物、空间、相机、色彩和跨帧连续性。

- [`prompts/`](技能/skills/layered-shot-narrative/prompts/)：A 空间基底帧、B 氛围建立帧、C 主体呈现帧、D 叙事关系帧、E 状态变化帧以及独立色彩控制卡。
- [`rules/`](技能/skills/layered-shot-narrative/rules/)：人物锁定、相机锁定和连续性检查规则。

### [`panorama-generation/`](技能/skills/panorama-generation/)：360° 全景生成与验证

360° equirectangular 全景资产 → Three.js 查看器 → 本地运行 → 映射和交互验证。因为会产生真实资产、下游文件并需要运行验证，所以属于 Skill 而不是普通 Prompt。

### [`需求 设计 实现/`](技能/skills/需求%20设计%20实现/)：历史原始目录

这是迁移前保留的中文原始稿目录，包含旧版“需求分析、需求澄清、需求评审、PRD、原型、版本复盘、项目知识沉淀”等文件。

**当前维护入口已经迁移到 [`product-development-skills/`](技能/skills/product-development-skills/)，不要继续在这个历史目录新增能力。** 迁移关系见 [`docs/迁移映射.md`](docs/迁移映射.md)。

完整 Skill 索引也可以查看 [`技能/skills/README.md`](技能/skills/README.md)。

---

## 2.3 [`智能体/agents/`](智能体/agents/)：路由与编排

### [`workflow-router/`](智能体/agents/workflow-router/)

仓库总路由器。任务模糊、跨域，或者用户明确问“应该用哪个 Prompt / Skill / Agent”时，用它判断下一步应该调用谁。

它是裁判，不是业务 Skill，因此使用 [`AGENT.md`](智能体/agents/workflow-router/AGENT.md)，不会安装到 `.codex/skills`。

### [`product-development-agent/`](智能体/agents/product-development-agent/)

产品研发组合 Agent。负责组合产品定义 Prompt、产品研发专项 Skill、完整流水线和汇报 Prompt，并维护产品阶段状态与 Gate。

详细说明见 [`智能体/agents/README.md`](智能体/agents/README.md)。

---

## 2.4 [`scripts/`](scripts/)：维护脚本

- [`install-codex-skills.ps1`](scripts/install-codex-skills.ps1)：列出并按需安装本仓库的标准 Codex Skill。
- [`audit-skill-metadata.ps1`](scripts/audit-skill-metadata.ps1)：检查 `SKILL.md` frontmatter、目录名和元数据是否符合仓库规范。

---

## 2.5 [`docs/`](docs/)：仓库规则与迁移说明

- [`naming-conventions.md`](docs/naming-conventions.md)：目录、Prompt、Skill、Agent 的命名规范。
- [`skill-description-guidelines.md`](docs/skill-description-guidelines.md)：Skill `description` 的写法、触发边界和审计要求。
- [`提示词Skill来源.md`](docs/提示词Skill来源.md)：Prompt / Skill 来源和分类背景说明。
- [`迁移映射.md`](docs/迁移映射.md)：历史路径到当前维护入口的映射，判断某个旧目录现在应该去哪里维护时先看这里。

---

# 3. 最常见的选择方式

可以直接按下面的判断使用：

```text
只需要一次输出文本 / Prompt / JSON / 分镜 / 分析
→ 提示词/prompts/

需要读取真实仓库、网络、文件、工具结果，或者要修改文件、跑测试、做验证
→ 技能/skills/

任务目标比较模糊，或者需要组合多个 Prompt / Skill
→ 智能体/agents/

某个代码仓库长期必须遵守的固定规则
→ 目标仓库自己的 AGENTS.md
```

几个容易混淆的例子：

- “给另一个 Codex 写开发任务书” → [`codex-task-brief.md`](提示词/prompts/software-development/codex-task-brief.md)。
- “你现在直接把这个 GitHub 项目改好并跑测试” → [`codex-task-execution`](技能/skills/software-development/codex-task-execution/)。
- “帮我分析需求” → [`requirement-analysis`](技能/skills/product-development-skills/requirement-analysis/)。
- “从需求一直做到方案、PRD、页面规格和一致性检查” → [`product-development-pipeline`](技能/skills/product-development-pipeline/)。
- “按参考图写一张生图 Prompt” → [`image-prompt-design.md`](提示词/prompts/image-generation/general/image-prompt-design.md)。
- “根据原剧照连续生成 A/B/C/D/E 多张镜头并保持人物一致” → [`layered-shot-narrative`](技能/skills/layered-shot-narrative/)。
- “我不知道应该用哪个能力” → [`workflow-router`](智能体/agents/workflow-router/)。

---

# 4. 导入 Codex 使用

## 4.1 推荐：按需安装 Skill

不要默认把所有 Skill 全装。安装与当前工作真正有关的能力即可，减少自动路由噪声。

查看可安装 Skill：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -List
```

安装指定 Skill：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 `
  -Include product-development-pipeline,codex-task-execution,code-review-fix
```

安装全部 Skill（不推荐长期这么做）：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -All
```

## 4.2 全局安装

本仓库脚本默认将 Skill 安装到用户级 Codex Skill 目录：

```text
%USERPROFILE%\.codex\skills\<skill-name>\SKILL.md
```

适合多个项目都需要的能力，例如：

- `codex-task-execution`
- `code-review-fix`
- `deep-research-fact-checking`

## 4.3 项目级安装

需要只对一个代码仓库生效时，把对应 Skill 放到项目：

```text
<project>\.agents\skills\<skill-name>\SKILL.md
```

适合项目专属流程或不希望污染全局候选的 Skill。

## 4.4 Prompt 怎么用

Prompt **不安装到 Skill 目录**。

使用方式：

1. 打开对应 `.md`，复制内容并替换变量。
2. 或让 Codex 直接读取本仓库的 Prompt 文件并执行。

例如：

```text
读取 My-Prompts/提示词/prompts/software-development/codex-task-brief.md，
根据下面需求生成任务书：……
```

## 4.5 Agent 怎么用

`智能体/agents/` 是本仓库自己的组合定义，不应复制到 `.codex/skills`。

可以显式让 Codex 读取：

```text
读取 My-Prompts/智能体/agents/workflow-router/AGENT.md，
判断下面任务应该使用哪个 Prompt / Skill / Agent：……
```

---

# 5. 维护与审计

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
- [`docs/迁移映射.md`](docs/迁移映射.md)

新增、移动或删除 Prompt / Skill / Agent 时，同时检查：

1. 根 [`README.md`](README.md) 的“项目目录与能力导航”是否需要更新。
2. 对应分类的 `README.md` 是否仍与真实目录一致。
3. 历史目录是否已经在 [`docs/迁移映射.md`](docs/迁移映射.md) 中说明。
4. Skill 是否仍然具有真实执行闭环；如果只是一次性输出文本，应迁移到 Prompt。

新增内容前最后问一次：

> 这件事真的需要真实执行闭环吗？

如果答案只是“我要模型按一个模板输出一段内容”，优先新增 Prompt，而不是 Skill。
