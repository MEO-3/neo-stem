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

        title = QtWidgets.QLabel("Thách thức: Cầu vồng đôi")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        scenario = QtWidgets.QLabel(
            "Bạn Lan đang ngắm cầu vồng sau cơn mưa chiều. Bất ngờ, Lan thấy có HAI cầu vồng! "
            "Cầu vồng thứ hai mờ hơn và nằm phía trên cầu vồng chính. Lan nhận ra thứ tự màu "
            "của cầu vồng thứ hai bị ngược lại — tím ở ngoài, đỏ ở trong.")
        scenario.setWordWrap(True)
        scenario.setAlignment(QtCore.Qt.AlignHCenter)
        scenario.setStyleSheet("font-size: 14px; color: #4A4A4A;")

        question = QtWidgets.QLabel("Tại sao đôi khi thấy 2 cầu vồng với thứ tự màu ngược nhau?")
        question.setWordWrap(True)
        question.setAlignment(QtCore.Qt.AlignHCenter)
        question.setStyleSheet("font-size: 16px; color: #4A4A4A; font-weight: 600;")

        self._group = QtWidgets.QButtonGroup(self)
        self._group.buttonClicked.connect(self._on_choice)

        choices = [
            (
                "Vì ánh sáng phản xạ 2 lần bên trong giọt nước, tạo cầu vồng phụ ngược thứ tự màu",
                True,
                "Đúng! Cầu vồng chính do ánh sáng phản xạ 1 lần trong giọt nước. Cầu vồng phụ do phản xạ 2 lần — "
                "mỗi lần phản xạ đảo ngược thứ tự màu, nên cầu vồng phụ có màu ngược lại và mờ hơn (mất năng lượng).",
            ),
            (
                "Vì có 2 lớp giọt mưa ở 2 độ cao khác nhau",
                False,
                "Số lớp giọt mưa không tạo ra cầu vồng đôi. Cầu vồng phụ sinh ra từ phản xạ bên trong giọt nước, "
                "không phải từ lớp mưa khác nhau.",
            ),
            (
                "Vì mắt nhìn thấy ảnh phản chiếu của cầu vồng trên mây",
                False,
                "Cầu vồng không phải vật thể thật để có ảnh phản chiếu. Nó là hiện tượng quang học xảy ra ở góc "
                "nhìn cụ thể giữa mắt, giọt nước và mặt trời.",
            ),
            (
                "Vì mặt trời phát ra 2 chùm ánh sáng khác nhau",
                False,
                "Mặt trời chỉ phát một loại ánh sáng trắng. Cầu vồng đôi do cách ánh sáng tương tác với giọt nước, "
                "không phải do nguồn sáng khác nhau.",
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
            "🌈 Mở rộng: Vùng tối giữa 2 cầu vồng gọi là 'Vùng tối Alexander' (Alexander's dark band). "
            "Vùng này tối hơn vì không có ánh sáng phản xạ đến mắt ở góc đó. "
            "Lý thuyết còn cho phép cầu vồng 3, 4, 5... nhưng quá mờ để nhìn thấy!\n\n"
            "Thí nghiệm tại nhà: Dùng vòi phun sương quay lưng về phía mặt trời → bạn sẽ thấy cầu vồng!")
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
