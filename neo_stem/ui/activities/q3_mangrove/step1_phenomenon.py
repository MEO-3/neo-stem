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
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Hiện tượng: Rừng ngập mặn Cần Giờ")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Rừng ngập mặn Cần Giờ, TP.HCM. Cây đước mọc khỏe trong nước mặn, nhưng cây thường lại héo. Tại sao?")
        description.setWordWrap(True)
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._info = QtWidgets.QLabel("Hãy chạm vào các điểm để tìm hiểu.")
        self._info.setWordWrap(True)
        self._info.setAlignment(QtCore.Qt.AlignHCenter)
        self._info.setStyleSheet("font-size: 14px; color: #2E7D32;")

        hotspots = [
            (
                "Cây đước khỏe mạnh",
                "Cây đước có hệ rễ đặc biệt và cơ chế lọc muối. Rễ cọc bám sâu, rễ thở nhô lên mặt nước. "
                "Tế bào rễ có thể lọc 90% muối khi hấp thụ nước.",
            ),
            (
                "Cây thường héo úa",
                "Cây bình thường sẽ héo và chết trong nước mặn. Nồng độ muối bên ngoài cao hơn bên trong tế bào, "
                "nước bị rút ra ngoài (thẩm thấu ngược).",
            ),
            (
                "Nước mặn",
                "Nước biển có nồng độ muối khoảng 3.5%. Muối NaCl tan trong nước tạo dung dịch có áp suất thẩm thấu "
                "cao, ảnh hưởng trực tiếp đến tế bào thực vật.",
            ),
        ]

        buttons = QtWidgets.QHBoxLayout()
        buttons.setSpacing(12)
        for label, detail in hotspots:
            btn = TouchButton(label)
            btn.clicked.connect(lambda _=False, l=label, d=detail: self._on_hotspot(l, d))
            buttons.addWidget(btn)

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(lambda: self.step_completed.emit(3))

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addLayout(buttons)
        layout.addWidget(self._info)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

    def _on_hotspot(self, label: str, detail: str) -> None:
        self._discovered.add(label)
        self._info.setText(detail)
        if len(self._discovered) >= 3:
            self._complete.setEnabled(True)
