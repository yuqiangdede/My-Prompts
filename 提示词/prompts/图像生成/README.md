# 图像生成

本分类管理**单张图像生成、人物参考、建筑视觉和风格转换**相关 Prompt。

## 定位

适合一次性生成图像提示词或对输入图片做视觉转换说明，不负责需要真实文件、查看器或跨阶段验证的执行闭环。

## 目录

| 目录 | 说明 |
| --- | --- |
| [`image-generation/general/`](image-generation/general/) | 通用单张图像提示词设计 |
| [`image-generation/architecture/`](image-generation/architecture/) | 建筑视觉与技术分析图 |
| [`image-generation/character-reference/`](image-generation/character-reference/) | 人物参考、人物关系和图谱 |
| [`image-generation/character-portrait/`](image-generation/character-portrait/) | 人物肖像、职业照、写真、海报、发型等 |
| [`image-generation/style-transfer/`](image-generation/style-transfer/) | 调色、油画、老照片等风格转换 |

## 边界

需要生成 360° 全景资产并接入查看器完成运行、映射和交互验证时，使用 [`panorama-generation`](../../../技能/skills/图像与视觉/panorama-generation/README.md) Skill。

需要根据参考剧照生成连续 A/B/C/D/E 镜头图组并检查跨帧一致性时，使用 [`layered-shot-narrative`](../../../技能/skills/图像与视觉/layered-shot-narrative/README.md) Skill。

## 返回上级

[返回 Prompts 索引](../README.md)
