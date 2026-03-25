from PyQt5 import QtCore, QtWidgets

from .neo_score import NeoScore


class NeoBonus(QtWidgets.QDialog):
    dismissed = QtCore.pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Neo Bonus")
        self.setModal(True)
        self.setMinimumWidth(360)

        self._title = QtWidgets.QLabel("Hoàn thành bước!")
        self._title.setAlignment(QtCore.Qt.AlignCenter)
        self._title.setStyleSheet("font-size: 20px; font-weight: 700;")

        self._score = NeoScore(0, 3)
        self._message = QtWidgets.QLabel("Bạn nhận được sao.")
        self._message.setAlignment(QtCore.Qt.AlignCenter)
        self._message.setStyleSheet("font-size: 14px; color: #4A4A4A;")

        self._dismiss_btn = QtWidgets.QPushButton("Tiếp tục")
        self._dismiss_btn.setMinimumHeight(44)
        self._dismiss_btn.clicked.connect(self._on_dismissed)

        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(20, 20, 20, 20)
        layout.setSpacing(12)
        layout.addWidget(self._title)
        layout.addWidget(self._score, alignment=QtCore.Qt.AlignCenter)
        layout.addWidget(self._message)
        layout.addStretch(1)
        layout.addWidget(self._dismiss_btn)

    def set_bonus(self, stars: int, is_final: bool = False) -> None:
        if is_final:
            self._title.setText("Hoàn thành câu hỏi!")
            self._dismiss_btn.setText("Về menu")
        else:
            self._title.setText("Hoàn thành bước!")
            self._dismiss_btn.setText("Tiếp tục")
        self._score.set_stars(stars, 3)

    def _on_dismissed(self) -> None:
        self.dismissed.emit()
        self.accept()
