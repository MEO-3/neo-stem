from PyQt5 import QtCore, QtWidgets

from ..widgets.neo_bar import NeoBar
from ..widgets.touch_button import TouchButton
from ...data import STEP_NAMES, get_question_by_id


class StepSelectorView(QtWidgets.QWidget):
    back_requested = QtCore.pyqtSignal()
    step_selected = QtCore.pyqtSignal(int, int)

    def __init__(self, question_id: int = 1, parent=None):
        super().__init__(parent)
        self._question_id = question_id
        self._build_ui()

    def set_question_id(self, question_id: int) -> None:
        self._question_id = question_id
        question = get_question_by_id(question_id)
        title = question["title"] if question else f"Câu hỏi {question_id}"
        self._title.setText(f"Chọn bước - {title}")

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)

        bar = NeoBar("Chọn bước")
        bar.back_clicked.connect(self.back_requested.emit)
        bar.home_clicked.connect(self.back_requested.emit)
        layout.addWidget(bar)

        content = QtWidgets.QWidget()
        content_layout = QtWidgets.QVBoxLayout(content)
        content_layout.setAlignment(QtCore.Qt.AlignCenter)

        question = get_question_by_id(self._question_id)
        title = question["title"] if question else f"Câu hỏi {self._question_id}"
        self._title = QtWidgets.QLabel(f"Chọn bước - {title}")
        self._title.setStyleSheet("font-size: 20px; font-weight: 600;")
        content_layout.addWidget(self._title, alignment=QtCore.Qt.AlignHCenter)

        buttons = QtWidgets.QHBoxLayout()
        buttons.setSpacing(12)
        for step_index, name in enumerate(STEP_NAMES):
            btn = TouchButton(name)
            btn.clicked.connect(lambda _=False, s=step_index: self.step_selected.emit(self._question_id, s))
            buttons.addWidget(btn)
        content_layout.addSpacing(16)
        content_layout.addLayout(buttons)

        layout.addWidget(content, 1)
