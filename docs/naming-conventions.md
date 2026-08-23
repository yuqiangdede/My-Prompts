# Repository Naming Conventions

本规范用于保证 Prompt、Skill、Agent 和文档在 GitHub、Codex、脚本及自动化工具中具有稳定、可预测的路径。

## 1. 目录命名

所有目录统一使用英文 `kebab-case`：

```text
product-development-pipeline
software-development
java-project-architecture-analysis
image-generation
```

禁止：

```text
软件设计流水线
需求 设计 实现
01-软件开发
Agent工作流设计
安全、合规与风险评估
```

规则：

- 只使用小写英文字母、数字和连字符 `-`。
- 不使用空格、下划线、中文字符、中文标点或大小写混排。
- 名称表达稳定职责，不表达临时版本或人员名称。
- 数字只有在业务语义明确时使用，不用 `01-`、`02-` 维持人工排序。

## 2. Prompt / Skill / Agent 名称

### Prompt 分类目录

使用领域名词：

```text
product-definition/
geospatial-intelligence/
image-generation/
```

### Skill 目录

使用能力或工作流名称：

```text
requirement-analysis/
code-review-fix/
technical-report-generation/
```

### Agent 目录

以 `-agent` 结尾：

```text
product-development-agent/
```

### Pipeline / Router

编排器名称应明确表达职责：

```text
product-development-pipeline/
workflow-router/
```

## 3. 文件命名

固定入口保持标准名称：

```text
README.md
SKILL.md
AGENT.md
```

历史 Prompt、规则、参考资料可以保留中文文件名，以避免无意义的大规模改名和 Git 历史噪声。

新增机器频繁引用的文件优先使用英文 `kebab-case.md`；面向人工阅读、无需程序引用的说明文档可以使用中文文件名。

## 4. 中文展示名

英文路径不意味着文档必须英文。

推荐：

```text
目录：skills/product-development-pipeline/
README 标题：# 产品研发流水线
SKILL name：product-development-pipeline
正文：中文
```

这样同时保证：

- 路径稳定。
- GitHub URL 简洁。
- Codex / Agent 引用方便。
- 中文使用者阅读自然。

## 5. 跨目录引用

所有跨 Prompt / Skill / Agent 的引用必须使用当前英文路径，不引用历史别名。

例如：

```text
skills/product-development-skills/requirement-analysis/SKILL.md
skills/software-development/codex-task-execution/SKILL.md
agents/product-development-agent/AGENT.md
```

修改目录时必须同步检查：

1. 根 `README.md`。
2. 对应分类 `README.md`。
3. `skills/workflow-router/`。
4. `agents/` 中的 Composition / Routing。
5. `docs/迁移映射.md`。
6. 其他 Skill 的相对链接。

## 6. 历史兼容

历史路径只允许出现在：

- `docs/迁移映射.md` 的 Source / 旧目录列。
- 明确标记为 Legacy 的历史参考文档。
- Git 历史。

历史路径不得继续作为当前执行入口。

## 7. 新增目录检查表

新增目录前检查：

- [ ] 是否为英文 `kebab-case`？
- [ ] 是否没有空格、中文、下划线和中文标点？
- [ ] 名称是否描述稳定职责？
- [ ] 是否与现有目录语义重复？
- [ ] 是否应该是 Prompt、Skill 还是 Agent？
- [ ] 是否已更新对应索引？
- [ ] 是否需要加入 `workflow-router`？
- [ ] 是否存在跨目录引用需要同步更新？
