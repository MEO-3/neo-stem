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

        title = QtWidgets.QLabel("Hiện tượng: Cầu vồng sau mưa")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Quan sát bầu trời nông thôn Việt Nam sau cơn mưa. Mặt trời xuất hiện — bạn thấy gì?")
        description.setWordWrap(True)
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._info = QtWidgets.QLabel("Hãy chạm vào các điểm để tìm hiểu.")
        self._info.setWordWrap(True)
        self._info.setAlignment(QtCore.Qt.AlignHCenter)
        self._info.setStyleSheet("font-size: 14px; color: #2E7D32;")

        hotspots = [
            (
                "Giọt mưa",
                "Hàng triệu giọt mưa nhỏ li ti lơ lửng trong không khí. Mỗi giọt nước hoạt động như một lăng "
                "kính tí hon, bẻ cong ánh sáng đi qua nó.",
            ),
            (
                "Tia nắng",
                "Ánh sáng mặt trời trông có vẻ trắng, nhưng thực ra là tổng hợp của tất cả các màu. Khi đi "
                "qua giọt nước, các màu bị tách ra.",
            ),
            (
                "Dải 7 màu",
                "Đỏ, cam, vàng, lục, lam, chàm, tím — 7 màu sắp xếp thành vòng cung. Mỗi màu bị bẻ cong một "
                "góc khác nhau bởi giọt nước.",
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
