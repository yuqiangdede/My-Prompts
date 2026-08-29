# Agents

Agent 是组合/路由层，用于在多个 Prompt 与 Skill 之间选择、编排并维护中间状态。

它与 Codex Skill 不同：本仓库 `智能体/agents/` 下的文件**不应安装到 `.codex/skills` 或 `.agents/skills`**。

## 当前 Agent

### [Workflow Router](workflow-router/README.md)

仓库总路由器。只有在任务模糊、跨域，或用户明确询问“应该用哪个 Prompt / Skill / Agent”时使用。

它负责选入口，不替代目标能力执行具体工作。

### [Product Development Agent](product-development-agent/AGENT.md)

产品研发组合 Agent：连接产品定义 Prompt、产品研发专项 Skill、端到端 Pipeline 和技术汇报 Prompt。

## 使用方式

显式让 Codex 读取 Agent 文件：

```text
读取 My-Prompts/智能体/agents/workflow-router/AGENT.md，
判断下面任务应该使用哪个入口：……
```

或：

```text
读取 My-Prompts/智能体/agents/product-development-agent/AGENT.md，
按这个 Agent 的路由与 Gate 推进下面产品需求：……
```

## 命名规则

Agent 目录统一使用英文 `kebab-case`；中文名称保留在 README/AGENT 正文中。
