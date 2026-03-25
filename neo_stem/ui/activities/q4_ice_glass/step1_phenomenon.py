from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step1Phenomenon(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._discovered = set()
        self._ice_added = False
        self._build_ui()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Hiện tượng: Giọt nước trên ly đá")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Bàn ăn Việt Nam, trời nóng. Thả đá vào ly nước — chờ một lát... bạn thấy gì bên ngoài ly?")
        description.setWordWrap(True)
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._info = QtWidgets.QLabel("Thử thả đá vào ly xem!")
        self._info.setWordWrap(True)
        self._info.setAlignment(QtCore.Qt.AlignHCenter)
        self._info.setStyleSheet("font-size: 14px; color: #2E7D32;")

        hotspots = [
            (
                "Giọt nước bên ngoài ly",
                "Giọt nước xuất hiện bên ngoài thành ly. Ly không bị rò rỉ! Nước này đến từ không khí — hơi "
                "nước gặp thành ly lạnh và ngưng tụ.",
            ),
            (
                "Đá trong ly",
                "Đá làm lạnh nước và thành ly. Nhiệt độ thành ly giảm xuống dưới 'điểm sương' — nhiệt độ "
                "mà hơi nước bắt đầu ngưng tụ.",
            ),
            (
                "Vũng nước dưới ly",
                "Giọt nước ngưng tụ chảy xuống tạo thành vũng nước quanh đáy ly. Đó là lý do cần dùng lót ly "
                "khi uống nước đá!",
            ),
        ]

        buttons = QtWidgets.QHBoxLayout()
        buttons.setSpacing(12)
        for label, detail in hotspots:
            btn = TouchButton(label)
            btn.clicked.connect(lambda _=False, l=label, d=detail: self._on_hotspot(l, d))
            buttons.addWidget(btn)

        self._ice_btn = TouchButton("🧊 Thả đá vào ly")
        self._ice_btn.clicked.connect(self._add_ice)

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(lambda: self.step_completed.emit(3))

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addLayout(buttons)
        layout.addWidget(self._ice_btn, alignment=QtCore.Qt.AlignHCenter)
        layout.addWidget(self._info)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

    def _add_ice(self) -> None:
        self._ice_added = True
        self._ice_btn.setText("🧊 Đã thêm đá")
        self._info.setText("Ly không bị rò mà! 🤔")
        self._update_complete()

    def _on_hotspot(self, label: str, detail: str) -> None:
        self._discovered.add(label)
        self._info.setText(detail)
        self._update_complete()

    def _update_complete(self) -> None:
        if self._ice_added and len(self._discovered) >= 3:
            self._complete.setEnabled(True)
