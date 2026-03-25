from PyQt5 import QtCore, QtGui, QtWidgets

from .. import theme
from .touch_button import TouchButton


class NeoBar(QtWidgets.QWidget):
    home_clicked = QtCore.pyqtSignal()
    back_clicked = QtCore.pyqtSignal()
    help_clicked = QtCore.pyqtSignal()

    def __init__(self, title: str = "", parent=None):
        super().__init__(parent)
        self._title = QtWidgets.QLabel(title)
        self._step = QtWidgets.QLabel("")

        self._home_btn = TouchButton("Trang chủ", primary=False)
        self._back_btn = TouchButton("Quay lại", primary=False)
        self._help_btn = TouchButton("Trợ giúp", primary=False)

        for btn in (self._home_btn, self._back_btn, self._help_btn):
            btn.setStyleSheet(
                "QPushButton {"
                "background-color: transparent;"
                f"color: {theme.OCEAN_BLUE};"
                "border: none;"
                "padding: 6px 10px;"
                "font-weight: 600;"
                "}"
                "QPushButton:pressed {"
                f"color: {theme.FOREST_GREEN};"
                "}"
            )

        self._home_btn.clicked.connect(self.home_clicked.emit)
        self._back_btn.clicked.connect(self.back_clicked.emit)
        self._help_btn.clicked.connect(self.help_clicked.emit)

        self._title.setStyleSheet("font-size: 20px; font-weight: 700;")
        self._step.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        layout = QtWidgets.QHBoxLayout(self)
        layout.setContentsMargins(16, 12, 16, 12)
        layout.setSpacing(12)
        layout.addWidget(self._back_btn)
        layout.addWidget(self._home_btn)
        layout.addWidget(self._title, 1)
        layout.addWidget(self._step)
        layout.addWidget(self._help_btn)

        self.setAutoFillBackground(True)
        palette = self.palette()
        palette.setColor(QtGui.QPalette.Window, QtGui.QColor(theme.CARD_BG))
        self.setPalette(palette)

    def set_title(self, text: str) -> None:
        self._title.setText(text)

    def set_step(self, current: int, total: int) -> None:
        if total > 0:
            self._step.setText(f"{current}/{total}")
        else:
            self._step.setText("")
