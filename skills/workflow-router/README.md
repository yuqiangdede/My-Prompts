# AI 工作流路由器使用说明

## 这个 Skill 能做什么

作为整个仓库的统一入口，先判断用户需要的是一次性 Prompt、固定多步骤 Skill，还是需要工具和状态管理的 Agent，再推荐最小可行的具体目录和组合顺序。

适合用户只有一个目标，但不确定应该调用哪条 Prompt、Skill 或 Agent 的情况。

## 具体例子 1：从需求做到原型

### 输入

```text
设计一个统一运维平台，从需求澄清开始，一直做到可以演示的原型。
```

### 路由结果

```text
类型：Skill
使用：skills/product-development-pipeline/
```

因为任务跨越需求、方案、状态、PRD、评审和原型多个阶段，需要 Gate 控制。

## 具体例子 2：修改现有 Java 项目

### 输入

```text
帮我分析一个 Spring Boot 事件系统，并让 Codex 增加事件驳回功能。
```

### 路由结果

```text
类型：Skill 组合
先使用：java-project-architecture-analysis
再使用：codex-task-execution
需要时追加：code-review-fix
```

## 具体例子 3：给一张监控图打标签

### 输入

```text
给这张园区入口图片输出 5 个标签，只返回 JSON 数组。
```

### 路由结果

```text
类型：Prompt
使用：prompts/vision-multimodal-understanding/图片标签.md
```

该任务是一次输入和一次输出，不需要多轮状态或工具编排。

## 具体例子 4：每周收集项目

### 输入

```text
每周收集能在 RTX 3060 上复现的热门视觉项目，去重、评分并发送报告。
```

### 路由结果

```text
类型：Agent
组合：deep-research-fact-checking + python-vision-project-reproduction + agent-workflow-design
```

## 最终能得到什么

- Prompt、Skill 或 Agent 类型判断。
- 推荐的具体文件和组合顺序。
- 适用的 Chaining、Routing、Parallelization 或 Evaluator-Optimizer 模式。
- 工具权限、风险和验收建议。

## 使用方式

当无法确定入口时，从 [SKILL.md](SKILL.md) 开始描述目标、资料、工具环境和输出要求。路由结果应优先选择最简单可行方案，不应为了“高级”而过度使用 Agent。
