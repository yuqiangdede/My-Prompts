# Skill Description 规范

本文规定 My-Prompts 中 `SKILL.md` 的自动发现元数据写法。目标是让 Codex 能根据 `name + description` 更准确地选择 Skill，并减少相邻 Skill 之间的误触发。

## 1. 每个 SKILL.md 必须有 YAML Frontmatter

文件开头统一使用：

```yaml
---
name: skill-directory-name
description: 当……时使用。负责……；不用于……，相邻任务应使用 another-skill。
---
```

要求：

- `name` 必须与 Skill 所在目录名一致。
- `name` 使用英文 `kebab-case`。
- `description` 是 Codex 自动发现的主要触发信息，不应只写泛化能力介绍。
- 正文可以继续保留 `## description` 作为人类阅读说明，但自动路由以 frontmatter 为准。

## 2. Description 必须回答四个问题

### 2.1 什么时候触发

写清用户目标或任务状态，例如：

```text
当已有 PRD，需要进入研发前做独立质量评审时使用。
```

不要只写：

```text
用于需求评审。
```

### 2.2 有什么前置条件

相邻阶段容易冲突时，写清输入成熟度：

```text
当需求背景、目标用户和核心场景已基本澄清……
```

这样可以把 `requirement-clarification` 与 `requirement-analysis` 分开。

### 2.3 本 Skill 负责什么

用一个稳定职责描述核心输出，不要罗列所有可能能力。

### 2.4 明确不负责什么

至少写出最容易混淆的相邻 Skill 或非触发条件，例如：

```text
普通明确功能实现应使用 codex-task-execution，不用于纯架构摸底。
```

负边界不是为了重复正文，而是为了帮助 Codex 做路由决策。

## 3. 推荐句式

```text
当 <任务状态/用户目标> 时使用。
负责 <本 Skill 的唯一核心职责>；
若 <相邻情况> 应使用 <other-skill>，不用于 <明确非目标>。
```

不是所有 Skill 都必须机械套用三句，但应包含等价信息。

## 4. 总控 Skill 与专项 Skill

总控 Skill 必须明确只在跨阶段任务中触发。

例如 `product-development-pipeline`：

- 用户说“从需求到原型完整推进” → 触发流水线。
- 用户只说“帮我写 PRD” → `prd-writing`。
- 用户只说“评审这份 PRD” → `requirement-review`。
- 用户只说“在现有项目做页面原型” → `prototype-existing-project`。

总控 Skill 不应因为 description 覆盖面更广而抢走所有专项任务。

## 5. 相邻 Skill 必须形成互斥边界

当前重点边界：

```text
requirement-clarification
  → 信息是否足够

requirement-analysis
  → 问题、价值、范围、规则是否站得住

solution-design
  → 选择什么业务/产品方案

prd-writing
  → 把已确认方案写成研发规格

requirement-review
  → 独立检查并决定是否可进入研发
```

```text
java-project-architecture-analysis
  → 先理解 Java 系统

codex-task-execution
  → 已有明确改动目标，执行实现

code-review-fix
  → 主动审查已有代码/PR，发现问题再修
```

```text
deep-research-fact-checking
  → 广泛外部研究

paper-reading-reproduction
  → 论文—代码—实验对照

python-vision-project-reproduction
  → 在真实本地环境跑视觉项目
```

```text
image-prompt-design
  → 普通单张/独立图片提示词

layered-shot-narrative
  → 有原始剧照/场景参考，直接生成连续分层镜头图组

video-storyboard-prompts
  → 通用视频分镜

technical-report-generation
  → 已有技术方案转技术汇报视频/PPT
```

## 6. Description 不应该出现的问题

避免：

- “万能”描述：什么都能处理。
- 只列功能，不写触发条件。
- 与目录名不同的 `name`。
- 把正文方法论全部塞进 description。
- 使用大量形容词但没有任务边界。
- 同时声称负责需求、方案、PRD、原型、开发，除非它明确是总控编排器。
- 只写“帮助用户……”而没有可判断的输入状态。

## 7. 长度建议

以清楚表达路由为准，通常 60–180 个中文字符足够。

优先级：

```text
触发准确性 > 边界明确性 > 关键词覆盖 > 文案优美
```

## 8. 新增 Skill 检查表

- [ ] 文件首部存在 YAML frontmatter。
- [ ] `name` 与目录名完全一致。
- [ ] `description` 写清触发条件。
- [ ] `description` 写清核心职责。
- [ ] 已指出最容易混淆的非目标或相邻 Skill。
- [ ] 没有和现有 Skill 大范围抢同一类任务。
- [ ] 总控与专项 Skill 的优先级明确。
- [ ] 正文规则与 frontmatter 没有冲突。
