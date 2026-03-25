# Lib Src Structure

## 目标

后续运行时代码统一放到 `lib/src/`，并按业务域组织，不再区分“手写”和“生成”。

## 推荐结构

```text
lib/src/
  app/
    app.dart
    startup_config.dart
    startup_config_io.dart
    startup_config_stub.dart
  core/
    navigation.dart
    instrument_scaffold.dart
    common_widgets.dart
  design_system/
    palette.dart
    design_system.dart
  features/
    analysis/
      analysis_page.dart
    list_review/
      list_review_page.dart
    lj_qc/
      lj_qc_page.dart
    maintenance/
      maintenance_page.dart
      maintenance_generated_base.dart
      maintenance_daily_pages.dart
    print/
      print_page.dart
```

## 规则

- 只按功能域组织目录，不按代码来源组织目录
- 页面、局部组件、状态类都优先放在对应功能域下
- 跨业务共享的能力放到 `core/`
- 设计系统放到 `design_system/`
- DSL、模板、图片索引继续留在 `lib/generated/`，它们不是运行时代码
