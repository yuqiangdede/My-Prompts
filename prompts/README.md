# Prompts

这里存放**一次性、单任务模板**：补全输入后交给模型处理，不依赖真实环境中的跨阶段状态、Gate、测试闭环或持续工具编排。

> 内部步骤很多，不代表它就是 Skill。只要这些步骤可以在一次上下文内完成、最终主要输出仍是一段文本/提示词，就优先放 Prompt。

## 使用原则

1. 选择最接近任务的 Prompt，再替换变量或补充输入。
2. Prompt 不需要安装到 Codex Skill 目录。
3. 可以直接复制 Prompt，也可以让 Codex 读取对应文件后执行。
4. 需要读取真实仓库/网络、修改文件、跨阶段状态、Gate、测试或验证时，改用 [`skills/`](../skills/README.md)。
5. 需要决定“该用哪个 Prompt / Skill / Agent”时，使用 [`agents/workflow-router/AGENT.md`](../agents/workflow-router/AGENT.md)。

## 产品定义

- [`product-definition/想法产品化.md`](product-definition/想法产品化.md)：模糊想法 → 用户、场景、MVP、闭环、验收、指标、风险和路线图草案。

## 软件开发

- [`software-development/codex-task-brief.md`](software-development/codex-task-brief.md)：把开发需求整理成可复制给**另一个** Codex/编码 Agent 的完整任务书。

如果当前 Codex 要直接修改仓库并运行验证，使用 `skills/software-development/codex-task-execution`。

## 写作

- [`writing/structured-longform-writing.md`](writing/structured-longform-writing.md)：主题/素材 → 提纲 → 完整长文 → 批评检查与修订。

如果需要真实外部资料检索与事实核验，先用 `deep-research-fact-checking` Skill。

## 技术汇报脚本

- [`technical-communication/technical-to-ppt-storyboard.md`](technical-communication/technical-to-ppt-storyboard.md)：技术方案 → PPT 分镜脚本。
- [`technical-communication/technical-to-video-storyboard.md`](technical-communication/technical-to-video-storyboard.md)：技术方案 → 视频分镜、旁白和 timing JSON。

注意：这里交付的是制作脚本，不是最终 PPTX/视频文件。

## 视频生成 Prompt

- [`video-generation/storyboard-design.md`](video-generation/storyboard-design.md)：故事、产品演示、业务流程 → 通用视频分镜和每镜头提示词。

如果需要直接生成连续静帧并检查人物/场景连续性，使用 `layered-shot-narrative` Skill。

## 视觉与多模态理解

- [`vision-multimodal-understanding/`](vision-multimodal-understanding/)：图片标签等视觉理解模板。

## 安全、合规与风险

- [`safety-compliance-risk/图片隐私风险分析.md`](safety-compliance-risk/图片隐私风险分析.md)：图片发布前隐私与安全风险初筛。

## 地理与空间智能

- [`geospatial-intelligence/图片地理位置分析.md`](geospatial-intelligence/图片地理位置分析.md)：基于可见证据输出候选区域、反证和置信度。

如果以后任务升级为“图片 → OCR → Web/地图检索 → 候选核验 → 排除”，应升级为 Skill，而不是继续扩大本 Prompt。

## 生图 Prompt

### 通用

- [`image-generation/general/image-prompt-design.md`](image-generation/general/image-prompt-design.md)：独立单张图的结构化生图提示词。

### 建筑

- [`image-generation/architecture/`](image-generation/architecture/)：建筑分析/技术视觉 Prompt。

### 人物图谱

- [`image-generation/character-reference/`](image-generation/character-reference/)：人物关系、人物参考图。

### 人物肖像

- [`image-generation/character-portrait/`](image-generation/character-portrait/)：职业照、时尚、电影肖像、杂志封面、九宫格、发型等。

### 风格转换

- [`image-generation/style-transfer/`](image-generation/style-transfer/)：调色、LUT、油画、老照片等。

360° 全景已经升级为需要文件生成与查看器验证的 Skill：[`skills/panorama-generation`](../skills/panorama-generation/README.md)。

## 新增 Prompt 判断标准

优先放 Prompt，当：

- [ ] 一次输入即可完成。
- [ ] 最终主要产物是文本、Prompt、JSON、表格或一次性分析。
- [ ] 不需要真实修改外部环境。
- [ ] 不需要跨阶段保存状态。
- [ ] 不需要 Gate/回退/测试闭环。
- [ ] 不需要多个工具结果作为后续真实输入。

如果其中多项不成立，应考虑 Skill。

## 质量检查

- [ ] 任务是否只有一个主要目标？
- [ ] 输入变量是否明确？
- [ ] 是否区分事实、假设和无法确认信息？
- [ ] 输出是否可直接使用？
- [ ] 是否包含无效输入/不确定性处理？
- [ ] 生图任务是否锁定主体、构图和可变项？
- [ ] 是否与已有 Prompt 重复？
- [ ] 是否其实已经需要真实执行闭环，应该升级为 Skill？
