# 技能（Skills）

本目录存放需要**真实执行闭环**的可复用能力：读取真实环境、跨阶段产物、Gate、工具/脚本、文件修改、测试、构建或验证。

> 仅仅“步骤很多”不构成 Skill。若任务能在一次上下文中完成，最终主要输出仍是一段文本、Prompt、JSON、表格或一次性分析，应优先放到 [`提示词/prompts/`](../../提示词/prompts/README.md)。

## 定位

Skill 适合以下任务特征：

- 读取真实仓库、文件、网络或工具结果。
- 修改真实代码、配置、文件或环境。
- 上一步产物作为下一步真实输入。
- 跨阶段维护状态。
- 存在 Gate、失败回退或重试。
- 运行测试、构建、启动或其他验证。
- 依赖 `scripts/`、`references/`、`assets/` 等支撑资源。

## 目录结构

```text
技能/
└── skills/
    └── 中文分类/
        └── english-skill-or-group/
```

中文分类层只负责人工浏览；真实 Skill 目录和 `SKILL.md -> name` 继续使用英文 `kebab-case`。

## 分类导航

| 分类 | 目录 | 说明 |
| --- | --- | --- |
| 产品研发 | [`产品研发/`](产品研发/) | 需求、方案、PRD、评审、原型、复盘和端到端研发流水线 |
| 软件开发 | [`软件开发/`](软件开发/) | 真实代码仓库分析、修改、审查、测试和验证 |
| 研究与复现 | [`研究与复现/`](研究与复现/) | 多来源调研、论文复现、真实 Python/CUDA/GPU 环境复现 |
| 图像与视觉 | [`图像与视觉/`](图像与视觉/) | 连续视觉叙事、全景资产、视觉风格研究 |
| 智能体与自动化 | [`智能体与自动化/`](智能体与自动化/) | Agent 工作流设计、Prompt/Skill 评测和自动化编排 |
| 安全与质量 | [`安全与质量/`](安全与质量/) | Agent 安全边界、权限、注入防护和质量验证 |
| 历史原始稿 | [`需求 设计 实现/`](需求%20设计%20实现/) | 迁移前保留内容，不作为当前标准分类继续扩展 |

## Skill 元数据

每个 `SKILL.md` 必须以 YAML frontmatter 开头：

```yaml
---
name: directory-name
description: 清楚写明触发条件、核心职责和与相邻能力的边界。
---
```

`name` 必须与真实 Skill 英文目录名一致，并使用英文 `kebab-case`。

## 新增判断

新增前至少确认满足一项强条件：

- [ ] 必须读取真实仓库、文件、网络或工具结果。
- [ ] 必须修改真实文件、代码或环境。
- [ ] 上一步产物是下一步的真实输入。
- [ ] 存在 Gate、失败回退或重试。
- [ ] 必须运行测试、构建、启动或其他验证。
- [ ] 需要 `scripts/`、`references/`、`assets/` 支撑。
- [ ] 需要跨阶段状态才能完成。

如果全部都不满足，大概率应该是 Prompt。

## 审计与安装

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\audit-skill-metadata.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -List
```

安装脚本递归扫描 `技能\skills\`；中文分类层不会进入 Codex 最终 Skill 名称。

## 返回上级

[返回仓库首页](../../README.md)
