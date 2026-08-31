# Repository Naming Conventions

本规范用于保证 Prompt、Skill、Agent 和文档在 GitHub、Codex、脚本及自动化工具中具有稳定、可预测的路径，同时兼顾人工浏览体验。

## 1. 顶层分层

仓库根目录保留中文展示层：

```text
提示词/
技能/
智能体/
docs/
scripts/
```

其中：

- `提示词/`、`技能/`、`智能体/` 是面向人工浏览的中文展示层。
- `prompts/`、`skills/`、`agents/` 是稳定命名空间。
- `docs/`、`scripts/` 继续保留在仓库根目录。

## 2. Skill 中文分类层

`技能/skills/` 下允许增加一层**中文分类目录**，用于方便查看和归类：

```text
技能/
└── skills/
    ├── 产品研发/
    │   ├── product-development-pipeline/
    │   └── product-development-skills/
    ├── 软件开发/
    │   └── software-development/
    ├── 研究与复现/
    │   └── research-analysis/
    ├── 图像与视觉/
    │   ├── layered-shot-narrative/
    │   ├── panorama-generation/
    │   └── style-reference-research/
    ├── 智能体与自动化/
    │   └── agent-automation/
    └── 安全与质量/
        └── safety-quality/
```

规则：

- 中文分类层只用于人工导航，不参与 Skill 的机器标识。
- 中文分类名应描述稳定业务域，不使用临时项目名、人员名或版本号。
- 同一英文 Skill 只能存在于一个中文分类中，禁止复制多份。
- 分类层可以调整，但真实 Skill 英文目录名应尽量保持稳定。

## 3. 机器目录命名

真实 Prompt、Skill、Agent 能力目录继续使用英文 `kebab-case`：

```text
product-development-pipeline
software-development
java-project-architecture-analysis
image-generation
technical-communication
panorama-generation
```

禁止在这些机器目录中使用：中文、空格、下划线、中文标点、大小写混排，以及仅用于人工排序的 `01-`、`02-` 前缀。

名称应表达稳定职责，不表达临时版本或人员名称。

## 4. Prompt / Skill / Agent 名称

### Prompt 分类目录

使用领域或输出类型：

```text
product-definition/
software-development/
writing/
technical-communication/
video-generation/
geospatial-intelligence/
image-generation/
```

### Skill 目录

使用真实执行能力或工作流名称：

```text
requirement-analysis/
code-review-fix/
python-vision-project-reproduction/
panorama-generation/
```

不要把只生成一段文本或 Prompt 的能力命名成 Skill。

### Agent 目录

Agent 可以使用 `-agent` 后缀，也可以使用明确的路由职责名称：

```text
product-development-agent/
workflow-router/
```

`workflow-router` 位于 `智能体/agents/`，不是 `技能/skills/`。

### Pipeline

明确表达编排职责：

```text
product-development-pipeline/
```

## 5. 固定文件名

固定入口使用：

```text
README.md
SKILL.md
AGENT.md
```

历史 Prompt、规则和参考资料可以保留中文文件名；新增机器频繁引用的文件优先使用英文 `kebab-case.md`。

## 6. Skill 元数据与目录关系

中文分类层不能写入 `SKILL.md` 的 `name`。

例如：

```text
仓库路径：技能/skills/图像与视觉/panorama-generation/
SKILL name：panorama-generation
Codex 安装目录：.codex/skills/panorama-generation/
```

又如：

```text
仓库路径：技能/skills/软件开发/software-development/codex-task-execution/
SKILL name：codex-task-execution
Codex 安装目录：.codex/skills/codex-task-execution/
```

安装、自动发现和路由依赖真实 Skill 英文目录名，而不是中文分类层。

## 7. 跨目录引用

必须使用当前真实路径，不引用已经迁移的旧位置。

例如：

```text
技能/skills/产品研发/product-development-skills/requirement-analysis/SKILL.md
技能/skills/软件开发/software-development/codex-task-execution/SKILL.md
技能/skills/图像与视觉/panorama-generation/SKILL.md
提示词/prompts/technical-communication/technical-to-ppt-storyboard.md
智能体/agents/workflow-router/AGENT.md
智能体/agents/product-development-agent/AGENT.md
```

修改目录或分类时同步检查：

1. 根 `README.md`。
2. `提示词/prompts/README.md`、`技能/skills/README.md`、`智能体/agents/README.md`。
3. `智能体/agents/workflow-router/AGENT.md`。
4. 其他 Agent 的 Composition / Routing。
5. `docs/迁移映射.md`。
6. `docs/skill-description-guidelines.md`。
7. 其他 Skill/Prompt 的相对链接。

## 8. 历史兼容

历史路径只允许出现在：

- `docs/迁移映射.md` 的历史列。
- 明确标记 Legacy 的参考文档。
- Git 历史。

旧的根级路径 `prompts/`、`skills/`、`agents/` 不得继续作为当前执行入口。

旧的 Skill 直达路径，例如：

```text
技能/skills/panorama-generation/
技能/skills/software-development/
```

在迁移完成后也不应继续作为当前文档链接；应改为包含中文分类层的新路径。

## 9. 新增 Skill 分类检查表

- [ ] 先确定应该属于哪个中文业务分类。
- [ ] 中文分类是否足够稳定，能容纳后续同类能力？
- [ ] Skill 英文目录是否为 `kebab-case`？
- [ ] Skill `name` 是否与真实英文目录名一致？
- [ ] 是否没有把中文分类名写进 Skill `name`？
- [ ] 是否与现有能力语义重复？
- [ ] 是否确实存在真实执行/验证闭环？
- [ ] 是否已更新对应索引？
- [ ] 是否存在跨目录引用需要同步修改？
