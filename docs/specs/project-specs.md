# Project Specs - NEO STEM

## Overview
NEO STEM is an interactive STEM education application for Vietnamese students (grades 3-9, ages ~8-15). It delivers 20 everyday science phenomena as learning activities using a 5-step learning flow (phenomenon, questions, investigation, model, challenge). The app is touch-friendly, offline-first, and gamified with stars and badges.

Primary sources: `README.md`, `ARCHITECTURE.md`, `pyproject.toml`.

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
- UI: Qt Quick / QML (Qt 6.5+)
- Backend: C++17
- Build system: CMake 3.16+
- Database: SQLite (Qt Sql + QML LocalStorage)
- Packaging: Python CLI (`neostem`)

Qt modules in use:
- Qt6::Quick
- Qt6::QuickControls2
- Qt6::Multimedia
- Qt6::Sql

## Architecture Summary
Entry point is `src/main.cpp` which initializes Qt, sets fonts, and creates SQLite tables. QML is loaded into `MainMenu.qml` which hosts a StackView for navigation.

Global singletons in QML:
- `NeoConstants.qml`: colors, activity metadata, step names, badge data
- `ProgressTracker.qml`: progress CRUD, stars, reset
- `BadgeSystem.qml`: badge unlock logic

Activity flow:
- Each activity (Q1-Q20) extends `ActivityBase.qml`
- `ActivityBase.qml` loads step QML files dynamically and triggers progress/badge updates

## Data Model (SQLite)
The app stores progress and badge state locally.

Tables:
- `progress`: per-question step completion, stars, and optional JSON data
- `badges`: unlocked badges with timestamps
- `dqb_state`: sticky note text/answers for driving questions

DB locations:
- macOS: `~/Library/Application Support/BinhDanHocSTEM/NEO_STEM/neostem.db`
- Linux: `~/.local/share/BinhDanHocSTEM/NEO_STEM/neostem.db`
- QML LocalStorage: `~/.local/share/BinhDanHocSTEM/NEO_STEM/QML/OfflineStorage/`

## Python Entry Point
The PyQt5 app entry point is exposed as `neostem = "neo_stem.app:main"` in `pyproject.toml`.

Run locally:
```
python -m neo_stem.app
```

## Supported Platforms and Requirements
Supported platforms:
- Linux x86_64 (Ubuntu 22.04+ / Debian 12+)
- Linux ARM64 (Armbian Bookworm / Ubuntu 22.04+)
- macOS 13+

Minimum hardware:
- Linux x86_64: 2GB RAM
- Linux ARM64: 2GB RAM
- macOS: 4GB RAM

Displays: HDMI, LCD touchscreen, X11, Wayland, or framebuffer.

## Project Layout (High Level)
- `src/`: C++ entry + QML UI
  - `core/`: shared QML components and singletons
  - `menu/`: navigation screens
  - `activities/`: 20 activity modules (Q1-Q20)
- `translations/`: TS translation files
- `neo_stem/`: PyQt5 application package
- `CMakeLists.txt`: CMake build config

## Performance Targets (from ARCHITECTURE.md)
- Startup time: ~1s (macOS M1), ~3-5s (ARM 2GB)
- RAM usage: ~80-120MB (macOS), ~60-100MB (ARM)
- Binary size: ~3-5MB
- UI FPS: 30-60

## Device specs
- End users machine:
    - Linux Armbian ARM64 
    - 2GB RAM
    - 16GB storage
