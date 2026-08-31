# Skill Description 与收录规范

本文规定 My-Prompts 中 `SKILL.md` 的收录条件和自动发现元数据写法。目标不仅是让 Codex 更准确选择 Skill，更重要的是避免把本应属于 Prompt 的一次性模板包装成 Skill。

## 1. 先判断：它真的应该是 Skill 吗？

“有固定步骤”不是充分条件。

只有任务需要至少一种真实执行闭环时，才优先做 Skill：

- 读取真实仓库、文件、网络或工具结果。
- 修改真实代码、文件或环境。
- 上一步产物作为下一步真实输入。
- 跨阶段维护状态。
- Gate、失败回退或重试。
- 执行测试、构建、启动或其他验证。
- 依赖 scripts / references / assets。

如果内部虽然有 5～10 个步骤，但可以在一次模型上下文中完成，最终主要输出仍是文本、Prompt、JSON、表格或分析报告，则优先放 `提示词/prompts/<中文分类>/<英文机器目录>/`。

典型 Prompt：

- 单张图片生图提示词。
- 通用视频分镜。
- 结构化长文。
- 技术方案 → PPT/视频分镜脚本。
- 给另一个 Codex 写任务书。

典型 Skill：

- 当前 Codex 实际修改代码并跑测试。
- 多来源网络调研与事实核验。
- 本地 Python/CUDA 项目复现。
- 需求流水线中有多轮澄清、Gate 与回退。
- 全景资产 → Three.js 查看器 → 运行/映射验证。

## 2. 每个 SKILL.md 必须有 YAML Frontmatter

```yaml
---
name: skill-directory-name
description: 当……时使用。负责……；不用于……，相邻任务应使用 another-skill 或某个 Prompt。
---
```

要求：

- `name` 必须与 Skill 所在**英文叶子目录名**一致。
- `name` 使用英文 `kebab-case`。
- 中文分类目录不进入 `name`。
- `description` 是 Codex 自动发现的主要触发信息。
- description 不应该只是能力广告，而应明确路由边界。

## 3. Description 必须回答四个问题

### 3.1 什么时候触发

写清用户目标或任务状态：

```text
当已有 PRD，需要进入研发前做独立质量评审时使用。
```

不要只写：

```text
用于需求评审。
```

### 3.2 前置条件是什么

相邻阶段容易冲突时，写清输入成熟度：

```text
当需求背景、目标用户和核心场景已基本澄清……
```

### 3.3 本 Skill 唯一核心职责是什么

不要把所有相关能力都塞进一个 description。

### 3.4 明确不负责什么

至少写出最容易混淆的相邻 Skill / Prompt：

```text
如果只是生成一份给其他 Codex 的任务书，使用 提示词/prompts/软件开发/software-development/codex-task-brief.md；本 Skill 负责当前仓库的真实修改和验证。
```

## 4. 推荐句式

```text
当 <任务状态/用户目标> 时使用。
负责 <唯一核心职责>；
若 <相邻情况> 应使用 <other-skill / prompt>，不用于 <明确非目标>。
```

不要求机械套模板，但应包含等价信息。

## 5. 总控 Skill 与专项 Skill

总控 Skill 必须明确只在跨阶段任务中触发。

例如 `product-development-pipeline`：

- “从需求到原型完整推进” → Pipeline。
- “帮我写 PRD” → `prd-writing`。
- “评审这份 PRD” → `requirement-review`。
- “在现有项目做页面原型” → `prototype-existing-project`。

总控 Skill 不应因为覆盖面更广而抢走专项任务。

## 6. 当前重点互斥边界

### 产品研发

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

### 软件开发

```text
提示词/prompts/软件开发/software-development/codex-task-brief.md
  → 只生成给“另一个 Codex”的任务书

java-project-architecture-analysis
  → 先理解 Java 系统

codex-task-execution
  → 当前 Codex 直接修改仓库并验证

code-review-fix
  → 主动审查已有代码/PR，发现问题再修
```

### 研究

```text
deep-research-fact-checking
  → 广泛外部研究

paper-reading-reproduction
  → 论文—代码—实验对照

python-vision-project-reproduction
  → 在真实本地环境跑视觉项目
```

### 图像与视频

```text
提示词/prompts/图像生成/image-generation/general/image-prompt-design.md
  → 普通单张/独立图片提示词

提示词/prompts/视频生成/video-generation/storyboard-design.md
  → 一次性通用视频分镜

layered-shot-narrative
  → 有原始剧照/场景参考，直接生成连续分层镜头图组并检查连续性

panorama-generation
  → 全景资产 + Three.js 查看器 + 运行/映射验证
```

### 写作与汇报

```text
提示词/prompts/内容写作/writing/structured-longform-writing.md
  → 一次性长文

提示词/prompts/技术汇报/technical-communication/
  → 已有技术方案转 PPT/视频分镜脚本
```

这些已经是 Prompt，不应再次包装成自动发现 Skill，除非未来增加真实文件生成、工具调用与验证闭环。

## 7. Router 不属于业务 Skill

`workflow-router` 位于 `智能体/agents/工作流编排/workflow-router/`。

原因：Router 的职责是选择 Prompt / Skill / Agent，它是裁判，不应作为一个候选业务 Skill 与被路由对象一起参与自动触发。

## 8. Description 常见问题

避免：

- “万能”描述，什么任务都能处理。
- 只列功能，不写触发条件。
- `name` 与英文叶子目录名不同。
- 把中文分类层写进 `name`。
- 把完整方法论塞进 description。
- 使用大量形容词但没有边界。
- 同时声称负责需求、方案、PRD、原型、开发，除非明确是总控编排器。
- 一个只输出文本的 Prompt 生成器被包装成 Skill。
- Skill 最终 output 是“再生成一段给同一个 Agent 的 Prompt”。

## 9. 长度建议

通常 60～180 个中文字符足够。

优先级：

```text
触发准确性 > 边界明确性 > 关键词覆盖 > 文案优美
```

## 10. 新增 Skill 检查表

### 先判定是否该做 Skill

- [ ] 是否必须接触真实外部环境或真实文件？
- [ ] 是否存在真实修改/工具调用？
- [ ] 是否需要跨阶段状态或真实中间产物？
- [ ] 是否存在 Gate/回退/重试？
- [ ] 是否必须运行测试/构建/验证？

如果全部为否，优先放 Prompt。

### 如果确定是 Skill

- [ ] 文件首部存在 YAML frontmatter。
- [ ] `name` 与英文叶子目录名完全一致。
- [ ] `description` 写清触发条件。
- [ ] `description` 写清核心职责。
- [ ] 指出最容易混淆的非目标或相邻入口。
- [ ] 没有和现有 Skill 大范围抢同一类任务。
- [ ] 总控与专项 Skill 的优先级明确。
- [ ] 正文规则与 frontmatter 没有冲突。
- [ ] description 中引用的 Prompt / Agent 路径是当前包含中文分类层的真实路径。
