# My-Prompts

个人 AI Workflow Library，用于集中管理 **Prompt、Skill、Agent 与项目级规则**。

本仓库的目标不是堆积尽可能多的提示词，而是让不同类型的 AI 能力有清楚边界、稳定目录和统一导航。

## 1. 仓库定位

| 类型 | 定位 | 典型产物 | 入口 |
| --- | --- | --- | --- |
| **Prompt** | 一次输入 → 一次处理 → 一次输出 | 文本、Prompt、JSON、表格、一次性分析 | [`提示词/prompts/`](提示词/prompts/) |
| **Skill** | 需要真实执行闭环的可复用能力 | 文件修改、工具调用、测试、构建、验证、跨阶段产物 | [`技能/skills/`](技能/skills/) |
| **Agent** | 在多个 Prompt / Skill / Agent 之间路由和编排 | 能力选择、阶段状态、Gate、跨能力协作 | [`智能体/agents/`](智能体/agents/) |
| **AGENTS.md** | 某个代码仓库长期遵守的项目规则 | 项目约束、编码规范、固定流程 | 放在目标代码仓库内 |
| **Plugin** | 多个 Skill、工具、MCP、Hook、命令或 UI 的集成层 | 集成能力包 | 预留 |

## 2. 如何选择

```text
只需要一次性生成文本 / Prompt / JSON / 表格 / 分析
→ Prompt

需要读取真实仓库、文件、网络或工具结果，修改文件，运行测试、构建或验证
→ Skill

任务目标模糊、跨多个能力域，或需要组合多个 Prompt / Skill
→ Agent

某个代码仓库长期必须遵守的固定规则
→ 目标仓库的 AGENTS.md
```

判断边界时，优先参考 [`docs/提示词Skill来源.md`](docs/提示词Skill来源.md)。

## 3. 目录结构

```text
My-Prompts/
├── 提示词/
│   └── prompts/
│       └── <中文分类>/<english-machine-directory>/
├── 技能/
│   └── skills/
│       └── <中文分类>/<english-skill-or-group>/
├── 智能体/
│   └── agents/
│       └── <中文分类>/<english-agent-name>/
├── docs/
└── scripts/
```

统一采用“**中文展示分类 + 英文机器目录**”：

- 中文分类层用于 GitHub、文件管理器和人工浏览。
- 英文目录使用稳定的 `kebab-case`，用于机器识别、链接和安装名称。
- Skill 的 `SKILL.md -> name`、Agent 机器名和 Prompt 英文目录名不包含中文分类前缀。

## 4. 总导航

### Prompt

完整索引：[`提示词/prompts/README.md`](提示词/prompts/README.md)

当前分类：产品与业务、软件开发、内容写作、技术汇报、视频生成、视觉理解、安全合规、地理空间、图像生成。

### Skill

完整索引：[`技能/skills/README.md`](技能/skills/README.md)

当前分类：产品研发、软件开发、研究与复现、图像与视觉、智能体与自动化、安全与质量。

> [`技能/skills/需求 设计 实现/`](技能/skills/需求%20设计%20实现/) 为迁移前历史原始稿，不作为当前标准 Skill 分类继续扩展。

### Agent

完整索引：[`智能体/agents/README.md`](智能体/agents/README.md)

当前分类：产品研发、工作流编排。

## 5. README 统一约定

README 按层级承担不同职责，避免重复维护同一份信息。

### 顶层索引 README

统一使用：

```text
定位
→ 选择规则
→ 目录结构
→ 分类导航
→ 新增/维护规范
```

### 中文分类 README

统一使用：

```text
定位
→ 目录
→ 边界
→ 返回上级
```

### 具体 Prompt / Skill / Agent README

按需要使用：

```text
定位
→ 适用场景
→ 内容/流程
→ 示例
→ 输出
→ 使用方式
→ 边界
```

不要求每个文件机械补齐所有栏目；没有实际内容的栏目不添加。

统一写作规则：

- 一级标题只出现一次。
- 中文负责解释，英文机器名使用反引号标识。
- Prompt、Skill、Agent 三个术语统一保留英文首字母大写写法。
- 目录和文件统一使用 Markdown 相对链接，避免只写不可点击的裸路径。
- README 负责导航和使用说明；详细执行规范放在 `SKILL.md`、`AGENT.md` 或具体 Prompt 文件中。
- 同一信息只保留一个权威入口，其他 README 使用链接引用，减少重复内容漂移。

## 6. 新增与维护

新增或移动内容时至少同步检查：

- [ ] 是否放入正确的 Prompt / Skill / Agent 类型。
- [ ] 是否先选择稳定中文分类，再使用英文 `kebab-case` 机器目录。
- [ ] 是否同步更新对应分类 README 和顶层索引 README。
- [ ] 是否存在跨目录相对链接需要更新。
- [ ] Skill 的 `name` 是否与真实 Skill 英文目录一致。
- [ ] 是否需要更新迁移映射或命名规范。

Skill 元数据可运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\audit-skill-metadata.ps1
```

Skill 安装预览：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -List
```

## 7. 相关文档

- [`docs/提示词Skill来源.md`](docs/提示词Skill来源.md)：Prompt / Skill / Agent 边界说明。
- [`docs/naming-conventions.md`](docs/naming-conventions.md)：目录与命名规范。
- [`docs/skill-description-guidelines.md`](docs/skill-description-guidelines.md)：Skill description 写法。
- [`docs/迁移映射.md`](docs/迁移映射.md)：历史目录迁移映射。

---

仓库维护原则：**先保证分类和边界清楚，再增加数量；先保证 README 可导航，再增加更深层内容。**
