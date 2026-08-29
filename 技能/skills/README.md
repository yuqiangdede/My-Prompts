# Skills

Skill 只保留**真正需要执行闭环**的工作流能力：读取真实环境、跨阶段产物、Gate、工具/脚本、文件修改、测试、构建或验证。

> 仅仅“有 5～7 个步骤”不构成 Skill。若这些步骤能在一次上下文里完成、最终只是输出文本或提示词，优先放 [`提示词/prompts/`](../../提示词/prompts/README.md)。

## Codex Skill 元数据

每个 `SKILL.md` 必须以 YAML frontmatter 开头：

```yaml
---
name: directory-name
description: 清楚写明触发条件、核心职责和与相邻能力的边界。
---
```

`name` 必须与目录名一致并使用英文 `kebab-case`。

## 产品研发

### 能力库：`product-development-skills`

- `requirement-clarification`：信息不足时多轮澄清。
- `requirement-analysis`：分析价值、根因、范围、角色、规则、风险、依赖和验证方式。
- `solution-design`：形成候选产品/业务方案、模块、对象、状态、权限和核心流程。
- `prd-writing`：把已确认方案写成研发/测试可使用的 PRD。
- `requirement-review`：独立评审，输出 S0–S3 与 GO / CONDITIONAL GO / NO-GO。
- `prototype-greenfield`：从零生成可运行、可点击前端原型。
- `prototype-existing-project`：在已有前端项目中新增/修改高保真原型。
- `version-retrospective`：版本复盘、根因与改进行动。
- `project-knowledge-capture`：把多份项目资料沉淀成可追溯知识。

### 总控：`product-development-pipeline`

跨多个产品阶段完整推进时使用。单独写 PRD、评审、做原型等任务直接使用专项 Skill。

## 软件开发

### `codex-task-execution`

当前 Codex 直接执行：

```text
读仓库 → 定位调用链 → 修改文件 → 补测试 → 跑测试/构建 → 修复失败 → 汇报真实结果
```

如果只是想生成一份给另一个 Codex 的任务书，使用 [`提示词/prompts/software-development/codex-task-brief.md`](../../提示词/prompts/software-development/codex-task-brief.md)。

### `code-review-fix`

主动审查代码/PR，发现真实缺陷并在允许时修复、验证。

### `java-project-architecture-analysis`

读取真实 Java/Spring 项目，分析模块、启动、调用链、数据/状态、集成和部署。

## 研究分析

- `deep-research-fact-checking`：外部多来源调研与事实核验。
- `paper-reading-reproduction`：论文、代码、实验配置和复现条件对照。
- `python-vision-project-reproduction`：在真实 Python/CUDA/GPU 环境中安装、运行、评测/训练并验证视觉项目。
- `style-reference-research`：检索作者/作品资料，提炼可验证视觉风格参数。

## Agent 工作流 / 质量 / 安全

- `agent-workflow-design`：设计 Chaining、Routing、Parallel、Orchestrator、Evaluator 等 Agent 工作流。
- `prompt-optimization-evaluation`：建立 Prompt/Skill 测试集、基线、失败归因和回归评测。
- `prompt-injection-defense`：Agent 信任边界、最小权限、操作 Gate 和红队测试。

## 图像与交互工作流

### `layered-shot-narrative`

已有影视剧照/场景参考时，直接生成连续 A/B/C/(D)/(E) 分层镜头图组，并执行人物、空间、色彩和跨帧连续性检查。

普通单张生图提示词已移动到 [`提示词/prompts/image-generation/general/image-prompt-design.md`](../../提示词/prompts/image-generation/general/image-prompt-design.md)。

### `panorama-generation`

360° equirectangular 全景资产 → Three.js 查看器 → 本地运行/映射/交互检查。

它从 Prompt 升级为 Skill，因为存在真实资产、下游文件和验证链路。

## 不再属于 Skill 的内容

以下能力已经移动到 Prompt：

- 单张图片提示词设计。
- 通用视频分镜提示词。
- 结构化长文写作。
- 技术方案 → PPT/视频分镜。

`workflow-router` 已移动到 [`智能体/agents/workflow-router`](../../智能体/agents/workflow-router/README.md)，因为路由器是编排层，不应该作为业务 Skill 候选参与自动触发。

## 新增 Skill 判断标准

新增前至少确认满足一项强条件：

- [ ] 必须读取真实仓库/文件/网络或工具结果。
- [ ] 必须修改真实文件、代码或环境。
- [ ] 上一步产物是下一步的真实输入。
- [ ] 存在 Gate、失败回退或重试。
- [ ] 必须运行测试、构建、启动或其他验证。
- [ ] 需要 scripts/references/assets 支撑。
- [ ] 需要跨阶段状态才能完成。

如果全部都不满足，大概率应该是 Prompt。

## 审计

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\audit-skill-metadata.ps1
```

规范见 [`docs/skill-description-guidelines.md`](../../docs/skill-description-guidelines.md)。
