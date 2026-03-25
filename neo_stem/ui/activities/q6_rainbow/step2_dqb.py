from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step2DQB(QtWidgets.QWidget):
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

        title = QtWidgets.QLabel("Bảng câu hỏi")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel("Chọn và trả lời ít nhất 3 câu hỏi phụ.")
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._list = QtWidgets.QListWidget()
        self._list.setMinimumHeight(240)
        self._list.itemChanged.connect(self._update_state)

        questions = [
            "Ánh sáng trắng có phải một màu duy nhất?",
            "Giọt nước làm gì với ánh sáng?",
            "Tại sao cầu vồng cong?",
            "Có thể tạo cầu vồng nhân tạo không?",
            "Tại sao chỉ thấy cầu vồng sau mưa?",
        ]
        for text in questions:
            item = QtWidgets.QListWidgetItem(text)
            item.setCheckState(QtCore.Qt.Unchecked)
            self._list.addItem(item)

        self._status = QtWidgets.QLabel("0/3 câu hỏi")
        self._status.setAlignment(QtCore.Qt.AlignHCenter)
        self._status.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(self._complete_step)

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addWidget(self._list, 1)
        layout.addWidget(self._status)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

    def _update_state(self) -> None:
        checked = 0
        for i in range(self._list.count()):
            if self._list.item(i).checkState() == QtCore.Qt.Checked:
                checked += 1
        self._status.setText(f"{checked}/3 câu hỏi")
        self._complete.setEnabled(checked >= 3)

    def _complete_step(self) -> None:
        checked = 0
        for i in range(self._list.count()):
            if self._list.item(i).checkState() == QtCore.Qt.Checked:
                checked += 1
        if checked >= 4:
            stars = 3
        elif checked >= 3:
            stars = 2
        else:
            stars = 1
        self.step_completed.emit(stars)
