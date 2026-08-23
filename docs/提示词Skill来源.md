# 提示词 Skill 来源与改编说明

> 最近核对：2026-08-23

本仓库不以复制“万能 Prompt”为目标，而是把公开方法、常见模式和真实任务经验改编为边界明确的 Prompt / Skill / Agent。

## 使用原则

1. 优先参考官方文档、论文和维护活跃的开源项目。
2. 只吸收方法、结构和工程模式，不直接搬运完整模板。
3. 外部示例需要重新编写，并适配本仓库规范。
4. 涉及开源代码、数据或完整模板时，单独核对许可证。
5. 模型和产品持续变化，使用前重新核对官方资料。
6. 目录使用英文 `kebab-case`，中文保留在标题和正文中。
7. “写了很多步骤”不自动等于 Skill；没有真实执行闭环时优先作为 Prompt。

## 当前结构

```text
prompts/
├── product-definition/
├── software-development/
├── writing/
├── technical-communication/
├── video-generation/
├── vision-multimodal-understanding/
├── safety-compliance-risk/
├── geospatial-intelligence/
└── image-generation/

skills/
├── product-development-skills/
├── product-development-pipeline/
├── software-development/
├── research-analysis/
├── agent-automation/
├── safety-quality/
├── layered-shot-narrative/
├── panorama-generation/
└── style-reference-research/

agents/
├── workflow-router/
└── product-development-agent/
```

## 分类原则

### Prompt

一次输入即可完成，最终主要输出仍是文本、Prompt、JSON、表格或一次性分析。

例如：单张图片提示词、视频分镜、结构化长文、技术方案转 PPT/视频分镜、给另一个 Codex 写任务书、一次性图片分析。

### Skill

需要真实执行闭环，例如：读取仓库/文件/网络、修改代码、跨阶段状态、Gate、失败回退、运行测试/构建/验证、依赖脚本或真实中间产物。

例如：当前 Codex 直接修改代码并验证、多来源调研、本地 Python/CUDA 项目复现、需求流水线、全景资产到 Three.js 查看器并验证。

### Agent

负责选择或组合 Prompt 与 Skill，例如 `workflow-router` 和 `product-development-agent`。Router 是裁判，不应作为业务 Skill 自动候选。

## 后续收集检查表

- [ ] 它应该是 Prompt、Skill 还是 Agent？
- [ ] 如果做 Skill，是否真的需要真实环境、工具、状态、Gate、测试或验证？
- [ ] 是否有明确来源和许可证？
- [ ] 是否与现有内容重复？
- [ ] 是否有清晰输入、边界、输出和失败处理？
- [ ] 是否能通过真实任务验证？
- [ ] 目录名是否符合英文 `kebab-case`？
- [ ] 是否已同步更新对应 README 和 Router？
