# 提示词 Skill 来源与改编说明

> 最近核对：2026-07-25

本仓库不以复制“万能 Prompt”为目标，而是把公开方法、常见模式和真实任务经验改编为可执行的 Skill。新增内容需要具备流程、状态、规则、验收和示例。

## 使用原则

1. 优先参考官方文档、论文和维护活跃的开源项目。
2. 只吸收方法、结构和工程模式，不复制受版权保护的完整提示词正文。
3. 外部仓库的示例需要重新编写，并适配本仓库的 Skill 规范。
4. 涉及开源代码、数据或完整模板时，单独核对许可证。
5. 流行度只能说明关注度，不能代替质量、安全和适用性评估。
6. 模型和产品持续变化，使用前应重新核对官方文档。

## 官方与标准来源

| 来源 | 主要内容 | 本仓库吸收方向 |
| --- | --- | --- |
| [OpenAI：Prompt engineering best practices](https://help.openai.com/en/articles/10032626-prompt-gineering-best-practices-for-chatgpt) | 清晰具体、补充上下文、迭代优化 | 通用 Prompt 结构、任务边界和迭代流程 |
| [OpenAI：API Prompt Engineering Best Practices](https://help.openai.com/en/articles/6654000-best-practices-for-prompt-engineering-with-gpt-4) | 指令顺序、分隔符、输出格式和示例 | 结构化 Prompt、Few-shot 和输出约束 |
| [OpenAI：Prompt management in Playground](https://help.openai.com/en/articles/9824968-generate-prompts-function-definitions-and-structured-output-schemas-in-the-playground) | Prompt 版本、变量、评测和发布 | `提示词优化与评测` Skill |
| [OpenAI：Designing AI agents to resist prompt injection](https://openai.com/index/designing-agents-to-resist-prompt-injection/) | Agent 注入风险和系统级约束 | `提示词注入防护` Skill |
| [Anthropic：Building effective agents](https://www.anthropic.com/engineering/building-effective-agents) | Chaining、Routing、Parallelization、Orchestrator-Workers、Evaluator-Optimizer 和 Agent | `Agent工作流设计` Skill |
| [Anthropic：Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) | 按需上下文、检索、工具和长任务上下文控制 | Agent 上下文和记忆设计 |
| [Anthropic：Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents) | 任务集、grader、环境和多轮 Agent 评测 | `提示词优化与评测` Skill |
| [Google Gemini：Prompt design strategies](https://ai.google.dev/gemini-api/docs/prompting-strategies) | 清晰指令、结构、参数、长上下文和多模态提示 | 通用结构和图像视频提示词 |
| [OWASP：LLM Prompt Injection Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/LLM_Prompt_Injection_Prevention_Cheat_Sheet.html) | 直接/间接注入、数据泄露、最小权限、输入输出检查和红队测试 | `提示词注入防护` Skill |
| [NIST：Strengthening AI Agent Hijacking Evaluations](https://www.nist.gov/news-events/news/2025/01/technical-blog-strengthening-ai-agent-hijacking-evaluations) | 间接提示词注入和 Agent 劫持评测 | 安全测试集和风险评价 |

## 开源社区来源

| 项目 | 主要内容 | 使用方式 |
| --- | --- | --- |
| [dair-ai/Prompt-Engineering-Guide](https://github.com/dair-ai/Prompt-Engineering-Guide) | Prompt 技术、论文、应用与工具的综合指南 | 用于建立术语和模式索引，不直接复制模板 |
| [promptslab/Awesome-Prompt-Engineering](https://github.com/promptslab/Awesome-Prompt-Engineering) | Prompt、Context Engineering、Agent、评测与安全资源目录 | 用于发现来源和补充分类 |
| [ai-boost/awesome-prompts](https://github.com/ai-boost/awesome-prompts) | Prompt 模板与 Prompt 工程化工具 | 用于区分“复制模板”和“可测试 Prompt 工程” |
| [Meirtz/Awesome-Context-Engineering](https://github.com/Meirtz/Awesome-Context-Engineering) | 上下文工程、记忆、检索和 Agent 资料 | 用于 Agent 上下文分类 |
| [trigaten/Learn_Prompting](https://github.com/trigaten/Learn_Prompting) | Prompt 基础、安全和应用教程 | 用于发现教学案例，不照搬原文 |

## 论文与模式来源

| 资料 | 主要内容 | 本仓库吸收方向 |
| --- | --- | --- |
| [A Prompt Pattern Catalog to Enhance Prompt Engineering with ChatGPT](https://arxiv.org/abs/2302.11382) | 用模式语言记录可复用 Prompt 方案 | Skill 的问题、适用场景、结构和组合方式 |
| [Understanding Prompt Management in GitHub Repositories](https://arxiv.org/abs/2509.12421) | 开源 Prompt 仓库的重复、格式和维护问题 | 分类、来源、索引、版本和质量规则 |
| [Design Patterns for Securing LLM Agents against Prompt Injections](https://arxiv.org/abs/2506.08837) | Agent 注入防护设计模式 | 权限隔离、可信边界和系统级防护 |

## 当前分类

```text
skills/
├── 01-软件开发/
├── 02-研究分析/
├── 03-内容创作/
├── 04-图像视频/
├── 05-Agent与自动化/
├── 06-安全与质量/
├── 软件设计流水线/
├── 分层镜头叙事/
├── 技术报告生成/
├── 风格参考研究/
└── 提示词工程技能库/
```

## 后续收集检查表

新增外部 Prompt 或 Skill 前检查：

- [ ] 是一次性 Prompt、固定 Skill 还是组合 Agent？
- [ ] 是否有明确来源和许可证？
- [ ] 是否存在重复内容？
- [ ] 是否包含输入、工作流、规则、输出和示例？
- [ ] 是否能通过真实任务验证？
- [ ] 是否涉及工具权限、敏感数据或提示词注入风险？
- [ ] 是否已加入对应 README 索引？
