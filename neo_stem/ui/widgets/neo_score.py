from typing import Optional

from PyQt5 import QtCore, QtWidgets


class NeoScore(QtWidgets.QWidget):
    def __init__(self, stars: int = 0, max_stars: int = 3, parent=None):
        super().__init__(parent)
        self._stars = stars
        self._max_stars = max_stars

        self._label = QtWidgets.QLabel()
        self._label.setAlignment(QtCore.Qt.AlignCenter)
        self._label.setStyleSheet("font-size: 16px; font-weight: 600;")

        layout = QtWidgets.QHBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.addWidget(self._label)

        self._render()

    def set_stars(self, stars: int, max_stars: Optional[int] = None) -> None:
        self._stars = max(0, stars)
        if max_stars is not None:
            self._max_stars = max(1, max_stars)
        self._render()

    def _render(self) -> None:
        if self._max_stars <= 10:
            filled = "*" * min(self._stars, self._max_stars)
            empty = "-" * max(0, self._max_stars - self._stars)
            self._label.setText(filled + empty)
        else:
            self._label.setText(f"{self._stars}/{self._max_stars}")
