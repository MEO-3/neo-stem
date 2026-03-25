from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step1Phenomenon(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._discovered = set()
        self._day_progress = 0.0
        self._build_ui()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Hiện tượng: Ruộng muối Ninh Thuận")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Ruộng muối ven biển Ninh Thuận. Kéo slider thời gian để xem nước biển biến thành muối.")
        description.setWordWrap(True)
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._day_label = QtWidgets.QLabel("Thời gian: Ngày 1")
        self._day_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._day_label.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        self._slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self._slider.setRange(0, 100)
        self._slider.setValue(0)
        self._slider.valueChanged.connect(self._on_day_changed)

        self._info = QtWidgets.QLabel("Hãy chạm vào các điểm để tìm hiểu.")
        self._info.setWordWrap(True)
        self._info.setAlignment(QtCore.Qt.AlignHCenter)
        self._info.setStyleSheet("font-size: 14px; color: #2E7D32;")

        hotspots = [
            (
                "Ruộng muối (ngày 1)",
                "Nước biển được bơm vào các ô ruộng nông. Mặt trời chiếu trực tiếp, gió biển thổi — điều "
                "kiện lý tưởng để nước bay hơi.",
            ),
            (
                "Nước cạn dần (ngày 2)",
                "Nước bay hơi dần, nồng độ muối trong nước tăng lên. Dung dịch trở nên bão hòa — muối "
                "bắt đầu kết tinh.",
            ),
            (
                "Muối kết tinh (ngày 3)",
                "Nước bay hơi hết, muối NaCl kết tinh thành lớp trắng trên ruộng. Diêm dân thu hoạch muối — "
                "quá trình tách hỗn hợp bằng bay hơi.",
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
        layout.addWidget(self._day_label)
        layout.addWidget(self._slider)
        layout.addLayout(buttons)
        layout.addWidget(self._info)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

    def _on_day_changed(self, value: int) -> None:
        self._day_progress = value / 100.0
        if value < 34:
            label = "Ngày 1"
        elif value < 67:
            label = "Ngày 2"
        else:
            label = "Ngày 3"
        self._day_label.setText(f"Thời gian: {label}")
        self._update_complete()

    def _on_hotspot(self, label: str, detail: str) -> None:
        self._discovered.add(label)
        self._info.setText(detail)
        self._update_complete()

    def _update_complete(self) -> None:
        if len(self._discovered) >= 3 and self._day_progress >= 0.6:
            self._complete.setEnabled(True)
