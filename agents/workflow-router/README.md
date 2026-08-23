# Workflow Router

仓库级能力路由 Agent。用于在用户目标模糊、跨域或明确询问“该用哪个能力”时，选择最小可行的 Prompt / Skill / Agent 入口。

正式规则见 [`AGENT.md`](AGENT.md)。

它不是 Codex Skill，不应安装到 `.codex/skills` 或 `.agents/skills`。任务已经明确命中具体 Skill 时，应直接调用目标 Skill。
