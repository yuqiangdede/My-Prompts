# 中文展示层目录调整实施计划

> For agentic workers: REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox syntax for tracking.

**Goal:** 将核心 Prompt、Skill、Agent 目录放入中文展示层，同时保留英文机器目录和 Codex Skill 元数据兼容性。

**Architecture:** 在仓库根目录新增 提示词、技能、智能体 三个中文展示层，分别承载原有 prompts、skills、agents。英文目录及其内部能力目录保持原名；所有仓库内当前路径、Markdown 链接和安装脚本路径同步到新的分层结构。

**Tech Stack:** Git、Windows PowerShell 7、Markdown、PowerShell 脚本、Codex Skill frontmatter。

**Spec:** docs/superpowers/specs/2026-08-29-chinese-directory-layer-design.md

## Global Constraints

- 中文展示层固定为：提示词、技能、智能体。
- 英文机器命名空间固定为：prompts、skills、agents。
- 英文能力目录使用英文 kebab-case；SKILL.md 的 name 必须继续匹配英文能力目录名。
- docs/、scripts/ 保持仓库根目录位置。
- 不修改 Prompt、Skill、Agent 业务正文，不复制中英文两套目录，不建立旧路径副本。
- 所有操作限定在 D:\code\OtherCode\My-Prompts 仓库内。

---

## 文件结构与职责

- Create: 提示词/，承载原 prompts/。
- Create: 技能/，承载原 skills/。
- Create: 智能体/，承载原 agents/。
- Move: prompts/ → 提示词/prompts/。
- Move: skills/ → 技能/skills/。
- Move: agents/ → 智能体/agents/。
- Modify: 根 README、移动后的三类索引、Agent 路由、docs/迁移映射.md、docs/naming-conventions.md、scripts/install-codex-skills.ps1，以及所有受影响的当前路径引用。
- Preserve: docs/、scripts/ 的位置，英文能力目录，README.md、SKILL.md、AGENT.md 和业务正文。

## Task 1: 建立移动前基线

**Files:**

- Read: README.md
- Read: docs/naming-conventions.md
- Read: docs/superpowers/specs/2026-08-29-chinese-directory-layer-design.md
- Read: scripts/install-codex-skills.ps1

**Interfaces:**

- Consumes: 当前仓库目录、Git 状态和路径引用。
- Produces: 可核对的移动前状态，不修改业务文件。

- [ ] **Step 1: 确认仓库根目录和工作区干净**

Run from D:\code\OtherCode\My-Prompts:

    $root = (git rev-parse --show-toplevel).Trim()
    if ($root -ne 'D:/code/OtherCode/My-Prompts') { throw "Unexpected repository root: $root" }
    git branch --show-current
    git status --short --branch --untracked-files=all

Expected: 根目录正确，当前分支明确，工作区没有未提交或未跟踪文件。

- [ ] **Step 2: 保存目录和路径引用清单**

    Get-ChildItem -LiteralPath '.\prompts','.\skills','.\agents' -Directory -Force | Select-Object FullName
    rg -n --glob '*.md' --glob '*.ps1' --glob '*.json' --glob '*.yml' --glob '*.yaml' '(^|[\\/])prompts([\\/]|$)|(^|[\\/])skills([\\/]|$)|(^|[\\/])agents([\\/]|$)' .

Expected: 三个源目录存在；命中结果用于区分当前路径、英文概念和迁移文档中的历史路径。

## Task 2: 移动核心目录到中文展示层

**Files:**

- Create: 提示词/、技能/、智能体/
- Move: prompts/ → 提示词/prompts/
- Move: skills/ → 技能/skills/
- Move: agents/ → 智能体/agents/

**Interfaces:**

- Consumes: Task 1 的干净工作区和三个源目录。
- Produces: 新中文展示层路径，内部英文目录和文件内容保持不变。

- [ ] **Step 1: 创建中文层并确认目标目录不存在**

    foreach ($path in @('.\提示词','.\技能','.\智能体')) {
        if (Test-Path -LiteralPath $path) { throw "Target layer already exists: $path" }
    }
    New-Item -ItemType Directory -Path '.\提示词','.\技能','.\智能体' -Force | Out-Null

Expected: 三个中文目录创建成功，原 prompts/、skills/、agents/ 仍存在。

- [ ] **Step 2: 使用 Git 移动三组目录**

    git mv -- 'prompts' '提示词/prompts'
    git mv -- 'skills' '技能/skills'
    git mv -- 'agents' '智能体/agents'

Expected: Git 识别为目录移动，旧根级目录消失。

- [ ] **Step 3: 检查移动后的关键入口**

    $required = @(
        '.\提示词\prompts\README.md',
        '.\技能\skills\README.md',
        '.\智能体\agents\README.md',
        '.\技能\skills\product-development-pipeline\SKILL.md',
        '.\智能体\agents\workflow-router\AGENT.md',
        '.\docs\naming-conventions.md',
        '.\scripts\install-codex-skills.ps1'
    )
    foreach ($path in $required) {
        if (-not (Test-Path -LiteralPath $path)) { throw "Missing required path: $path" }
    }

Expected: 所有入口存在，docs/ 和 scripts/ 仍在根目录。

## Task 3: 更新根导航、索引和 Agent 路由

**Files:**

- Modify: README.md
- Modify: 提示词/prompts/README.md
- Modify: 技能/skills/README.md
- Modify: 智能体/agents/README.md
- Modify: 智能体/agents/workflow-router/AGENT.md
- Modify: 智能体/agents/product-development-agent/AGENT.md
- Modify: docs/迁移映射.md

**Interfaces:**

- Consumes: Task 2 的新目录路径。
- Produces: 用户可点击的新入口，历史迁移表继续保留历史路径并标记为历史。

- [ ] **Step 1: 更新根 README 的仓库路径**

    prompts/ → 提示词/prompts/
    skills/  → 技能/skills/
    agents/  → 智能体/agents/

只替换仓库路径，不替换 product-development-pipeline、workflow-router 等能力名或命令参数。

- [ ] **Step 2: 修正移动后索引的相对链接**

移动后索引使用以下相对路径规则：

    提示词/prompts/README.md → ../../技能/skills/、../../智能体/agents/
    技能/skills/README.md    → ../../提示词/prompts/、../../智能体/agents/、../../docs/
    智能体/agents/README.md  → ../../提示词/prompts/、../../技能/skills/

同一英文命名空间内部的相对链接继续保持原层级。

- [ ] **Step 3: 更新 Agent 路由和迁移说明**

将 Agent 路由、Agent 组合说明和 docs/迁移映射.md 中描述当前入口的路径改为中文层路径。迁移表的历史路径列保留 prompts/、skills/、agents/，并明确其为历史路径。

## Task 4: 更新命名规范和安装脚本

**Files:**

- Modify: docs/naming-conventions.md
- Modify: scripts/install-codex-skills.ps1
- Modify: 技能/skills/README.md

**Interfaces:**

- Consumes: 技能/skills/ 的实际路径和已确认的分层命名规则。
- Produces: 与目录结构一致的规范说明和可运行的 Skill 安装入口。

- [ ] **Step 1: 更新命名规范**

在 docs/naming-conventions.md 中写明：

    中文展示层：提示词、技能、智能体
    英文机器命名空间：prompts、skills、agents
    英文能力目录：kebab-case
    固定入口文件：README.md、SKILL.md、AGENT.md
    docs/、scripts/：保持根目录位置

同步更新其中所有当前路径示例。

- [ ] **Step 2: 更新安装脚本的 Skill 根目录**

将 scripts/install-codex-skills.ps1 中的：

    $SkillsRoot = Join-Path $RepoRoot "skills"

改为：

    $SkillsRoot = Join-Path $RepoRoot "技能\skills"

保留 Skill name、-Include 参数、全局/项目安装目标和重复名称检查逻辑。

- [ ] **Step 3: 同步 Skill 索引**

将 技能/skills/README.md 中指向 Prompt、Agent、Docs 或脚本的仓库路径改为中文层路径，Skill 名称继续使用英文。

## Task 5: 扫描并修正全部当前路径引用

**Files:**

- Modify: 所有仍包含当前路径引用的 .md、.ps1、.json、.yml、.yaml 文件。
- Preserve: docs/迁移映射.md 中明确标注为历史路径的旧路径。

**Interfaces:**

- Consumes: Task 3 和 Task 4 的文档、脚本更新。
- Produces: 当前入口统一指向中文展示层，相对链接在移动后可解析。

- [ ] **Step 1: 扫描旧路径并逐条分类**

    rg -n --glob '*.md' --glob '*.ps1' --glob '*.json' --glob '*.yml' --glob '*.yaml' '(^|[\\/])prompts([\\/]|$)|(^|[\\/])skills([\\/]|$)|(^|[\\/])agents([\\/]|$)' '.\README.md' '.\提示词' '.\技能' '.\智能体' '.\docs' '.\scripts'

逐条区分当前路径、英文概念/命令参数和迁移文档历史记录；当前路径改为中文层路径，历史记录保留并标注。

- [ ] **Step 2: 确认新路径已覆盖所有入口**

    rg -n --glob '*.md' --glob '*.ps1' --glob '*.json' --glob '*.yml' --glob '*.yaml' '提示词/prompts|技能/skills|智能体/agents|提示词\\prompts|技能\\skills|智能体\\agents' .

Expected: 根导航、索引、路由、规范和脚本均出现对应新路径。

- [ ] **Step 3: 检查差异类型和空白错误**

    git diff --find-renames --stat
    git diff --find-renames --name-status
    git diff --check

Expected: 主要变化为三组目录移动以及路径/规范文档同步，没有无关正文重写。

## Task 6: 验证链接、Skill 元数据和安装入口

**Files:**

- Read: 全部 Markdown 链接目标。
- Read: 技能/skills/**/SKILL.md frontmatter。
- Execute: scripts/audit-skill-metadata.ps1。
- Execute: scripts/install-codex-skills.ps1。

**Interfaces:**

- Consumes: Task 5 完成后的目录和引用。
- Produces: 可验证的文档导航和 Skill 发现结果。

- [ ] **Step 1: 验证目录布局**

    $checks = [ordered]@{
        promptsLayer = Test-Path -LiteralPath '.\提示词\prompts'
        skillsLayer = Test-Path -LiteralPath '.\技能\skills'
        agentsLayer = Test-Path -LiteralPath '.\智能体\agents'
        oldPromptsAbsent = -not (Test-Path -LiteralPath '.\prompts')
        oldSkillsAbsent = -not (Test-Path -LiteralPath '.\skills')
        oldAgentsAbsent = -not (Test-Path -LiteralPath '.\agents')
        docsAtRoot = Test-Path -LiteralPath '.\docs'
        scriptsAtRoot = Test-Path -LiteralPath '.\scripts'
    }
    $checks.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }
    if ($checks.Values -contains $false) { throw 'Directory layout validation failed' }

Expected: 所有检查为 True。

- [ ] **Step 2: 检查全部 Markdown 本地链接**

对各级 .md 提取 Markdown 链接，跳过 http、https 和锚点；相对链接按来源文件所在目录解析，使用 Test-Path -LiteralPath 检查每个目标。

Expected: 本地链接失败数为 0，并输出失败链接和来源文件。

- [ ] **Step 3: 运行 Skill 元数据审计**

    powershell -ExecutionPolicy Bypass -File '.\scripts\audit-skill-metadata.ps1'

Expected: 审计成功，所有 SKILL.md 的 name 仍与英文能力目录名一致。

- [ ] **Step 4: 验证安装脚本发现 Skill**

    powershell -ExecutionPolicy Bypass -File '.\scripts\install-codex-skills.ps1' -List

Expected: 成功列出全部 Skill，列出的相对路径以 技能\skills\ 开头；不执行全局安装，不修改用户目录。

## Task 7: 最终审查与交付

**Files:**

- Review: 目录移动、路径修正、规范文档和验证输出。
- Commit: 仅在用户明确要求提交时创建实施提交。
- Push: 仅在用户明确要求推送时执行。

**Interfaces:**

- Consumes: Task 6 的验证结果。
- Produces: 变更范围、验证证据和未验证边界。

- [ ] **Step 1: 核对工作区和变更文件**

    git status --short --branch --untracked-files=all
    git diff --find-renames --name-status
    git diff --check

Expected: 只有预期目录移动、路径引用和命名规范变更，没有临时文件或空目录残留。

- [ ] **Step 2: 记录验证边界**

报告目录结构、Markdown 链接、Skill 审计、安装脚本 -List 和项目测试结果。由于本次是目录/文档变更，项目测试若无测试套件则写明 NOT RUN，不以测试缺失推断功能正确。

- [ ] **Step 3: 按用户后续指令处理提交或推送**

如果用户明确要求提交，使用只包含本次变更的 Git 暂存清单创建提交；如果用户明确要求推送，先确认远端关系，再推送并核对本地 HEAD、origin/main 和远端分支指针。
