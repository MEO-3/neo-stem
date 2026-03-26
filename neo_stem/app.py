"""NEO STEM application entry point — PyQt6 + QML with Python backend."""

import os
import sys
from pathlib import Path

# Use Basic style to allow full QML control customization (handle, background, etc.)
os.environ.setdefault("QT_QUICK_CONTROLS_STYLE", "Basic")

from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine

from neo_stem.backend.progress_backend import ProgressTracker
from neo_stem.backend.badge_backend import BadgeSystem


def main() -> int:
    app = QGuiApplication(sys.argv)
    app.setOrganizationName("BinhDanHocSTEM")
    app.setApplicationName("NEO_STEM")

    engine = QQmlApplicationEngine()

    # Determine QML base directory
    qml_dir = Path(__file__).parent / "qml"

    # Add import paths so all QML types are discoverable globally,
    # mirroring the single NEO_STEM QML module from the C++ build.
    engine.addImportPath(str(qml_dir))
    engine.addImportPath(str(qml_dir / "core"))
    engine.addImportPath(str(qml_dir / "menu"))
    for activity_dir in sorted((qml_dir / "activities").iterdir()):
        if activity_dir.is_dir():
            engine.addImportPath(str(activity_dir))

    # Register Python backends as QML context properties.
    # QML code calls ProgressTracker.saveStepProgress(...) etc. —
    # these resolve to the Python QObject registered here.
    progress = ProgressTracker()
    badges = BadgeSystem(progress)

    ctx = engine.rootContext()
    ctx.setContextProperty("ProgressTracker", progress)
    ctx.setContextProperty("BadgeSystem", badges)

    # Load the main QML file
    main_qml = qml_dir / "menu" / "MainMenu.qml"
    engine.load(str(main_qml))

    if not engine.rootObjects():
        print("Error: Failed to load QML. Check console for details.", file=sys.stderr)
        return 1

    return app.exec()


if __name__ == "__main__":
    raise SystemExit(main())
