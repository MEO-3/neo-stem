from PyQt5 import QtCore, QtGui, QtWidgets

from .. import theme
from ..widgets.touch_button import TouchButton


class SplashView(QtWidgets.QWidget):
    start_requested = QtCore.pyqtSignal()
    profile_requested = QtCore.pyqtSignal()
    settings_requested = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._build_ui()

    def _build_ui(self) -> None:
        self.setAutoFillBackground(True)
        palette = self.palette()
        palette.setColor(QtGui.QPalette.Window, QtGui.QColor(theme.FOREST_GREEN))
        self.setPalette(palette)

        root = QtWidgets.QVBoxLayout(self)
        root.setContentsMargins(24, 24, 24, 24)
        root.addStretch(1)

        title = QtWidgets.QLabel("NEO")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet(f"color: {theme.SUNSHINE}; font-size: 72px; font-weight: 800;")

        subtitle = QtWidgets.QLabel("STEM")
        subtitle.setAlignment(QtCore.Qt.AlignHCenter)
        subtitle.setStyleSheet("color: white; font-size: 48px; font-weight: 700;")

        tagline = QtWidgets.QLabel("Khám phá Khoa học cùng Neo!")
        tagline.setAlignment(QtCore.Qt.AlignHCenter)
        tagline.setStyleSheet("color: #C8E6C9; font-size: 18px;")

        mascot = QtWidgets.QLabel("🤖")
        mascot.setAlignment(QtCore.Qt.AlignHCenter)
        mascot.setStyleSheet(
            f"background-color: {theme.OCEAN_BLUE};"
            "border-radius: 50px;"
            "font-size: 56px;"
            "min-width: 100px;"
            "min-height: 100px;"
        )

        start_btn = TouchButton("Bắt đầu khám phá!")
        start_btn.clicked.connect(self.start_requested.emit)

        secondary_row = QtWidgets.QHBoxLayout()
        secondary_row.setSpacing(16)
        profile_btn = TouchButton("Hồ sơ", primary=False)
        settings_btn = TouchButton("Cài đặt", primary=False)
        profile_btn.clicked.connect(self.profile_requested.emit)
        settings_btn.clicked.connect(self.settings_requested.emit)
        secondary_row.addStretch(1)
        secondary_row.addWidget(profile_btn)
        secondary_row.addWidget(settings_btn)
        secondary_row.addStretch(1)

        root.addWidget(title)
        root.addWidget(subtitle)
        root.addWidget(tagline)
        root.addSpacing(24)
        root.addWidget(mascot, alignment=QtCore.Qt.AlignHCenter)
        root.addSpacing(24)
        root.addWidget(start_btn, alignment=QtCore.Qt.AlignHCenter)
        root.addSpacing(12)
        root.addLayout(secondary_row)
        root.addStretch(2)

        version = QtWidgets.QLabel("NEO STEM v1.0 — Bình Dân Học STEM & Robot — Lớp 3-9")
        version.setAlignment(QtCore.Qt.AlignHCenter)
        version.setStyleSheet("color: rgba(255, 255, 255, 0.6); font-size: 11px;")
        root.addWidget(version)
