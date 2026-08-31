# jg-product-design-skills

> 产品设计与产品会议方法论 Claude plugin。覆盖产品需求、原型、评审、周例会和禅道需求。
>
> **维护者维护、git 发布、团队自动更新**。

---

## 包含的 skill

| Skill name | displayName | 触发场景 | 文件 |
|---|---|---|---|
| `requirements2prd` | 粗需求到PRD | 用户给一句话粗需求,需要做成可评审的 PRD | [skills/requirements2prd/SKILL.md](skills/requirements2prd/SKILL.md) |
| `prd2prototype` | PRD到原型 | 有了 PRD,需要做 HTML 原型用于产品评审 | [skills/prd2prototype/SKILL.md](skills/prd2prototype/SKILL.md) |
| `prd2zentao` | PRD到禅道需求 | PRD 定稿后,把第四章产品范围批量同步成禅道研发需求 | [skills/prd2zentao/SKILL.md](skills/prd2zentao/SKILL.md) |
| `proto-check` | 原型自查 | 原型产出后、评审前,按自查表+UI规范逐条自查,出报告和整改要求 | [skills/proto-check/SKILL.md](skills/proto-check/SKILL.md) |
| `write-design-review-memo` | 设计评审备忘录 | 设计评审结束后,把录音文字稿整理成可上传的评审备忘录 | [skills/write-design-review-memo/SKILL.md](skills/write-design-review-memo/SKILL.md) |
| `write-product-weekly-minutes` | 产品部周例会主持稿与纪要 | 根据上周纪要和本周周报准备主持稿,再根据会议逐字稿形成正式纪要 | [skills/write-product-weekly-minutes/SKILL.md](skills/write-product-weekly-minutes/SKILL.md) |

`write-product-weekly-minutes` 分两次使用：会前提供上周正式会议纪要和本周成员周报，先生成会议主持稿；会后补充录音逐字稿，再整理正式纪要。会议制度和历史人工定稿提炼出的格式标准已经随 Skill 一起分发，不依赖维护者本地文件。

## 原型编辑器(下载 · 产品自己改需求标签)

`prd2prototype` 产出的原型里,**需求便签 / 原型说明可以由产品自己在网页上改**(不用改代码、不用找 Claude),改完自动写回原型。这个能力靠一个独立小工具「原型编辑器」——它**不随插件自动更新分发,而是下载使用**:

- **下载**:[prototype-editor.zip](https://github.com/yideng-xl/jg-product-design-skills/releases/latest/download/prototype-editor.zip)(GitHub Release 附件),或从[使用说明页](https://yideng-xl.github.io/jg-product-design-skills/#editor)点下载。
- **用法**:解压后 Mac 双击 `原型编辑器.app` / Windows 双击 `原型编辑器.vbs`(需装 [Node.js](https://nodejs.org))→ 控制页选原型 → 开「编辑态」改字 → 关页面即停。
- 只有本地用编辑器打开(localhost)才可编辑;发布到内网、或直接双击 HTML 都是**只读**,评审看不到编辑入口。

---

## 工作流(完整闭环)

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
    │  · 产品设计自查表(67条) + 七大易用原则量化标准(75条)逐条判定
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

Claude 在看到用户消息里包含 `description` 关键词时,会自动加载对应 skill:

- **`requirements2prd` 的关键词**:粗需求 / 做 PRD / 产品方案 / 新模块设计 / 需求拆解 / 产品需求文档 / requirements / PRD
- **`prd2prototype` 的关键词**:做原型 / HTML 原型 / 高保真原型 / 产品评审 / 原型规范 / prototype / mockup
- **`prd2zentao` 的关键词**:同步禅道 / 建禅道需求 / 把 PRD 提到禅道 / 批量提研发需求 / 需求落禅道 / zentao
- **`write-design-review-memo` 的关键词**:设计评审备忘录 / 设计评审会议纪要 / 录音文字稿 / 逐字稿 / 产研评审 memo
- **`write-product-weekly-minutes` 的关键词**:产品部周例会 / 周例会主持稿 / 周例会纪要 / 上周会议纪要 / 本周成员周报

> 用户:"老板说要做一个 X 模块,你帮我做个 PRD"
> Claude:[自动加载 skills/requirements2prd/SKILL.md,按七步法开始]

### 显式触发

```
/requirements2prd
/prd2prototype
/write-design-review-memo
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
            ├── 产品设计自查表.md        # 67 条,Z-* 编号,标注原型判定口径
            ├── 七大易用原则量化标准.md   # 75 条,F/T/D/C/R/E/P,标注判定方式
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
