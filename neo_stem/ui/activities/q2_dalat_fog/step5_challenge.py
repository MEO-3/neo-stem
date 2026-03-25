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

        title = QtWidgets.QLabel("Thách thức: Sương mù vs Smog")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        scenario = QtWidgets.QLabel(
            "Ở Đà Lạt, sương mù sáng sớm tan nhanh khi mặt trời lên — bầu trời trong xanh. "
            "Nhưng ở Hà Nội vào mùa đông, có những ngày 'sương mù' kéo dài cả ngày, "
            "trời xám xịt và không khí có mùi khó chịu. Thực ra đó không phải sương mù thuần túy — "
            "người ta gọi là smog (sương mù + ô nhiễm).")
        scenario.setWordWrap(True)
        scenario.setAlignment(QtCore.Qt.AlignHCenter)
        scenario.setStyleSheet("font-size: 14px; color: #4A4A4A;")

        question = QtWidgets.QLabel("Tại sao smog ở Hà Nội kéo dài hơn sương mù tự nhiên ở Đà Lạt?")
        question.setWordWrap(True)
        question.setAlignment(QtCore.Qt.AlignHCenter)
        question.setStyleSheet("font-size: 16px; color: #4A4A4A; font-weight: 600;")

        self._group = QtWidgets.QButtonGroup(self)
        self._group.buttonClicked.connect(self._on_choice)

        choices = [
            (
                "Vì smog chứa hạt bụi ô nhiễm giữ giọt nước lâu hơn, khó bay hơi",
                True,
                "Đúng! Hạt bụi mịn (PM2.5) làm 'nhân ngưng tụ' — hơi nước bám vào bụi tạo giọt nước bền hơn. "
                "Mặt trời khó xuyên qua, nhiệt độ chậm tăng, smog kéo dài.",
            ),
            (
                "Vì Hà Nội ở vùng thấp hơn Đà Lạt nên lạnh hơn",
                False,
                "Thực tế Đà Lạt (1500m) lạnh hơn Hà Nội. Vấn đề của smog không phải nhiệt độ mà là ô nhiễm không khí.",
            ),
            (
                "Vì Hà Nội có nhiều nước hơn Đà Lạt",
                False,
                "Lượng nước không phải yếu tố chính. Smog kéo dài vì ô nhiễm tạo hạt nhân ngưng tụ và cản ánh sáng mặt trời.",
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
            "🌍 Ô nhiễm không khí: Hạt PM2.5 từ xe cộ, nhà máy, đốt rác... tạo 'nhân ngưng tụ' nhân tạo. "
            "Hơi nước bám vào hạt bụi này dễ hơn bám vào không khí sạch. "
            "Đó là lý do thành phố ô nhiễm hay có smog kéo dài.\n\n"
            "Giải pháp: Giảm ô nhiễm (xe điện, năng lượng sạch, trồng cây) → Ít nhân ngưng tụ → Ít smog.")
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
