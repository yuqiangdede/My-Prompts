# 工作流编排

本分类管理**仓库级能力选择、路由和跨能力编排**相关 Agent。

## 定位

用于在任务目标模糊、跨域，或用户明确询问“该用哪个 Prompt / Skill / Agent”时选择最小可行入口。

## 目录

| 目录 | 说明 |
| --- | --- |
| [`workflow-router/`](workflow-router/) | 在 Prompt、Skill、Agent 之间选择最合适入口；只负责路由，不替代目标能力执行具体业务 |

## 边界

任务已经明确命中具体 Prompt 或 Skill 时，应直接调用目标能力，不额外经过路由 Agent。

## 返回上级

[返回 Agents 索引](../README.md)
