from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step1Phenomenon(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._discovered = set()
        self._build_ui()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(16)

        title = QtWidgets.QLabel("Hiện tượng")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Quan sát nhà bếp Việt Nam. Nồi cơm đang nấu — bạn thấy gì?")
        description.setWordWrap(True)
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        hotspot_row = QtWidgets.QHBoxLayout()
        hotspot_row.setSpacing(12)

        self._info = QtWidgets.QLabel("Hãy chọn một điểm để bắt đầu.")
        self._info.setWordWrap(True)
        self._info.setAlignment(QtCore.Qt.AlignHCenter)
        self._info.setStyleSheet("font-size: 15px; color: #2E7D32;")

        hotspot_data = [
            (
                "Hơi nước",
                "Hơi nước bốc lên từ khe nắp nồi. Đó là nước ở dạng khí — mắt thường không thấy hơi nước thật sự, "
                "chỉ thấy khi nó ngưng tụ thành giọt nhỏ trong không khí.",
            ),
            (
                "Nắp nồi rung",
                "Nắp nồi liên tục nhấc lên hạ xuống. Áp suất hơi nước bên trong nồi đẩy nắp lên, rồi thoát ra ngoài, "
                "nắp hạ xuống lại.",
            ),
            (
                "Nước sôi bên trong",
                "Bên trong nồi, nước đang sôi sùng sục ở 100°C. Bọt khí nổi lên liên tục — đó là hơi nước hình thành từ đáy nồi.",
            ),
        ]

        for label, text in hotspot_data:
            btn = TouchButton(label)
            btn.clicked.connect(lambda _=False, l=label, t=text: self._on_hotspot(l, t))
            hotspot_row.addWidget(btn)

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(lambda: self.step_completed.emit(3))

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addLayout(hotspot_row)
        layout.addWidget(self._info)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

    def _on_hotspot(self, label: str, text: str) -> None:
        self._discovered.add(label)
        self._info.setText(text)
        if len(self._discovered) >= 3:
            self._complete.setEnabled(True)
