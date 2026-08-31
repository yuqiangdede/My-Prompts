# Agents

Agent 是组合/路由层，用于在多个 Prompt 与 Skill 之间选择、编排并维护中间状态。

它与 Codex Skill 不同：本仓库 `智能体/agents/` 下的文件**不应安装到 `.codex/skills` 或 `.agents/skills`**。

## 目录规则

Agent 采用：

```text
智能体/
└── agents/
    └── 中文分类/
        └── english-agent-name/
```

中文分类层用于 GitHub 和文件管理器中的人工浏览；真实 Agent 目录继续使用英文 `kebab-case`。

## 当前分类

### 工作流编排

目录：[`工作流编排/`](工作流编排/)

- [`workflow-router/`](工作流编排/workflow-router/)：仓库总路由器。只有在任务模糊、跨域，或用户明确询问“应该用哪个 Prompt / Skill / Agent”时使用。

它负责选入口，不替代目标能力执行具体工作。

### 产品研发

目录：[`产品研发/`](产品研发/)

- [`product-development-agent/`](产品研发/product-development-agent/)：连接产品定义 Prompt、产品研发专项 Skill、端到端 Pipeline 和技术汇报 Prompt，并维护阶段状态与 Gate。

## 使用方式

显式让 Codex 读取 Agent 文件：

```text
读取 My-Prompts/智能体/agents/工作流编排/workflow-router/AGENT.md，
判断下面任务应该使用哪个入口：……
```

或：

```text
读取 My-Prompts/智能体/agents/产品研发/product-development-agent/AGENT.md，
按这个 Agent 的路由与 Gate 推进下面产品需求：……
```

## 命名规则

- 中文分类名描述稳定业务域或编排职责。
- 真实 Agent 目录统一使用英文 `kebab-case`。
- 中文分类层不进入 Agent 的机器名称。
- 同一 Agent 只保留一份，不通过复制目录实现多分类。
- 移动分类时必须同步根 README、Agent README、路由文件和迁移映射。
