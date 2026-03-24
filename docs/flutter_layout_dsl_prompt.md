# Flutter Layout DSL Prompt

## 目标

请分析一张 `800x600` 的医疗 UI 截图，并生成一个适合当前项目的
Flutter 页面 DSL，格式使用 YAML。

这个 DSL 是当前项目的中间格式，用于：

1. 节省 token
2. 稳定描述重复页面结构
3. 便于后续自动生成 Flutter Dart 文件
4. 支持公共模板抽取与页面差异覆盖
5. 在模板层保留可复用的设计 token

## 执行模式

当任务是“根据截图生成 DSL 文件”时，必须执行以下动作：

1. 先生成最终 YAML DSL
2. 将 DSL 内容写入目标文件
3. 如果父目录不存在，先创建目录
4. 最终回复只返回已保存的文件路径，除非用户明确要求显示 DSL 内容

如果任务只是“展示 DSL 示例”或“输出 DSL 内容”，才直接在回复中输出 YAML，
不要写文件。

## 输出要求

生成的 DSL 必须适合当前项目的 Flutter 生成流程，重点描述：

- 页面模板
- 公共 shell
- 主体 section
- 可复用颜色 token
- 可复用字号 token
- 可复用比例和关键尺寸 token
- 最终输出文件路径
- 可复用模板引用

不要输出视觉分析说明，不要输出 JSON，不要输出 Dart 代码。

## DSL 顶层结构

顶层字段优先使用：

- `extends`
- `page`
- `theme`
- `shell`
- `body`
- `actions`

其中：

- 独立页面可不写 `extends`
- 基于公共模板的页面应优先写 `extends`
- 使用 `extends` 时，只保留差异字段，不重复模板已有内容

## `extends`

用于引用公共 DSL 模板。

字段要求：

- 直接写相对路径字符串，例如
  `lib/generated/templates/maintenance_daily_base.dsl.yaml`

合并规则：

1. 顶层对象按键深度合并
2. `body.sections` 按 `id` 合并
3. 同 `id` 的 section 只覆盖差异字段
4. 未覆盖字段继承自模板

## `page`

用于标识页面和目标输出文件。

字段要求：

- `id`: 页面唯一标识，使用 snake_case，例如 `lj_qc_analyse`
- `template`: 页面模板名，例如 `qc_analyse`
- `size`: 固定写成 `800x600`
- `output`: 输出 Dart 文件路径，固定写成 `lib/generated/<id>.dart`

当页面使用 `extends` 时，`template` 和 `size` 如果与基类一致，可省略。

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

要求：

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

规则：

- `size` 使用数字
- `weight` 使用数值，例如 `400`、`500`、`600`
- 同一系列页面应优先把字号放在基础模板

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

### `side_nav`

字段：

- `selected`: 当前选中项
- `items`: 文本数组

### `status_bar`

字段：

- `left`
- `center`
- `right`
- `indicator`: 可选

## `body`

`body.sections` 是页面主体，由若干模板 section 组成。

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

规则：

- 不要枚举所有空白单元格样式
- 保留文本矩阵即可

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

当 `selected` 存在时，生成器应以 `selected` 为准渲染选中态，
而不是依赖每个按钮单独声明 `variant`。

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
3. 表格优先输出文本矩阵，不拆成大量独立 label。
4. 对重复导航项、按钮、表头，优先用数组表达。
5. 优先把颜色、字号和比例放在基础模板，不要在每个页面重复输出。
6. 不要输出任何绝对坐标、像素偏移、`x/y`。
7. 同系列页面必须先考虑抽取公共模板，再输出页面差异。

## Flutter 适配要求

生成的 DSL 必须满足：

1. 可直接映射到当前项目的 Flutter 组件模板。
2. 优先表达结构，不表达底层实现细节。
3. 页面最终应能生成到 `lib/generated/*.dart`。
4. 相同模板页面之间只保留参数差异。
5. 当页面来自同一组截图时，应优先产出一个基础模板文件。
6. 基础模板应包含该组页面复用的颜色、字号和关键比例 token。

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
extends: lib/generated/templates/maintenance_daily_base.dsl.yaml

page:
  id: maintenance_1_2
  output: lib/generated/maintenance_1_2.dart

shell:
  status_bar:
    right: 2026-03-24 17:39:51

body:
  sections:
    - id: maintenance_tabs
      selected: Clean

    - type: action_row
      id: clean_actions
      align: center
      items:
        - text: Liquid path cleaning
          variant: primary
          disabled: false
        - text: Sampling probe cleaning
          variant: primary
          disabled: false
        - text: WBC chamber cleaning
          variant: primary
          disabled: false
        - text: RBC chamber cleaning
          variant: primary
          disabled: false
```
