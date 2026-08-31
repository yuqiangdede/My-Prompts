# 技术汇报脚本（`technical-communication`）

用于把已经完成的技术方案一次性转换成汇报制作脚本，而不是直接生成最终 PPTX 或视频。

## 定位

适合输入已有技术方案，输出 PPT 页级分镜、视频镜头、旁白和 timing 等制作说明。

## 通用 Prompt

| Prompt | 说明 |
| --- | --- |
| [`technical-to-ppt-storyboard.md`](technical-to-ppt-storyboard.md) | 技术方案 → PPT 分镜脚本 |
| [`technical-to-video-storyboard.md`](technical-to-video-storyboard.md) | 技术方案 → 技术讲解视频分镜、旁白和 timing JSON |

## 示例

[`examples/`](examples/) 保留历史项目中已经使用过的专用模板，供参考但不作为通用默认规则：

- [`ais-clickhouse-ppt-storyboard.md`](examples/ais-clickhouse-ppt-storyboard.md)
- [`ais-clickhouse-video-storyboard.md`](examples/ais-clickhouse-video-storyboard.md)

这些示例包含 AIS、轨迹回放、ClickHouse、缓存等项目专用要求。新项目优先使用通用 Prompt，再按需借鉴示例，不要把历史表名和模块名硬套到其他系统。

## 适用场景

当输入已经是一份相对完整的技术方案，只需要整理成可交给 Presentations、Codex、HyperFrames 或其他制作工具的脚本时使用。

## 边界

如果目标是直接生成并交付 PPTX 或视频成品，应使用具备真实文件生成与验收能力的下游工具或 Skill，而不是把本目录当成最终产物生成器。

## 返回上级

[返回技术汇报分类](../README.md)
