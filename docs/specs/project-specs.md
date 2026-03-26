# Project Specs - NEO STEM

## Overview
NEO STEM is an interactive STEM education application for Vietnamese students (grades 3-9, ages ~8-15). It delivers 20 everyday science phenomena as learning activities using a 5-step learning flow (phenomenon, questions, investigation, model, challenge). The app is touch-friendly, offline-first, and gamified with stars and badges.

## Goals and Target Users
- Audience: Vietnamese students, grades 3-9 (8-15 years old)
- Goals: hands-on STEM discovery, step-by-step inquiry learning, offline progress tracking
- Class levels: basic (grades 3-5), intermediate (grades 5-6), advanced (grades 6-9)

## Learning Model (5 Steps)
Each activity is structured as 5 steps with star scoring (1-3 per step):
1. Phenomenon: observe and explore via hotspots
2. Driving questions: create and answer sub-questions on sticky notes
3. Investigation: simulated experiment, data, conclusions
4. Model building: drag-and-drop models
5. Challenge: multiple-choice quiz

Maximum score is 300 stars (20 activities x 15 stars).

## Key Features
- 20 interactive science activities across 4 topic groups
- 3 difficulty levels aligned with grades
- Gamification: 300 stars and 29 badges
- Touch-optimized UI (48px+ controls)
- Offline progress storage with SQLite
- Multi-language support (Vietnamese default, English available)

## Technology Stack
- UI: QML (Qt Quick) running on PyQt6 6.5+
- Backend: Python 3.8+ QObject bridge classes
- Database: SQLite (sqlite3 + QStandardPaths)
- Packaging: `pyproject.toml` with console entry point `neostem`

Legacy reference (still in repo under `src/`):
- Qt 6.5+ / QML UI with C++17 backend
- CMake build system

## Architecture Summary
Entry point is `neo_stem/app.py`, which initializes a `QGuiApplication` + `QQmlApplicationEngine`, registers Python QObject backends as QML context properties, and loads `MainMenu.qml`.

QML UI layer (`neo_stem/qml/`):
- `core/`: Shared components (ActivityBase, NeoBar, NeoBonus, NeoScore, TouchButton, DragItem, DropZone, ParticleEffects, PhenomenonViewer, InvestigationBase, ModelBuilder, ProblematizeChallenge, DrivingQuestionBoard, SliderControl, ThermometerWidget, NeoAudio)
- `core/NeoConstants.qml`: Singleton with colors, typography, question data, badge definitions
- `menu/`: Navigation screens (MainMenu, QuestionSelector, StepSelector, ProfileScreen, SettingsScreen)
- `activities/`: 20 activity directories (q1_rice_cooker through q20_water_xylophone), each with main QML + 5 step files

Python backend (`neo_stem/backend/`):
- `progress_backend.py`: `ProgressTracker(QObject)` — SQLite persistence for progress, badges, DQB notes. Exposes `@pyqtSlot` methods matching the QML API. Emits `progressChanged` signal with a `revision` property so QML bindings auto-update.
- `badge_backend.py`: `BadgeSystem(QObject)` — evaluates badge criteria, delegates to ProgressTracker.

Data (`neo_stem/data/`):
- `constants.py`: 20 question definitions and 5 step names (pure Python data, also mirrored in NeoConstants.qml)

## Data Model (SQLite)
Progress is stored locally via `neo_stem/backend/progress_backend.py`.

Tables:
- `progress`: per-question step completion, stars, and optional data
- `badges`: unlocked badges with timestamps
- `dqb_state`: sticky note text/answers for driving questions

DB locations:
- Windows: `%LOCALAPPDATA%/BinhDanHocSTEM/NEO_STEM/neostem.db`
- macOS: `~/Library/Application Support/BinhDanHocSTEM/NEO_STEM/neostem.db`
- Linux: `~/.local/share/BinhDanHocSTEM/NEO_STEM/neostem.db`

## Python Entry Point
Exposed as `neostem = "neo_stem.app:main"` in `pyproject.toml`.

Run locally:
```
python -m neo_stem.app
```

## Supported Platforms and Requirements
Supported platforms:
- Linux x86_64 (Ubuntu 22.04+ / Debian 12+)
- Linux ARM64 (Armbian Bookworm / Ubuntu 22.04+)
- macOS 13+
- Windows 10+

Minimum hardware:
- Linux x86_64: 2GB RAM
- Linux ARM64: 2GB RAM
- macOS: 4GB RAM

Displays: HDMI, LCD touchscreen, X11, Wayland, or framebuffer.

## Project Layout
- `neo_stem/`: Application package
  - `app.py`: Entry point (QGuiApplication + QQmlApplicationEngine)
  - `backend/`: Python QObject bridge classes (progress, badges)
  - `db/`: Legacy SQLite module (unused, kept for reference)
  - `data/`: Activity metadata (constants.py)
  - `qml/`: QML UI files
    - `core/`: Shared components + NeoConstants singleton
    - `menu/`: Navigation screens
    - `activities/`: 20 activity directories with step QML files
- `src/`: Legacy C++/QML implementation (reference only)
- `translations/`: TS translation files

## Performance Targets
- Startup time: ~1s (macOS M1), ~3-5s (ARM 2GB)
- RAM usage: ~80-120MB (macOS), ~60-100MB (ARM)
- UI FPS: 30-60
