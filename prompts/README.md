# Prompts

这里存放一次性、单任务 Prompt：补全输入变量后直接交给模型处理，不依赖跨轮状态、固定工作流或复杂工具编排。

## 阅读顺序

- 每个 Prompt 叶子目录都提供 `README.md`，用于说明**具体能干什么、输入示例、预期结果和使用边界**。
- 目录中的具体 Prompt 文件是正式执行内容，复制前需要替换其中的 `{{变量}}`。
- 第一次使用某个分类时，先读该分类 README，再打开具体 Prompt。

## 使用原则

1. 先选择最接近任务的 Prompt，再替换其中的 `{{变量}}`。
2. 不需要的可选变量可以留空，但不要删除目标、边界和输出要求。
3. Prompt 只负责一次处理；需要多步骤执行、状态管理、质量 Gate 或工具调用时，应使用 [`skills/`](../skills/README.md)。
4. 图片分析类 Prompt 只使用可见证据，不能把猜测写成事实。
5. 生图类 Prompt 优先固定主体、构图和身份，再逐项调整服装、灯光、色彩或姿态。
6. 需要准确文字、尺寸、关系图或工程参数时，优先用 HTML、SVG、Mermaid、CAD 或后期排版，不依赖生图模型直接生成。

## 产品定义

- [用途与具体例子](product-definition/README.md)
- [想法产品化](product-definition/想法产品化.md)：模糊想法 → 用户场景 → MVP 边界 → 业务闭环 → 验收与路线图。

## 视觉与多模态理解

- [用途与具体例子](vision-multimodal-understanding/README.md)
- [图片标签](vision-multimodal-understanding/图片标签.md)：为街景、园区和监控画面生成稳定标签，支持数组或 JSON 输出。

## 安全、合规与风险评估

- [用途与具体例子](safety-compliance-risk/README.md)
- [图片隐私风险分析](safety-compliance-risk/图片隐私风险分析.md)：识别身份、位置、凭证、屏幕、商业和物理安全风险。

## 地理与空间智能

- [用途与具体例子](geospatial-intelligence/README.md)
- [图片地理位置分析](geospatial-intelligence/图片地理位置分析.md)：按证据强度生成候选区域、反证、置信度和核验计划。

## 生图提示词

### 建筑

- [用途与具体例子](image-generation/architecture/README.md)
- [建筑技术分析海报](image-generation/architecture/01%20建筑分析)：真实建筑摄影 + 克制的技术分析叠加，不伪造工程参数。

### 人物图谱

- [用途与具体例子](image-generation/character-reference/README.md)
- [人物关系图海报](image-generation/character-reference/01%20人物图谱)：基于用户提供的角色和关系生成阵营化信息海报。

### 360° 全景图

- [用途与具体例子](image-generation/panorama-generation/README.md)
- [全景图生成与 Three.js 查看器](image-generation/panorama-generation/说明)：2:1 等距柱状全景图与交互查看器 Prompt。

### 风格转换

- [4 个风格转换 Prompt 的用途与例子](image-generation/style-transfer/README.md)
- [参考图片调色分析](image-generation/style-transfer/01%20参考图片调色.md)：提取调色方向，并区分真实测量与视觉估算。
- [参考图 LUT 重建方案](image-generation/style-transfer/02%20参考图片调色.md)：输出节点、曲线、色轮和 LUT 验证方案。
- [参考图油画风格转换](image-generation/style-transfer/03%20复刻油画.md)：保留主体和构图，重建油彩、笔触和画布材料特征。
- [老照片质感转换](image-generation/style-transfer/04%20复刻老照片.md)：按年代、介质和保存状态建立可信老化效果。

### 人物肖像

- [13 个人物肖像 Prompt 的用途与例子](image-generation/character-portrait/README.md)
- [职业照转换](image-generation/character-portrait/01%20职业照转换)：自然可信的专业职业半身照。
- [高级商业时尚肖像](image-generation/character-portrait/02%20时尚照片)：影棚商业写真，保持人物身份和真实材质。
- [美术馆黑白纪实肖像](image-generation/character-portrait/03%20美术馆肖像)：静止主体与移动人群形成黑白纪实对比。
- [艺术黑白肖像组](image-generation/character-portrait/04%20艺术黑白照片)：4 张统一影调、不同姿态的编辑肖像。
- [复古时尚杂志封面肖像](image-generation/character-portrait/05%20杂志封面)：3 张复古编辑照片并预留后期排版空间。
- [几何光影电影肖像](image-generation/character-portrait/06%20电影肖像)：中性面部主光与单色几何效果光。
- [男士时尚九宫格肖像](image-generation/character-portrait/07%20海马体九宫格)：同一成年男性的 9 种表情和机位。
- [女士流行时尚九宫格肖像](image-generation/character-portrait/07.1%20海马体%20女生)：同一成年女性的 9 种自然表情。
- [双层侧脸背景肖像海报](image-generation/character-portrait/08%20同一张脸的柔和模糊的侧面特写)：前景全身人物 + 背景同脸柔焦侧脸。
- [雨夜霓虹电影人物照](image-generation/character-portrait/09%20人物的电影级逼真图像)：雨后城市环境中的冷暖电影光线。
- [雪天校园多角度写真海报](image-generation/character-portrait/10%20多角度特写的写真海报图)：明确为成年大学生的雪景情侣写真。
- [职业篮球看台转播抓拍](image-generation/character-portrait/11%20体育看台)：通用体育转播风格，不伪造真实台标和比分。
- [人物发型分析与探索图卡](image-generation/character-portrait/12%20发型)：统一身份下的 8–12 种差异化发型方案。

## 目录命名规则

- 分类目录和子目录统一使用英文 `kebab-case`。
- 中文只用于 README 标题、说明文字和历史 Prompt 文件名。
- 新增 Prompt 分类时必须同步更新本索引。

## 质量检查

新增或修改 Prompt 时至少检查：

- [ ] 对应叶子目录是否存在 `README.md`？
- [ ] README 是否包含具体输入和预期结果？
- [ ] 是否只有一个明确任务？
- [ ] 输入变量是否写清必填和可选？
- [ ] 是否说明不可推断或不可编造的内容？
- [ ] 输出格式是否可直接使用或解析？
- [ ] 是否包含失败、无效输入和不确定性处理？
- [ ] 生图任务是否锁定主体、构图和可变项？
- [ ] 是否避免真实 Logo、乱码文字、伪精确参数和无依据数据？
- [ ] 是否与现有 Prompt 重复，或实际应该升级为 Skill？
