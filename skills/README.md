# Skills

Skill 是带有固定执行顺序、中间状态、质量检查或工具编排的工作流。

## 阅读顺序

- 每个 Skill 根目录应提供 `README.md`，说明用途、示例输入、执行过程和预期结果。
- `SKILL.md` 是正式执行规范，包含 `description`、`input`、`workflow`、`rules`、`output` 和 `examples`。
- 第一次使用某个 Skill 时，先读 README，再按 `SKILL.md` 执行。

## 统一入口

- **工作流路由器**：[用途与例子](workflow-router/README.md) · [SKILL.md](workflow-router/SKILL.md)
- **提示词 Skill 来源与改编说明**：[文档](../docs/提示词Skill来源.md)

## 产品研发

- **产品研发能力库**：[能力说明](product-development-skills/README.md)
- **产品研发流水线**：[用途与完整流程](product-development-pipeline/README.md) · [SKILL.md](product-development-pipeline/SKILL.md)

能力库包含：`requirement-clarification`、`requirement-analysis`、`solution-design`、`prd-writing`、`requirement-review`、`prototype-greenfield`、`prototype-existing-project`、`version-retrospective`、`project-knowledge-capture`。

## 软件开发

- **Codex 任务执行**：[用途与例子](software-development/codex-task-execution/README.md) · [SKILL.md](software-development/codex-task-execution/SKILL.md)
- **代码审查与修复**：[用途与例子](software-development/code-review-fix/README.md) · [SKILL.md](software-development/code-review-fix/SKILL.md)
- **Java 项目架构分析**：[用途与例子](software-development/java-project-architecture-analysis/README.md) · [SKILL.md](software-development/java-project-architecture-analysis/SKILL.md)

## 研究分析

- **深度调研与事实核验**：[用途与例子](research-analysis/deep-research-fact-checking/README.md) · [SKILL.md](research-analysis/deep-research-fact-checking/SKILL.md)
- **论文阅读与复现**：[用途与例子](research-analysis/paper-reading-reproduction/README.md) · [SKILL.md](research-analysis/paper-reading-reproduction/SKILL.md)
- **Python 视觉算法项目复现**：[用途与例子](research-analysis/python-vision-project-reproduction/README.md) · [SKILL.md](research-analysis/python-vision-project-reproduction/SKILL.md)
- **风格参考研究**：[用途与完整例子](style-reference-research/README.md) · [SKILL.md](style-reference-research/SKILL.md)

## 内容创作

- **结构化长文写作**：[用途与例子](content-creation/structured-longform-writing/README.md) · [SKILL.md](content-creation/structured-longform-writing/SKILL.md)
- **技术报告生成**：[用途与完整例子](technical-report-generation/README.md) · [SKILL.md](technical-report-generation/SKILL.md)

## 图像视频

- **图像提示词设计**：[用途与例子](image-video/image-prompt-design/README.md) · [SKILL.md](image-video/image-prompt-design/SKILL.md)
- **视频分镜提示词**：[用途与例子](image-video/video-storyboard-prompts/README.md) · [SKILL.md](image-video/video-storyboard-prompts/SKILL.md)
- **分层镜头叙事**：[用途与完整例子](layered-shot-narrative/README.md) · [SKILL.md](layered-shot-narrative/SKILL.md)

## Agent 与自动化

- **Agent 工作流设计**：[用途与例子](agent-automation/agent-workflow-design/README.md) · [SKILL.md](agent-automation/agent-workflow-design/SKILL.md)
- **提示词优化与评测**：[用途与例子](agent-automation/prompt-optimization-evaluation/README.md) · [SKILL.md](agent-automation/prompt-optimization-evaluation/SKILL.md)

## 安全与质量

- **提示词注入防护**：[用途与例子](safety-quality/prompt-injection-defense/README.md) · [SKILL.md](safety-quality/prompt-injection-defense/SKILL.md)

## 目录命名规则

1. 目录名统一使用英文 `kebab-case`。
2. 不使用中文、空格、中文标点或中英混排作为目录名。
3. Skill 的中文名称保留在 README、SKILL 标题和索引展示中。
4. 跨 Skill 引用必须使用稳定的英文相对路径。
5. 新增目录后必须同步更新本索引和 `workflow-router`。

## 收录标准

1. 一次性输入输出放入 `prompts/`，不要包装成 Skill。
2. 只有存在多步骤、状态、Gate、工具或质量检查时才放入 `skills/`。
3. 每个正式 Skill 根目录应同时包含 `README.md` 和 `SKILL.md`。
4. README 必须至少说明用途、一个具体输入例子、执行过程和预期结果。
5. 新增内容必须注明来源或改编依据。
6. 不直接复制低质量“万能 Prompt”。
7. 新增后必须同步更新本索引。
