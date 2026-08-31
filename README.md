# jg-product-design-skills

> 产品设计与产品会议方法论 Claude plugin。覆盖产品需求、原型、评审、周例会和禅道需求。
>
> **维护者维护、git 发布、团队自动更新**。

---

## 按业务阶段选择 skill

### 1. 跟随需求阶段

#### 1.1 需求管理流程

需求管理主线包含 3 个 skill。完整执行时，`prd2prototype` 与 `prd2zentao` 之间还会经过需求自查和设计评审纪要：

| 阶段 | Skill | 处理内容 | 产出 |
|---|---|---|---|
| 需求梳理 | [`requirements2prd`](skills/requirements2prd/SKILL.md) | 把粗需求、现有模块改造或产品化问题梳理成可评审方案 | PRD 草稿、术语、数据模型、状态和待定事项 |
| 产品设计 | [`prd2prototype`](skills/prd2prototype/SKILL.md) | 根据稳定 PRD 制作 HTML 原型，评审后回写 PRD | 高保真原型、PRD 终稿、本轮迭代范围 |
| 研发需求入库 | [`prd2zentao`](skills/prd2zentao/SKILL.md) | 把 PRD 产品范围拆成研发需求并同步禅道 | 可估算、可领取的禅道研发需求 |

#### 1.2 需求自查流程

[`proto-check`](skills/proto-check/SKILL.md) 是产品评审前的检查环节。它读取 PRD 和原型，按产品设计自查表与易用性标准逐条检查，输出自查报告和整改要求。

自查发现问题后，回到 `prd2prototype` 修改原型；复查通过后再进入产品评审。

#### 1.3 设计评审纪要

[`write-design-review-memo`](skills/write-design-review-memo/SKILL.md) 跟随单个需求或版本的设计评审。评审结束后读取录音逐字稿，提炼会议共识、待办、评审结论和按需复盘。产出的备忘录用于确认设计结论，再进入 PRD 定稿和禅道需求同步。

### 2. 日常工作阶段

#### 2.1 产品部周例会主持稿与纪要

[`write-product-weekly-minutes`](skills/write-product-weekly-minutes/SKILL.md) 用于部门日常周例会，与单个需求流程分开运行。

- 会前：提供上周正式会议纪要和本周成员周报，生成会议主持稿。
- 会后：补充本周会议录音逐字稿，生成正式会议纪要。

会议制度和历史人工定稿提炼出的格式标准已经随 Skill 分发，不依赖维护者本地文件。

## 业务流程

### 1. 跟随需求阶段

```
粗需求(一句话)
    ↓ 触发 skill: requirements2prd
    │  · 需求规模定级(大模块走完整流程 / 具体功能走轻量细化)
    │  · 商业本质三问(降本/增效/合规) ← 仅大模块
    │  · 五看三定 ← 仅大模块
    │  · 苏格拉底式引导讨论
    │  · 七步法(5W / 约束 / 数据模型 / 状态机 / 视图 / PDCA / 挂起话题)
    │  · 历史债务子框架(优化场景)
    ↓
PRD 草稿 + 挂起话题 + 术语字典 + 数据模型 + 状态机
    ↓ 触发 skill: prd2prototype
    │  · 七步法(IA / 设计语言 / 共性组件 / 主线先做 / 列宽 / 原型说明分区 / 目的地)
    │  · 第 8 步:回写 PRD + 锁定本轮迭代 + 拉通设计/技术/QA
    ↓
HTML 原型 + PRD 终稿 + 本轮迭代范围 + 设计/技术/QA 确认
    ↓ 触发 skill: proto-check
    │  · 产品设计自查表(86条) + 七大易用原则量化标准原型检查版(51条)逐条判定
    │  · 产出:产品自查报告 + UI规范自查报告(纯表格) + 整改要求
    │  · 整改要求粘贴回原型会话整改 → 复查通过后进评审
    ↓
自查通过的原型(进产品评审)
    ↓ 触发 skill: write-design-review-memo
    │  · 完整读取录音文字稿
    │  · 区分现状、建议、决策、待办和结论
    │  · 输出会议共识、待办、评审结论和按需复盘
    ↓
设计评审备忘录(TXT)
    ↓ 触发 skill: prd2zentao
    │  · 确认目标产品 productID / 模块 moduleID / 来源
    │  · 按 PRD 第四章拆需求 → 字段映射 → API 批量 upsert
    │  · 模块只到二级 / needNotReview / 验证落位
    ↓
禅道研发需求(开发可领、可估、可追踪)
    ↓ 开发
代码实现
```

### 2. 日常工作阶段：产品部周例会

```text
上周正式会议纪要 + 本周成员周报
    ↓ 触发 skill: write-product-weekly-minutes
会议主持稿
    ↓ 召开周例会
本周最新主持稿 + 会议录音逐字稿
    ↓ 再次触发 skill: write-product-weekly-minutes
正式会议纪要
    ↓
下周例会继承“本周闭环”事项
```

---

## 配套工具：原型编辑器

`prd2prototype` 产出的原型里,**需求便签 / 原型说明可以由产品自己在网页上改**(不用改代码、不用找 Claude),改完自动写回原型。这个能力靠一个独立小工具「原型编辑器」——它**不随插件自动更新分发,而是下载使用**:

- **下载**:[prototype-editor.zip](https://github.com/yideng-xl/jg-product-design-skills/releases/latest/download/prototype-editor.zip)(GitHub Release 附件),或从[使用说明页](https://yideng-xl.github.io/jg-product-design-skills/#editor)点下载。
- **用法**:解压后 Mac 双击 `原型编辑器.app` / Windows 双击 `原型编辑器.vbs`(需装 [Node.js](https://nodejs.org))→ 控制页选原型 → 开「编辑态」改字 → 关页面即停。
- 只有本地用编辑器打开(localhost)才可编辑;发布到内网、或直接双击 HTML 都是**只读**,评审看不到编辑入口。

---

## 安装(团队成员一次性配置)

### 方式一:Claude Code(推荐)

```bash
cd ~/.claude/plugins/
git clone https://github.com/yideng-xl/jg-product-design-skills.git
```

Claude Code 启动时会自动扫描 `~/.claude/plugins/` 下的 plugin,识别 `plugin.json`,加载 skills。

### 方式二:Cowork mode

在 Cowork 的 plugin 管理界面里:
- 选择"从 git URL 导入" → 填仓库地址 `https://github.com/yideng-xl/jg-product-design-skills`
- 或下载压缩包后选择"本地导入"

---

## 触发(团队成员日常使用)

### 自动触发(推荐)

Claude 在看到用户消息里包含 `description` 关键词时,会自动加载对应 skill。

| 业务阶段 | 子流程 | Skill | 常见触发词 |
|---|---|---|---|
| 跟随需求阶段 | 需求管理 | `requirements2prd` | 粗需求 / 做 PRD / 产品方案 / 新模块设计 / 需求拆解 |
| 跟随需求阶段 | 需求管理 | `prd2prototype` | 做原型 / HTML 原型 / 高保真原型 / 产品评审 / 原型规范 |
| 跟随需求阶段 | 需求自查 | `proto-check` | 原型自查 / 原型走查 / 规范检查 / 易用性检查 / 整改清单 |
| 跟随需求阶段 | 设计评审纪要 | `write-design-review-memo` | 设计评审备忘录 / 设计评审会议纪要 / 逐字稿 / 产研评审 memo |
| 跟随需求阶段 | 需求管理 | `prd2zentao` | 同步禅道 / 建禅道需求 / 批量提研发需求 / 需求落禅道 |
| 日常工作阶段 | 产品部周例会 | `write-product-weekly-minutes` | 产品部周例会 / 周例会主持稿 / 周例会纪要 / 本周成员周报 |

> 用户:"老板说要做一个 X 模块,你帮我做个 PRD"
> Claude:[自动加载 skills/requirements2prd/SKILL.md,按七步法开始]

### 显式触发

```
/requirements2prd
/prd2prototype
/proto-check
/write-design-review-memo
/prd2zentao
/write-product-weekly-minutes
```

---

## 维护者发布流程

> 推荐用一键脚本 `release.sh`。它会自动堵住三类历史坑:**版本号漂移**(plugin.json 与 marketplace.json 不一致)、**空壳 tag**(tag 指向旧 commit、内容是旧的)、**漏提交**(本地改了 skill 但忘了 commit,同事更新时拉不到)。

### 一键发布(推荐)

每次有新踩坑 / 新最佳实践要沉淀进 skill:

```bash
# 1. 改 SKILL.md 内容(补踩坑案例 / 改检查清单等)
vim skills/requirements2prd/SKILL.md

# 2. 在 CHANGELOG.md 顶部写好本版本条目(脚本会强制检查,没写就拒绝发布)
#    PATCH 改文案/补案例            → 1.9.0  -> 1.9.1
#    MINOR 加检查清单条目 / 新章节    → 1.9.x  -> 1.10.0
#    MAJOR 七步法变结构 / 加删 skill  → 1.x.x  -> 2.0.0
vim CHANGELOG.md

# 3. 一条命令发布(版本号同步 + 打 tag + 推送,一气呵成)
./release.sh 1.10.0 "requirements2prd 补充 XX 场景踩坑"
```

脚本依次执行:校验版本号格式 → 确认 tag 未被占用(本地 + 远端)→ 检查 CHANGELOG 已有该版本条目 → 把 `plugin.json` / `marketplace.json` 所有 version 字段同步成新版本 → `git add -A` 列出全部改动并让你按 `y` 确认 → commit → 在该 commit 上打 tag → push 当前分支 + tag。

### 手动发布(脚本不可用时的兜底)

```bash
# 版本号四处必须一致,一个都不能落下
vim .claude-plugin/plugin.json       # "version"
vim .claude-plugin/marketplace.json  # metadata.version + plugins[0].version
vim CHANGELOG.md                     # 加新版本条目
git add -A
git commit -m "1.10.0: 一句话说明"
git tag -a v1.10.0 -m v1.10.0        # tag 必须打在含本次改动的 commit 上
git push origin main
git push origin v1.10.0
```

> ⚠️ 不要在 GitHub Releases 界面对着旧 commit 单独建 tag —— 那会产生"空壳 tag"(tag 名是新版本,内容却是旧的),Cowork 会拉到错内容。tag 一律由 `release.sh` 或上面的命令在真实 commit 上打。

### 提交规范

提交消息格式:`<version>: <一句话说明>`,例如:
- `1.9.1: 补充 X 项目的"状态机命名冲突"踩坑`
- `1.10.0: prd2prototype 增加"无障碍 a11y 检查清单"`

---

## Cowork 如何判断"有更新"(机制,实测)

**Cowork 追踪的是 git 提交(commit),不是版本号。** 这点搞清楚后,"时好时坏"就有解释了:

- 插件菜单 `⋮` 里那行 `Synced commit: xxxxxxx`,就是它当前同步到的 commit。**只要追踪分支(main)出现新 commit,它就认为有更新——与版本号是多少无关。**
- 界面显示的 `Version` 数字,读的是 `.claude-plugin/plugin.json` 的 `version` 字段(实测:曾出现 marketplace.json=1.6.0、plugin.json=1.5.0,界面显示 **1.5.0**)。所以版本号只是"给人看的标签",不参与更新判断。
- 推论:**让 Cowork 检测到更新的唯一可靠动作 = 往 main 推一个新 commit**。`release.sh` 每次都产生新 commit 并 push,所以它不只是兜底——它直接产出了 Cowork 依赖的那个触发信号,同时把 plugin.json 版本号一起升,保证界面数字也跟着变。
- **tag 不参与 Cowork 的分支同步**(tag 不会移动,而 Sync automatically 针对的是会前进的分支)。tag 仍保留,供 Claude Code 锁版本(`git checkout v1.x`)和人查阅。

> 待确认:Cowork 究竟追踪 main 分支 HEAD 还是某个 release——从现象看是分支 HEAD,但无法从本地缓存 100% 证实。验证法:推一个新 commit 但**不打 tag**,看 `Check for updates` 是否仍能检测到;能,即为追踪分支 HEAD。

---

## 团队成员更新流程

### Cowork mode(推荐)

- **开启自动同步**:插件菜单 `⋮ → Sync automatically` 打开后,维护者往 main 推新 commit,几分钟内自动拉取,**无需删除重装**。
- **手动检查**:`⋮ → Check for updates` 强制和远端比对并拉取。
  > 详情页那个 `Update` 按钮若是灰的,是因为 Cowork 缓存的同步状态还没识别到新 commit;用 `⋮ → Check for updates` 才会真正去远端比对。
- **刚 push 完没反应**:GitHub 内容接口有几分钟缓存,等 2–3 分钟再点一次 `Check for updates`。
- **兜底(极少用)**:仍拉不到时 `⋮ → Remove` 卸载,再用 `+` 重新添加 git URL 强制全新 clone。正常流程不该走到这步。

### Claude Code

```bash
cd ~/.claude/plugins/jg-product-design-skills
git fetch
git log HEAD..origin/main --oneline    # 看有什么新提交
cat CHANGELOG.md                        # 看变更说明
git pull                                # 确认后拉取
```

### 强制锁定某版本

某项目不想被新版本打扰:

```bash
cd ~/.claude/plugins/jg-product-design-skills
git checkout v1.9.0    # 锁到指定 tag
```

---

## 文件结构

```
jg-product-design-skills/
├── .claude-plugin/
│   ├── plugin.json          # 插件元信息(version 等;界面 Version 读这里)
│   └── marketplace.json     # marketplace 索引(metadata.version + plugins[].version)
├── release.sh               # 一键发布脚本(版本号同步 + 打 tag + 推送)
├── CHANGELOG.md             # 变更日志(每次升版本必更,release.sh 会强制检查)
├── README.md                # 本文件
└── skills/
    ├── requirements2prd/
    │   └── SKILL.md         # 粗需求 → PRD 方法论
    ├── prd2prototype/
    │   └── SKILL.md         # PRD → 原型 方法论
    ├── prd2zentao/
    │   ├── SKILL.md         # PRD → 禅道研发需求 方法论
    │   └── 前期操作手册.md   # 装扩展/登录禅道/确认产品 等前置步骤
    ├── proto-check/
        ├── SKILL.md         # 原型自查 → 整改要求 方法论
        └── assets/
            ├── 产品设计自查表.md        # 86 条,Z-* 编号,标注原型判定口径
            ├── 七大易用原则量化标准.md   # 原型检查版 51 条,F/T/D/C/R/E/P
            └── 易用性原则定义.md        # 七大原则定义与价值
    ├── write-design-review-memo/
    │   └── SKILL.md                    # 录音文字稿 → 设计评审备忘录
    └── write-product-weekly-minutes/
        ├── SKILL.md                    # 周报与逐字稿 → 主持稿与正式纪要
        ├── agents/openai.yaml          # Codex 展示与触发信息
        └── references/
            ├── meeting-standard.md     # 会议制度与历史定稿提炼标准
            └── template.md             # 6 章正文模板
```

---

## 来源

这些 skill 来自真实 B 端项目的复盘。原始项目复盘不随 plugin 分发(项目级敏感细节),plugin 内只保留可通用复用的方法论。

## 维护者

yideng

## License

Internal use only.
