# 核心目录中文展示层调整设计

## 1. 目标

为仓库的核心能力目录增加中文展示层，使用户在文件管理器和 GitHub 中首先看到中文目录名，同时保留 Prompt、Skill、Agent 的稳定英文机器目录，降低 Codex 元数据、安装脚本和既有引用的兼容风险。

本次只处理核心能力目录：Prompt、Skill、Agent。`docs/` 和 `scripts/` 保持当前路径不变。

## 2. 目标目录结构

当前结构：

```text
prompts/
skills/
agents/
docs/
scripts/
```

调整后：

```text
提示词/
└── prompts/
    ├── product-definition/
    ├── software-development/
    └── ...

技能/
└── skills/
    ├── product-development-skills/
    ├── software-development/
    └── ...

智能体/
└── agents/
    ├── workflow-router/
    └── product-development-agent/

docs/
scripts/
```

中文层是面向人的分类入口；英文层是稳定的机器命名空间。英文能力目录、固定入口文件 `README.md`、`SKILL.md`、`AGENT.md` 以及 Prompt 文件名不在本次重命名范围内。

## 3. 兼容性约束

### 3.1 Skill 元数据

- 每个 Skill 的 `name` 继续使用英文 `kebab-case`。
- `name` 继续与 Skill 的英文目录名一致。
- 不把中文展示层名称写入 `SKILL.md` 的 `name`，避免破坏自动发现和安装映射。

### 3.2 安装脚本

`scripts/install-codex-skills.ps1` 继续保留在根目录下，但 `$SkillsRoot` 改为 `提示词` 同级的 `技能/skills`。脚本对外暴露的 Skill 名称、`-Include` 参数和目标目录逻辑保持不变。

### 3.3 文档与路由

以下内容中的仓库内路径统一改为新的中文层路径：

- 根 `README.md`。
- `prompts/README.md`、`skills/README.md`、`agents/README.md` 移动后的对应索引文件。
- `agents/workflow-router/AGENT.md` 与其他 Agent 组合说明。
- `docs/迁移映射.md`、`docs/naming-conventions.md` 和 Skill 说明中的当前路径。
- 所有 Prompt、Skill、Agent 内部的相对链接和路径示例。

历史路径只保留在迁移说明的历史列或明确标注为 Legacy 的内容中；当前使用说明不再指向旧路径。

## 4. 命名规范调整

`docs/naming-conventions.md` 将从“所有目录统一使用英文”调整为分层规则：

- 面向用户的顶层分类层使用中文：`提示词`、`技能`、`智能体`。
- 面向工具和自动发现的稳定命名空间使用英文：`prompts`、`skills`、`agents`。
- 英文能力目录使用英文 `kebab-case`。
- 固定入口文件继续使用英文文件名。
- `docs/`、`scripts/` 维持现状，不额外增加中文层。

## 5. 实施步骤

1. 在仓库根目录创建 `提示词/`、`技能/`、`智能体/` 三个中文层目录。
2. 使用 Git 感知的目录移动，将 `prompts/`、`skills/`、`agents/` 分别移动到对应中文层下。
3. 批量更新所有当前路径引用，并保留技术标识、Skill 名称和命令参数中的英文名称。
4. 更新命名规范、根目录导航、分类索引、Agent 路由和安装脚本。
5. 扫描旧的当前路径引用，检查中文路径解析和 Markdown 相对链接。
6. 运行 Skill 元数据审计，并使用安装脚本的 `-List` 模式确认 Skill 仍可被发现。
7. 检查 Git 差异只包含目录移动和路径/规范文档同步，没有 Prompt 或 Skill 正文内容变化。

## 6. 非目标

- 不修改 Prompt、Skill、Agent 的业务内容。
- 不重命名英文能力目录，例如 `product-development-pipeline`、`workflow-router`。
- 不修改 `docs/`、`scripts/` 的顶层位置。
- 不复制一套中文和英文目录，不建立旧路径的冗余副本。
- 不修改 Codex 全局目录、用户目录或项目外部文件。

## 7. 风险与处理

### Windows 中文路径

Windows、PowerShell 和 Git 对中文路径可用，但命令和脚本必须使用明确引用的路径。验证阶段将直接检查目标目录和文件是否存在。

### Markdown 链接编码

GitHub 链接中的中文目录需要正确编码或使用仓库当前可解析的相对路径格式。验证脚本将提取各级 README 的本地链接并逐一检查目标。

### 外部旧路径引用

仓库外部脚本或个人书签可能仍引用 `prompts/`、`skills/`、`agents/`。本次会在仓库内文档中更新当前入口，并在 README 中说明新的使用方式；不会为仓库外部系统创建隐式兼容目录。

## 8. 验收标准

- [ ] `提示词/prompts/`、`技能/skills/`、`智能体/agents/` 存在，旧的根级 `prompts/`、`skills/`、`agents/` 不再作为当前入口存在。
- [ ] `docs/`、`scripts/` 仍位于仓库根目录。
- [ ] 根 README、各类索引和 Agent 路由均指向新路径。
- [ ] 仓库内不存在指向旧当前路径的未标记引用。
- [ ] 所有 Markdown 本地链接目标存在。
- [ ] Skill 元数据审计通过，安装脚本 `-List` 能发现全部 Skill。
- [ ] Git 差异未改变 Prompt、Skill、Agent 的正文语义。
- [ ] 工作区状态、提交范围和最终远端关系按交付要求核对。
