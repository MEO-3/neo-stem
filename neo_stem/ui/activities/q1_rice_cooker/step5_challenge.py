from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step5Challenge(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._build_ui()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Thách thức: Nồi áp suất")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        scenario = QtWidgets.QLabel(
            "Bạn Minh nấu cơm bằng nồi áp suất. Minh nhận thấy nồi áp suất nấu nhanh hơn nồi thường, "
            "nhưng khi mở nắp (sau khi xả hơi), nước bên trong vẫn đang sôi sùng sục dù đã tắt bếp. "
            "Nhiệt kế cho thấy nước trong nồi áp suất đạt 120°C trước khi tắt bếp.")
        scenario.setWordWrap(True)
        scenario.setAlignment(QtCore.Qt.AlignHCenter)
        scenario.setStyleSheet("font-size: 14px; color: #4A4A4A;")

        question = QtWidgets.QLabel("Tại sao nước trong nồi áp suất sôi ở nhiệt độ cao hơn 100°C?")
        question.setWordWrap(True)
        question.setAlignment(QtCore.Qt.AlignHCenter)
        question.setStyleSheet("font-size: 16px; color: #4A4A4A; font-weight: 600;")

        self._group = QtWidgets.QButtonGroup(self)
        self._group.buttonClicked.connect(self._on_choice)

        choices = [
            (
                "Vì nồi áp suất tạo áp suất cao hơn, nên nước cần nhiệt độ cao hơn để sôi",
                True,
                "Đúng! Áp suất cao ép phân tử nước lại, cần nhiều năng lượng hơn để chuyển sang thể khí. "
                "Nước sôi ở 120°C ở áp suất 2 atm.",
            ),
            (
                "Vì nồi áp suất làm nóng nước nhanh hơn nên nhiệt độ sôi tăng",
                False,
                "Tốc độ đun nóng không thay đổi nhiệt độ sôi. Nhiệt độ sôi phụ thuộc vào áp suất, không phải tốc độ đun.",
            ),
            (
                "Vì nồi áp suất cách nhiệt tốt hơn nên giữ nhiệt lâu",
                False,
                "Cách nhiệt giúp giữ nhiệt nhưng không thay đổi nhiệt độ sôi. Yếu tố quyết định là áp suất bên trong nồi.",
            ),
            (
                "Vì nước trong nồi áp suất là loại nước đặc biệt",
                False,
                "Nước vẫn là H₂O bình thường. Sự khác biệt nằm ở áp suất bên trong nồi, không phải bản chất của nước.",
            ),
        ]

        self._answers = []
        choice_layout = QtWidgets.QVBoxLayout()
        for text, is_correct, explanation in choices:
            radio = QtWidgets.QRadioButton(text)
            radio._is_correct = is_correct
            radio._explanation = explanation
            self._group.addButton(radio)
            self._answers.append(radio)
            choice_layout.addWidget(radio)

        self._feedback = QtWidgets.QLabel("")
        self._feedback.setAlignment(QtCore.Qt.AlignHCenter)
        self._feedback.setStyleSheet("font-size: 14px; color: #2E7D32;")

        self._extended = QtWidgets.QLabel(
            "🏔 Mở rộng: Trên đỉnh núi cao (ví dụ Fansipan 3143m), áp suất không khí thấp hơn mực nước biển. "
            "Vì vậy nước sôi ở nhiệt độ THẤP hơn 100°C (khoảng 90°C). "
            "Đó là lý do nấu cơm trên núi cao thường lâu chín hơn!\n\n"
            "Công thức: Áp suất ↑ → Nhiệt độ sôi ↑ | Áp suất ↓ → Nhiệt độ sôi ↓")
        self._extended.setWordWrap(True)
        self._extended.setStyleSheet("font-size: 13px; color: #5A5A5A;")

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(self._complete_step)

        layout.addWidget(title)
        layout.addWidget(scenario)
        layout.addWidget(question)
        layout.addLayout(choice_layout)
        layout.addWidget(self._feedback)
        layout.addWidget(self._extended)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

    def _on_choice(self) -> None:
        self._complete.setEnabled(True)
        button = self._group.checkedButton()
        if not button:
            return

        explanation = getattr(button, "_explanation", "")
        if getattr(button, "_is_correct", False):
            self._feedback.setText(explanation)
            self._feedback.setStyleSheet("font-size: 14px; color: #2E7D32;")
        else:
            self._feedback.setText(explanation)
            self._feedback.setStyleSheet("font-size: 14px; color: #E53935;")

    def _complete_step(self) -> None:
        button = self._group.checkedButton()
        stars = 3 if button and getattr(button, "_is_correct", False) else 1
        self.step_completed.emit(stars)
