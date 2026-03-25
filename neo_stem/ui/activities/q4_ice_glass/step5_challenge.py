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

        title = QtWidgets.QLabel("Thách thức: Vệt contrail máy bay")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        scenario = QtWidgets.QLabel(
            "Bạn nhìn lên bầu trời và thấy máy bay để lại một vệt trắng dài phía sau. "
            "Vệt trắng đó gọi là 'contrail' (condensation trail = vệt ngưng tụ). "
            "Ở độ cao 10,000m, nhiệt độ bên ngoài khoảng -50°C. "
            "Khí xả từ động cơ máy bay rất nóng (khoảng 600°C) và chứa nhiều hơi nước.")
        scenario.setWordWrap(True)
        scenario.setAlignment(QtCore.Qt.AlignHCenter)
        scenario.setStyleSheet("font-size: 14px; color: #4A4A4A;")

        question = QtWidgets.QLabel("Tại sao máy bay tạo ra vệt trắng trên bầu trời?")
        question.setWordWrap(True)
        question.setAlignment(QtCore.Qt.AlignHCenter)
        question.setStyleSheet("font-size: 16px; color: #4A4A4A; font-weight: 600;")

        self._group = QtWidgets.QButtonGroup(self)
        self._group.buttonClicked.connect(self._on_choice)

        choices = [
            (
                "Hơi nước nóng từ động cơ gặp không khí cực lạnh, ngưng tụ thành tinh thể băng",
                True,
                "Đúng! Nguyên lý giống hệt giọt nước trên ly đá. Hơi nước nóng → gặp không khí -50°C → ngưng tụ "
                "tức thì thành tinh thể băng li ti → tạo vệt trắng.",
            ),
            (
                "Máy bay phun khói trắng từ ống xả",
                False,
                "Không phải khói! Vệt trắng là tinh thể băng từ hơi nước ngưng tụ. Tương tự khi bạn thở ra hơi "
                "trắng vào ngày lạnh — đó cũng là ngưng tụ.",
            ),
            (
                "Máy bay xả nhiên liệu thừa tạo khói trắng",
                False,
                "Máy bay không xả nhiên liệu. Vệt trắng là nước ở dạng tinh thể băng — sản phẩm của ngưng tụ "
                "khi hơi nước nóng gặp không khí lạnh.",
            ),
        ]

        choice_layout = QtWidgets.QVBoxLayout()
        for text, is_correct, explanation in choices:
            radio = QtWidgets.QRadioButton(text)
            radio._is_correct = is_correct
            radio._explanation = explanation
            self._group.addButton(radio)
            choice_layout.addWidget(radio)

        self._feedback = QtWidgets.QLabel("")
        self._feedback.setAlignment(QtCore.Qt.AlignHCenter)
        self._feedback.setStyleSheet("font-size: 14px; color: #2E7D32;")

        self._extended = QtWidgets.QLabel(
            "🌡 So sánh:\n"
            "• Ly đá: Hơi nước trong phòng (30°C) gặp ly lạnh (5°C) → giọt nước\n"
            "• Contrail: Hơi nước từ động cơ (600°C) gặp không khí (-50°C) → tinh thể băng\n"
            "• Thở ngày lạnh: Hơi nước từ phổi (37°C) gặp không khí lạnh (0°C) → hơi trắng\n\n"
            "Tất cả cùng nguyên lý: hơi nước gặp lạnh → ngưng tụ!")
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
