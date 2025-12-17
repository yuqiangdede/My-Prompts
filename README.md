# My-Prompts

用于管理和版本化个人提示词（Prompts）的仓库，目标是：可检索、可复用、可迭代。

## 目录结构

```
prompts/
  templates/      # 提示词模板
  system/         # 系统提示词（System Prompts）
  user/           # 用户提示词（User Prompts）
  examples/       # 可直接复制使用的示例
```

## 使用方式（推荐）

1. 从模板复制一份新文件

PowerShell 示例：

```powershell
Copy-Item prompts/templates/prompt-template.md prompts/user/my-new-prompt.md
```

2. 按模板补全“目标/输入/约束/输出格式”等信息
3. 通过文件名、标题、标签等方式沉淀可检索的提示词资产

## 约定（可按需调整）

- 一个提示词一个文件，使用 Markdown 编写
- 文件名建议使用英文或短横线（便于跨平台与搜索），例如：`polish-text.md`
- 如需元数据，建议使用 YAML Front Matter（模板已提供）

