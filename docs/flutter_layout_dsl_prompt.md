# Flutter Layout DSL Prompt

## 目标

请分析一组 `800x600` 的医疗 UI 截图，并生成一个适合当前项目的
Flutter 页面 DSL，格式使用 YAML。

这个 DSL 是当前项目的中间格式，用于：

1. 节省 token
2. 稳定描述重复页面结构
3. 便于后续自动生成 Flutter Dart 文件
4. 支持公共模板抽取与页面差异覆盖
5. 在模板层保留可复用的设计 token
6. 用单个页面 DSL 表达同一页面的多个标签态或子状态
7. 通过全局图片索引避免重复生成

## 核心原则

优先按“逻辑页面”生成 DSL，而不是按“单张截图”生成 DSL。

例如：

- 同一左侧菜单页面下的多个顶部标签，应合并成一个 DSL 文件
- 同一页面的不同状态，应放入 `states`
- 只有结构明显独立、无法共享同一页面骨架时，才拆成多个 DSL 文件

错误示例：

- `maintenance_9_1.dsl.yaml`
- `maintenance_9_2.dsl.yaml`
- `maintenance_9_3.dsl.yaml`

推荐示例：

- `lib/generated/maintenance/basic.dsl.yaml`

其中用 `states.carryover`、`states.precision`、`states.comparability`
表达不同标签态。

## 执行模式

当任务是“根据截图生成 DSL 文件”时，必须执行以下动作：

1. 先判断截图是否属于同一逻辑页面
2. 若属于同一逻辑页面，优先合并为一个页面 DSL
3. 检查全局图片索引 `lib/generated/image_map.yaml`
4. 对已经存在于索引中的图片，不要重复生成
5. 生成最终 YAML DSL
6. 将 DSL 内容写入目标文件
7. 如果父目录不存在，先创建目录
8. 更新 `lib/generated/image_map.yaml`
9. 最终回复只返回已保存的文件路径，除非用户明确要求显示 DSL 内容

如果任务只是“展示 DSL 示例”或“输出 DSL 内容”，才直接在回复中输出 YAML，
不要写文件。

## 输出要求

生成的 DSL 必须适合当前项目的 Flutter 生成流程，重点描述：

- 页面模板
- 公共 shell
- 主体 section
- 页面内多个状态
- 可复用颜色 token
- 可复用字号 token
- 可复用比例和关键尺寸 token
- 最终输出文件路径
- 可复用模板引用
- 来源图片映射

不要输出视觉分析说明，不要输出 JSON，不要输出 Dart 代码。

## DSL 顶层结构

顶层字段优先使用：

- `extends`
- `source`
- `page`
- `theme`
- `shell`
- `body`
- `states`
- `actions`

其中：

- 独立页面可不写 `extends`
- 基于公共模板的页面应优先写 `extends`
- `Menu` 体系页面优先继承 `lib/generated/templates/menu_shell_base.dsl.yaml`
- 使用 `extends` 时，只保留差异字段，不重复模板已有内容
- 同一页面的多个标签态或子状态，应优先放进 `states`
- 页面级 DSL 应尽量包含 `source`

## `extends`

用于引用公共 DSL 模板。

字段要求：

- 直接写相对路径字符串，例如
  `lib/generated/templates/maintenance_shell_base.dsl.yaml`

合并规则：

1. 顶层对象按键深度合并
2. `body.sections` 按 `id` 合并
3. `states.<name>.body.sections` 也按 `id` 合并
4. 同 `id` 的 section 只覆盖差异字段
5. 未覆盖字段继承自模板

## `source`

用于记录页面 DSL 与原始图片之间的映射，方便查重和追踪。

页面级字段：

- `images`: 图片路径数组
- `grouping`: 页面分组名，例如 `daily`、`basic`

状态级字段：

- `states.<name>.source.image`: 单张状态图路径

规则：

- 图片路径统一使用仓库相对路径，例如
  `images/Maintenance/Maintenance_9_1.png`
- 页面级 `source.images` 应覆盖该 DSL 涉及的所有图片
- 如果某个状态对应具体截图，应补充 `states.<name>.source.image`
- `source` 信息必须同步写入全局索引 `lib/generated/image_map.yaml`

## 全局索引

项目级图片映射文件固定为：

- `lib/generated/image_map.yaml`

用途：

- 记录图片与 DSL 的对应关系
- 记录图片命中的是哪个 state
- 用于下一次生成前做查重

格式要求：

```yaml
images:
  images/Maintenance/Maintenance_9_1.png:
    dsl: lib/generated/maintenance/basic.dsl.yaml
    state: carryover
```

规则：

1. 每张已处理图片都必须写入索引
2. `dsl` 使用仓库相对路径
3. 若命中某个状态，补充 `state`
4. 生成前先查索引，生成后立即更新索引

## `page`

用于标识页面和目标输出文件。

字段要求：

- `id`: 页面唯一标识，使用 snake_case，例如 `maintenance_basic`
- `template`: 页面模板名，例如 `maintenance_panel`
- `size`: 固定写成 `800x600`
- `output`: 输出 Dart 文件路径，固定写成 `lib/generated/<id>.dart`

建议：

- 页面 DSL 本身优先保存到 `lib/generated/<domain>/...dsl.yaml`
- 不要再按截图编号作为长期文件名，除非只是临时识别阶段

## `theme`

`theme` 用于描述生成 Flutter 代码需要的最小设计 token。

字段只允许：

- `variant`
- `tokens`
- `typography`
- `metrics`

### `theme.tokens`

用于颜色 token。

如果输出 `tokens`，只允许以下键：

- `bg`
- `topBar`
- `sideBar`
- `panel`
- `header`
- `text`
- `textOnDark`
- `accent`
- `border`

规则：

- 颜色统一使用十六进制字符串，例如 `#2F6F9E`
- 不要输出相近重复色
- 优先把颜色放在基础模板，不要在每个页面重复输出

### `theme.typography`

用于可复用字号和字重 token。

推荐键：

- `nav`
- `sideNav`
- `sectionTitle`
- `button`
- `tableHeader`
- `tableCell`
- `status`

每个字体 token 只允许：

- `size`
- `weight`

### `theme.metrics`

用于比例和关键尺寸 token。

字段只允许：

- `ratios`
- `sizes`

`ratios` 推荐键：

- `topBar`
- `content`
- `bottomBar`
- `sideNav`
- `mainPanel`

`sizes` 推荐键：

- `subTabHeight`
- `actionButtonWidth`
- `actionButtonHeight`
- `cornerRadius`
- `borderWidth`

规则：

- 只保留会影响页面复用的关键比例和尺寸
- 不要退化成逐像素描述

## `shell`

描述项目的公共外壳。

字段只允许：

- `top_nav`
- `side_nav`
- `status_bar`

### `top_nav`

字段：

- `selected`: 当前选中模块
- `items`: 可选，导航项数组

`items` 推荐写成对象数组，而不是纯文本数组，例如：

```yaml
items:
  - text: Analysis
    target: {module: analysis, page: analysis_main}
  - text: L-J QC
    target: {module: lj_qc, page: lj_qc_main, state: settings}
```

### `side_nav`

字段：

- `selected`: 当前选中项
- `items`: 导航项数组

`side_nav.items` 优先写成对象数组，每项至少包含：

- `text`
- `target`

### `status_bar`

字段：

- `left`
- `center`
- `right`
- `indicator`: 可选

## `target`

`target` 用于显式表达 DSL 中的跳转或动作，避免后续生成 Dart 时只能靠
`selected`、文本匹配或页面命名去猜。

字段只允许：

- `module`: 顶部模块跳转目标，例如 `analysis`、`lj_qc`
- `page`: 逻辑页面 id，例如 `maintenance_daily`
- `state`: 页面内部状态 id，例如 `replace_reagents`、`graph`
- `action`: 非页面跳转动作，例如 `save`、`delete`、`close_dialog`

规则：

1. 顶部导航优先写 `module + page`
2. 左侧菜单优先写 `page`，同页多标签时补 `state`
3. 同页标签切换优先写 `state`
4. 纯命令按钮不写页面跳转时，写 `action`
5. 不要混用多个语义冲突的目标

## `body`

`body.sections` 是页面默认主体，由若干模板 section 组成。

每个 section 只允许使用：

- `type`
- `id`
- `title`
- `columns`
- `rows`
- `fields`
- `groups`
- `items`
- `align`
- `variant`
- `zebra`
- `dense`
- `selected`

其中交互型 `items` 优先写成对象数组，每项可包含：

- `text`
- `variant`
- `disabled`
- `target`

## `states`

用于描述同一页面的不同标签态、模式态或子页面状态。

字段要求：

- `states` 的键使用 snake_case，例如 `carryover`、`precision`
- 每个 state 只保留与默认页面不同的内容
- 允许的子字段：
  - `source`
  - `status_bar`
  - `body`
  - `actions`

适用场景：

- 顶部 tab 切换
- 同一表格页的不同模式
- 同一页面内的多步状态

不适用场景：

- 左侧菜单完全不同
- 页面骨架完全不同

## 支持的 section 类型

只允许以下类型：

- `form_grid`
- `triplet_table`
- `matrix_table`
- `chart_row`
- `stats_panel`
- `action_row`
- `info_bar`

### `form_grid`

用于顶部表单区域。

字段：

- `columns`: 列数
- `rows`: 二维字段 id 数组
- `fields`: 字段字典

字段定义只允许：

- `label`
- `value`
- `control`: `input | select | readonly`
- `placeholder`: 可选

### `triplet_table`

用于 `L-J QC`、`Analysis` 这类三组并列表格。

字段：

- `groups`: 表头二维数组
- `rows`: 数据二维数组
- `zebra`: 布尔值
- `dense`: 布尔值

### `matrix_table`

用于普通矩阵表格。

字段：

- `title`: 可选
- `groups`: 表头二维数组
- `rows`: 数据二维数组
- `zebra`: 布尔值
- `dense`: 布尔值

### `chart_row`

用于图表并排区域。

字段：

- `items`: 图表数组

每个图表项只允许：

- `title`
- `kind`: 固定为 `histogram`
- `x_axis`
- `y_axis`: 布尔值

### `action_row`

用于标签组或按钮组。

字段：

- `title`: 可选
- `align`: `start | center | end`
- `items`: 按钮数组
- `selected`: 可选，表示当前选中的按钮文本

按钮只允许：

- `text`
- `variant`: `primary | secondary | muted`
- `disabled`: 布尔值

### `info_bar`

用于简单的说明、状态或只读信息行。

字段：

- `title`: 可选
- `items`: 文本数组

## `actions`

用于底部页面动作。

结构：

- `bottom.align`
- `bottom.items`

每个按钮只允许：

- `text`
- `variant`: `primary | secondary | muted`
- `disabled`: 布尔值

## 压缩规则

为节省 token，必须遵守：

1. 不重复描述公共 top bar、side bar、status bar 的具体样式。
2. 优先通过 `extends` 复用重复页面结构。
3. 优先按页面合并，不要按截图长期拆分。
4. 同一页面的多标签态优先使用 `states`。
5. 表格优先输出文本矩阵，不拆成大量独立 label。
6. 对重复导航项、按钮、表头，优先用数组表达。
7. 优先把颜色、字号和比例放在基础模板，不要在每个页面重复输出。
8. 不要输出任何绝对坐标、像素偏移、`x/y`。
9. 所有已处理图片都必须写入全局索引。

## Flutter 适配要求

生成的 DSL 必须满足：

1. 可直接映射到当前项目的 Flutter 组件模板。
2. 优先表达结构，不表达底层实现细节。
3. 页面最终应能生成到 `lib/generated/*.dart`。
4. 相同页面的不同状态应保留在同一 DSL 中。
5. 基础模板应包含该组页面复用的颜色、字号和关键比例 token。
6. 图片与 DSL 的对应关系应可通过 `lib/generated/image_map.yaml` 反查。

## 推荐模板

当前项目优先使用以下模板名：

- `qc_settings`
- `qc_analyse`
- `qc_graph`
- `qc_list`
- `analysis_main`
- `list_review`
- `maintenance_panel`

## 推荐输出示例

```yaml
extends: lib/generated/templates/maintenance_shell_base.dsl.yaml

source:
  images:
    - images/Maintenance/Maintenance_9_1.png
    - images/Maintenance/Maintenance_9_2.png
    - images/Maintenance/Maintenance_9_3.png
  grouping: basic

page:
  id: maintenance_basic
  output: lib/generated/maintenance_basic.dart

shell:
  side_nav:
    selected: Basic

body:
  sections:
    - type: action_row
      id: basic_tabs
      selected: Carryover
      items:
        - text: Carryover
          variant: secondary
          disabled: false
        - text: Precision
          variant: secondary
          disabled: false
        - text: Comparability
          variant: secondary
          disabled: false
        - text: Accuracy
          variant: secondary
          disabled: false
        - text: Linear
          variant: secondary
          disabled: false

states:
  carryover:
    source:
      image: images/Maintenance/Maintenance_9_1.png
    status_bar:
      right: 2026-03-18 16:42:34
    body:
      sections:
        - id: basic_tabs
          selected: Carryover
        - type: matrix_table
          id: carryover_table
          groups:
            - [Item, WBC, RBC, HGB, PLT, HCT]
          rows:
            - [H1, "", "", "", "", ""]
```
