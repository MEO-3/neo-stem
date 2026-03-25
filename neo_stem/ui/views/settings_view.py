from PyQt5 import QtCore, QtWidgets

from ..widgets.neo_bar import NeoBar


class SettingsView(QtWidgets.QWidget):
    back_requested = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._build_ui()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)

        bar = NeoBar("Cài đặt")
        bar.back_clicked.connect(self.back_requested.emit)
        bar.home_clicked.connect(self.back_requested.emit)
        layout.addWidget(bar)

        label = QtWidgets.QLabel("Cài đặt (đang phát triển)")
        label.setAlignment(QtCore.Qt.AlignCenter)
        label.setStyleSheet("font-size: 20px; font-weight: 600;")
        layout.addWidget(label, 1)
