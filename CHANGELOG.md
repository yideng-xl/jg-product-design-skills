# Changelog

本 plugin 所有版本变更记录。格式遵循 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/),版本号遵循 [SemVer 2.0.0](https://semver.org/lang/zh-CN/)。

---

## [1.1.2] - 2026-05-15

### 新增
- **`.claude-plugin/marketplace.json`** —— 让本仓库同时成为 Claude plugin marketplace
- 现在团队成员可以通过 **Cowork → Plugins → Personal → + → Add marketplace** 直接填 git URL `https://github.com/yideng-xl/jg-product-design-skills` 安装,**无需手动下载 zip + 上传**
- 仓库现在是"既是 marketplace 又是 plugin"的紧凑形态:marketplace.json 里 `source: "./"` 把当前仓库本身作为唯一的 plugin

### 影响
- 团队成员升级 plugin 不需要再下载 zip,直接在 Cowork 里 sync marketplace 即可拉到最新版
- 维护者发布流程不变(改 → 升版本 → push git → 团队 sync)

---

## [1.1.1] - 2026-05-15

### 修复(plugin 格式合规)
- `plugin.json` 移到 `.claude-plugin/` 目录下(此前在根目录导致 Cowork 上传时 "Plugin validation failed")
- 精简 `plugin.json` 字段,只保留 Claude 官方 plugin manifest 标准字段:name / version / description / author / homepage / repository / license / keywords
- 移除非标准的 `skills` / `displayName` / `bugs` / `changelog` 字段(skills 由 `skills/<name>/SKILL.md` 自动发现,无需在 manifest 里声明)
- License 从 "Internal" 改为 "MIT"(plugin 是公开仓库,跟 GitHub 仓库 license 对齐)

---

## [1.1.0] - 2026-05-15

### `requirements2prd` 新增章节
- **工作纪律(挨个过确认点 + 苏格拉底式引导)** —— 强调主动引导对面深入思考,逐项 AskUserQuestion 明确达成共识,不许默默推进
- **0 号问题:商业本质三问(降本/增效/合规)** —— 必答,作为需求是否该做的底线判断
- **战略视角:五看三定** —— 看用户/现状/法规/竞品/自己 + 定目标/边界/打法
- **历史债务/模块优化 子框架** —— 适配重构场景:现状盘点 + 痛点矩阵 + 改造路径选择(渐进/平行/整体) + 兼容性策略 + 显式废弃声明
- 检查清单升级为"逐项确认"形式,加 A-I 共 9 类

### `prd2prototype` 新增章节
- **第 8 步:回写 PRD + 锁定本轮迭代范围** —— 工作流的关键收尾
  - 8.1 把原型里的"新决策"回填进 PRD
  - 8.2 定义本轮迭代范围(本轮包含 / 本轮不包含 / 显式列出)
  - 8.3 找设计 / 技术 / 运维 / QA 确认(产品经理是迭代 owner 主动驱动)
- 检查清单加 G 类(评审后的回写)
- 输出物清单加回写后的 PRD 终稿 + 迭代范围定义 + 各方确认记录

### 通用化合规
- 全面去除特定行业术语(包括但不限于"厂站"等领域属性词),确保 plugin 内容跨行业可复用

### 升级原因
团队对 plugin 实战使用提出 7 个改进点,本版本一次性吸收(版本号 MINOR 升级,无 breaking changes)。

---

## [1.0.0] - 2026-05-15

### 新增
- 初始版本,包含两个 skill:
  - **`requirements2prd`(粗需求到PRD)** —— 七步法 + 检查清单 + 5 类常犯错
  - **`prd2prototype`(PRD到原型)** —— 七步法 + 6 类检查清单 + 原型规范实战版 + 8 类常犯错
- plugin.json 元信息
- README 安装/触发/分发指南

### 来源
- 基于一个真实 B 端项目的完整复盘
- 累计沉淀 8 类犯错改进点 + 6 类对的做法

---

## 后续版本预期

每次在新模块上跑完一轮:

- **PATCH(1.0.x)**:补充踩坑案例、修改文案、修正笔误。skill 内容不变结构
- **MINOR(1.x.0)**:新增检查清单条目、新增"常犯的错"章节、引入新的设计规范
- **MAJOR(x.0.0)**:七步法步骤调整、引入新的 skill、删除已废弃的方法

升级版本号 → 更新本 CHANGELOG → push git → 团队 Claude 检测到新版本会提示用户更新。
