---
name: technical-report-generation
description: 当已有技术方案、架构说明或技术文档，需要编排成面向汇报的视频分镜脚本或 PPT 页级分镜，并生成实现工具提示时使用。负责技术内容的汇报叙事与可视化编排；不负责设计底层技术方案，也不用于普通长文或通用故事视频分镜。
---

# technical-report-generation

## description

将技术方案文档编排为可交给 Codex、HyperFrames 或 Presentations 实现的视频分镜脚本或 PPT 分镜脚本。

## input

- 技术方案全文。
- 输出模式：视频或 PPT。
- 受众、时长、比例、视觉风格和实现工具约束。

## workflow

1. 读取 `steps/00 整体步骤.md` 确定视频/PPT路径。
2. 提取问题、架构、数据流、模块、查询链路、性能点和上线策略。
3. 按输出模式读取对应的 storyboard Prompt。
4. 生成镜头/页面目标、核心观点、画面、旁白、图形方式和禁止项。
5. 视频模式生成连续 timing JSON；PPT 模式生成页级版式和素材来源。
6. 生成 Codex、HyperFrames 或 Presentations 的实现提示。
7. 检查逻辑顺序、时长/页数、可实现性和技术事实一致性。

## rules

- 先讲问题，再讲方案；先总体架构，再讲局部流程。
- 每个镜头或页面只传达一个核心结论。
- 不堆完整 SQL、字段、代码或无关历史讨论。
- 图形必须服务技术表达，不能擅自改变技术逻辑。
- 视频 timing 的 start 必须连续；PPT 页面必须有明确汇报目的。
- 互联网图片必须标明搜索关键词和版权约束。

## output

- 视频或 PPT 分镜脚本。
- 视频模式的旁白全文和 timing JSON。
- PPT 模式的页级版式、图形生成方式和素材提示。
- 可直接交给实现工具的执行提示。
- 完整性和一致性检查结果。

## examples

输入一份包含缓存、数据库、消息推送和前端展示的技术方案，选择视频模式，输出 6–10 个镜头、口语化旁白、连续 timing JSON，以及 HyperFrames 实现提示。
