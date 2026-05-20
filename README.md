# jg-product-design-skills

> 产品设计方法论 Claude plugin。从粗需求到 PRD、从 PRD 到高保真原型的完整工作流。
>
> **维护者维护、git 发布、团队自动更新**。

---

## 包含的 skill

| Skill name | displayName | 触发场景 | 文件 |
|---|---|---|---|
| `requirements2prd` | 粗需求到PRD | 用户给一句话粗需求,需要做成可评审的 PRD | [skills/requirements2prd/SKILL.md](skills/requirements2prd/SKILL.md) |
| `prd2prototype` | PRD到原型 | 有了 PRD,需要做 HTML 原型用于产品评审 | [skills/prd2prototype/SKILL.md](skills/prd2prototype/SKILL.md) |
| `prd2zentao` | PRD到禅道需求 | PRD 定稿后,把第四章产品范围批量同步成禅道研发需求 | [skills/prd2zentao/SKILL.md](skills/prd2zentao/SKILL.md) |

## 工作流(完整闭环)

```
粗需求(一句话)
    ↓ 触发 skill: requirements2prd
    │  · 商业本质三问(降本/增效/合规)
    │  · 五看三定
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

> 用户:"老板说要做一个 X 模块,你帮我做个 PRD"
> Claude:[自动加载 skills/requirements2prd/SKILL.md,按七步法开始]

### 显式触发

```
/requirements2prd
/prd2prototype
```

---

## 维护者发布流程

每次有新错例 / 新踩坑 / 新最佳实践要沉淀进 skill:

```bash
# 1. 改 SKILL.md 内容(补踩坑案例 / 改检查清单等)
vim skills/requirements2prd/SKILL.md

# 2. 升 version 号(plugin.json + CHANGELOG.md 都要改)
#    PATCH 改文案/补案例 → 1.0.0 -> 1.0.1
#    MINOR 加新检查清单条目 / 新章节 → 1.0.x -> 1.1.0
#    MAJOR 七步法变结构 / 加新 skill / 删旧方法 → 1.x.x -> 2.0.0
vim plugin.json    # 改 "version"
vim CHANGELOG.md   # 加新版本条目

# 3. 提交并打 tag
git add .
git commit -m "1.0.1: 补充 XX 场景踩坑案例"
git tag v1.0.1
git push && git push --tags
```

### 提交规范

提交消息格式:`<version>: <一句话说明>`

例如:
- `1.0.1: 补充 X 项目的"状态机命名冲突"踩坑`
- `1.1.0: prd2prototype 增加"无障碍 a11y 检查清单"`

---

## 团队成员更新流程

### 自动检测(Claude 提示)

Claude 启动时会比对本地 plugin.json 的 version 和远程仓库的最新 release。**发现新版本会提示**:

> "jg-product-design-skills 有新版本可用:1.0.0 → 1.0.1。是否查看变更日志并更新?"

### 手动检测

```bash
cd ~/.claude/plugins/jg-product-design-skills
git fetch
git log HEAD..origin/main --oneline    # 看有什么新提交
cat CHANGELOG.md                        # 看变更说明
git pull                                # 确认更新后拉取
```

### 强制锁定某版本

如果团队成员当前项目不想被新版本打扰:

```bash
cd ~/.claude/plugins/jg-product-design-skills
git checkout v1.0.0    # 锁到指定 tag
```

---

## 文件结构

```
jg-product-design-skills/
├── plugin.json              # 元信息 + skills 索引
├── CHANGELOG.md             # 变更日志(每次升版本必更)
├── README.md                # 本文件
└── skills/
    ├── requirements2prd/
    │   └── SKILL.md         # 粗需求 → PRD 方法论
    ├── prd2prototype/
    │   └── SKILL.md         # PRD → 原型 方法论
    └── prd2zentao/
        ├── SKILL.md         # PRD → 禅道研发需求 方法论
        └── 前期操作手册.md   # 装扩展/登录禅道/确认产品 等前置步骤
```

---

## 来源

两个 skill 来自一个真实 B 端项目的完整复盘。原始项目复盘不随 plugin 分发(项目级敏感细节),plugin 内只保留可通用复用的方法论。

## 维护者

yideng

## License

Internal use only.
