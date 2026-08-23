# Technical Communication Prompts

用于把已经完成的技术方案一次性转换成汇报脚本，而不是直接生成最终 PPTX 或视频。

## 通用 Prompt

- `technical-to-ppt-storyboard.md`：技术方案 → PPT 分镜脚本。
- `technical-to-video-storyboard.md`：技术方案 → 技术讲解视频分镜、旁白和 timing JSON。

## 项目示例

`examples/` 保留历史项目中已经使用过的专用模板，供参考但不作为通用默认规则：

- `examples/ais-clickhouse-ppt-storyboard.md`
- `examples/ais-clickhouse-video-storyboard.md`

这些示例包含 AIS、轨迹回放、ClickHouse、缓存等项目专用要求。新项目优先使用通用 Prompt，再按需要借鉴示例，不要把示例中的表名、模块名硬套到其他系统。

## 什么时候使用

当输入已经是一份相对完整的技术方案，只需要整理成可交给 Presentations、Codex、HyperFrames 或其他制作工具的脚本时使用。

如果目标是直接生成并交付 PPTX/视频成品，应使用具备真实文件生成与验收能力的下游工具/Skill，而不是把本目录误当成最终产物生成器。
