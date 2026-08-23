# 需求 / 设计 / 实现能力 Skill 集

本目录是**可独立调用的能力库**，不是固定顺序的流水线。

复杂 B 端/行业系统需要从模糊需求完整推进时，使用同级的 `软件设计流水线` 作为总控；仅处理某一个阶段时，直接使用本目录对应 Skill。

## 能力清单

| Skill | 职责 | 不负责 |
|---|---|---|
| `requirement-clarification` | 澄清背景、用户、场景、问题、范围、成功标准 | 方案设计、PRD |
| `requirement-analysis` | 分析价值、根因、范围、角色、规则、风险 | 决定具体产品方案 |
| `solution-design` | 形成候选方案并完成业务方案设计 | 写完整 PRD、技术实现 |
| `prd-writing` | 将已确认方案写成可开发、可测试 PRD | 最终评审放行 |
| `requirement-review` | 独立评审并给出 S0-S3 与 GO/NO-GO | 代替作者重写整份 PRD |
| `prototype-greenfield` | 从零生成可运行、可点击高保真原型 | 生产后端 |
| `prototype-existing-project` | 在已有前端项目内复用现有栈构建原型 | 大规模重构 |
| `version-retrospective` | 版本/阶段复盘并形成改进动作 | 因单次问题自动创建 Skill |
| `project-knowledge-capture` | 把规则、决策、变更、结论沉淀成可检索知识 | 原样堆放项目资料 |

## 推荐组合

常规产品链路：

`澄清 → 分析 → 方案设计 → PRD → 独立评审 → 原型`

复杂行业系统：

`软件设计流水线（总控） → 按需复用本目录能力 → Gate → 输出路由`

版本结束：

`版本复盘 → 项目知识沉淀`

## 设计约束

- 每个 Skill 只承担一种稳定职责，避免触发冲突。
- 前一步信息不足时可以回退，但不得偷偷把假设写成事实。
- PRD 负责“写”，Requirement Review 负责“审”。
- `solution-design` 是需求分析与 PRD 之间的明确桥梁，禁止在 PRD 中临时发明核心方案。
- 原型分成 Greenfield 与 Existing Project 两条路径，禁止混用。
- 通用模板、存储协议和长案例优先放到各 Skill 的 `references/`，不要持续膨胀 `SKILL.md`。
