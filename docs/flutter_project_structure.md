# Flutter项目工程目录规范文档

这是一份针对中大型项目、支持**多语言**、**多主题设计系统**以及**底层 C++/硬件交互**的 Flutter 项目标准目录结构技术文档。

## 1. 设计哲学

本工程采用 **功能优先 (Feature-first)** 结合 **洁净架构 (Clean Architecture)** 的设计思想。

- **高内聚**：每个功能模块（Feature）自成体系，包含其 UI、逻辑与数据处理。
- **低耦合**：核心基础设施（主题、多语言、网络封装）与业务逻辑分离。
- **可扩展**：支持通过 Dart FFI 调用底层 C/C++ 库，适配高性能计算或硬件驱动场景。

## 2. 核心目录结构

```text
.
├── lib/
│   ├── main.dart                  # 应用入口，负责初始化环境（Firebase, Window Size等）
│   ├── src/
│   │   ├── app.dart               # MaterialApp 配置，集成路由、主题与多语言
│   │   ├── core/                  # 【核心层】全局共享的非业务逻辑
│   │   │   ├── theme/             # 设计系统 (Design System)
│   │   │   │   ├── tokens/        # 【第一层：设计令牌】最基础的定义
│   │   │   │   │   ├── app_colors.dart         # 原始色板（如 Blue50, Grey900）
│   │   │   │   │   ├── app_spacing.dart        # 间距系统（如 xs: 4, s: 8, m: 16）
│   │   │   │   │   ├── app_sizes.dart          # 针对 800x600 屏幕的组件尺寸定义
│   │   │   │   │   └── app_typography.dart     # 基础字体粗细、大小预设
│   │   │   │   ├── extensions/    # 【第二层：主题扩展】处理 Material 未涵盖的属性
│   │   │   │   │   └── custom_colors.dart      # 例如：硬件状态色（Normal/Warning/Critical）
│   │   │   │   ├── data/          # 【第三层：具体主题实现】
│   │   │   │   │   ├── light_theme.dart        # 浅色模式配置
│   │   │   │   │   ├── dark_theme.dart         # 深色模式配置
│   │   │   │   │   └── high_contrast_theme.dart # (可选) 工业场景常用的高对比度模式
│   │   │   │   └── design_system.dart # 【第四层：统一出口】单例或静态聚合类
│   │   │   ├── localization/      # 多语言中心 (*.arb 文件及生成代码)
│   │   │   ├── network/           # 网络请求封装 (Dio 拦截器、错误处理)
│   │   │   └── utils/             # 通用工具（校验、转换、日志）
│   │   ├── features/              # 【业务层】按功能模块划分
│   │   │   ├── dashboard/         # 示例：仪表盘模块
│   │   │   │   ├── data/          # 数据源 (API/Local) 与 Repository 实现
│   │   │   │   ├── domain/        # 业务实体 (Entity) 与 抽象接口
│   │   │   │   └── presentation/  # UI 界面、小组件及状态管理 (Controller)
│   │   │   └── settings/          # 示例：设置模块
│   │   ├── shared/                # 【共享层】跨模块复用的 UI 组件
│   │   │   └── widgets/           # 自定义按钮、卡片、加载动画等
│   │   └── native/                # 【底层桥接】Dart FFI 接口定义
│   ├── assets/                    # 静态资源
│   │   ├── images/                # 图片、图标
│   │   ├── fonts/                 # 字体文件
│   │   └── lang/                  # (可选) 若不使用 arb，存放 json 语言包
│   └── test/                      # 测试目录
├── native_src/                    # C/C++ 源代码目录 (独立于 Flutter 逻辑)
└── pubspec.yaml                   # 依赖管理
```

## 3. 关键模块定义详解

### 3.1 基础设施：设计系统 (`core/theme/`)

为了适配特定硬件（如 800x600 屏幕）并保持视觉一致性：

- **Tokens**: 定义最小单位。例如 `AppSpacing.md = 16.0`。
- **Theme Extensions**: 解决 Material Theme 字段不足的问题。
  > *应用场景：在工业控制界面中，定义 `sensorSafe`, `sensorWarning` 等语义化颜色。*

### 3.2 国际化：多语言 (`core/localization/`)

- 使用官方 `flutter_gen` 方案。
- 所有字符串必须提取至 `.arb` 文件，严禁在 UI 代码中硬编码中文或英文。

### 3.3 业务逻辑：功能划分 (`features/`)

每个功能遵循 **数据-领域-表现** 三层架构：

1. **Presentation**: 仅负责渲染。通过 `Provider/Riverpod` 监听状态变化。
2. **Domain**: 定义业务逻辑。例如：判断 ADC 采样值是否越界。
3. **Data**: 负责数据获取。无论是通过 `Dio` 访问后端 API，还是通过 `FFI` 从 C++ 层获取原生数据。

### 3.4 原生交互 (`native/` & `native_src/`)

- `native_src/`: 存放高性能 C/C++ 算法、驱动接口。
- `lib/src/native/`: 存放 Dart 侧的 `DynamicLibrary` 加载逻辑与
  `lookup` 封装。

## 4. 开发规范建议

1. **路径引用**：统一使用 Package 绝对路径引用（如
   `import 'package:my_app/src/core/...'`），避免相对路径 `../../`
   导致的重构困难。
2. **响应式布局**：由于目标设备屏幕固定（800x600），在 `core/theme/tokens` 中应定义一套基于该分辨率的尺寸基准，确保 UI 不会溢出。
3. **状态隔离**：UI 组件尽量设计为无状态（Stateless），逻辑交由对应的 Controller 或 Provider 处理。

---

**这份文档是否符合您的工程需求？如果需要，我可以为您补充 `ThemeExtension` 或 `FFI` 调用的具体代码模板作为附录。**
