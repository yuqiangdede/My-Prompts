# Skills

Skill 是带有固定执行顺序、中间状态、质量检查或工具编排的工作流。

## 阅读顺序

- 每个 Skill 根目录都提供 `README.md`，用于说明**具体能干什么、示例输入、执行过程和预期结果**。
- `SKILL.md` 是正式执行规范，包含 `description`、`input`、`workflow`、`rules`、`output` 和 `examples`。
- 第一次使用某个 Skill 时，先读 README，再按 `SKILL.md` 执行。

## 入口

- [提示词工程技能库：用途与路由例子](提示词工程技能库/README.md)
- [提示词工程技能库：正式 Skill](提示词工程技能库/SKILL.md)
- [提示词 Skill 来源与改编说明](../docs/提示词Skill来源.md)

## 01 软件开发

- **Codex 任务执行**：[用途与例子](01-软件开发/Codex任务执行/README.md) · [SKILL.md](01-软件开发/Codex任务执行/SKILL.md)
- **代码审查与修复**：[用途与例子](01-软件开发/代码审查与修复/README.md) · [SKILL.md](01-软件开发/代码审查与修复/SKILL.md)
- **Java 项目架构分析**：[用途与例子](01-软件开发/Java项目架构分析/README.md) · [SKILL.md](01-软件开发/Java项目架构分析/SKILL.md)

## 02 研究分析

- **深度调研与事实核验**：[用途与例子](02-研究分析/深度调研与事实核验/README.md) · [SKILL.md](02-研究分析/深度调研与事实核验/SKILL.md)
- **论文阅读与复现**：[用途与例子](02-研究分析/论文阅读与复现/README.md) · [SKILL.md](02-研究分析/论文阅读与复现/SKILL.md)
- **Python 视觉算法项目复现**：[用途与例子](02-研究分析/Python视觉算法项目复现/README.md) · [SKILL.md](02-研究分析/Python视觉算法项目复现/SKILL.md)

## 03 内容创作

- **结构化长文写作**：[用途与例子](03-内容创作/结构化长文写作/README.md) · [SKILL.md](03-内容创作/结构化长文写作/SKILL.md)

## 04 图像视频

- **图像提示词设计**：[用途与例子](04-图像视频/图像提示词设计/README.md) · [SKILL.md](04-图像视频/图像提示词设计/SKILL.md)
- **视频分镜提示词**：[用途与例子](04-图像视频/视频分镜提示词/README.md) · [SKILL.md](04-图像视频/视频分镜提示词/SKILL.md)

## 05 Agent 与自动化

- **Agent 工作流设计**：[用途与例子](05-Agent与自动化/Agent工作流设计/README.md) · [SKILL.md](05-Agent与自动化/Agent工作流设计/SKILL.md)
- **提示词优化与评测**：[用途与例子](05-Agent与自动化/提示词优化与评测/README.md) · [SKILL.md](05-Agent与自动化/提示词优化与评测/SKILL.md)

## 06 安全与质量

- **提示词注入防护**：[用途与例子](06-安全与质量/提示词注入防护/README.md) · [SKILL.md](06-安全与质量/提示词注入防护/SKILL.md)

## 已有完整工作流

- **软件设计流水线**：[用途与完整例子](软件设计流水线/README.md) · [SKILL.md](软件设计流水线/SKILL.md)
- **分层镜头叙事**：[用途与完整例子](分层镜头叙事/README.md) · [SKILL.md](分层镜头叙事/SKILL.md)
- **技术报告生成**：[用途与完整例子](技术报告生成/README.md) · [SKILL.md](技术报告生成/SKILL.md)
- **风格参考研究**：[用途与完整例子](风格参考研究/README.md) · [SKILL.md](风格参考研究/SKILL.md)

## 收录标准

1. 一次性输入输出放入 `prompts/`，不要包装成 Skill。
2. 只有存在多步骤、状态、Gate、工具或质量检查时才放入 `skills/`。
3. 每个 Skill 根目录必须同时包含 `README.md` 和 `SKILL.md`。
4. README 必须至少说明用途、一个具体输入例子、执行过程和预期结果。
5. 新增内容必须注明来源或改编依据。
6. 不直接复制低质量“万能 Prompt”。
7. 新增后必须同步更新本索引。
