# 智能体（Agents）

Agent 是组合与路由层，用于在多个 Prompt、Skill 与 Agent 之间选择、编排并维护中间状态。

> 本仓库 [`智能体/agents/`](./) 下的 Agent **不应安装到 `.codex/skills` 或 `.agents/skills`**。

## 定位

适合以下情况：

- 用户目标模糊，尚未明确应该使用哪个能力。
- 任务跨多个能力域，需要组合多个 Prompt / Skill。
- 需要维护阶段状态、Gate 或跨能力编排关系。

任务已经明确命中单个 Prompt 或 Skill 时，应直接进入目标能力，不额外套一层 Agent。

## 目录结构

```text
智能体/
└── agents/
    └── 中文分类/
        └── english-agent-name/
```

中文分类层用于人工浏览；真实 Agent 目录继续使用英文 `kebab-case`。

## 分类导航

| 分类 | 目录 | 说明 |
| --- | --- | --- |
| 工作流编排 | [`工作流编排/`](工作流编排/) | 仓库级能力选择、路由和跨能力编排 |
| 产品研发 | [`产品研发/`](产品研发/) | 连接产品定义 Prompt、产品研发 Skill、Pipeline 和技术汇报 Prompt |

## 使用方式

显式让 Codex 读取 Agent 文件，例如：

```text
读取 My-Prompts/智能体/agents/工作流编排/workflow-router/AGENT.md，
判断下面任务应该使用哪个入口：……
```

或：

```text
读取 My-Prompts/智能体/agents/产品研发/product-development-agent/AGENT.md，
按这个 Agent 的路由与 Gate 推进下面产品需求：……
```

## 命名与维护

- 中文分类名描述稳定业务域或编排职责。
- 真实 Agent 目录统一使用英文 `kebab-case`。
- 中文分类层不进入 Agent 机器名称。
- 同一 Agent 只保留一份，不通过复制目录实现多分类。
- 移动分类时必须同步根 README、Agent README、路由文件和迁移映射。

## 返回上级

[返回仓库首页](../../README.md)
