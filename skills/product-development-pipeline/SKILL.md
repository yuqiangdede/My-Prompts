---
name: software-design-pipeline
description: 当用户希望把模糊的 B 端或行业系统需求从问题定义一路推进到可冻结的方案、模块、数据/状态、异常、PRD、页面规格，并最终选择 UI Prompt 或可运行原型时使用。该 Skill 是总控编排器，优先复用“需求 设计 实现”目录中的独立能力 Skill，并通过 Gate 控制推进。
---

# Software Design Pipeline

## 定位

本 Skill 是 **Orchestrator / 总控**，不是另一个巨型需求 Prompt。

- 单独处理某一阶段：直接调用 `../需求 设计 实现/` 中对应能力 Skill。
- 从模糊需求完整推进：使用本流水线。
- 内部 `steps/` 主要保存阶段契约和 Gate，不重复维护能力 Skill 的全部方法论。

## 能力映射

- 需求澄清 → `requirement-clarification`
- 需求分析 → `requirement-analysis`
- 产品/业务方案 → `solution-design`
- PRD → `prd-writing`
- 独立需求评审 → `requirement-review`
- 从零可运行原型 → `prototype-greenfield`
- 已有项目原型 → `prototype-existing-project`
- 版本结束后的复盘/知识沉淀不属于本设计阶段主链路，分别使用 `version-retrospective`、`project-knowledge-capture`

## 主流程

每次只推进一个阶段；用户已明确提供并确认的上游产物可直接验收后复用，不机械重复提问。

1. `steps/01 问题澄清与反问.md`：调用需求澄清能力，冻结问题边界。
2. `steps/02 问题拆解.md`：调用需求分析能力，形成问题、目标、范围、对象和成功标准。
3. `steps/03 需求风险扫描.md`：Gate ①，扫描方向性风险；失败则回退 01/02。
4. `steps/04 决策与方案对比.md`：调用方案设计能力，形成推荐方案、模块、对象、主流程、状态和权限框架。
5. `steps/05 模块边界审计.md`：Gate ②-A，模块结构未站稳不得冻结。
6. `steps/06 数据模型与状态校验.md` + `steps/07 关键流程异常枚举.md`：Gate ②-B，先状态后异常；失败则回退 04/05/06。
7. `steps/08 PRD与页面规格.md`：先调用 `prd-writing` 形成研发规格，再调用 `requirement-review` 做独立评审；通过后只把已确认业务设计投影成页面规格，不重新做 01–07。
8. `steps/09 页面-流程-权限一致性校验.md`：Gate ③，检查页面、流程、状态、角色和权限是否一致。
9. `steps/10 输出路由.md`：根据用户目标选择 UI Prompt、从零可运行原型、已有项目原型或仅输出文档。

## Gate 状态

统一使用：

- `PASS`：可以进入下一阶段。
- `CONDITIONAL PASS`：存在明确待办，但不改变主方向；记录关闭条件后可继续。
- `FAIL`：存在阻断项，只能回退到指定阶段。

## 强制规则

- 不得把推测写成业务事实。
- 不得重复询问用户已经明确的信息。
- Gate 失败不得靠“默认假设”强行通过。
- 先稳定核心对象和状态，再枚举异常。
- PRD 负责写，独立评审负责审；作者不能自行宣布 GO。
- Step 08 禁止重新执行需求澄清、需求分析、模块设计和流程设计。
- Gate ③ 未通过，禁止进入 UI/原型输出。
- 最后一步不默认生图：由用户目标决定输出到 UI Prompt、Greenfield 原型、Existing Project 原型或文档。

## 中间产物契约

每阶段至少保留：

- 已确认事实。
- 当前结论。
- 待确认/待验证项。
- Gate 状态。
- 下一阶段可直接读取的结构化产物。

## 最终可能产物

- 需求分析与范围。
- 方案决策与模块/对象/状态/流程设计。
- PRD 与独立评审结论。
- 页面规格与一致性 Gate 结果。
- UI Prompt，或可运行的 HTML/React/Vue 原型，或仅文档交付。
