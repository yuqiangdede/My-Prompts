# 产品研发

本分类管理面向**产品需求、方案、PRD、原型等多阶段工作**的组合 Agent。

## 定位

用于根据任务成熟度组合产品定义 Prompt、产品研发专项 Skill、完整 Pipeline 和技术汇报 Prompt，并维护阶段状态与 Gate。

## 目录

| 目录 | 说明 |
| --- | --- |
| [`product-development-agent/`](product-development-agent/) | 产品研发组合 Agent，按任务成熟度选择和编排对应能力 |

## 边界

- 单阶段任务应优先直接使用对应 Prompt 或 Skill。
- 只有需要跨阶段持续推进、维护状态或 Gate 时才使用本分类 Agent。
- 英文 Agent 目录名保持稳定；本层中文目录仅用于人工浏览和归类。

## 返回上级

[返回 Agents 索引](../README.md)
