from PyQt5 import QtCore, QtWidgets


class StepBaseWidget(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, title: str, description: str, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index

        self._title = QtWidgets.QLabel(title)
        self._title.setStyleSheet("font-size: 22px; font-weight: 700;")
        self._title.setAlignment(QtCore.Qt.AlignHCenter)

        self._description = QtWidgets.QLabel(description)
        self._description.setWordWrap(True)
        self._description.setAlignment(QtCore.Qt.AlignHCenter)
        self._description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._complete_btn = QtWidgets.QPushButton("Hoàn thành bước")
        self._complete_btn.setMinimumHeight(48)
        self._complete_btn.clicked.connect(lambda: self.step_completed.emit(3))

        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.addStretch(1)
        layout.addWidget(self._title)
        layout.addSpacing(12)
        layout.addWidget(self._description)
        layout.addSpacing(24)
        layout.addWidget(self._complete_btn, alignment=QtCore.Qt.AlignHCenter)
        layout.addStretch(2)
