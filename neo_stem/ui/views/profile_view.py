from PyQt5 import QtCore, QtWidgets

from ..widgets.neo_bar import NeoBar
from ..widgets.neo_score import NeoScore
from ...db import progress_tracker


class ProfileView(QtWidgets.QWidget):
    back_requested = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._build_ui()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)

        bar = NeoBar("Hồ sơ")
        bar.back_clicked.connect(self.back_requested.emit)
        bar.home_clicked.connect(self.back_requested.emit)
        layout.addWidget(bar)

        content = QtWidgets.QWidget()
        content_layout = QtWidgets.QVBoxLayout(content)
        content_layout.setAlignment(QtCore.Qt.AlignCenter)

        title = QtWidgets.QLabel("Tổng sao")
        title.setAlignment(QtCore.Qt.AlignCenter)
        title.setStyleSheet("font-size: 18px; font-weight: 600;")

        total = progress_tracker.get_total_stars()
        score = NeoScore(total, 300)

        content_layout.addWidget(title)
        content_layout.addSpacing(8)
        content_layout.addWidget(score, alignment=QtCore.Qt.AlignHCenter)
        layout.addWidget(content, 1)
