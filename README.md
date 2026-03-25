# dart_demo

A Flutter UI demo for a medical analyzer-style instrument interface.

This repository contains:

- runtime Flutter pages under `lib/src/`
- generated DSL assets under `lib/generated/`
- image references under `images/`
- prompt and architecture docs under `docs/`

## Project Layout

```text
lib/
  main.dart
  src/
    app/
      app.dart
      navigation/
      shell/
      startup_config.dart
    core/
      theme/
      widget/
    features/
      analysis/
      list_review/
      lj_qc/
      maintenance/
      print/
  generated/
    image_map.yaml
    maintenance/
    lj_qc/
    xb_qc/
    xr_qc/
    setings/
    calibration/
    menu/
    templates/
```

## Architecture

### `lib/src/app`

Application assembly layer.

- `app.dart`: app entry widget and page switching
- `navigation/`: top-level module and side-menu definitions
- `shell/`: instrument shell UI such as top bar, side bar, and bottom status bar
- `startup_config.dart`: startup configuration and screenshot/test boot parameters

### `lib/src/core/theme`

Shared design-system tokens and Flutter theme assembly.

- `palette.dart`: colors
- `typography.dart`: text styles
- `metrics.dart`: spacing and sizing
- `app_theme.dart`: `ThemeData`
- `theme.dart`: barrel export

### `lib/src/core/widget`

Shared low-level reusable widgets.

- `buttons.dart`
- `fields.dart`
- `panels.dart`
- `tables.dart`
- `widget.dart`: barrel export

### `lib/src/features`

Feature-level pages.

Current features include:

- `analysis`
- `list_review`
- `lj_qc`
- `maintenance`
- `print`

`maintenance` has been refactored to align with the DSL structure in
`lib/generated/maintenance/`, with:

- `main.dart` as the side-entry page
- `daily.dart`, `data.dart`, `version.dart`, `statistics.dart`, `log.dart`,
  `status.dart`, `engineering.dart`, `basic.dart` as side pages
- `sections.dart` as shared section rendering primitives

## DSL Assets

The repository uses Flutter Layout DSL YAML files as intermediate assets.

### Rules

- module-level groups use `<group>/main.dsl.yaml` as the group entry
- child DSL files in the same group should extend that group `main.dsl.yaml`
- `status_bar` time is not stored as a fixed string; runtime uses system time
- `lib/generated/image_map.yaml` tracks image-to-DSL mappings

Examples:

- `lib/generated/maintenance/main.dsl.yaml`
- `lib/generated/setings/main.dsl.yaml`
- `lib/generated/lj_qc/main.dsl.yaml`
- `lib/generated/xb_qc/main.dsl.yaml`
- `lib/generated/xr_qc/main.dsl.yaml`

## Development

Install Flutter dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

Run static analysis:

```bash
flutter analyze lib lib/main.dart
```

Format source files:

```bash
dart format lib/src lib/main.dart
```

## Linux Build

Build the Linux app:

```bash
flutter build linux
```

Run the built executable:

```bash
./build/linux/x64/release/bundle/dart_demo
```

## Web Build

Build the web app:

```bash
flutter build web
```

Serve locally:

```bash
cd build/web
python3 -m http.server 8080
```

## Notes

- `hiddify-app/` exists in this repository as a local reference project for
  architecture comparison. It is not part of the main Flutter app in this
  directory.
- When running analysis, prefer targeting `lib` for this project to avoid
  unrelated issues from `hiddify-app/`.
