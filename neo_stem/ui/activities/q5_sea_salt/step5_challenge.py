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

        title = QtWidgets.QLabel("Thách thức: Chưng cất mặt trời")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        scenario = QtWidgets.QLabel(
            "Trên một hòn đảo xa, không có nước ngọt. Bạn có nước biển, chai nhựa, và ánh nắng mặt trời. "
            "Bạn cần tạo nước ngọt uống được. "
            "Nhớ lại: ở Q5, nước bay hơi để lại muối. Ở Q4, hơi nước gặp lạnh ngưng tụ thành giọt nước. "
            "Có thể kết hợp 2 nguyên lý này không?")
        scenario.setWordWrap(True)
        scenario.setAlignment(QtCore.Qt.AlignHCenter)
        scenario.setStyleSheet("font-size: 14px; color: #4A4A4A;")

        question = QtWidgets.QLabel("Làm thế nào để lấy nước ngọt từ nước biển bằng chưng cất mặt trời?")
        question.setWordWrap(True)
        question.setAlignment(QtCore.Qt.AlignHCenter)
        question.setStyleSheet("font-size: 16px; color: #4A4A4A; font-weight: 600;")

        self._group = QtWidgets.QButtonGroup(self)
        self._group.buttonClicked.connect(self._on_choice)

        choices = [
            (
                "Cho nước biển bay hơi bằng nắng, rồi hứng hơi nước ngưng tụ trên bề mặt lạnh → nước ngọt",
                True,
                "Đúng! Chưng cất mặt trời = Bay hơi (Q5) + Ngưng tụ (Q4). Nước biển bay hơi → hơi nước (sạch, "
                "không muối) → ngưng tụ trên mặt lạnh → nước ngọt chảy xuống. Muối ở lại bên dưới.",
            ),
            (
                "Lọc nước biển qua cát sạch để tách muối",
                False,
                "Lọc qua cát chỉ tách được cặn bẩn, không tách được muối hòa tan. Muối ở mức phân tử, nhỏ hơn "
                "hạt cát rất nhiều.",
            ),
            (
                "Để nước biển dưới nắng cho muối lắng xuống đáy rồi gạn nước",
                False,
                "Muối hòa tan hoàn toàn trong nước, không tự lắng xuống. Chỉ khi nước bay hơi gần hết, muối mới "
                "kết tinh ra.",
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
            "🔗 Kết nối Q4 + Q5:\n"
            "• Bay hơi (Q5): Nước biển → Nhiệt → Hơi nước (bỏ lại muối)\n"
            "• Ngưng tụ (Q4): Hơi nước → Gặp lạnh → Nước ngọt\n\n"
            "🏝 Thiết bị chưng cất mặt trời (Solar Still):\n"
            "1. Đào hố, đặt chai hứng ở giữa\n"
            "2. Phủ nylon trong suốt trên hố\n"
            "3. Đặt hòn đá nhỏ trên nylon ngay trên chai\n"
            "4. Nắng làm nước bay hơi → ngưng tụ dưới nylon → chảy xuống chai\n\n"
            "Đây chính là nguyên lý của nhà máy khử muối nước biển hiện đại!")
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
