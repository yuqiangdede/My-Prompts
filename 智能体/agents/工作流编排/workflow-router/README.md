# 工作流路由器（`workflow-router`）

仓库级能力路由 Agent，用于在 Prompt、Skill、Agent 之间选择最小可行入口。

## 定位

适合以下情况：

- 用户目标模糊，尚未明确能力类型。
- 任务跨多个能力域。
- 用户明确询问“应该使用哪个 Prompt / Skill / Agent”。

## 边界

- 它负责选入口，不替代目标能力执行具体工作。
- 任务已经明确命中具体 Skill 时，应直接调用目标 Skill。
- 它不是 Codex Skill，不应安装到 `.codex/skills` 或 `.agents/skills`。

## 使用方式

正式路由规则见 [`AGENT.md`](AGENT.md)。

## 返回上级

[返回工作流编排分类](../README.md)
