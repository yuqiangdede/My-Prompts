# Task 4 Report

日期：2026-08-29
分支：`codex/chinese-directory-layer`
仓库：`D:\code\OtherCode\My-Prompts\.worktrees\chinese-directory-layer`

## 任务范围

按 brief 仅处理以下内容：

- `docs/naming-conventions.md`
- `scripts/install-codex-skills.ps1`
- `技能/skills/README.md`

另按要求输出本报告：

- `.superpowers/sdd/2026-08-29-chinese-directory-layer/task-4-report.md`

未修改 Prompt/Skill/Agent 业务内容，未修改其他业务文件，未使用子代理或 reviewer。

## 变更文件

1. `docs/naming-conventions.md`
2. `scripts/install-codex-skills.ps1`
3. `技能/skills/README.md`
4. `.superpowers/sdd/2026-08-29-chinese-directory-layer/task-4-report.md`

## 具体变更

### 1. `docs/naming-conventions.md`

- 将“所有目录统一使用英文 `kebab-case`”调整为“中文展示层 + 英文机器命名空间”。
- 明确中文展示层固定为：`提示词/`、`技能/`、`智能体/`。
- 明确英文机器命名空间固定为：`prompts/`、`skills/`、`agents/`。
- 明确 `docs/`、`scripts/` 保持根目录位置。
- 将当前路径示例同步改为：
  - `技能/skills/...`
  - `提示词/prompts/...`
  - `智能体/agents/...`
- 将索引/路由检查清单同步到中文展示层路径。
- 将历史兼容说明明确为：根级 `prompts/`、`skills/`、`agents/` 不再作为当前入口。

### 2. `scripts/install-codex-skills.ps1`

- 将 `$SkillsRoot` 的解析目标更新为仓库内 `技能\skills`。
- 为兼容 brief 指定的 `powershell -File` 执行方式，使用字符码拼接：

```powershell
$SkillsRoot = Join-Path $RepoRoot (([string][char]0x6280) + [char]0x80FD + "\skills")
```

- 保持以下逻辑不变：
  - Skill 目录名即 Skill name。
  - `-Include` 参数解析逻辑。
  - `Global` / `Project` 安装目标。
  - 重名目录检查。
  - `-List` 输出格式。
  - 安装与跳过统计逻辑。

### 3. `技能/skills/README.md`

- 增加仓库分层路径规则说明：
  - 中文展示层：`提示词/`、`技能/`、`智能体/`
  - 英文机器命名空间：`prompts/`、`skills/`、`agents/`
  - 当前 Skill 入口：`技能/skills/`
  - `docs/`、`scripts/` 继续保留在仓库根目录
- 保持 Skill 名称继续使用英文目录名。
- 保留原有业务说明，仅补充当前安装入口说明：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -List
```

## 精确行为

### 安装脚本路径行为

- 仓库内 Skill 搜索根目录：`技能\skills\`
- `-List` 时列出的相对路径前缀：`技能\skills\`
- `Global` 安装目标：`%USERPROFILE%\.codex\skills`
- `Project` 安装目标：`<ResolvedProject>\.agents\skills`
- Skill 名称来源：每个 `SKILL.md` 所在目录名，保持英文 `kebab-case`

### 文档路径行为

- 面向人工浏览的当前入口使用中文展示层：
  - `提示词/prompts/...`
  - `技能/skills/...`
  - `智能体/agents/...`
- 面向机器稳定识别的子命名空间继续使用英文：
  - `prompts`
  - `skills`
  - `agents`
- `docs/`、`scripts/` 仍位于仓库根目录

## 执行命令与输出

### 1. 进入指定 worktree 并确认分支

命令：

```powershell
Set-Location -LiteralPath 'D:\code\OtherCode\My-Prompts\.worktrees\chinese-directory-layer'
git branch --show-current
```

输出：

```text
codex/chinese-directory-layer
```

### 2. metadata audit

命令：

```powershell
Set-Location -LiteralPath 'D:\code\OtherCode\My-Prompts\.worktrees\chinese-directory-layer'
powershell -ExecutionPolicy Bypass -File '.\scripts\audit-skill-metadata.ps1'
```

输出：

```text
At D:\code\OtherCode\My-Prompts\.worktrees\chinese-directory-layer\scripts\audit-skill-metadata.ps1:82 char:32
+ ... n -notmatch '涓嶇敤浜巪涓嶈礋璐搴斾娇鐢▅鐩存帴浣跨敤|涓嶅簲瑙﹀彂|涓嶇洿鎺涓嶅仛|涓嶅紑鍙憒涓嶆妸|绂佹|涓嶅睘浜? ...
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The string is missing the terminator: '.
At D:\code\OtherCode\My-Prompts\.worktrees\chinese-directory-layer\scripts\audit-skill-metadata.ps1:109 char:2
+
Missing closing ')' after expression in 'if' statement.
At D:\code\OtherCode\My-Prompts\.worktrees\chinese-directory-layer\scripts\audit-skill-metadata.ps1:21 char:27
+ foreach ($file in $Files) {
+                           ~
Missing closing '}' in statement block or type definition.
    + CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : TerminatorExpectedAtEndOfString
```

结果：失败，退出码 `1`。该错误来自现有 `audit-skill-metadata.ps1` 本身，本任务未修改该文件。

### 3. installer `-List`

命令：

```powershell
Set-Location -LiteralPath 'D:\code\OtherCode\My-Prompts\.worktrees\chinese-directory-layer'
powershell -ExecutionPolicy Bypass -File '.\scripts\install-codex-skills.ps1' -List
```

输出：

```text
Available skills:
  agent-workflow-design                    技能\skills\agent-automation\agent-workflow-design
  code-review-fix                          技能\skills\software-development\code-review-fix
  codex-task-execution                     技能\skills\software-development\codex-task-execution
  deep-research-fact-checking              技能\skills\research-analysis\deep-research-fact-checking
  java-project-architecture-analysis       技能\skills\software-development\java-project-architecture-analysis
  layered-shot-narrative                   技能\skills\layered-shot-narrative
  panorama-generation                      技能\skills\panorama-generation
  paper-reading-reproduction               技能\skills\research-analysis\paper-reading-reproduction
  prd-writing                              技能\skills\product-development-skills\prd-writing
  product-development-pipeline             技能\skills\product-development-pipeline
  project-knowledge-capture                技能\skills\product-development-skills\project-knowledge-capture
  prompt-injection-defense                 技能\skills\safety-quality\prompt-injection-defense
  prompt-optimization-evaluation           技能\skills\agent-automation\prompt-optimization-evaluation
  prototype-existing-project               技能\skills\product-development-skills\prototype-existing-project
  prototype-greenfield                     技能\skills\product-development-skills\prototype-greenfield
  python-vision-project-reproduction       技能\skills\research-analysis\python-vision-project-reproduction
  requirement-analysis                     技能\skills\product-development-skills\requirement-analysis
  requirement-clarification                技能\skills\product-development-skills\requirement-clarification
  requirement-review                       技能\skills\product-development-skills\requirement-review
  solution-design                          技能\skills\product-development-skills\solution-design
  style-reference-research                 技能\skills\style-reference-research
  version-retrospective                    技能\skills\product-development-skills\version-retrospective
```

结果：成功，退出码 `0`。验证了脚本从 `技能\skills\` 解析 Skill，并保持英文 Skill 名称。

### 4. 补丁完整性检查

命令：

```powershell
Set-Location -LiteralPath 'D:\code\OtherCode\My-Prompts\.worktrees\chinese-directory-layer'
git diff --check -- '.\docs\naming-conventions.md' '.\scripts\install-codex-skills.ps1' '.\技能\skills\README.md'
```

输出：

```text
warning: in the working copy of 'scripts/install-codex-skills.ps1', LF will be replaced by CRLF the next time Git touches it
```

结果：无 diff 语法错误，仅有 Git 行尾警告。

## 自检

- 已确认当前分支为 `codex/chinese-directory-layer`。
- 已将命名规范更新为中文展示层 + 英文机器命名空间。
- 已将安装脚本的 Skill 根目录更新为解析 `技能\skills`。
- 已确认 `-List` 输出的相对路径前缀为 `技能\skills\`。
- 已确认未改动 Skill 名称、frontmatter、安装参数、安装目标和重复名称检查逻辑。
- 已确认 `技能/skills/README.md` 仅补充分层路径和安装入口说明，未改业务内容。
- 已运行 brief 要求的两个检查，并如实记录成功/失败结果。

## 关注点

1. `scripts/audit-skill-metadata.ps1` 在 brief 指定的 `powershell -File` 方式下因自身解析错误失败；本任务未越界修改该文件，因此该问题仍待其他任务处理。
2. `git diff --check` 仅提示 `scripts/install-codex-skills.ps1` 的 LF/CRLF 行尾告警，没有发现补丁格式错误。

## 提交

1. `82ddf68` `docs: align chinese skill layer paths`
   - 包含：
     - `docs/naming-conventions.md`
     - `scripts/install-codex-skills.ps1`
     - `技能/skills/README.md`
2. 报告文件位于 `.superpowers/...`，默认被 `.gitignore` 忽略，需要使用 `git add -f` 单独纳入提交。
