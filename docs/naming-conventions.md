# Repository Naming Conventions

本规范用于保证 Prompt、Skill、Agent 和文档在 GitHub、Codex、脚本及自动化工具中具有稳定、可预测的路径。

## 1. 目录命名

所有目录统一使用英文 `kebab-case`：

```text
product-development-pipeline
software-development
java-project-architecture-analysis
image-generation
technical-communication
panorama-generation
```

禁止：中文目录、空格、下划线、中文标点、大小写混排，以及仅用于人工排序的 `01-`、`02-` 前缀。

名称应表达稳定职责，不表达临时版本或人员名称。

## 2. Prompt / Skill / Agent 名称

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

不要把只生成一段文本/Prompt 的能力命名成 Skill。

### Agent 目录

Agent 可以使用 `-agent` 后缀，也可以使用明确的路由职责名称：

```text
product-development-agent/
workflow-router/
```

`workflow-router` 位于 `agents/`，不是 `skills/`。

### Pipeline

明确表达编排职责：

```text
product-development-pipeline/
```

## 3. 文件命名

固定入口使用：

```text
README.md
SKILL.md
AGENT.md
```

历史 Prompt、规则和参考资料可以保留中文文件名；新增机器频繁引用的文件优先使用英文 `kebab-case.md`。

## 4. 中文展示名

英文路径不要求正文英文。

例如：

```text
目录：skills/product-development-pipeline/
README 标题：# 产品研发流水线
SKILL name：product-development-pipeline
正文：中文
```

## 5. 跨目录引用

必须使用当前英文路径，不引用历史别名。

例如：

```text
skills/product-development-skills/requirement-analysis/SKILL.md
skills/software-development/codex-task-execution/SKILL.md
skills/panorama-generation/SKILL.md
prompts/technical-communication/technical-to-ppt-storyboard.md
agents/workflow-router/AGENT.md
agents/product-development-agent/AGENT.md
```

修改目录或分类时同步检查：

1. 根 `README.md`。
2. `prompts/README.md` / `skills/README.md` / `agents/README.md`。
3. `agents/workflow-router/AGENT.md`。
4. 其他 Agent 的 Composition / Routing。
5. `docs/迁移映射.md`。
6. `docs/skill-description-guidelines.md`。
7. 其他 Skill/Prompt 的相对链接。

## 6. 历史兼容

历史路径只允许出现在：

- `docs/迁移映射.md` 的历史列。
- 明确标记 Legacy 的参考文档。
- Git 历史。

历史路径不得继续作为当前执行入口。

## 7. 新增目录检查表

- [ ] 是否为英文 `kebab-case`？
- [ ] 是否没有空格、中文、下划线和中文标点？
- [ ] 名称是否描述稳定职责？
- [ ] 是否与现有目录语义重复？
- [ ] 是否先判断应该是 Prompt、Skill 还是 Agent？
- [ ] 如果是 Skill，是否确实存在真实执行/验证闭环？
- [ ] 是否已更新对应索引？
- [ ] 是否需要更新 `agents/workflow-router`？
- [ ] 是否存在跨目录引用需要同步修改？
