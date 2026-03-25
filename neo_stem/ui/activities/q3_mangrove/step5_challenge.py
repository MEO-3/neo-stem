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

        title = QtWidgets.QLabel("Thách thức: Biến đổi khí hậu và rừng ngập mặn")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        scenario = QtWidgets.QLabel(
            "Do biến đổi khí hậu, mực nước biển dâng cao. Một số vùng ven biển bị nhiễm mặn nặng hơn, "
            "nồng độ muối trong nước tăng từ 3.5% lên 5%. "
            "Đồng thời, một số vùng khác do mưa nhiều bất thường, nước biển bị pha loãng, "
            "nồng độ muối giảm xuống 1%.")
        scenario.setWordWrap(True)
        scenario.setAlignment(QtCore.Qt.AlignHCenter)
        scenario.setStyleSheet("font-size: 14px; color: #4A4A4A;")

        question = QtWidgets.QLabel("Điều gì sẽ xảy ra với rừng ngập mặn nếu nồng độ muối thay đổi mạnh?")
        question.setWordWrap(True)
        question.setAlignment(QtCore.Qt.AlignHCenter)
        question.setStyleSheet("font-size: 16px; color: #4A4A4A; font-weight: 600;")

        self._group = QtWidgets.QButtonGroup(self)
        self._group.buttonClicked.connect(self._on_choice)

        choices = [
            (
                "Cây ngập mặn thích nghi được với một khoảng nồng độ muối nhất định. Thay đổi quá nhiều sẽ gây stress",
                True,
                "Đúng! Cây đước lọc muối hiệu quả ở 2-4%. Muối >5% vượt khả năng lọc → cây stress. "
                "Muối <1% → cây ngập mặn thua cạnh tranh với cây nước ngọt. Mỗi loài có giới hạn thích nghi.",
            ),
            (
                "Cây ngập mặn sẽ thích nghi hoàn toàn vì chúng đã quen sống trong muối",
                False,
                "Dù thích nghi tốt, mỗi loài có giới hạn. Nồng độ muối thay đổi quá nhanh hoặc quá nhiều sẽ vượt khả năng điều chỉnh của cây.",
            ),
            (
                "Rừng ngập mặn sẽ không bị ảnh hưởng vì chúng sống dưới nước",
                False,
                "Rừng ngập mặn RẤT nhạy cảm với nồng độ muối. Thay đổi nồng độ ảnh hưởng trực tiếp đến khả năng hấp thụ nước qua rễ (thẩm thấu).",
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
            "🌏 Rừng ngập mặn Việt Nam: Cần Giờ (TP.HCM), Cà Mau, Quảng Ninh... "
            "là hệ sinh thái quan trọng: chống xói mòn, nuôi dưỡng hải sản, hấp thụ CO₂.\n\n"
            "Biến đổi khí hậu đe dọa rừng ngập mặn qua: nước biển dâng, bão mạnh hơn, "
            "thay đổi nồng độ muối. Bảo vệ rừng ngập mặn = bảo vệ bờ biển Việt Nam.")
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
