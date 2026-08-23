# My-Prompts

个人 AI Workflow Library，用于集中管理：

- **Prompts**：一次性任务模板。
- **Skills**：可被 Codex 发现、按需加载并重复执行的工作流能力。
- **Agents**：组合多个 Prompt / Skill 的角色与编排入口。

这个仓库的重点不是“收集很多提示词”，而是把日常研发、研究、产品、图像和文档工作整理成**边界明确、能重复使用、方便 Codex 调用**的能力库。

---

# 1. Prompt、Skill、Agent 到底怎么区分

目前把 `prompts/` 和 `skills/` 分开是合适的，而且应该继续保持。

## 1.1 Prompt：一次性任务模板

Prompt 适合：

- 输入一次，处理一次，输出一次。
- 不需要维护跨阶段状态。
- 不需要固定 Gate、回退、测试、工具编排。
- 通常复制内容后替换变量就可以使用。

例如：

```text
给一张图片做隐私风险分析
给一张人物照片生成职业照提示词
把一个模糊产品想法整理成 MVP
根据图片判断可能的地理区域
```

Prompt **不会因为放在 `prompts/` 目录里就自动成为 Codex Skill**。

在 Codex 中通常有三种使用方式：

1. 打开 Prompt 文件，复制内容到当前对话。
2. 让 Codex 读取本地 Prompt 文件后执行。
3. 如果某个 Prompt 后来变成高频、固定、多步骤流程，再升级为 Skill。

---

## 1.2 Skill：可重复执行的工作流

Skill 适合：

- 有固定步骤。
- 有输入、输出和边界。
- 可能需要工具、脚本、参考资料。
- 需要质量检查、Gate、回退或测试。
- 希望 Codex 根据任务自动判断是否调用。

一个标准 Codex Skill 的核心结构是：

```text
skill-name/
├── SKILL.md          # 必须：name、description、执行规则
├── scripts/          # 可选：确定性脚本
├── references/       # 可选：按需读取的资料
├── assets/           # 可选：输出所需模板或资源
└── agents/           # 可选：Skill UI / 依赖元数据
```

Codex 不会一开始把所有 `SKILL.md` 全部塞进上下文，而是先读取 Skill 的 `name + description` 做轻量发现；真正触发后再加载完整 `SKILL.md` 和必要资源。

因此 Skill 的 `description` 非常重要：它决定 Codex **什么时候应该调用、什么时候不应该调用**。

---

## 1.3 Agent：组合多个能力的角色入口

本仓库的 `agents/` 用来表达：

> 一个长期角色应该如何在多个 Prompt 和 Skill 之间路由、维护状态、处理 Gate，并最终交付结果。

例如：

```text
product-development-agent
```

负责把：

```text
产品想法
→ 产品定义 Prompt
→ 产品研发流水线
→ PRD / 原型
→ 技术报告
```

串成一条完整路径。

注意：

- 本仓库的 `agents/` 是**能力编排定义**。
- 它和 Codex 项目根目录里的 `AGENTS.md` 不是一回事。
- `AGENTS.md` 更适合放“这个代码仓库长期必须遵守的开发规范、构建命令、测试要求、代码约束”。

---

## 1.4 哪些内容不应该放进 Prompt / Skill

### 应放到 `AGENTS.md`

例如：

```text
Java 版本必须使用 17
修改接口后必须运行 mvn test
模型文件统一放 models/
禁止修改某个公共组件
数据库脚本必须兼容 PostgreSQL 14
```

这是**项目长期规则**，不是某一个任务流程。

### 应考虑 Plugin

如果未来某项能力同时需要：

- 多个 Skill
- 命令
- MCP
- Hook
- 工具依赖
- Assets
- App / UI

则不应继续把所有东西堆进一个巨型 Skill，可以进一步打包为 Codex Plugin。

---

# 2. 推荐判断规则

| 需求 | 放哪里 | 原因 |
| --- | --- | --- |
| “帮我分析这张图” | Prompt | 一次输入一次输出 |
| “生成某种风格的图片提示词” | Prompt | 单任务模板 |
| “每次接手 Java 项目都按固定步骤分析” | Skill | 可重复流程 |
| “代码修改后必须审查、测试、验证” | Skill | 有固定工作流和质量 Gate |
| “完整推进需求→方案→PRD→原型” | Pipeline Skill | 多阶段、有状态、有 Gate |
| “根据任务决定调用哪个 Skill” | Agent / Router Skill | 负责能力路由 |
| “本项目 Java 17，必须跑 mvn test” | AGENTS.md | 仓库长期规则 |
| “同时集成 MCP、Hook、Skills、命令” | Plugin | 已超出单 Skill 范围 |

一句话判断：

> **一次性内容用 Prompt；重复流程用 Skill；组合能力用 Agent；项目长期规则用 AGENTS.md。**

---

# 3. 仓库目录结构

```text
My-Prompts/
├── prompts/
│   ├── product-definition/
│   ├── vision-multimodal-understanding/
│   ├── safety-compliance-risk/
│   ├── geospatial-intelligence/
│   └── image-generation/
│
├── skills/
│   ├── product-development-skills/
│   ├── product-development-pipeline/
│   ├── software-development/
│   ├── research-analysis/
│   ├── content-creation/
│   ├── image-video/
│   ├── agent-automation/
│   ├── safety-quality/
│   ├── layered-shot-narrative/
│   ├── technical-report-generation/
│   ├── style-reference-research/
│   └── workflow-router/
│
├── agents/
│   └── product-development-agent/
│
├── scripts/
│   └── install-codex-skills.ps1
│
└── docs/
```

---

# 4. Prompts：每个目录是做什么的

## 4.1 `prompts/product-definition`

### `想法产品化.md`

把一个比较模糊的想法整理成产品定义。

适合：

- 只有一句产品想法。
- 还没有完整需求。
- 需要先明确用户、场景、价值、MVP、闭环和验收标准。

示例：

```text
我想做一个根据经纬度、月份和露台条件推荐种植方案的 App。
```

先使用该 Prompt 把想法产品化，再决定是否进入 `product-development-pipeline`。

---

## 4.2 `prompts/vision-multimodal-understanding`

### `图片标签.md`

从图片中提取稳定、可控的标签。

适合：

- 监控图像标签。
- 园区 / 街景元素提取。
- 图像分类前的语义整理。
- 需要固定 JSON / 数组格式输出。

---

## 4.3 `prompts/safety-compliance-risk`

### `图片隐私风险分析.md`

分析图片可能暴露的敏感信息和安全风险。

覆盖：

- 身份信息。
- 地址 / 地理信息。
- 证件、工牌、车牌。
- 屏幕内容。
- 商业信息。
- 物理安全信息。

原则是只根据可见证据判断，不把猜测写成事实。

---

## 4.4 `prompts/geospatial-intelligence`

### `图片地理位置分析.md`

根据图片中的道路、建筑、植被、文字、交通、气候等线索推测可能区域。

输出重点不是“硬猜一个地点”，而是：

```text
证据
→ 候选区域
→ 反证
→ 置信度
→ 下一步核验方式
```

---

# 5. Image Generation Prompts

目录：

```text
prompts/image-generation/
```

这些主要是**图像生成 / 图像变换模板**，不是 Codex 工作流 Skill。

## 5.1 `architecture`

### 建筑技术分析海报

真实建筑摄影基础上叠加克制的结构 / 技术分析表达。

适合：

- 建筑分析图。
- 技术汇报视觉图。
- 建筑摄影 + 信息图表达。

不允许凭空制造工程参数。

---

## 5.2 `character-reference`

### 人物关系图

把角色、阵营和关系整理成人物图谱式视觉海报。

适合小说、影视、游戏人物关系整理。

---

## 5.3 `panorama-generation`

### 360° 全景图生成

生成 2:1 等距柱状全景图，并包含 Three.js 查看方式的相关提示。

适合：

- 场景全景图。
- 虚拟空间预览。
- 360° 环境素材。

---

## 5.4 `style-transfer`

包含：

- 参考图片调色分析。
- LUT 重建方案。
- 油画质感转换。
- 老照片质感转换。

目标是提取可观察的色彩、光线、材料和画面语言，而不是只写“变成某某风格”。

---

## 5.5 `character-portrait`

人物肖像模板集合，包括：

- 职业照。
- 商业时尚肖像。
- 黑白纪实肖像。
- 艺术黑白组图。
- 杂志封面。
- 电影肖像。
- 九宫格表情 / 角度图。
- 双层侧脸海报。
- 雨夜电影人物照。
- 雪景多角度写真。
- 体育转播抓拍。
- 发型探索图卡。

这类内容适合直接复制到图像模型使用，不必全部转成 Skill。

---

# 6. Skills：产品研发能力

## 6.1 `product-development-skills/requirement-clarification`

**需求澄清。**

负责确认：

- 背景。
- 用户。
- 场景。
- 问题。
- 范围。
- 成功标准。

不负责直接设计方案。

适合：

```text
需求说得比较模糊，先帮我问清楚。
```

---

## 6.2 `requirement-analysis`

**需求分析。**

负责：

- 价值判断。
- 根因分析。
- 范围。
- 角色。
- 规则。
- 依赖。
- 风险。

不负责直接决定最终产品方案。

---

## 6.3 `solution-design`

**产品 / 业务方案设计。**

负责把已经确认的问题转成候选方案，并形成：

- 模块。
- 核心对象。
- 主流程。
- 状态。
- 权限框架。
- 方案对比与推荐。

它是“需求分析”和“PRD”之间的桥梁。

---

## 6.4 `prd-writing`

**PRD 编写。**

把已确认方案转成：

- 可开发。
- 可测试。
- 可验收。

的产品规格。

它负责“写”，不负责自己宣布评审通过。

---

## 6.5 `requirement-review`

**独立需求评审。**

负责：

- 找需求漏洞。
- 找边界遗漏。
- 找流程 / 状态 / 权限问题。
- 按严重程度分级。
- 给出 GO / NO-GO。

和 `prd-writing` 分离，是为了避免“自己写、自己审、自己宣布通过”。

---

## 6.6 `prototype-greenfield`

**从零构建可运行原型。**

适合：

- 没有现成前端项目。
- 希望快速生成 HTML / React / Vue Demo。
- 需要可点击、可运行，而不是只出图片。

---

## 6.7 `prototype-existing-project`

**在现有前端项目里增加原型。**

它会优先复用：

- 当前技术栈。
- 路由。
- 组件。
- Design Token。
- 相似页面。

避免把一个全新的 Greenfield 方案硬塞进旧项目。

---

## 6.8 `version-retrospective`

**版本 / 阶段复盘。**

负责把一次版本执行过程整理成：

```text
目标
→ 实际结果
→ 偏差
→ 根因
→ 可执行改进动作
```

---

## 6.9 `project-knowledge-capture`

**项目知识沉淀。**

适合把长期稳定的信息整理成可检索知识，例如：

- 业务规则。
- 关键决策。
- 接口约定。
- 已知坑。
- 版本变化。
- 架构结论。

不是简单把聊天记录和文档原样堆进去。

---

# 7. `product-development-pipeline`：产品研发总控流水线

这是复杂 B 端 / 行业系统的 Orchestrator。

适合：

```text
我只有一个比较模糊的需求，希望一路做到方案、PRD、页面规格甚至原型。
```

执行链：

```text
01 需求澄清
02 需求分析
03 风险 Gate ①
04 方案设计
05 模块边界 Gate ②-A
06 数据 / 状态 Gate ②-B
07 异常流程补全
08 PRD → 独立评审 → 页面规格
09 页面 / 流程 / 权限 Gate ③
10 输出路由
   ├─ 文档
   ├─ UI Prompt
   ├─ Greenfield 原型
   └─ Existing Project 原型
```

简单任务不要启动整条流水线。

例如只是“帮我审一下 PRD”，直接调用 `requirement-review` 更合适。

---

# 8. 软件开发 Skills

## 8.1 `codex-task-execution`

用于把一个模糊的开发任务转成 Codex 可执行任务，并完成：

```text
理解任务
→ 定位代码
→ 明确验收
→ 修改
→ 测试
→ 汇报证据
```

适合真实代码仓库修改。

---

## 8.2 `code-review-fix`

代码审查与修复。

重点关注：

- Bug。
- 逻辑漏洞。
- 回归风险。
- 异常处理。
- 并发 / 事务。
- 兼容性。
- 测试覆盖。

适合“先找问题，再修复，再验证”。

---

## 8.3 `java-project-architecture-analysis`

用于快速接手和理解 Java / Spring Boot 项目。

重点分析：

- 模块结构。
- Maven / Gradle 依赖。
- Controller → Service → DAO 调用链。
- 消息队列。
- 数据库。
- 状态机。
- 事务边界。
- 异步流程。
- 外部接口。
- 改造风险。

适合维护大型历史 Java 项目。

---

# 9. 研究分析 Skills

## 9.1 `deep-research-fact-checking`

深度网络调研与事实核验。

用于：

- 技术选型。
- 产品比较。
- 事实确认。
- 多来源交叉验证。
- 输出来源与不确定性。

---

## 9.2 `paper-reading-reproduction`

论文阅读与复现。

负责：

- 理解论文贡献。
- 提取模型 / 数据 / 训练配置。
- 找官方代码和权重。
- 识别复现条件。
- 设计本地复现实验。

---

## 9.3 `python-vision-project-reproduction`

Python 视觉算法项目复现。

适合：

- GitHub 视觉项目。
- YOLO / DETR / VLM / OCR / 深度估计等项目。
- 本地 CUDA 环境部署。
- 官方 Demo。
- 自有图片 / MP4 测试。
- 显存和性能评估。

---

## 9.4 `style-reference-research`

视觉风格参考研究。

负责从作者 / 作品 / 参考图中提取：

- 构图。
- 色彩。
- 光线。
- 材质。
- 笔触。
- 镜头。
- 时代特征。

最终转成可复用的视觉参数、LUT 建议或图像生成约束。

---

# 10. 内容和报告 Skills

## 10.1 `structured-longform-writing`

结构化长文写作。

适合：

- 技术方案。
- 汇报材料。
- 分析文章。
- 规范文档。
- 长篇说明。

重点是结构、逻辑和信息密度，而不是堆文字。

---

## 10.2 `technical-report-generation`

技术报告生成。

把技术方案转换成：

- 视频分镜。
- PPT 分镜。
- 旁白。
- timing JSON。
- 页面目标。
- 图形表达建议。

用于把“技术文档”转成“可讲解、可汇报”的材料。

---

# 11. 图像和视频 Skills

## 11.1 `image-prompt-design`

用于系统设计图像生成 Prompt。

适合：

- 主体锁定。
- 构图控制。
- 光线。
- 色彩。
- 镜头。
- 材质。
- 风格一致性。

和 `prompts/image-generation/` 的区别：

- `prompts/image-generation/` 是具体可直接使用的模板。
- `image-prompt-design` 是“如何根据新需求设计一个高质量 Prompt”的方法型 Skill。

---

## 11.2 `video-storyboard-prompts`

视频分镜 Prompt 设计。

适合把故事、技术说明或短片需求拆成：

- 镜头。
- 景别。
- 动作。
- 镜头运动。
- 连续性。
- 时长。
- 画面提示词。

---

## 11.3 `layered-shot-narrative`

分层镜头叙事。

用于以一张原始影视剧照 / 场景图为母版，继续扩展：

```text
A 空间基底
B 氛围建立
C 主体呈现
D 叙事关系
E 状态变化
```

同时保持：

- 人物身份连续。
- 相机连续。
- 空间连续。
- 色彩连续。

适合系列镜头和连续画面生成。

---

# 12. Agent / 自动化 / 安全 Skills

## 12.1 `agent-workflow-design`

设计 Agent 工作流。

用于判断什么时候应该使用：

- Chaining。
- Routing。
- Parallelization。
- Orchestrator / Worker。
- Evaluator / Optimizer。
- Tool-use Agent。

适合设计复杂 AI 工作流，而不是普通单轮 Prompt。

---

## 12.2 `prompt-optimization-evaluation`

Prompt 优化和评测。

重点不是“润色一句提示词”，而是：

- 建测试集。
- 明确 grader。
- 比较版本。
- 回归测试。
- 识别失败样本。
- 持续优化。

---

## 12.3 `prompt-injection-defense`

提示词注入防护。

用于：

- Agent 安全边界。
- 外部网页 / 邮件 / 文件中的不可信指令。
- 工具权限。
- 数据泄露风险。
- 间接 Prompt Injection。
- 红队测试。

---

# 13. `workflow-router`：不知道用哪个能力时，从这里开始

这是整个仓库的能力路由入口。

当用户只说：

```text
帮我做一下这个需求
帮我分析这个项目
我要整理一个方案
这个任务应该用什么 Skill
```

但还不确定具体该调用哪个 Prompt / Skill 时，先使用 `workflow-router`。

它负责判断：

```text
Prompt？
Skill？
Agent？
↓
哪个分类？
↓
调用哪个具体能力？
↓
是否需要组合多个 Skill？
```

---

# 14. Agent

## `agents/product-development-agent`

这是产品研发负责人角色。

主要路由：

```text
模糊产品想法
    ↓
prompts/product-definition/想法产品化.md
    ↓
skills/product-development-pipeline
    ↓
需求 / 方案 / PRD / 页面规格 / 原型
    ↓
skills/technical-report-generation
```

当前 `agents/` 主要作为本仓库的编排定义和长期设计资产保存，**不会因为 clone 仓库就自动注册成 Codex Skill**。

---

# 15. 如何导入 Codex

Codex Skill 推荐有两种安装范围。

## 15.1 全局 Skill

适合你个人经常使用、跨项目通用的 Skill。

Windows 默认目录：

```text
%USERPROFILE%\.codex\skills\<skill-name>\SKILL.md
```

Linux / macOS：

```text
~/.codex/skills/<skill-name>/SKILL.md
```

例如：

```text
~/.codex/skills/codex-task-execution/SKILL.md
~/.codex/skills/java-project-architecture-analysis/SKILL.md
```

---

## 15.2 项目级 Skill

如果某个 Skill 只应该在一个项目中生效，放到项目：

```text
<project>/.agents/skills/<skill-name>/SKILL.md
```

例如：

```text
D:\code\MyProject\.agents\skills\java-project-architecture-analysis\SKILL.md
```

项目 Skill 更适合团队共享：可以直接提交到业务仓库 Git 中。

---

# 16. 推荐安装方式 A：Codex `$skill-installer`

Codex 自带 Skill Installer，可以直接从 GitHub Skill 目录安装。

例如安装产品研发流水线：

```text
$skill-installer install https://github.com/yuqiangdede/My-Prompts/tree/main/skills/product-development-pipeline
```

安装 Java 项目架构分析：

```text
$skill-installer install https://github.com/yuqiangdede/My-Prompts/tree/main/skills/software-development/java-project-architecture-analysis
```

安装 Codex 任务执行：

```text
$skill-installer install https://github.com/yuqiangdede/My-Prompts/tree/main/skills/software-development/codex-task-execution
```

安装后如果 Codex 没有立即显示新 Skill，重启一次 Codex。

> 建议安装**具体 Skill 目录**，不要直接把 `skills/software-development/` 这种分类目录当成一个 Skill 安装，因为分类目录本身没有 `SKILL.md`。

---

# 17. 推荐安装方式 B：Windows PowerShell 脚本

仓库提供：

**文件名：`scripts/install-codex-skills.ps1`**

先克隆：

```powershell
# 文件名：PowerShell 命令行

git clone https://github.com/yuqiangdede/My-Prompts.git
cd My-Prompts
```

查看所有可安装 Skill：

```powershell
# 文件名：PowerShell 命令行

powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -List
```

安装常用 Skill 到全局 Codex：

```powershell
# 文件名：PowerShell 命令行

powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 `
  -Include product-development-pipeline,codex-task-execution,code-review-fix,java-project-architecture-analysis
```

安装指定 Skill 到某个项目：

```powershell
# 文件名：PowerShell 命令行

powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 `
  -Scope Project `
  -ProjectPath D:\code\YourProject `
  -Include codex-task-execution,code-review-fix
```

全部安装：

```powershell
# 文件名：PowerShell 命令行

powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -All
```

覆盖已经安装的同名 Skill：

```powershell
# 文件名：PowerShell 命令行

powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 `
  -Include codex-task-execution `
  -Force
```

### 不建议默认 `-All`

Skill 越多并不代表效果越好。

Codex 启动任务时需要先读取所有 Skill 的基础 metadata 来决定使用哪个能力。长期建议：

- 全局只安装你经常使用的通用 Skill。
- 项目专用 Skill 放 `.agents/skills/`。
- 低频能力需要时再安装。

---

# 18. 我的推荐安装组合

## 18.1 日常代码开发

```text
codex-task-execution
code-review-fix
java-project-architecture-analysis
```

适合 Java / Python 项目维护。

---

## 18.2 产品和系统设计

```text
workflow-router
product-development-pipeline
requirement-clarification
requirement-analysis
solution-design
prd-writing
requirement-review
prototype-greenfield
prototype-existing-project
```

---

## 18.3 AI / 视觉算法研究

```text
deep-research-fact-checking
paper-reading-reproduction
python-vision-project-reproduction
```

---

## 18.4 图像和视频

```text
image-prompt-design
video-storyboard-prompts
layered-shot-narrative
style-reference-research
```

---

# 19. Prompt 在 Codex 里怎么使用

Prompt 不需要安装。

## 方式 1：直接复制

例如打开：

```text
prompts/product-definition/想法产品化.md
```

复制到 Codex，然后补充自己的需求。

## 方式 2：让 Codex 读取本地文件

如果你已经 clone 了本仓库，可以在 Codex 中直接说：

```text
读取 D:\code\My-Prompts\prompts\product-definition\想法产品化.md，
按照其中的规则处理下面这个想法：
……
```

## 方式 3：高频 Prompt 升级成 Skill

判断标准：

如果一个 Prompt 开始出现：

- 多步骤。
- 多轮状态。
- 工具调用。
- 固定输入 / 输出契约。
- Gate。
- 回退。
- 自动测试。

就应该考虑从 `prompts/` 提升到 `skills/`，而不是继续把 Prompt 写得越来越长。

---

# 20. Skill 在 Codex 里怎么调用

安装后可以有两种方式。

## 20.1 显式指定

例如：

```text
使用 codex-task-execution Skill，给这个项目增加录像归档失败重试功能。
```

或者：

```text
使用 java-project-architecture-analysis，先分析当前 Spring Boot 项目，暂时不要改代码。
```

这种方式最稳定，适合你已经知道应该调用哪个 Skill 的场景。

## 20.2 自动触发

直接描述任务：

```text
分析这个 Java 项目的事件处理架构，重点看状态机、事务和 MQ。
```

Codex 会根据已安装 Skill 的 `name` 和 `description` 判断是否应该调用。

因此新增 Skill 时不要只写：

```yaml
description: Java 项目分析
```

应该写清：

```text
什么时候使用
解决什么问题
典型输入是什么
什么时候不要使用
```

---

# 21. 推荐实际使用流程

我的建议不是把这个仓库全部塞进 Codex，而是把它当成**能力源仓库**。

```text
My-Prompts
    │
    ├─ prompts/
    │    └─ 需要时读取 / 复制
    │
    ├─ skills/
    │    └─ 按需安装到 Codex
    │         ├─ ~/.codex/skills
    │         └─ project/.agents/skills
    │
    └─ agents/
         └─ 负责组合与设计更高级工作流
```

推荐原则：

> **My-Prompts 是源仓库，Codex 的 skills 目录是运行环境。不要把两者混成一个目录。**

这样以后 Skill 可以继续在 GitHub 中维护和版本控制，而本机 / 项目只安装真正需要的能力。

---

# 22. 目录命名规范

- 所有**目录名**统一使用英文 `kebab-case`。
- 目录名不使用中文、空格、中文标点或中英混排。
- `README.md`、`SKILL.md`、`AGENT.md` 的标题和正文可以使用中文。
- 历史资料中的中文文件名可以保留。
- 新增可执行入口优先使用稳定英文名称。
- 修改目录后同步更新 README、Router、Agent、迁移映射和跨 Skill 链接。

完整规则：

[`docs/naming-conventions.md`](docs/naming-conventions.md)

---

# 23. 维护入口

- [Prompt 索引](prompts/README.md)
- [Skill 索引](skills/README.md)
- [Agent 索引](agents/README.md)
- [工作流路由器](skills/workflow-router/SKILL.md)
- [产品研发能力库](skills/product-development-skills/README.md)
- [产品研发流水线](skills/product-development-pipeline/SKILL.md)
- [目录命名规范](docs/naming-conventions.md)
- [提示词 Skill 来源](docs/提示词Skill来源.md)
- [迁移映射](docs/迁移映射.md)

---

# 24. Codex 官方机制参考

本仓库的 Codex 安装方式按当前 Codex Skill 机制设计：

- Skill 是包含 `SKILL.md` 的目录。
- `SKILL.md` 至少需要明确 `name` 和 `description`。
- 全局 Skill 默认位于 `$CODEX_HOME/skills`，通常是 `~/.codex/skills`。
- 项目级 Skill 使用 `.agents/skills/`。
- 可以使用 Codex 自带 `$skill-installer` 从 GitHub Skill 目录安装。
- 新 Skill 通常可被自动检测；未出现时可以重启 Codex。

参考：

- https://github.com/openai/codex
- https://github.com/openai/plugins
- https://developers.openai.com/
