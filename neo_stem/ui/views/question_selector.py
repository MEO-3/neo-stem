from PyQt5 import QtCore, QtWidgets

from ..widgets.neo_bar import NeoBar
from ..widgets.touch_button import TouchButton
from ...data import QUESTIONS


class QuestionSelectorView(QtWidgets.QWidget):
    back_requested = QtCore.pyqtSignal()
    question_selected = QtCore.pyqtSignal(int)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._build_ui()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)

        bar = NeoBar("Chọn câu hỏi")
        bar.back_clicked.connect(self.back_requested.emit)
        bar.home_clicked.connect(self.back_requested.emit)
        layout.addWidget(bar)

        scroll = QtWidgets.QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setFrameShape(QtWidgets.QFrame.NoFrame)

        content = QtWidgets.QWidget()
        grid = QtWidgets.QGridLayout(content)
        grid.setContentsMargins(24, 24, 24, 24)
        grid.setSpacing(16)

        columns = 3
        row = 0
        col = 0
        for question in QUESTIONS:
            card = self._build_card(question)
            grid.addWidget(card, row, col)
            col += 1
            if col >= columns:
                col = 0
                row += 1

        scroll.setWidget(content)
        layout.addWidget(scroll, 1)

    def _build_card(self, question: dict) -> QtWidgets.QFrame:
        frame = QtWidgets.QFrame()
        frame.setStyleSheet(
            "QFrame {"
            "background: white;"
            "border-radius: 12px;"
            "border: 1px solid #E0E0E0;"
            "}"
        )
        frame.setMinimumWidth(220)

        layout = QtWidgets.QVBoxLayout(frame)
        layout.setContentsMargins(16, 16, 16, 16)
        layout.setSpacing(8)

        icon = QtWidgets.QLabel(question.get("icon", ""))
        icon.setAlignment(QtCore.Qt.AlignLeft)
        icon.setStyleSheet("font-size: 24px;")

        title = QtWidgets.QLabel(question["title"])
        title.setStyleSheet("font-size: 16px; font-weight: 700;")
        title.setWordWrap(True)

        topic = QtWidgets.QLabel(question["topic"])
        topic.setStyleSheet("font-size: 13px; color: #5A5A5A;")
        topic.setWordWrap(True)

        open_btn = TouchButton("Mở")
        open_btn.clicked.connect(lambda _=False, qid=question["id"]: self.question_selected.emit(qid))

        layout.addWidget(icon)
        layout.addWidget(title)
        layout.addWidget(topic)
        layout.addStretch(1)
        layout.addWidget(open_btn)

        return frame
