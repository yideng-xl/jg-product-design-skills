---
name: prd2zentao
displayName: PRD到禅道需求
description: 把 PRD 第四章「产品范围」按模块拆成禅道研发需求(SR),通过禅道 API 在浏览器会话里批量创建/更新。触发场景:同步禅道 / 建禅道需求 / 把 PRD 提到禅道 / 批量提研发需求 / PRD to zentao / 需求落禅道。关键词:禅道、研发需求、SR、同步需求、批量建需求、提研发需求、zentao。配套姐妹 skill「requirements2prd」「prd2prototype」,处于工作流最后一环。
---

# PRD → 禅道研发需求 的方法论

> 来自一个真实 B 端项目的复盘沉淀。流程经实战验证(配置核查 MVP1,8 条需求一次跑通)。

---

## 何时该启用本 skill

**典型触发场景**:

- PRD 已定稿(或第四章产品范围已稳定),要把功能项录入禅道作为研发需求(SR)
- 需要批量建需求,不想一条条点表单
- PRD 迭代后要同步更新禅道里已有的需求

**不适用**:

- 只建 1~2 条需求(直接在禅道点表单更快)
- PRD 第四章还没成形(先回 requirements2prd)

---

## 心法

**这一步的本质**:把 PRD 里"已经想清楚的功能边界",一比一搬进研发的任务系统,让开发能领、能估、能追踪。

不是"把文档复制进禅道",而是:

- 让每条需求的粒度 = 一个可独立评审/排期的功能块
- 让需求的描述(spec)+ 验收标准(verify)足够开发动工,而不是只有一个标题
- 让模块归属对得上产品菜单,方便后续按模块筛选和统计

**铁律:拆需求只锚定 PRD 第四章「产品范围」。** 那一章永远按菜单/模块层级(4.1、4.2…)展开,MVP1/MVP2/MVP3 都在这章里按版本归属铺开。所以本 skill 处理的是"读第四章 → 按模块逐块映射成禅道需求",而不是记住某个具体产品有几条需求。换任何 PRD、任何 MVP 阶段都套这一套。

---

## 前置:三件必须先确认的事(不确认不准动手)

### 一、确认目标产品(productID)—— 最高优先级

**不同产品在禅道里是不同的目录,productID 不同,模块树也各自独立。建错产品是灾难性的(需求散落、要逐条删)。**

所以每次同步前,必须跟用户确认:

- 同步到哪个禅道产品?(产品名 + productID)
- productID 怎么拿:打开该产品的需求列表页,URL 里的 `productID=XX` 就是。例:`index.php?m=product&f=browse&productID=75` → productID 是 75。
- 测试 vs 正式:打通链路先用测试产品;正式同步必须二次确认是正式产品的 productID。

### 二、确认目标模块(moduleID)

- 正式产品里,模块通常已按 PRD 菜单建好,直接对应即可。
- 测试产品里可能没有,需要先建模块(见步骤 3)。
- moduleID 怎么拿:进「模块维护」(产品需求列表左下角齿轮 → 模块设置),点进目标模块,URL 里的 `currentModuleID=XX` 就是它的 moduleID。

### 三、确认「来源」字段取值

- 禅道 SR 的「来源」是必填字段,但**具体取值需要和产品经理确认**,不要擅自拍板。
- 打通链路阶段可先用默认值(`customer` / 客户沟通时提出需求),正式同步前找 PM 敲定。

---

## 七步法(主线工作流)

### 第 1 步:从 PRD 第四章拆需求清单

读 PRD 第四章「产品范围」,按子菜单/模块逐块拆。每块 = 一条需求(SR)。
- 粒度参考:一个功能模块一条(如"核查任务""核查记录")。核查策略下若有多个并列编辑器(核查项/规则/忽略),可拆成多条。
- 边界性章节(如"与 X 的边界")、信息架构章节不单独建需求,作为上下文。
- 拆完先给用户一份清单确认粒度,再往下走。

### 第 2 步:确认产品 / 模块 / 来源(见上方"前置三件事")

这一步不是走过场。productID 填错,后面全白做。

### 第 3 步:建模块(只到二级,铁律)

**模块层级只到二级,不建三级。**
- PRD 一级菜单(如"运行管理")= 禅道一级模块。
- 该菜单下的新模块(如"配置核查")= 禅道二级模块。
- PRD 里"配置核查"下的三级子菜单(核查记录/核查任务/核查策略/核查统计)**不在禅道里建成三级模块**,需求统一挂在二级模块下。
- 建模块入口:产品需求列表左下角齿轮 → 模块设置 → 点目标父模块 → 在空行填子模块名 → 保存。

> 为什么只到二级:三级模块会让需求树过深、筛选反而麻烦,团队约定到二级为止。

### 第 4 步:字段映射(PRD → 禅道 payload)

| 禅道字段 | payload key | 取值 | 必填 |
|---|---|---|---|
| 研发需求名称 | `title` | PRD 功能块标题 | 是 |
| 需求描述 | `spec` | 功能描述(支持 HTML) | 是 |
| 验收标准 | `verify` | 从 PRD 提炼的验收点 | 否(本流程要求填) |
| 优先级 | `pri` | 1/2/3/4(数字) | 否 |
| 类别 | `category` | 英文 key,见字典 | 否 |
| 来源 | `source` | 英文 key,见字典 | 是 |
| 所属模块 | `module` | 二级模块的 moduleID | 否 |
| 不需要评审 | `needNotReview` | `1` | 见避坑 |
| 所属产品 | `product` | productID | 是 |

**spec(需求描述)和 verify(验收标准)两个都要填**,不要只填描述。`相关文档`字段 API 不直接设,留空即可(它关联的是禅道内已有文档)。

### 第 5 步:用浏览器会话调 API 创建

禅道没有独立 API token 方案,但创建走的是传统 PHP 路由,认证靠**浏览器里已登录的会话 cookie**。所以做法是:在已登录禅道的标签页里,用 JS 执行 `fetch(..., {credentials:'include'})`。

端点与固定参数见下方「API 速查」。完整防御逻辑参考仓库里的现成实现:`0-方法论/禅道Axure同步插件/extension/src/zentao-client.js`(同一套客户端,本 skill 直接复用其 createStory/upsert 逻辑)。

### 第 6 步:upsert 防重复

按 title 先查后建:同名已存在则走 `m=story&f=edit` 更新,否则 `m=story&f=create` 新建。批量串行执行,逐条记录成功/失败。这样 PRD 迭代后重跑不会产生重复需求。(查找逻辑见 zentao-client.js 的 `findStoryIdByTitle`)

### 第 7 步:验证落位

建完后,导航到按模块筛选的列表页确认:
`index.php?m=product&f=browse&productID=XX&browseType=byModule&param=<moduleID>`
逐条核对:数量对不对、模块对不对、优先级对不对、评审人是否为空(needNotReview 生效)。截图给用户过一遍。

---

## 字段字典(中文选项 → 禅道英文 key)

**category(类别):**

| 中文 | key |
|---|---|
| 功能 | `feature` |
| 性能 | `performance` |
| 亮点 | `improve` |
| 其他 | `other` |
| 技术债务 | `technicalDebt` |

**source(来源,取值需 PM 确认):**

| 中文 | key |
|---|---|
| 客户沟通时提出需求 | `customer` |
| 项目团队提出的需求 | `work_com` |
| 交付现场提出的需求 | `work_pain` |
| 竞品分析挖掘的需求 | `cd_customer` |
| 行业技术规范的要求 | `cd_self` |

> 字典随禅道版本/自定义字典可能变。拿不准时去「后台 → 字段字典」核对,或先建一条看返回的 fail 信息。

---

## API 速查

**创建研发需求(POST):**

```
URL:  index.php?m=story&f=create&productID=<PID>
      &branch=all&moduleID=0&story=0&objectID=0&bugID=0&planID=0&todoID=0&storyType=story
body: product=<PID>&branch=0&module=<MID>&plan=0&title=...&pri=1&estimate=0
      &category=feature&source=customer&needNotReview=1&spec=...&verify=...&keywords=
headers: X-Requested-With: XMLHttpRequest
         Content-Type: application/x-www-form-urlencoded; charset=UTF-8
credentials: include   ← 关键,带上登录会话
```

URL 里那串 `branch=all&moduleID=0&story=0&...&storyType=story` 必须带全,缺了禅道抛 `PARAM_CODE_MISSING`。

**判定成功(HTTP 200 ≠ 业务成功):**

- 成功:`{"result":"success","message":"保存成功"}`
- 字段错:`{"result":"fail","message":{"字段名":["错误信息"]}}` —— 把 message 原样抛给用户
- 未登录:返回 HTML 登录页(不是 JSON)→ 提示用户先登录禅道

可直接执行的最小创建片段(在已登录禅道的标签页里跑):

```js
(async () => {
  const PID = 75, MID = 1004;                 // ← 改成确认过的 productID / moduleID
  const qs = new URLSearchParams({ m:'story', f:'create', productID:String(PID),
    branch:'all', moduleID:'0', story:'0', objectID:'0', bugID:'0', planID:'0', todoID:'0', storyType:'story' });
  const url = `${location.origin}/index.php?${qs}`;
  const p = { product:PID, branch:0, module:MID, plan:0, title:'示例需求', pri:1, estimate:0,
    category:'feature', source:'customer', needNotReview:1, keywords:'',
    spec:'需求描述…', verify:'验收标准…' };
  const body = new URLSearchParams(); for (const [k,v] of Object.entries(p)) body.append(k, String(v));
  const r = await fetch(url, { method:'POST', credentials:'include',
    headers:{ 'X-Requested-With':'XMLHttpRequest', 'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8' }, body });
  const t = await r.text(); let result=null, message=null;
  try { const d=JSON.parse(t); result=d.result??d.status; message=typeof d.message==='object'?JSON.stringify(d.message):d.message; } catch(e){}
  // 只回传判定字段,不要回传原始 HTML(见避坑 2)
  return JSON.stringify({ status:r.status, result, message:(message||'').slice(0,200) });
})()
```

**更新(POST):** `index.php?m=story&f=edit&storyID=<SID>`,body 同上 + `comment=<变更说明>`。
**查列表/按 title 找 id:** `index.php?m=product&f=browse&productID=<PID>&...&zin=1`,解析 zin 响应里的 stories(逻辑见 zentao-client.js)。

---

## 检查清单(每次同步逐项打勾)

### A. 前置确认
- [ ] 确认了目标产品 productID(测试 vs 正式说清楚)
- [ ] 确认了目标模块 moduleID(或已建好二级模块)
- [ ] 来源字段取值跟 PM 对齐了(或明确标注"暂用默认,待 PM 确认")

### B. 内容
- [ ] 需求清单只来自 PRD 第四章,粒度跟用户确认过
- [ ] 每条都填了 spec(需求描述)+ verify(验收标准)
- [ ] 优先级按约定分配,跟用户确认过哪几条非默认
- [ ] category 用了英文 key(不是中文)

### C. 结构
- [ ] 模块只到二级,没有建三级
- [ ] 需求都挂在正确的二级模块下

### D. 执行
- [ ] 先建 1 条试点,验证落位 + 字段正确,再批量
- [ ] needNotReview=1 已带(否则评审人必填报错)
- [ ] 批量串行,逐条记录成功/失败
- [ ] 建完按模块筛选列表,截图给用户核对

---

## 常犯的错(避坑)

### 错 1:没确认 productID 就开建
不同产品不同目录、不同模块树。建错产品 = 需求散落到别人的产品里,只能逐条删。**任何同步动作前,先把 productID 跟用户对死。**

### 错 2:JS 里回传原始 HTML,被隐私过滤拦掉
禅道响应的 HTML 里带会话/查询串,浏览器 JS 工具会判定为 "Cookie/query string data" 直接 BLOCK,你啥也看不到。**只回传 `result`/`message`/`id` 这些判定字段,绝不回传 `text.slice(...)` 原始 HTML 或带 query string 的 URL。**

### 错 3:漏了 needNotReview,被"评审人不能为空"挡住
若产品开启了需求评审,不带评审人会报 `{"reviewer":"『评审人』不能为空。"}`。对应表单上的"不需要评审"勾选 = `needNotReview:1`。批量建时统一带上(除非确实要走评审、那就传 `reviewer[]`)。

### 错 4:模块建到三级
团队约定模块只到二级。PRD 的三级子菜单不映射成三级模块,需求挂二级模块即可。

### 错 5:把 HTTP 200 当成功
禅道字段校验失败照样返回 200 + `{result:'fail'}`。必须解析 result 标志,`fail` 时把 message 原样抛出,别静默吞掉。

### 错 6:擅自定"来源"
来源是必填,但具体归类是产品经理的判断。别替 PM 拍板,标注"待确认"或用默认值并说明。

### 错 7:只填标题/只填描述
需求描述(spec)和验收标准(verify)都要填。只有标题的需求开发没法动工,只有描述没验收标准 QA 没法测。

### 错 8:不做 upsert,迭代重跑产生重复
PRD 会迭代,重跑同步如果只 create 不 upsert,会建出一堆同名需求。按 title 先查后建/改。

---

## 输出物清单

- 禅道里建好的研发需求(挂在确认过的产品 + 二级模块下)
- 一份拆分清单(标题 / 模块 / 优先级 / 来源),建前给用户确认、建后核对
- 批量执行结果(逐条成功/失败 + 失败原因)
- 建后的模块筛选列表截图(验证落位)

---

## 与上一步的衔接

```
PRD 终稿(第四章产品范围已稳定)
    ↑ 来自 skill: prd2prototype 的第 8 步回写
    ↓ 触发 skill: prd2zentao
    │  · 确认 productID / moduleID / 来源
    │  · 按第四章拆需求 → 字段映射 → API 批量 upsert
    │  · 模块只到二级、needNotReview、验证落位
    ↓
禅道研发需求(开发可领、可估、可追踪)
```

前置依赖:浏览器装好 Claude 扩展并连接、禅道已登录、确认目标产品。详见配套《前期操作手册》。
