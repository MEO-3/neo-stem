# PyQt5 Migration Plan (UI-First)

## Objectives
- Migrate from Qt 6 QML/C++ to PyQt5 Widgets for a unified Python-based development cycle.
- Preserve feature parity: 20 activities, 5-step flow, progress/badges, offline SQLite, touch UX.
- Enable later prebuilt binary distribution for resource-limited ARM devices.

## Scope and Assumptions
- UI is rewritten in PyQt5 Widgets (not QML).
- Data model, logic, and assets are preserved.
- Initial focus is UI and interaction parity before packaging work.

## Phased Plan

### Phase 0 — Project Setup
- Create a new Python application module (e.g., `neo_stem/`).
- Add PyQt5 dependency and a CLI entry point to `pyproject.toml`.
- Define new project layout: `ui/`, `backend/`, `db/`, `assets/`, `translations/`.
- Mirror existing constants into a `theme.py` (colors, typography, spacing).

### Phase 1 — App Shell and Navigation
- Build `QApplication` bootstrap and `MainWindow`.
- Implement a view manager using `QStackedWidget` or similar.
- Recreate navigation flow: Splash -> Question Selector -> Step Selector -> Activity -> Profile/Settings.
- Establish common UI primitives (TouchButton, NeoBar, NeoScore, NeoBonus).

### Phase 2 — Core Services
- Port progress storage into Python using `sqlite3` with the same schema.
- Port badge logic into a Python service with signals/slots.
- Implement audio manager using `QMediaPlayer` or `QSoundEffect`.

### Phase 3 — Activity Framework
- Create `ActivityBaseWidget` that mirrors `ActivityBase.qml`.
- Define step widget interfaces and a dynamic step loader.
- Add progress save, badge check, and star handling.

### Phase 4 — Vertical Slice (One Activity)
- Port one full activity (Q1) including all 5 steps.
- Validate touch interactions, animations, and scoring.
- Iterate on base widgets to reduce duplicate logic.

### Phase 5 — Full Activity Migration
- Migrate remaining activities in batches by similarity.
- Reuse shared step widgets and data models.
- Ensure each activity reaches feature parity with QML version.

### Phase 6 — Polish and Performance
- Add transitions/animations with `QPropertyAnimation`.
- Optimize for low-resource devices (caching, reduced effects).
- Verify localization and font usage.

### Phase 7 — Packaging and Installer
- Package with PyInstaller or Nuitka for each target platform.
- Produce prebuilt tarballs for Linux x86_64, Linux ARM64, and macOS if required.
- Provide a POSIX `install.sh` that downloads and installs the correct artifact.

## Deliverables
- PyQt5 UI application with full feature parity.
- Python backend services (progress, badges, settings, audio).
- Release artifacts for target platforms.
- One-command installer.

## Risks and Mitigations
- UI parity risk: mitigate via vertical slice and reusable components.
- Performance risk on ARM: profile early and reduce effects where needed.
- Packaging complexity: standardize build pipeline and artifact naming.
